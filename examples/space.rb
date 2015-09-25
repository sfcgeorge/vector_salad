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
  fill_a = [red, *[blue] * bias].sample
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

def asteroid(r, at:)
  _r_min, r_max = 20, 55
  #r = Random.rand(r_min..r_max)
  #x = Random.rand(r..WIDTH - r)
  #y = Random.rand(r..HEIGHT - r)
  _c_min, c_max = 60, 120
  c = c_max / r_max * r
  col = "rgb(#{c}, #{c}, #{c})"
  circle(r, fill: col)[*at].jitter(r / 8, fn: r)

  Random.rand(1..6).times { crater(r: r, x: at[0], y: at[1], c: c) }
end

def crater(r:, x:, y:, c:)
  r_min, r_max = r / 6, r / 3
  cr = Random.rand(r_min..r_max)
  margin = cr * 1.5
  offset = Random.rand(0..r - margin)
  a = Random.rand(2 * Math::PI)
  cx = offset * Math.cos(a) + x
  cy = offset * Math.sin(a) + y
  cc = c * 0.9
  col = "rgb(#{cc}, #{cc}, #{cc})"
  circle(cr, fill: col)[cx, cy].jitter(cr / 4, fn: cr)
end

rect(WIDTH, HEIGHT, fill: "#000")

background(n: 500 * QUALITY, star: 1.0 / 550)

galaxy(n: 4_000 * QUALITY, size: WIDTH / 5, star: 1.0 / 700, at: [WIDTH / 3, HEIGHT / 2])
galaxy(n: 1_300 * QUALITY, size: WIDTH / 12, star: 1.0 / 800, arms: 2, at: [WIDTH / 4 * 3, HEIGHT / 6])

asteroid(25, at: [WIDTH * 0.4, HEIGHT / 2.2])
asteroid(40, at: [WIDTH * 0.22, HEIGHT * 0.36])
asteroid(30, at: [WIDTH * 0.11, HEIGHT * 0.28])
asteroid(55, at: [WIDTH * 0.15, HEIGHT * 0.75])
asteroid(35, at: [WIDTH * 0.55, HEIGHT * 0.65])
asteroid(40, at: [WIDTH * 0.5, HEIGHT * 0.15])
asteroid(45, at: [WIDTH * 0.4, HEIGHT * 0.85])
asteroid(30, at: [WIDTH * 0.91, HEIGHT * 0.13])
# asteroid(50, at: [WIDTH * 0.85, HEIGHT])

def helmet(size, at:)
  s15 = size / 1.5
  s2 = size / 2
  s3 = size / 3
  s4 = size / 4
  s5 = size / 5
  s6 = size / 6
  s8 = size / 8
  s10 = size / 10
  s16 = size / 16
  s32 = size / 32

  metal = "#aaa"

  outer = Path.new(
    N.g(0, - s2 - s32),
    N.l(s2 - s16, s8),
    N.n(s2 - s8, s2 + s8),
    N.n(-s2 + s16, s2 + s8),
    N.r(-s2, s8)
  )

  visor_hole = Path.new(
    N.n(-s2, -s15),
    N.r(-s4, -s2 + s16),
    N.l(-s4, s10),
    N.n(-s15, s10)
  )

  visor_inner = Circle.new(s2)

  neck_hole = Path.new(
    N.n(-s2, s2 - s8 - s8),
    N.s(0, s2 - s8),
    N.n(s2, s2 - s8 - s8),
    N.n(s2, size),
    N.n(-s2, size)
  )

  move(*at) do
    rotate(-20) do
      difference(fill: '#976', opacity: 0.4) do
        canvas << visor_inner
        square(size * 2)[0, -s2]
        square(size * 2)[-s15, s10]
        circle(s16)[-s2, -s16].jitter(s16 / 3, fn: 16)
      end.rotate(20)

      difference(fill: :white) do
        canvas << outer
        canvas << visor_hole
        canvas << neck_hole
      end

      intersection(fill: metal) do
        difference do
          canvas << visor_hole.scale(1.2).move(s32, s32 / 2)
          canvas << visor_hole
        end
        canvas << outer
      end

      intersection(fill: metal) do
        difference do
          canvas << outer
          canvas << neck_hole
        end
        canvas << neck_hole.move(0, -s16)
      end.scale(1.02)
    end
  end

  circle(s16, fill: metal)[s10, -s32].move(*at)
end

helmet(HEIGHT / 3 * 2, at: [WIDTH / 4 * 3, HEIGHT / 2 + HEIGHT / 16])
