# Simple rectangle 100x150
rect(100, 200)

rect(500, 10)[0, 200]

rect(300, 200, fill: "yellow")[100, 0]

canvas << Rect.new(500, 30, fill: "red")[0, 410].to_path

rect(20, 500)[400, 0]
