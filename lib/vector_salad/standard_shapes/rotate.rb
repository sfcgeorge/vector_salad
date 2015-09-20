require "vector_salad/standard_shapes/transform"

module VectorSalad
  module StandardShapes
    # Rotates the contained shapes by the specified angle about the origin.
    class Rotate < Transform
      # @example
      #   rotate(45) do
      #     triangle(30, at: [50, -50])
      #     pentagon(40, at: [50, -100])
      #   end
      Contract Num, { canvas: VectorSalad::Canvas }, Proc => Any
      def initialize(angle, canvas:, **_options, &block)
        instance_eval(&block) # inner_canvas is populated

        @canvas.each do |shape|
          canvas << shape.rotate(angle)
        end
      end
    end
  end
end
