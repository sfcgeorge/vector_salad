@width = 320.0
# Background
rect(@width, @width * 2, fill: "tan")

# Draw a row of repeating shapes at a y position cycling through colors
def row(shape, y)
  n, col = 16, %w(firebrick darkorange white saddlebrown black).shuffle
  (1..n - 1).each do |x|
    col.rotate! # cycle through the colors
    (options = shape.options.clone)[:fill] = col[0]
    (s = shape.clone).options = options
    canvas << s.move(@width / n * x, y)
  end
end

row(Circle.new(5), 15)

(1..7).each do |x| # Triangle snake
  if x.even?
    iso_tri(30, fill: "darkorange")[x * 40, -60].flip_x
  else
    iso_tri(30, fill: "firebrick")[x * 40, 30]
  end
end

row(Pentagon.new(6), 80)

# Toothy face
rect(320, 160, fill: "saddlebrown")[0, 100]

flip(:x) do # flip multiple shapes at once
  6.times { |x| iso_tri(30, 100, fill: "white")[x * 30 + 85, -200] }
  iso_tri(50, 20, fill: "black")[35, -145]
  iso_tri(50, 20, fill: "black")[285, -145]
  circle(7, fill: "firebrick")[35, -160]
  circle(7, fill: "firebrick")[285, -160]
end
7.times { |x| iso_tri(30, 100, fill: "white")[x * 30 + 70, @width / 2] }

row(Pentagon.new(6), 280)

# Triangle rosette
n, col1, col2 = 14, %w(firebrick white), %w(darkorange black)
n.times do |t|
  col1.rotate!
  col2.rotate!
  move(@width / 2, 450) do
    iso_tri(20, fill: col2[0])[0, -120].rotate(360.0 / n * t)
    iso_tri(25, fill: col1[0])[0, 120].rotate(360.0 / n * t + 180.0 / n)
  end
end
# "Diamond"
intersection(fill: "firebrick") do
  triangle(80).flip_x
  pentagon(60)
end.move(@width / 2, 450)

row(Circle.new(5), 625)
