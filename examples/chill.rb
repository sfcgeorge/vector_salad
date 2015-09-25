srand 1
WIDTH, HEIGHT = 800, 300

def shard(size)
  b = rand 200..250
  l = b * 0.7
  col = "rgb(#{l}, #{l}, #{b})"
  opa = rand 0.2..0.7
  iso_tri(size / 6, size, fill: col, opacity: opa)[0, -size]
end

80.times do
  shard(rand(HEIGHT / 5..HEIGHT / 3 * 2))
    .flip_x.move(rand(WIDTH), 0)
end
