# Basic circle with jitter added
circle(100).jitter(10, fn: 50)

# Circle at position
circle(50, at: [200, 100])

# Circle with options
circle(30, at: [60, 140], fill: 'cyan', stroke: 'magenta', stroke_width: 3)

# Circle flipped (no visual effect)
circle(40, at: [150, -200], fill: 'magenta').flip(:x)

# Circle converted to a path and manually added to canvas
canvas << Circle.new(30, at: [250, 130], fill: 'lightblue').to_path
