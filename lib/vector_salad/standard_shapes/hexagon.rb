require "vector_salad/standard_shapes/polygon"

module VectorSalad
  module StandardShapes
    # Regular hexagon shape.
    class Hexagon < Polygon
      # Create a regular hexagon.
      #
      # @example
      #   new(100)
      def initialize(radius, **options)
        super(6, radius, **options)
      end
    end
  end
end
