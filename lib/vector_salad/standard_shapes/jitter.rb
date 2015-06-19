require 'vector_salad/standard_shapes/transform'

module VectorSalad
  module StandardShapes
    class Jitter < Transform
      # Moves the contained shapes by the specified x and y amounts relatively.
      #
      # Examples:
      #
      #   move(50, -10) do
      #     triangle(30, at: [50, -50])
      #     pentagon(40, at: [50, -100])
      #   end

      # Jitter the position of nodes in a Path randomly.
      # @param max The maximum offset
      # @param min The minimum offset (default 0)
      # @param fn The quantization number of sides
      Contract Num, { min: Maybe[Num],
                      fn: Maybe[Fixnum],
                      canvas: VectorSalad::Canvas
                    }, Proc => Any
      def initialize(max, min: 0, fn: nil, canvas:, **_options, &block)
        instance_eval(&block) # inner_canvas is populated

        @canvas.each do |shape|
          canvas << shape.jitter(max, min: min, fn: fn)
        end
      end
    end
  end
end
