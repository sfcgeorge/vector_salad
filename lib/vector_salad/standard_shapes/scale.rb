require 'vector_salad/standard_shapes/transform'

module VectorSalad
  module StandardShapes
    class Scale < Transform
      # Scale the contained shapes by multiplier about the origin.
      # Supply just 1 multiplier to scale evenly, or x and y multipliers
      # to stretch or squash the axies.
      # @param x_multiplier 1 is no change, 2 is double size, 0.5 is half, etc.
      #
      # Examples:
      #
      #   scale(2) do
      #     triangle(30, at: [50, -50])
      #     pentagon(40, at: [50, -100])
      #   end
      #
      #   scale(2, 0.5) do
      #     triangle(30, at: [50, -50])
      #     pentagon(40, at: [50, -100])
      #   end
      Contract Coord, Coord, { canvas: VectorSalad::Canvas }, Proc => Any
      def initialize(x_multiplier,
                     y_multiplier = x_multiplier,
                     canvas:, **_options, &block)
        instance_eval(&block) # inner_canvas is populated

        @canvas.each do |shape|
          canvas << shape.scale(x_multiplier, y_multiplier)
        end
      end
    end
  end
end
