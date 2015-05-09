WIDTH, HEIGHT = 800, 300

def shard(size)
  b = Random.rand 200..250
  l = b * 0.7
  col = "rgb(#{l}, #{l}, #{b})"
  opa = Random.rand 0.2..0.7
  width = size / Random.rand(4..7)
  iso_tri(size / 6, size, fill: col, opacity: opa)[0, -size]
end


80.times do
  shard(Random.rand(HEIGHT / 5..HEIGHT / 3 * 2))
    .flip_x.move(Random.rand(WIDTH), 0)
end
