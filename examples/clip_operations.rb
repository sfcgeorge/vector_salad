# A rectangle to "show through" the clipped shape
rect(200, 40, at: [0,85], fill: 'purple')

# Subtract subsequent shapes from the first square, draw the result
difference(fill: 'red') do
  square(200)
  square(60, at: [120,100])

  # Result of this difference will be used in outer difference
  difference do # (it will be a donut)
    circle(60, at: [55,55])
    circle(20, at: [55,55])
  end
end
