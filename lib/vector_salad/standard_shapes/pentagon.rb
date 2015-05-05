require 'vector_salad/standard_shapes/polygon'

module VectorSalad
  module StandardShapes
    class Pentagon < Polygon
      # Create a regular pentagon.
      #
      # Examples:
      #   new(100)
      #   new(100, at: [50,50])
      def initialize(radius, at: [0,0], **options)
        super(5, radius, at: at, **options)
      end
    end
  end
end
