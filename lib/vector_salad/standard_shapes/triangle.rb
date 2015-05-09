require "vector_salad/standard_shapes/polygon"

module VectorSalad
  module StandardShapes
    class Triangle < Polygon
      # Create an equilateral triangle.
      #
      # Examples:
      #   new(100)
      def initialize(radius, **options)
        super(3, radius, **options)
      end
    end
  end
end
