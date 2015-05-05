# Basic square in the corner
square(100)

# Square at position
square(50, at: [200,100])

# Square with options
square(30, at: [60,140], fill: 'cyan', stroke: 'magenta', stroke_width: 3).flip_y

# Square with N node position
square(40, at: [150, 200], fill: 'magenta').flip(:x)

# Square converted to a path and manually added to canvas
canvas << Square.new(30, at: [250, 130], fill: 'lightblue').to_path
