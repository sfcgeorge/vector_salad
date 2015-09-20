QUALITY = 1 # 8
WIDTH = 1000
HEIGHT = (WIDTH / 16.0 * 9.0).round
GOLDEN = 1.618

def cluster_repeat(repeats:, width:, total:, i:)
  period = total / repeats
  repeat = i / period # integer division
  t = i % period
  sub_width = width / repeats
  set = (Math.cos(1.0 / period * t * Math::PI) + 1) / 2 * sub_width
  offset = sub_width * repeat

  set + offset
end

def star(r, at:, shift: 30, bias: 2)
  col = 255 - (1 - Random.rand**3) * shift
  red = [255, col, col]
  blue = [col, col, 255]
  blues = [blue]
  bias.times { blues + [blue] }
  fill_a = ([red] + blues).sample
  fill = "rgb(#{fill_a.join(',')})"
  circle(r, fill: fill)[*at]
end

def background(n:, star:)
  n.times do
    r = Random.rand**2 * (WIDTH * star) + 0.05
    x = Random.rand(WIDTH)
    y = Random.rand(HEIGHT)

    star(r, at: [x, y])
  end
end

def galaxy(n:, star:, size:, at:, arms: 4)
  a_n = n * 2

  n.times do
    r = Random.rand**2 * (WIDTH * star) + 0.05
    dist = Random.rand**3 * size
    twirl = (1 + Math.log(dist / size) / 2) * GOLDEN
    a_c = cluster_repeat(repeats: arms, width: 2.0, total: a_n, i: Random.rand(a_n))
    a = a_c + twirl

    x = dist * Math.cos(a * Math::PI) + at[0]
    y = dist * Math.sin(a * Math::PI) + at[1]

    star(r, at: [x, y], shift: 120, bias: 4)
  end
end

# rect(WIDTH, HEIGHT, fill: "#000")

background(n: 500 * QUALITY, star: 1.0 / 550)

galaxy(n: 4_000 * QUALITY, size: WIDTH / 5, star: 1.0 / 700, at: [WIDTH / 3, HEIGHT / 2])
galaxy(n: 1_300 * QUALITY, size: WIDTH / 12, star: 1.0 / 800, arms: 2, at: [WIDTH / 4 * 3, HEIGHT / 6])
