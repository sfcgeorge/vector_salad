path(
  N.n(0,0),
  N.c(50,200),
  N.c(200,250),
  N.n(300,0)
).to_simple_path

# A candle flame with mirrored cubic nodes
# Tricky using cubic nodes but still possible by hand
path(
  N.n(105, 200), # tip
  N.c(95, 220), # right inner top curve
  N.c(95, 240),
  N.n(110, 255), # right bulge
  N.r,
  N.c(120, 300), # right outer base curve
  N.n(90, 300), # bottom
  N.r,
  N.c(55, 275),
  N.n(65, 250), # left bulge
  N.r,
  N.c(80, 220), # left outer tip curve
  N.n(105, 200),
  fill: :yellow,
  stroke: :orange,
  stroke_width: 5,
  stroke_linejoin: :miter,
  stroke_miterlimit: 10
).to_simple_path
