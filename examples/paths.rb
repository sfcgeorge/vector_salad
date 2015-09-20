# A simple triangle using arrays as nodes
path([0,0], [100,10], [70,100])

# A house, including quadratic node and options
path(
  N.n(150,50),
  N.n(200,20),
  N.n(250,50),
  N.n(250,150),
  N.n(210,150),
  N.n(210,100),
  N.q(200,90),
  N.n(190,100),
  N.n(190,150),
  N.n(150,150),
  fill: 'red',
  stroke: 'black',
  stroke_width: 2
)

# A wave using mirror nodes
path(
  N.n(300,100),
  N.q(380,0),
  N.n(400,100),
  N.m,
  N.n(500,100),
  N.n(500,200),
  N.n(300,200),
  fill: 'blue'
)

# A candle flame with mirrored cubic nodes
# Tricky using cubic nodes but still possible by hand
path(
  N.n(105, 200), # tip
  N.c(95, 220), # right inner top curve
  N.c(95, 240),
  N.n(110, 255), # right bulge
  N.m,
  N.c(120, 300), # right outer base curve
  N.n(90, 300), # bottom
  N.m,
  N.c(55, 275),
  N.n(65, 250), # left bulge
  N.m,
  N.c(80, 220), # left outer tip curve
  N.n(105, 200),
  fill: :yellow,
  stroke: :orange,
  stroke_width: 5,
  stroke_linejoin: :miter,
  stroke_miterlimit: 10
)

# A smooth Spiro curve, very beautiful
path(
  N.n(100, 370),
  N.s(200, 420),
  N.s(250, 400),
  N.s(300, 440),
  N.n(400, 300),
  fill: 'purple'
)

# Another smooth Spiro, easily forming an egg
path(
  N.s(100, 450),
  N.s(50, 500),
  N.s(100, 600),
  N.s(150, 500),
  fill: 'turquoise'
)

# An open Spiro path, showing :left and :right nodes
path(
  N.n(200, 500),
  N.r(300, 500),
  N.g(350, 500),
  N.s(350, 580),
  N.l(250, 650),
  N.n(250, 700),
  closed: false,
  fill: 'none',
  stroke: 'green',
  stroke_width: 6
)
