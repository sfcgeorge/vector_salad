require "vector_salad/standard_shapes/basic_shape"
require "vector_salad/standard_shapes/path"
require "vector_salad/standard_shapes/n"
require "vector_salad/mixins/at"

module VectorSalad
  module StandardShapes
    # Isosceles or right-angle triangle shape.
    class IsoTri < BasicShape
      include VectorSalad::Mixins::At

      attr_reader :height

      # Create an isosceles or right-angle triangle.
      #
      # @example
      #   new(100)
      #   new(100, 150)
      #
      # @param width (defaults to height*2).
      Contract Args[Pos], {} => IsoTri
      def initialize(width = nil, height, **options)
        width = height * 2 if width.nil?
        @width, @height = width, height
        @options = options
        @x, @y = 0, 0
        self
      end

      # Convert the shape to a path
      def to_path
        Path.new(
          N.n(@x, @y),
          N.n(@x - @width / 2, @y + @height),
          N.n(@x + @width / 2, @y + @height),
          **@options
        )
      end
    end
  end
end
