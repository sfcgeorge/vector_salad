require "vector_salad/standard_shapes/rect"
require "vector_salad/mixins/at"

module VectorSalad
  module StandardShapes
    # Square shape with equal width and height.
    class Square < Rect
      # Create a square with equal width and height.
      #
      # @example Square with sides 100x100
      #   new(100)
      Contract Pos, {} => Square
      def initialize(size, **options)
        super(size, size, **options)
        self
      end
    end
  end
end
