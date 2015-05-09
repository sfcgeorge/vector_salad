def balloon(size, at: [0, 0], **options)
  tri_size = size / 5

  union(**options) do
    oval(size * 0.8, size)[*at]
    path(
      [at[0], at[1] + size - tri_size * 0.2],
      [at[0] - tri_size, at[1] + size + tri_size],
      [at[0] + tri_size, at[1] + size + tri_size]
    )
  end
end

width = height = 800

square(width, fill: "lightgrey")

600.times do # Confetti
  r1, r2, r3 = Random.rand, Random.rand, Random.rand
  color = "rgb(#{(r1 * 255).to_i}, #{(r2 * 255).to_i}, #{(r3 * 255).to_i})"
  circle((r1 * 8).ceil, fill: color)[r3 * width, r2 * height]
end

(-1..1).step(0.1).each do |t| # Balloons rosette
  radius = 320
  x = width / 2 + radius * Math.cos(t * Math::PI)
  y = height / 2 + radius * Math.sin(t * Math::PI)

  balloon(45, at: [x, y], fill: (t * 10).round.odd? ? "purple" : "white")
end

difference(fill: "black") do # Camera body
  union do
    rect(300, 200)[width / 2 - 150, height / 2 - 100]
    path(
      [width / 2 - 50, height / 2 - 100],
      [width / 2 + 90, height / 2 - 100],
      [width / 2 + 60, height / 2 - 150],
      [width / 2 - 20, height / 2 - 150]
    )
    rect(50, 15)[width / 2 + 90, height / 2 - 115]
  end
  circle(80)[width / 2 + 20, height / 2]
end
rect(70, 8, fill: "darkred")[width / 2 - 150, height / 2 - 60]
