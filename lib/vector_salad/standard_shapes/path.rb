require "spiro"

require "vector_salad/standard_shapes/basic_shape"
require "vector_salad/standard_shapes/n"
require "vector_salad/interpolate"

module VectorSalad
  module StandardShapes
    # The simplest shape primitive, all shapes can be represented as a Path.
    class Path < BasicShape
      attr_reader :nodes, :closed

      # A path is made up of N nodes and these nodes can have different types
      # (see N).
      #
      # @example
      #   new([0,0], [0,1], [1,1])
      #
      # @param nodes x,y coordinate arrays or N node instances
      # @param closed whether the path is open or closed
      Contract Args[Or[Array, N]], { closed: Maybe[Bool] } => Path
      def initialize(*nodes, closed: true, **options)
        @nodes = []
        nodes.each_index do |i|
          node = nodes[i].class == Array ? N.new(*nodes[i]) : nodes[i]
          if i == 0 && ![:node, :g2, :g4, :left, :right].include?(node.type)
            fail "First node in a path must be :node or :spiro type."
          end
          case node.type
          when :cubic
            unless nodes[i - 1].type == :node ||
                  (nodes[i - 2].type == :node && nodes[i - 1].type == :cubic)
              fail ":cubic node must follow a :node and at most 1 other :cubic."
            end
          when :quadratic
            unless nodes[i - 1].type == :node
              fail ":quadratic nodes must follow a :node."
            end
          when :mirror
            if nodes[i - 1].type == :node &&
               (nodes[i - 2].type == :quadratic || nodes[i - 2].type == :cubic)
              pivot = nodes[i - 1]
              source = nodes[i - 2]

              dx = pivot.x - source.x
              dy = pivot.y - source.y
              node.at = [pivot.x + dx, pivot.y + dy]

              node.type = source.type
            else
              fail ":reflect nodes must be preceeded by a :node with a
                :quadratic or :cubic before that."
            end
          when :node
          end
          @nodes << node
        end

        @closed = closed
        @options = options
        self
      end

      # Move the path absolutely.
      Contract Coord, Coord => Path
      def [](x, y)
        # finds the top-left most point as if the path is in a bounding box
        top_left_point = nodes[0].at
        nodes.each do |node|
          top_left_point[0] = node.at[0] if node.at[0] < top_left_point[0]
          top_left_point[1] = node.at[1] if node.at[1] < top_left_point[1]
        end
        # finds the delta between the current top-left and new top-left coords
        dx = x - top_left_point[0]
        dy = y - top_left_point[1]
        # move path to the new delta
        move(dx, dy)
      end

      # Move the path relatively.
      Contract Coord, Coord => Path
      def move(x, y)
        Path.new(
          *to_path.nodes.map do |node|
            node.move(x, y)
          end,
          closed: @closed,
          **@options
        )
      end

      # Flips on the x axis.
      Contract None => Path
      def flip_x
        flip(:x)
      end

      # Flips on the y axis.
      Contract None => Path
      def flip_y
        flip(:y)
      end

      # Flips the path on the specified axis.
      #
      # @example
      #   flip(:x)
      # @example
      #   flip(:y)
      Contract Or[:x, :y] => Path
      def flip(axis)
        x = axis == :y ? -1 : 1
        y = axis == :x ? -1 : 1

        Path.new(
          *to_path.nodes.map { |n| N.new(n.x * x, n.y * y, n.type) },
          closed: @closed, **@options
        )
      end

      # Rotates the Path by the specified angle about the origin.
      #
      # @example
      #   rotate(90)
      # @example
      #   rotate(-45)
      Contract Coord => Path
      def rotate(angle)
        theta = angle / 180.0 * Math::PI

        # http://stackoverflow.com/a/786508
        # p'x = cos(theta) * (px-ox) - sin(theta) * (py-oy) + ox
        # p'y = sin(theta) * (px-ox) + cos(theta) * (py-oy) + oy
        Path.new(
          *to_path.nodes.map do |n|
            N.new(
              Math.cos(theta) * n.x - Math.sin(theta) * n.y,
              Math.sin(theta) * n.x + Math.cos(theta) * n.y,
              n.type
            )
          end, closed: @closed, **@options
        )
      end

      # Scale a Path by multiplier about the origin.
      # Supply just 1 multiplier to scale evenly, or x and y multipliers
      # to stretch or squash the axies.
      #
      # @param x_multiplier 1 is no change, 2 is double size, 0.5 is half, etc.
      Contract Coord, Maybe[Coord] => Path
      def scale(x_multiplier, y_multiplier = x_multiplier)
        Path.new(
          *to_path.nodes.map do |n|
            N.new(
              n.x * x_multiplier,
              n.y * y_multiplier,
              n.type
            )
          end, closed: @closed, **@options
        )
      end

      # Jitter the position of nodes in a Path randomly.
      #
      # @param max The maximum offset
      # @param min The minimum offset (default 0)
      # @param fn The quantization number of sides
      Contract Coord, { min: Maybe[Coord], fn: Maybe[Fixnum] } => Path
      def jitter(max, min: 0, fn: nil)
        Path.new(
          *to_simple_path(fn).nodes.map do |n|
            r = Random.rand(min..max)
            a = Random.rand(0..Math::PI * 2)
            x = r * Math.cos(a)
            y = r * Math.sin(a)
            n.move(x, y)
          end, closed: @closed, **@options
        )
      end

      # Convert the path to a path (it returns self)
      def to_path
        self
      end

      # Convert the complex path to a bezier path.
      # This will convert any Spiro curve nodes into beziers.
      def to_bezier_path
        path = to_path
        spiro = false
        flat_path = path.nodes.map do |n|
          spiro = true if spiro || [:g2, :g4, :left, :right].include?(n.type)
          [n.x, n.y, n.type]
        end
        if spiro
          flat_spline_path = Spiro.spiros_to_splines(flat_path, @closed)
          if flat_spline_path.nil?
            fail "Spiro failed, try different coordinates or using G2 nodes."
          else
            path = Path.new(*flat_spline_path.map do |n|
              N.new(n[0], n[1], n[2])
            end, closed: @closed, **@options)
          end
        end
        path
      end

      # Convert the path into a cubic bezier path (no quadratics).
      # This will convert any Spiro curve nodes into beziers and
      # any quadratic beziers into cubics.
      def to_cubic_path
        path = to_bezier_path.nodes
        cubic_path = []
        quadratic_last = false
        path.each_index do |i|
          n = path[i]
          if quadratic_last
            n0 = path[i - 2]
            q  = path[i - 1]

            # CP1 = QP0 + 2/3 * (QP1-QP0)
            # CP2 = QP2 + 2/3 * (QP1-QP2)
            third = 2 / 3.0
            cubic_path << N.c(
              n0.x + third * (q.x - n0.x),
              n0.y + third * (q.y - n0.y)
            )
            cubic_path << N.c(
              n.x + third * (q.x - n.x),
              n.y + third * (q.y - n.y)
            )
            cubic_path << n

            quadratic_last = false
          elsif n.type == :quadratic
            quadratic_last = true
          else
            cubic_path << n
          end
        end
        Path.new(*cubic_path, closed: @closed, **@options)
      end

      # Flatten any curves in the path into many small straight line segments.
      def to_simple_path(*_)
        # convert bezier curves and spiro splines
        path = to_cubic_path.nodes

        nodes = []
        path.each_index do |i|
          case path[i].type
          when :node
            if path[i - 1].type == :cubic
              curve = path[i - 3..i].map(&:at)
              nodes += VectorSalad::Interpolate.new.casteljau(curve)
            else
              nodes << path[i]
            end
          when :cubic
          else
            fail "Only :node and :cubic nodes in a path can be converted
              to a simple path, was #{path[i].type}."
          end
        end
        Path.new(*nodes, closed: @closed, **@options)
      end

      # Wrap the path in a multi_path.
      def to_multi_path
        MultiPath.new(self)
      end

      # Return the nodes as an array of coordinates.
      def to_a
        nodes.map(&:at)
      end
    end
  end
end
