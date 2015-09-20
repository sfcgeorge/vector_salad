square(600, fill: "none") # background

def petal(radius, **options)
  width = radius / 4.6
  path(
    N.n(0, 0),
    N.s(-width, radius/2.0),
    N.n(0, radius),
    N.s(width, radius/2.0),
    **options
  )
end

(repeats = 18).times do |repeat|
  angle = 360.0 / repeats
  petal(250, fill: 'rgb(50, 155, 0)', opacity: 0.6)
    .rotate(angle * repeat).move(300, 300)
end
