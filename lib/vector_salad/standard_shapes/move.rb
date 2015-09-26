require "vector_salad/standard_shapes/transform"
require "vector_salad/canvas"

module VectorSalad
  module StandardShapes
    # Move the contained shapes.
    class Move < Transform
      # Moves the contained shapes by the specified x and y amounts relatively.
      #
      # @example
      #   Move.new do
      #     canvas << Triangle.new(30, at: [50, -50])
      #     canvas << Pentagon.new(40, at: [50, -100])
      #   end
      #
      # @example Using DSL:
      #   move(50, -10) do
      #     triangle(30, at: [50, -50])
      #     pentagon(40, at: [50, -100])
      #   end
      Contract Coord, Coord, { canvas: VectorSalad::Canvas }, Proc => Any
      def initialize(x, y, canvas:, **_options, &block)
        instance_eval(&block) # inner_canvas is populated

        @canvas.each do |shape|
          canvas << shape.move(x, y)
        end
      end
    end
  end
end
