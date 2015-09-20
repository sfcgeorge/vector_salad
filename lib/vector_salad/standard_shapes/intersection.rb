require "vector_salad/standard_shapes/clip"
require "vector_salad/standard_shapes/multi_path"

module VectorSalad
  module StandardShapes
    # Intersect the contained shapes.
    class Intersection < Clip
      # The first path is used as the subject, subsequent paths are intersected
      # with the first.
      #
      # @example
      #   Intersection.new do
      #     canvas << Path.new([0,0], [90,90], [0,90])
      #     canvas << Path.new([50,0], [95,0], [50, 70])
      #   end
      #
      # @example Using DSL:
      #   intersection do
      #     path([0,0], [90,90], [0,90])
      #     path([50,0], [95,0], [50, 70])
      #   end
      def initialize(**options, &block)
        super(:intersection, **options, &block)
      end
    end
  end
end
