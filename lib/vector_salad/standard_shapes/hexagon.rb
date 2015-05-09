require 'vector_salad/standard_shapes/polygon'

module VectorSalad
  module StandardShapes
    class Hexagon < Polygon
      # Create a regular hexagon.
      #
      # Examples:
      #   new(100)
      def initialize(radius, **options)
        super(6, radius, **options)
      end
    end
  end
end
