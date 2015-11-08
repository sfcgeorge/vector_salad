require "contracts"
require "contracts_builtin"

module VectorSalad
  module Mixins
    # Mixin for transforming shapes.
    module Transforms
      include Contracts::Core
      include Contracts::Builtin

      # Move the shape absolutely.
      Contract Num, Num => Any
      def [](x, y)
        each_send(:[], x, y)
      end

      # Move the shape relatively.
      Contract Num, Num => Any
      def move(x, y)
        each_send(:move, x, y)
      end

      # Rotates the shape by the specified angle about the origin.
      Contract Num => Any
      def rotate(angle)
        each_send(:rotate, angle)
      end

      # Scale a shape by multiplier about the origin.
      Contract Num => Any
      def scale(multiplier)
        each_send(:scale, multiplier)
      end
    end
  end
end
