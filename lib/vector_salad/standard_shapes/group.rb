require "vector_salad/standard_shapes/transform"
require "vector_salad/canvas"
require "vector_salad/mixins/transforms"

module VectorSalad
  module StandardShapes
    # Group the contained shapes.
    class Group < BasicShape
      include VectorSalad::Mixins::Transforms
      include VectorSalad::DSL
      include VectorSalad::StandardShapes

      attr_accessor :canvas

      def initialize(**_options, &block)
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
        new_canvas = VectorSalad::Canvas.new
        @canvas.each do |shape|
          new_canvas << shape.send(method, *args, &block)
        end
        self.class.new.tap(&:canvas=.(new_canvas))
      end
    end
  end
end
