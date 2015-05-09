require "vector_salad/standard_shapes/polygon"

module VectorSalad
  module StandardShapes
    class Pentagon < Polygon
      # Create a regular pentagon.
      #
      # Examples:
      #   new(100)
      def initialize(radius, **options)
        super(5, radius, **options)
      end
    end
  end
end
