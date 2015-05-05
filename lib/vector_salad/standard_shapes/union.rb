require 'vector_salad/standard_shapes/clip'
require 'vector_salad/standard_shapes/multi_path'

module VectorSalad
  module StandardShapes
    class Union < Clip
      # Unite paths.
      # The first path is used as the subject, subsequent paths are united
      # with the first.
      #
      # Examples:
      #
      #   Union.new do
      #     canvas << Path.new([0,0], [90,90], [0,90])
      #     canvas << Path.new([50,0], [95,0], [50, 70])
      #   end
      #
      #   # Using DSL:
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
