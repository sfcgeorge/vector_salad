require 'vector_salad/standard_shapes/clip'
require 'vector_salad/standard_shapes/multi_path'

module VectorSalad
  module StandardShapes
    class Difference < Clip
      # Subtract paths.
      # The first path is used as the subject, subsequent paths are subtracted
      # from the first.
      #
      # Examples:
      #
      #   Difference.new do
      #     canvas << Path.new([0,0], [90,90], [0,90])
      #     canvas << Path.new([50,0], [95,0], [50, 70])
      #   end
      #
      #   # Using DSL:
      #   difference do
      #     path([0,0], [90,90], [0,90])
      #     path([50,0], [95,0], [50, 70])
      #   end
      def initialize(**options, &block)
        super(:difference, **options, &block)
      end
    end
  end
end
