# A rectangle to "show through" the clipped shape
rect(200, 40, fill: "purple")[0, 85]

# Subtract subsequent shapes from the first square, draw the result
difference(fill: "red") do
  square(200)
  square(60)[120, 100]

  # Result of this difference will be used in outer difference
  difference do # (it will be a donut)
    circle(60)[55, 55]
    circle(20)[55, 55]
  end
end
