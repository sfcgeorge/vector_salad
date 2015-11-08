require "vector_salad/canvas"
require "vector_salad/standard_shapes/transform"

module VectorSalad
  module StandardShapes
    # Jitter the position of nodes in the contained shapes randomly.
    class Jitter < Transform
      # @example
      #   Jitter.new(5) do
      #     canvas << Triangle.new(30, at: [50, -50])
      #     canvas << Pentagon.new(40, at: [50, -100])
      #   end
      #
      # @example Using DSL:
      #   jitter(5) do
      #     triangle(30, at: [50, -50])
      #     pentagon(40, at: [50, -100])
      #   end
      #
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
