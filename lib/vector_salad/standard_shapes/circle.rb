require "vector_salad/standard_shapes/path"
require "vector_salad/standard_shapes/n"
require "vector_salad/mixins/at"

module VectorSalad
  module StandardShapes
    # Perfect circle shape.
    class Circle < BasicShape # Used to inherit from Path, check still works
      include VectorSalad::Mixins::At
      attr_reader :radius

      # Create a perfectly round circle.
      #
      # @example
      #   new(100)
      Contract Pos, {} => Circle
      def initialize(radius, **options)
        @options = options
        @radius = radius
        @x, @y = 0, 0
        self
      end

      # Convert the shape to a path
      def to_path
        # http://stackoverflow.com/a/13338311
        # c = 4 * (Math.sqrt(2) - 1) / 3
        # c = 0.5522847498307936
        #
        # http://spencermortensen.com/articles/bezier-circle/
        c = 0.551915024494
        d = c * @radius
        Path.new(
          N.n(@x + @radius, @y),
          N.c(@x + @radius, @y + d),
          N.c(@x + d, @y + @radius),
          N.n(@x, @y + @radius),
          N.c(@x - d, @y + @radius),
          N.c(@x - @radius, @y + d),
          N.n(@x - @radius, @y),
          N.c(@x - @radius, @y - d),
          N.c(@x - d, @y - @radius),
          N.n(@x, @y - @radius),
          N.c(@x + d, @y - @radius),
          N.c(@x + @radius, @y - d),
          N.n(@x + @radius, @y),
          **@options
        )
      end

      # Flatten the circle into many small straight line segments.
      #
      # @param fn The number of segments
      Contract Maybe[Num] => Path
      def to_simple_path(fn = nil)
        fn ||= (@radius * 4).ceil

        nodes = []
        arc = (2.0 * Math::PI) / fn
        fn.times do |t|
          a = arc * t
          x = @radius * Math.cos(a) + @x
          y = @radius * Math.sin(a) + @y
          nodes << N.n(x, y)
        end
        Path.new(*nodes, **@options)
      end
    end
  end
end
