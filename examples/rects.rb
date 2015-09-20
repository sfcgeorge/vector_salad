# Simple rectangle 100x150
rect(100, 200)

rect(500, 10, at: [0, 200])

rect(300, 200, at: [100, 0], fill: 'yellow')

canvas << Rect.new(500, 30, at: [0, 410], fill: 'red').to_path

rect(20, 500, at: [400, 0])
