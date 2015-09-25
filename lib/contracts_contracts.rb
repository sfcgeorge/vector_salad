# @api private
module Contracts
  class Coords
    def self.valid?(val)
      Maybe[[Num, Num]].valid? val
    end

    def self.to_s
      "[Num, Num] an x,y coordinate array"
    end
  end

  class Coord
    def self.valid?(val)
      Num.valid? val
    end

    def self.to_s
      "Num; a coordinate"
    end
  end

  class PolySides
    def self.valid?(val)
      val && val.is_a?(Integer) && val >= 3
    end

    def self.to_s
      "Int; sides of the polygon, minimum of 3"
    end
  end
end
