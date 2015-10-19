# require "contracts"
# require "contracts_builtin"
# require "vector_salad/dsl"
# require "vector_salad/canvas"

# module VectorSalad
  # module StandardShapes
    # # @api private
    # class Transform
      # include VectorSalad::DSL
      # include VectorSalad::StandardShapes
      # include Contracts::Core
      # include Contracts::Builtin
    # end
  # end
# end

# require "vector_salad/standard_shapes/group_dsl"
require "vector_salad/standard_shapes/transform"
require "vector_salad/canvas"
require "vector_salad/mixins/transforms"

module VectorSalad
  module StandardShapes
    # Move the contained shapes.
    class Group < BasicShape
      include VectorSalad::Mixins::Transforms
      include VectorSalad::DSL
      include VectorSalad::StandardShapes

      attr_accessor :canvas

      def initialize(**_options, &block)
        # @canvas = GroupDSL.new(&block).canvas if block
        instance_eval(&block) if block # inner_canvas is populated
      end

      def canvas
        @canvas ||= VectorSalad::Canvas.new
      end

      # Returns self
      def to_path
        self
      end

      private

      def each_send(method, *args, &block)
        @canvas.each do |shape|
          shape.send(method, *args, &block)
        end
        self
      end
    end
  end
end
