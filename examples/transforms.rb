@width = 320.0
# Background
rect(@width, @width * 2, fill: 'tan')

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
    iso_tri(30, at: [x * 40, -60], fill: 'darkorange').flip_x
  else
    iso_tri(30, at: [x * 40, 30], fill: 'firebrick')
  end
end

row(Pentagon.new(6), 80)

# Toothy face
rect(320, 160, at: [0, 100], fill: 'saddlebrown')

flip(:x) do # flip multiple shapes at once
  6.times { |x| iso_tri(30, 100, at: [x * 30 + 85, -200], fill: 'white') }
  iso_tri(50, 20, at: [35, -145], fill: 'black')
  iso_tri(50, 20, at: [285, -145], fill: 'black')
  circle(7, at: [35, -160], fill: 'firebrick')
  circle(7, at: [285, -160], fill: 'firebrick')
end
7.times { |x| iso_tri(30, 100, at: [x * 30 + 70, @width / 2], fill: 'white') }

row(Pentagon.new(6), 280)

# Triangle rosette
n, col1, col2 = 14, %w(firebrick white), %w(darkorange black)
n.times do |t|
  col1.rotate!
  col2.rotate!
  move(@width / 2, 450) do
    iso_tri(20, at: [0, -120], fill: col2[0]).rotate(360.0 / n * t)
    iso_tri(25, at: [0, 120], fill: col1[0]).rotate(360.0 / n * t + 180.0 / n)
  end
end
# "Diamond"
intersection(fill: 'firebrick') do
  triangle(80, at: [0, 0]).flip_x
  pentagon(60, at: [0, 0])
end.move(@width/2,450)

row(Circle.new(5), 625)
