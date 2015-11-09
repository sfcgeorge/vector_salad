r = 80
pentagon(r, fill: "green", stroke: "black", stroke_width: 3)[r, r]

custom(:eye) do |height, **options|
  oval(height / 2, height, fill: "white")
  oval(height / 4, height / 2)[0, height * 0.3]
end

eye(r / 2).move(r * 0.7, r)
eye(r / 2).move(r * 1.3, r)
