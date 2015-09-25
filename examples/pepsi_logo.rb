square(500, fill: "#01205C") # background

circle(200, fill: "white")[250, 250] # white circle

intersection(fill: "#FC002C") do # red circle
  circle(190)[250, 250]
  circle((190 * 1.6).round)[30, 60]
end

difference(fill: "#0B60BB") do # blue circle
  circle(190)[250, 250]
  path(
    N.n(0, 0),
    N.n(420, 0),
    N.n(380, 110),
    N.s(370, 270),
    N.s(220, 335),
    N.n(100, 365),
    N.n(0, 365)
  )
end
