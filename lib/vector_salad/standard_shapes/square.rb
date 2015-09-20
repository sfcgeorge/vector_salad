require "vector_salad/standard_shapes/path"
require "vector_salad/standard_shapes/n"
require "vector_salad/mixins/at"

module VectorSalad
  module StandardShapes
    # Square shape with equal width and height.
    class Square < BasicShape
      include VectorSalad::Mixins::At
      attr_reader :size

      # Create a square with equal width and height.
      #
      # @example Square with sides 100x100
      #   new(100)
      Contract Pos, {} => Square
      def initialize(size, **options)
        @size = size
        @options = options
        @x, @y = 0, 0
        self
      end

      # Convert the shape to a path
      def to_path
        Path.new(
          N.n(@x, @y),
          N.n(@x, @y + @size),
          N.n(@x + @size, @y + @size),
          N.n(@x + @size, @y),
          **@options
        )
      end
    end
  end
end
