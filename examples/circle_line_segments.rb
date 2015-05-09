square(240, fill: :none)

canvas << circ = Circle.new(100,
  fill: :red,
  stroke: :black,
  stroke_width: 4
)[120, 120].to_simple_path(20)

circ.nodes.each do |node|
  circle(4, fill: :green)[*node.at]
end
