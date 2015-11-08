require "contracts_builtin"
require "vector_salad/standard_shapes/basic_shape"
require "vector_salad/standard_shapes/path"
require "vector_salad/mixins/at"

module VectorSalad
  module StandardShapes
    # Regular polygon shape.
    class Polygon < BasicShape
      include VectorSalad::Mixins::At
      attr_reader :sides

      # Create a regular polygon with a specified number of sides.
      #
      # @example
      #   new(6, 100)
      Contract PolySides, Pos, {} => Polygon
      def initialize(sides, radius, **options)
        @sides, @radius = sides, radius
        @options = options
        @x, @y = 0, 0
        self
      end

      # Convert the shape to a path
      def to_path
        nodes = []
        angle = 2 * Math::PI / @sides
        theta = angle / 2 + Math::PI / 2
        @sides.times do |n|
          nodes[n] = []
          nodes[n][0] = @radius * Math.cos(angle * n + theta) + @x
          nodes[n][1] = @radius * Math.sin(angle * n + theta) + @y
        end

        Path.new(*nodes, **@options)
      end
    end
  end
end
