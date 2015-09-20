# Basic square in the corner
square(100)

# Square at position
square(50)[200, 100]

# Square with options
square(30, fill: "cyan", stroke: "magenta", stroke_width: 3)[-60, 140].flip_y

# Square with N node position
square(40, fill: "magenta")[150, -200].flip(:x)

# Square converted to a path and manually added to canvas
canvas << Square.new(30, fill: "lightblue")[250, 130].to_path
