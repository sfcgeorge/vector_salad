#custom(:grass) do |width, height, at: [0,0], **options|
def grass(width, height, at: [0,0], **options)
  x_jit = width * 4
  y_jit = height / 3

  x_tip = at[0]+width/2+Random.rand(-x_jit..x_jit)
  y_tip = at[1]-height+Random.rand(-y_jit..y_jit)
  x_mid = at[0]-(at[0]-x_tip)/2
  y_mid = at[1]-(at[1]-y_tip)/2
  path(
    N.n(at[0], at[1]),
    N.n(at[0]+width, at[1]),
    N.s(x_mid+width, y_mid),
    N.n(x_tip, y_tip),
    N.s(x_mid, y_mid),
    **options
  )
end

width = 600
height = 800

# Sky
rect(width, height, fill: 'skyblue')

# Sun
circle(width/3, fill: 'yellow')

# Grass
grass_w = 8
grass_h = height / 3
(width/grass_w).times do |i|
  grass(grass_w, grass_h, at: [i*grass_w, height], fill: 'green')
end

def bunny(u, at: [0,0], **options)
  stroke = '#222'
  outline = u/4
  detail = outline*0.85
  # Bunny outline
  path(
    N.n(at[0], at[1]+u*1),
    N.r(at[0], at[1]-u*4),
    N.g(at[0]+u, at[1]-u*6),
    N.l(at[0]+u*2, at[1]-u*4),
    N.r(at[0]+u*2, at[1]-u*3),
    N.g(at[0]+u*3, at[1]-u*1), #mid ear dip
    N.l(at[0]+u*4, at[1]-u*3),
    N.r(at[0]+u*4, at[1]-u*4),
    N.g(at[0]+u*5, at[1]-u*6),
    N.l(at[0]+u*6, at[1]-u*4),
    N.n(at[0]+u*6, at[1]+u*1),
    N.s(at[0]+u*3, at[1]+u*4), #chin
    fill: 'white',
    stroke: stroke,
    stroke_width: outline
  )
  # Bunny left ear
  path(
    N.n(at[0]+u*0.5, at[1]-u*2),
    N.r(at[0]+u*0.5, at[1]-u*4),
    N.s(at[0]+u, at[1]-u*5.5),
    N.l(at[0]+u*1.5, at[1]-u*4),
    N.n(at[0]+u*1.5, at[1]-u*2),
    closed: false,
    #stroke: 'black',
    #stroke_width: outline,
    fill: 'lightpink'
  )
  # Bunny right ear
  path(
    N.n(at[0]+u*4.5, at[1]-u*2),
    N.r(at[0]+u*4.5, at[1]-u*4),
    N.s(at[0]+u*5, at[1]-u*5.5),
    N.l(at[0]+u*5.5, at[1]-u*4),
    N.n(at[0]+u*5.5, at[1]-u*2),
    closed: false,
    #stroke: 'black',
    #stroke_width: outline,
    fill: 'lightpink'
  )
  # Bunny eyes
  circle(u/4, at: [at[0]+u*2, at[1]+u*0.5])
  circle(u/4, at: [at[0]+u*4, at[1]+u*0.5])
  # Bunny nose
  circle(u/3, at: [at[0]+u*3, at[1]+u*1.5])
  path(
    N.n(at[0]+u*3.7, at[1]+u*2.4),
    N.s(at[0]+u*3.2, at[1]+u*2.2),
    N.n(at[0]+u*3,   at[1]+u*1.5),
    N.s(at[0]+u*2.8, at[1]+u*2.2),
    N.n(at[0]+u*2.3, at[1]+u*2.4),
    closed: false,
    fill: 'none',
    stroke: 'black',
    stroke_width: detail,
    stroke_linecap: 'round'
  )
  # Puff tail
  circle(u, at: [at[0]+u*3, at[1]+u*10],
    fill: 'white',
    stroke: stroke,
    stroke_width: outline
  )
  # Bunny body
  path(
    N.g(at[0]+u*3, at[1]+u*4),
    N.l(at[0],      at[1]+u*7),
    N.r(at[0],      at[1]+u*10),
    N.s(at[0]-u,   at[1]+u*11),
    N.s(at[0]-u*3, at[1]+u*12), #toe left
    N.l(at[0]-u,   at[1]+u*13),
    N.r(at[0],      at[1]+u*13),
    N.l(at[0]+u*2, at[1]+u*11),
    N.r(at[0]+u*2, at[1]+u*10.5), #midleft
    N.g(at[0]+u*3, at[1]+u*9), #midleft
    N.l(at[0]+u*4, at[1]+u*10.5), #midright
    N.r(at[0]+u*4, at[1]+u*11),
    N.l(at[0]+u*6, at[1]+u*13),
    N.r(at[0]+u*7,   at[1]+u*13),
    N.s(at[0]+u*9, at[1]+u*12), #toe right
    N.s(at[0]+u*7,   at[1]+u*11),
    N.l(at[0]+u*6,      at[1]+u*10),
    N.r(at[0]+u*6,      at[1]+u*7),
    fill: 'white',
    stroke: stroke,
    stroke_width: outline
  )
  # Feet
  path(
    N.n(at[0]-u*2.9, at[1]+u*11.7),
    N.n(at[0]-u*2, at[1]+u*11.7),
    closed: false,
    fill: 'none',
    stroke: stroke,
    stroke_linecap: 'round',
    stroke_width: outline
  )
  path(
    N.n(at[0]-u*2.9, at[1]+u*12.3),
    N.n(at[0]-u*2, at[1]+u*12.3),
    closed: false,
    fill: 'none',
    stroke: stroke,
    stroke_linecap: 'round',
    stroke_width: outline
  )
  path(
    N.n(at[0]+u*8.9, at[1]+u*11.7),
    N.n(at[0]+u*8, at[1]+u*11.7),
    closed: false,
    fill: 'none',
    stroke: stroke,
    stroke_linecap: 'round',
    stroke_width: outline
  )
  path(
    N.n(at[0]+u*8.9, at[1]+u*12.3),
    N.n(at[0]+u*8, at[1]+u*12.3),
    closed: false,
    fill: 'none',
    stroke: stroke,
    stroke_linecap: 'round',
    stroke_width: outline
  )
  # Paws
  path(
    N.n(at[0]+u*1.5, at[1]+u*6),
    N.r(at[0]+u*1.5, at[1]+u*7),
    N.l(at[0]+u*3, at[1]+u*7),
    N.n(at[0]+u*3, at[1]+u*6),
    N.r(at[0]+u*3, at[1]+u*7),
    N.l(at[0]+u*4.5, at[1]+u*7),
    N.n(at[0]+u*4.5, at[1]+u*6),
    closed: false,
    fill: 'none',
    stroke: 'black',
    #stroke_linecap: 'round',
    stroke_width: detail
  )
  path(
    N.n(at[0]+u*2, at[1]+u*7.5),
    N.n(at[0]+u*2, at[1]+u*8),
    closed: false,
    fill: 'none',
    stroke: 'black',
    stroke_linecap: 'round',
    stroke_width: detail
  )
  path(
    N.n(at[0]+u*2.5, at[1]+u*7.5),
    N.n(at[0]+u*2.5, at[1]+u*8),
    closed: false,
    fill: 'none',
    stroke: 'black',
    stroke_linecap: 'round',
    stroke_width: detail
  )
  path(
    N.n(at[0]+u*4, at[1]+u*7.5),
    N.n(at[0]+u*4, at[1]+u*8),
    closed: false,
    fill: 'none',
    stroke: 'black',
    stroke_linecap: 'round',
    stroke_width: detail
  )
  path(
    N.n(at[0]+u*3.5, at[1]+u*7.5),
    N.n(at[0]+u*3.5, at[1]+u*8),
    closed: false,
    fill: 'none',
    stroke: 'black',
    stroke_linecap: 'round',
    stroke_width: detail
  )
end
bunny(width/18, at: [width/3, height*0.47])

# Grass
grass_w = 9
grass_h = height / 7
(width/grass_w/2).times do |i|
  grass(grass_w, grass_h, at: [i*grass_w*2-Random.rand(0..grass_w), height], fill: 'green')
end
