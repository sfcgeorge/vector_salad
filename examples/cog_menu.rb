U = 20 # "unit", set to 1 for export at real scale, 10 or more for designing
GRID = true # turn on or off the grid lines

# Add ~ method for multiplying a number by the "unit"
class ::Fixnum
  def ~
    self * U
  end
end

union do
  difference do
    union do
      union do
        (n_teeth = 4).times do |t|
          a = 180.0 / n_teeth * t
          rect(~2, ~16)[~-1, ~-8].rotate(a)
        end
      end

      circle(~6)
    end
    circle(~4)
  end

  iso_tri(~6, ~3, fill: :red).flip_x.move(0, ~2)
end.move(~8, ~8)

(1..15).each do |i| # 16px grid
  path([~i, 0], [~i, ~16], stroke: "orange", opacity: 0.6)
  path([0, ~i], [~16, ~i], stroke: "orange", opacity: 0.6)
end if GRID
