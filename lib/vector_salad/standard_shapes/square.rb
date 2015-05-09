require "vector_salad/standard_shapes/path"
require "vector_salad/standard_shapes/n"
require "vector_salad/mixins/at"

module VectorSalad
  module StandardShapes
    class Square < BasicShape
      include VectorSalad::Mixins::At
      attr_reader :size

      # Create a square with equal width and height.
      #
      # Examples:
      #   new(100).detail 'Square sides 100x100 at 0,0.'
      Contract Pos, {} => Square
      def initialize(size, **options)
        @size = size
        @options = options
        @x, @y = 0, 0
        self
      end

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
