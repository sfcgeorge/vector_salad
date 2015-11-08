# @markup markdown
# @title 1. Getting Started

## Setup ##

Take a look at the README to get set up, and run through the quick example there to make sure you've got everything working. 

For this guide you should use the `fresh_vector_salad` tool so you can see your design evolve live.

## Shapes ##

There are lots of ready-made shapes in VectorSalad so you can get designing quickly. Lets start with a hexagon:

```ruby
hexagon(50)
```

See that was easy; VectorSalad tries to name things clearly and simply. Render it and you should see a black hexagon in the top left corner. Coordinates start at the top left and the shape is by default centered at `0, 0` which is why it's cut off. VectorSalad outputs SVG (which fresh_vector_salad turns into an image) and it's default is black fill with no stroke (border). We set the radius to 50, you can see in the documentation how to create each different shape by looking at the `new` method (this is run automatically).

_Try a different polygon like hexagon, or even a circle._

## Movement ##

To move a shape absolutely (from the top left `0, 0` coordinate) you can use square brackets, e.g. `[50, 100]` would position the shape at x 50 y 100. You can also move a shape relative to where it was with `move`, e.g. `move(10, 20)` would move the shape from where it was so it ends up at 60, 120. Lets try moving our shape:

```ruby
hexagon(50)[50, 50]
```

And now it's not cut off by the screen because we moved it by the same amount as its radius.

## Styles ##

VectorSalad hands styling over to SVG so you can use all of its style attributes. Some good ones are `fill`, `stroke_width` and `stroke`. Lets give our shape some style:

```ruby
hexagon(50, fill: "green", stroke: "black", stroke_width: 3)[50, 50]
```

## Variables ##

Sometimes it's nice to be able to change a value in one place and have our whole design update, so we use variables. That 50 is repeated so lets put that in one place:

```ruby
r = 80
hexagon(r, fill: "green", stroke: "black", stroke_width: 3)[r, r]
```

_Try changing the radius to see it update!_

## Maths ##

You can use simple maths with variables and numbers to help you keep sizes and positions consistent.

```ruby
r = 80
hexagon(r, fill: "green", stroke: "black", stroke_width: 3)[r, r]

oval(r / 4, r / 2, fill: "white")[r * 0.7, r]
oval(r / 8, r / 4)[r * 0.7, r * 1.2]

oval(r / 4, r / 2, fill: "white")[r * 1.3, r]
oval(r / 8, r / 4)[r * 1.3, r * 1.2]
```

_Experiment with the multipliers and see how they change the shapes._

## Custom Shapes ##

In the example above there's some repetition—each eye has the same color and size. We could use more variables to reduce repetition, but a better way here is to create our own custom shape!

```ruby
r = 80
hexagon(r, fill: "green", stroke: "black", stroke_width: 3)[r, r]

custom(:eye) do |height, **options|
  group do
    oval(height / 2, height, fill: "white")
    oval(height / 4, height)
  end
end

eye(r / 2).move(r * 0.7, r)
eye(r / 2)[r * 1.3, r]
```
