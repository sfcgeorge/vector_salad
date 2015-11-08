require "vector_salad/standard_shapes/clip"

module VectorSalad
  module StandardShapes
    # Unite the contained shapes.
    class Union < Clip
      # The first path is used as the subject, subsequent paths are united
      # with the first.
      #
      # @example
      #   Union.new do
      #     canvas << Path.new([0,0], [90,90], [0,90])
      #     canvas << Path.new([50,0], [95,0], [50, 70])
      #   end
      #
      # @example Using DSL:
      #   union do
      #     path([0,0], [90,90], [0,90])
      #     path([50,0], [95,0], [50, 70])
      #   end
      def initialize(**options, &block)
        super(:union, **options, &block)
      end
    end
  end
end
