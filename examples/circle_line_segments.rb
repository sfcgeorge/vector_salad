square(240, fill: :none)

canvas << circ = Circle.new(
  100,
  at: [120, 120],
  fill: :red,
  stroke: :black,
  stroke_width: 4
).to_simple_path(20)

circ.nodes.each do |node|
  circle(4, at: node.at, fill: :green)
end
