# @markup markdown
# @title 1. Getting Started

## Setup ##

Take a look at the README to get set up, and run through the quick example there to make sure you've got everything working. 

For this guide you should use the `fresh_vector_salad` tool so you can see your design evolve live.

## Shapes ##

There are lots of ready-made shapes in VectorSalad so you can get designing quickly. Lets start with a pentagon:

```ruby
pentagon(50)
```

See that was easy; VectorSalad tries to name things clearly and simply. Render it and you should see a black pentagon in the top left corner. VectorSalad outputs SVG (which fresh_vector_salad turns into an image) and it's default is black fill with no line. Coordinates start at the top left and the shape is by default at `0, 0`. We set the radius to 50, you can see in the documentation how to create each different shape by looking at the `new` method (this is run automatically).

_Try a different polygon like hexagon, or even a circle._

## Movement ##

To move a shape absolutely (from the top left `0, 0` coordinate) you can use square brackets, e.g. `[50, 100]` would position the shape at x 50 y 100. You can also move a shape relative to where it was with `move`, e.g. `move(10, 20)` would move the shape from where it was so it ends up at 60, 120. Lets try moving our shape:

```ruby
pentagon(50)[50, 50]
```

And now it's not cut off by the screen because we moved it by the same amount as its radius.

## Variables ##

Sometimes it's nice to be able to change a value in one place and have our whole design update, so we use variables. That 50 is repeated so lets put that in one place:

```ruby
r = 50
pentagon(r)[r, r]
```

_Try changing the radius to see it update!_

## Styles ##

VectorSalad hands styling over to SVG so you can use all of its style attributes. Some good ones are `fill`, `stroke_width` and `stroke`. Lets give our shape some style:
