module VectorSalad
  module Mixins
    # Mixin for positioning shapes.
    module At
      include Contracts

      # Set the x, y coordinates of the shape.
      Contract Coord, Coord => Any
      def [](x, y)
        shape = clone
        shape.at = [x, y]
        shape
      end

      # Get the x, y coordinates of the shape.
      Contract None => Coords
      def at
        [@x, @y]
      end

      # Set the x, y coordinates of the shape directly.
      Contract Coords => Any
      def at=(at)
        @x, @y = *at
        self
      end

      # Move the shape relatively.
      Contract Coord, Coord => Any
      def move(x, y)
        shape = clone
        shape.at = [shape.at[0] + x, shape.at[1] + y]
        shape
      end
    end
  end
end
