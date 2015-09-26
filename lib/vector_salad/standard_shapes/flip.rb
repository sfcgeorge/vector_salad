require "vector_salad/standard_shapes/transform"
require "vector_salad/canvas"

module VectorSalad
  module StandardShapes
    # Flip the contained shapes.
    class Flip < Transform
      # Flip the contained shapes on the specified axis.
      #
      # @example
      #   Flip.new(:x) do
      #     canvas << Triangle.new(30, at: [50, -50])
      #     canvas << Pentagon.new(40, at: [50, -100])
      #   end
      #
      # @example Using DSL:
      #   flip(:x) do
      #     triangle(30, at: [50, -50])
      #     pentagon(40, at: [50, -100])
      #   end
      Contract Or[:x, :y], { canvas: VectorSalad::Canvas }, Proc => Any
      def initialize(axis, canvas:, **_options, &block)
        instance_eval(&block) # inner_canvas is populated

        @canvas.each do |shape|
          canvas << shape.flip(axis)
        end
      end
    end
  end
end
