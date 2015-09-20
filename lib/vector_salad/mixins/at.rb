module VectorSalad
  module Mixins
    # Mixin for positioning shapes.
    module At
      include Contracts

      # Change the absolute x, y coordinates of the shape.
      Contract Num, Num => Any
      def [](x, y)
        @x, @y = x, y
        self
      end

      # Get the x, y coordinates of the shape.
      Contract None => Coords
      def at
        [@x, @y]
      end

      # Move the shape relatively.
      Contract Num, Num => Any
      def move(x, y)
        shape = clone
        shape[shape.at[0] + x, shape.at[1] + y]
        shape
      end
    end
  end
end
