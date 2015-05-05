rect 450, 250, fill: :none

# A smooth Spiro curve, very beautiful
path(
  n1 = N.n(50, 120),
  s1 = N.s(150, 170),
  s2 = N.s(200, 150),
  s3 = N.s(250, 190),
  n2 = N.n(350, 50),
  closed: false,
  fill: :red,
  stroke: :black,
  stroke_width: 4
)

circle(5, at: n1.at, fill: :green)
circle(5, at: n2.at, fill: :green)
circle(5, at: s1.at, fill: :blue)
circle(5, at: s2.at, fill: :blue)
circle(5, at: s3.at, fill: :blue)
