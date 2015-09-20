square(210, fill: :none)

# A rectangle to "show through" the clipped shape
rect(200, 40, fill: "purple")[5, 90]

# Subtract subsequent shapes from the first square, draw the result
shape = difference(fill: "blue") do
  square(200)[5, 5]
  square(60)[120, 105]

  # Result of this difference will be used in outer difference
  difference do # (it will be a donut)
    circle(60)[60, 60]
    circle(20)[60, 60]
  end
end

# Draw circles to show the resultant clipped nodes
shape.shape.to_path.paths.each do |path|
  path.nodes.each do |node|
    circle(3, fill: :green)[*node.at]
  end
end
