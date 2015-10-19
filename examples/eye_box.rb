SIZE = 256
BOXES = 8
BOX_SIZE = SIZE / BOXES
FORCE = 0.31

square(SIZE)

custom(:eyebox) do |x, y, **options|
  middle = SIZE / 2
  xm = x + BOX_SIZE / 2
  ym = y + BOX_SIZE / 2

  dx = middle - xm
  dy = middle - ym

  h = Math.sqrt(dx**2 + dy**2)
  a = Math.atan2(dx, dy)

  r = (h * FORCE)**1.3
  x2 = -r * Math.sin(a)
  y2 = -r * Math.cos(a)

  r = (h * (FORCE - 0.01))**1.3
  x3 = -r * Math.sin(a)
  y3 = -r * Math.cos(a)

  c = 255.0 / SIZE
  c2 = 200.0 / SIZE
  col1 = "rgb(#{50 + c2 * x}, 0, #{50 + c2 * y})"
  col2 = "rgb(#{205 - c * x}, 0, #{c * y})"

  group do
    square(BOX_SIZE, fill: col1)[x, y]
    # circle(BOX_SIZE / 3, fill: "rgb(#{c * x}, 0, #{c * y})")[x2 + middle, y2 + middle]
    intersection(fill: "white") do
      square(BOX_SIZE, fill: "rgb(#{c * x}, 0, #{c * y})")[x, y]
      circle(BOX_SIZE / 2.5, fill: "white")[x2 + middle, y2 + middle]
    end
    intersection(fill: col2) do
      square(BOX_SIZE, fill: "rgb(#{c * x}, 0, #{c * y})")[x, y]
      circle(BOX_SIZE / 6, fill: "black")[x3 + middle, y3 + middle]
    end
  end
end

BOXES.times do |x|
  BOXES.times do |y|
    eyebox(x * BOX_SIZE, y * BOX_SIZE)
  end
end
