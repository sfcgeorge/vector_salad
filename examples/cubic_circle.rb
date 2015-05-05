square(240, fill: :none)

cubic = Circle.new(
  100,
  at: [120, 120],
  fill: :red,
  stroke: :black,
  stroke_width: 4
)
canvas << cubic

handle = []
nodes = cubic.to_path.nodes
(nodes + [nodes[0]]).each do |node|
  if handle.size == 2
    path(*handle.map(&:at), stroke: :blue, stroke_width: 2)
    handle = handle[1..1]
  end
  if handle.size == 1 && handle[0].type == :cubic && node.type == :cubic
    handle = []
  end
  handle << node.clone
end

nodes.each do |node|
  color = node.type == :node ? :green : :blue
  circle(4, at: node.at, fill: color)
end
