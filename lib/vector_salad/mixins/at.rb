module VectorSalad
  module Mixins
    module At
      include Contracts
      attr_reader :at

      # Change the absolute x,y coordinates of the shape.
      Contract Coords => Any
      def at=(xy)
        @at = xy
        self
      end

      # Move the shape relatively.
      Contract Num, Num => Any
      def move(x, y)
        shape = clone
        shape.at = [shape.at[0]+x, shape.at[1]+y]
        shape
      end
    end
  end
end
