require "contracts"
require "contracts_contracts"

require "vector_salad/dsl"
require "vector_salad/canvas"
require "vector_salad/standard_shapes/path"

module VectorSalad
  module StandardShapes
    # @api private
    class Transform
      include VectorSalad::DSL
      include VectorSalad::StandardShapes
      include Contracts

      def canvas
        @canvas ||= VectorSalad::Canvas.new
      end
    end
  end
end
