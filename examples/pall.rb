size = 300 # background size
r = size * 0.4 # body radius
body_style = { fill: "green", stroke: "black", stroke_width: 3 }

square(size, fill: "skyblue") # background sky

custom(:eye) do |height, **options|
  oval(height / 2, height, fill: "white") # white
  oval(height / 4, height / 2)[height * 0.1, height * 0.3] # pupil
end

move(size / 2, size / 2) do
  pentagon(r, body_style)

  eye(r / 2).move(-r * 0.3, 0)
  eye(r / 2).move(r * 0.3, 0)

  circle(r / 4, body_style)[-r * 0.6, r * 0.8] # left hand
  circle(r / 4, body_style)[r * 0.6, r * 0.8] # right hand
end
