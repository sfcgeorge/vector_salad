rect(390, 200, fill: 'beige') # background

(1..5).each do |n| # repeat 5 times
  # make a star from the union of two triangles
  union(fill: 'gold', stroke_width: 3, stroke: 'black') do
    triangle(25)
    triangle(25).flip(:x)
  end.move(n * 65, 100) # move stars at intervals horizontally
end
