module VectorSalad
  # Code adapted from:
  # http://jeremykun.com/2013/05/11/bezier-curves-and-picasso/
  #
  # Interpolate a cubic bezier spline into straight line segments,
  # using the De Casteljau algorithm.
  #
  # @api private
  class Interpolate
    TOLERANCE = 0.2 # anything below 50 is roughly good-looking

    def initialize
      @nodes = []
    end

    def casteljau(curve)
      if flat_enough? curve
        @nodes << curve[3]
      else
        halves = subdivide(curve)
        casteljau(halves[0])
        casteljau(halves[1])
      end
    end

    # Early stopping function for the Casteljau algorithm.
    # Is the curve flat enough for visual purposes?
    def flat_enough?(curve)
      ax = (3.0 * curve[1][0] - 2.0 * curve[0][0] - curve[3][0])**2
      ay = (3.0 * curve[1][1] - 2.0 * curve[0][1] - curve[3][1])**2
      bx = (3.0 * curve[2][0] - curve[0][0] - 2.0 * curve[3][0])**2
      by = (3.0 * curve[2][1] - curve[0][1] - 2.0 * curve[3][1])**2

      [ax, bx].max + [ay, by].max <= TOLERANCE
    end

    def midpoint(p, q)
      [(p[0] + q[0]) / 2.0, (p[1] + q[1]) / 2.0]
    end

    def midpoints(points)
      midpoints = Array.new(points.length - 1)
      midpoints.each_index do |i|
        midpoints[i] = midpoint(points[i], points[i + 1])
      end
      midpoints
    end

    def subdivide(curve)
      first = midpoints(curve)
      second = midpoints(first)
      third = midpoints(second)

      [[curve[0], first[0], second[0], third[0]],
       [third[0], second[1], first[2], curve[3]]]
    end
  end
end
