require "vector_salad/standard_shapes/clip"

module VectorSalad
  module StandardShapes
    # Exclude the contained shapes.
    class Exclusion < Clip
      # The first path is used as the subject, subsequent paths are excluded
      # from the first.
      #
      # @example
      #   Exclusion.new do
      #     canvas << Path.new([0,0], [90,90], [0,90])
      #     canvas << Path.new([50,0], [95,0], [50, 70])
      #   end
      #
      # @example Using DSL:
      #   exclusion do
      #     path([0,0], [90,90], [0,90])
      #     path([50,0], [95,0], [50, 70])
      #   end
      def initialize(**options, &block)
        super(:xor, **options, &block)
      end
    end
  end
end
