require "vector_salad/standard_shapes/basic_shape"
require "vector_salad/standard_shapes/path"
require "vector_salad/standard_shapes/n"
require "vector_salad/mixins/at"

module VectorSalad
  module StandardShapes
    # Rectangle shape.
    class Rect < BasicShape
      include VectorSalad::Mixins::At
      attr_reader :width, :height

      # Create a rectangle with specified width and height.
      #
      # @example
      #   new(100, 200)
      Contract Pos, Pos, {} => Rect
      def initialize(width, height, **options)
        @width, @height = width, height
        @options = options
        @x, @y = 0, 0
        self
      end

      # Convert the shape to a path
      def to_path
        Path.new(
          N.n(@x, @y),
          N.n(@x, @y + @height),
          N.n(@x + @width, @y + @height),
          N.n(@x + @width, @y),
          **@options
        )
      end
    end
  end
end
