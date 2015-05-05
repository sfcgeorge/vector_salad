def petal(size, **options)
  path(
    N.n(0, 0),
    N.s(-size / 10.0, size / 2.0),
    N.n(0, size),
    N.s(size / 10.0, size / 2.0),
    **options
  )
end

square(600, fill: "rgb(25, 0, 45)") # background

(layers = 8).times do |layer|
  (repeats = 25).times do |repeat|
    red = 25 + (230.0 / layers * (layer + 1)) # linear
    blue = 75 + (180.0 / (layers**2) * ((layer + 1)**2)) # exponential
    angle = 360.0 / repeats
    twist = angle / 2.0

    petal(250 - 250.0 / layers * layer, fill: "rgb(#{red}, 0, #{blue})")
      .rotate(angle * repeat + twist * layer).move(300, 300)
  end
end
