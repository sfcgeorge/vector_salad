# Basic circle with jitter added
circle(100).jitter(10, fn: 50)

# Circle at position
circle(50)[200, 100]

# Circle with options
circle(30, fill: "cyan", stroke: "magenta", stroke_width: 3)[60, 140]

# Circle flipped (no visual effect)
circle(40, fill: "magenta")[150, -200].flip(:x)

# Circle converted to a path and manually added to canvas
canvas << Circle.new(30, fill: "lightblue")[250, 130].to_path
