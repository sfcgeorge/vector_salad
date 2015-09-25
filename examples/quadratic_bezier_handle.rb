rect 400, 300, fill: :none

path(
  n1 = N.n(20, 280),
  h1 = N.q(150, 50),
  n2 = N.n(380, 280),
  closed: false,
  fill: :red,
  stroke: :black,
  stroke_width: 4
)

path(n1, N.n(*h1.at), closed: false, stroke: :blue, stroke_width: 2)
circle(4, fill: :blue)[*h1.at]
path(n2, N.n(*h1.at), closed: false, stroke: :blue, stroke_width: 2)

circle(4, fill: :green)[*n1.at]
circle(4, fill: :green)[*n2.at]
