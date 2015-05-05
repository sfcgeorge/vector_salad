square(210, fill: :none)

# A rectangle to "show through" the clipped shape
rect(200, 40, at: [5, 90], fill: 'purple')

# Subtract subsequent shapes from the first square, draw the result
shape = difference(fill: 'blue') do
  square(200, at: [5, 5])
  square(60, at: [120, 105])

  # Result of this difference will be used in outer difference
  difference do # (it will be a donut)
    circle(60, at: [60, 60])
    circle(20, at: [60, 60])
  end
end

# Draw circles to show the resultant clipped nodes
shape.shape.to_path.paths.each do |path|
  path.nodes.each do |node|
    circle(3, at: node.at, fill: :green)
  end
end
