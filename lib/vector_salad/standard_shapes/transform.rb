require "contracts"
require "contracts_builtin"
require "vector_salad/dsl"
require "vector_salad/canvas"

module VectorSalad
  module StandardShapes
    # @api private
    class Transform
      include VectorSalad::DSL
      include VectorSalad::StandardShapes
      include Contracts::Core
      include Contracts::Builtin

      def canvas
        @canvas ||= VectorSalad::Canvas.new
      end
    end
  end
end
