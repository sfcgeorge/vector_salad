require 'vector_salad/standard_shapes/clip'
require 'vector_salad/standard_shapes/multi_path'

module VectorSalad
  module StandardShapes
    class Intersection < Clip
      # Intersect paths.
      # The first path is used as the subject, subsequent paths are intersected
      # with the first.
      #
      # Examples:
      #
      #   Intersection.new do
      #     canvas << Path.new([0,0], [90,90], [0,90])
      #     canvas << Path.new([50,0], [95,0], [50, 70])
      #   end
      #
      #   # Using DSL:
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
