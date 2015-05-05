WIDTH, HEIGHT = 400, 600
(stripes = 15).times do |i|
  c = Random.rand(0..25)
  col1 = "rgb(#{30 - c}, #{30 - c}, #{150 - c})"
  col2 = "rgb(#{150 - c}, #{30 - c}, #{30 - c})"
  #col = [col1, col2].sample
  col = i.odd? ? col1 : col2
  rect(WIDTH, HEIGHT - HEIGHT / stripes * i, fill: col)
end
#rect(WIDTH, HEIGHT, fill: '#811')
#rect(WIDTH, HEIGHT / 2, fill: '#118')

def fox(size, at:, **options)
  x, y = at
  h = size
  w = size / 2.5

  contrast = options.merge(fill: 'white')

  # tail
  tail = path(
    N.n(w / 2, h / 2),
    N.s(w / 2 - w / 6, h + w / 3),
    N.s(-w / 3, h + w / 6),
    tip_n = N.n(-w - w / 3, h + w / 2), # tip
    N.s(-w / 4 * 3, h + w / 4 * 3),
    N.s(w / 2 + w * 0.8, h),
    N.n(w / 2, h / 2 - w / 12),
    **options
  ).move(x, y)
  # tail tip
  intersection(**contrast) do
    canvas << tail.shape
    circle(w.round, at: tip_n.move(x, y).at)
  end

  # body
  body = path(
    N.s(0, 0),
    N.l(-w / 2, h / 2),
    N.r(-w / 2, h - w / 2),
    N.s(-w / 3, h),
    N.l(-w / 6, h - w / 2),
    N.n(-w / 6, h / 2 + w / 6),
    N.s(0, h / 2),
    N.n(w / 6, h / 2 + w / 6),
    N.r(w / 6, h - w / 2),
    N.s(w / 3, h),
    N.l(w / 2, h - w / 2),
    N.r(w / 2, h / 2),
    **options
  ).move(x, y)
  # feet
  intersection(**contrast) do
    canvas << body.shape
    square(h, at: [x - w, y + size - size / 3])
  end

  # head
  head = path(
    N.s(0, 0), # chin
    N.g(w / 6, -w / 12),
    N.s(w / 2, -w),
    N.s(w / 3 + w / 12, -w - w / 12 * 3),
    N.s(w / 3, -w - w / 3), # ear tip
    N.s(w / 3 - w / 12, -w - w / 12 * 3),
    N.n(w / 6, -w),
    N.s(0, -w - w / 200), # head bump
    N.n(-w / 6, -w),
    N.s(-w / 3 + w / 12, -w - w / 12 * 3),
    N.s(-w / 3, -w - w / 3), # ear tip
    N.s(-w / 3 - w / 12, -w - w / 12 * 3),
    N.s(-w / 2, -w),
    N.g(-w / 6, -w / 12),
    **options
  ).move(x, y + w / 2)
  # ears
  ear = difference(**contrast, stroke: 'none') do
    difference do
      canvas << head.shape.clone
      circle((w * 1.08).round, at: [x, y + w / 2])
    end.scale(0.6).move(0.32 * x, 0.22 * y)
    square(size, at: [x - w / 6, y - w])
  end
  ear2 = ear.shape.to_path.paths.first.flip_y.move(x * 2, 0)
  ear2.options = { fill: 'white' }
  canvas << ear2
  # nose
  intersection do
    canvas << head.shape.clone
    circle((w / 9).round, at: [x, y + w / 2])
  end

  # eyes
  circle((w / 18).round, at: [x - w / 7, y - w / 6])
  circle((w / 18).round, at: [x + w / 7, y - w / 6])
end

fox(HEIGHT / 2, at: [WIDTH / 2, HEIGHT / 4],
  fill: 'orangered',
  stroke: 'black',
  stroke_width: 4
)

# show nodes
canvas.flat_map do |shape|
  shape.to_path.nodes.map do |n|
    #Circle.new(3, at: n.at, fill: 'grey')
  end if shape.class == VectorSalad::StandardShapes::Path
end.each { |n| canvas << n }
