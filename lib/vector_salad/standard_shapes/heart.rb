require "vector_salad/standard_shapes/polygon"

module VectorSalad
  module StandardShapes
    class Heart < BasicShape
      # Create a perfect heart
      Contract Pos, {} => Heart
      def initialize(size, **options)
        r = size / 4 # two circles next to each other
        r2 = Math.sqrt(2 * r**2)
        the_little_bit = r2 - r
        the_long_one = size + 2 * the_little_bit
        l = Math.sqrt(the_long_one**2 / 2) - r

        @shape = Union.new(**options) do
          circle(r)[-r, 0]
          circle(r)[r, 0]
          difference do
            square(l)[-l/2, -l/2].rotate(45).move(0, r2 / 2)
            square(l * 2)[-l, -l * 2]
          end
        end
        self
      end

      def to_path
        @shape
      end
    end
  end
end
