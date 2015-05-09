require "vector_salad/standard_shapes/transform"

module VectorSalad
  module StandardShapes
    class Move < Transform
      # Moves the contained shapes by the specified x and y amounts relatively.
      #
      # Examples:
      #
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
