require "vector_salad/standard_shapes/polygon"

module VectorSalad
  module StandardShapes
    # Regular pentagon shape.
    class Pentagon < Polygon
      # Create a regular pentagon.
      #
      # @example
      #   new(100)
      def initialize(radius, **options)
        super(5, radius, **options)
      end
    end
  end
end
