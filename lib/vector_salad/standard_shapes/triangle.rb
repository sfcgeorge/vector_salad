require "vector_salad/standard_shapes/polygon"

module VectorSalad
  module StandardShapes
    # Equilateral triangle shape.
    class Triangle < Polygon
      # Create a new equilateral triangle.
      #
      # @example
      #   new(100)
      def initialize(radius, **options)
        super(3, radius, **options)
      end
    end
  end
end
