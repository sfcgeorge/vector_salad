# @markup markdown
# @title 1. Getting Started

# Getting Started

In this guide we'll create a... well wait and see. Or you could naughtily skip ahead to the end—I see you there! Tisk tisk. Extra suggestions for things to do are found in _italics_ at then end of each section if you want to earn back some gold stars, very shiny.

## Setup ##

Take a look at the {file:README.md Readme} to get set up, and run through the quick example there to make sure you've got everything working. 

For this guide you should use the `fresh_vector_salad` tool so you can see your design evolve live! It's all too exciting.

## Shapes ##

There are lots of ready-made shapes in VectorSalad so you can get designing quickly. Lets start with a pentagon:

```ruby
pentagon(50)
```

See that was easy; VectorSalad tries to name things clearly and simply. Render it and you should see a black pentagon in the top left corner. Coordinates start at the top left and the shape is by default centered at `0, 0` which is why it's cut off. VectorSalad outputs SVG (which fresh_vector_salad turns into an image) and it's default is black fill with no stroke (border). We set the radius to 50, you can see in the documentation how to create each different shape by looking at the `new` method (this is run automatically when you write the shape by name).

_Try a different polygon like hexagon, or even a circle._

## Movement ##

To move a shape absolutely (from the top left `0, 0` coordinate) you can use square brackets, e.g. `[50, 100]` would position the shape at x 50 y 100. You can also move a shape relative to where it was with `move`, e.g. `move(10, 20)` would move the shape from where it was so it ends up at 60, 120. Lets try moving our shape:

```ruby
pentagon(50)[50, 50]
```

And now it's not cut off by the screen because we moved it by the same amount as its radius.

## Styles ##

VectorSalad hands styling over to SVG so you can use all of its style attributes. Some good ones are `fill`, `stroke_width` and `stroke`. Lets give our shape some style:

```ruby
pentagon(50, fill: "green", stroke: "black", stroke_width: 3)[50, 50]
```

## Variables ##

Sometimes it's nice to be able to change a value in one place and have our whole design update, so we use variables. That 50 is repeated so lets put that in one place:

```ruby
r = 80
pentagon(r, fill: "green", stroke: "black", stroke_width: 3)[r, r]
```

_Try changing the radius to see it update!_

## Maths ##

You can use simple maths with variables and numbers to help you keep sizes and positions consistent.

```ruby
r = 80
pentagon(r, fill: "green", stroke: "black", stroke_width: 3)[r, r]

oval(r / 4, r / 2, fill: "white")[r * 0.7, r]
oval(r / 8, r / 4)[r * 0.7, r]

oval(r / 4, r / 2, fill: "white")[r * 1.3, r]
oval(r / 8, r / 4)[r * 1.3, r]
```

_Experiment with the multipliers and see how they change the shapes._

## Custom Shapes ##

In the example above there's some repetition—each eye has the same color and size. We could use more variables to reduce repetition, but a better way here is to create our own custom shape!

```ruby
r = 80
pentagon(r, fill: "green", stroke: "black", stroke_width: 3)[r, r]

custom(:eye) do |height, **options|
  oval(height / 2, height, fill: "white")
  oval(height / 4, height / 2)[0, height * 0.3]
end

eye(r / 2).move(r * 0.7, r)
eye(r / 2).move(r * 1.3, r)
```

_Find out why `move` was used by changing it to the square brackets._

## Finish! ##

Finally we can add a few finishing touches and reorganise the code a bit. First we add a nice background. Then we reorganise the body code and wrap it in a `move` block to move our little character into the middle. Finally we've added some hands at the bottom of the `move` block so they are moved with the body as a whole.

```ruby
size = 300 # background size
r = size * 0.4 # body radius
body_style = { fill: "green", stroke: "black", stroke_width: 3 }

square(size, fill: "skyblue") # background sky

custom(:eye) do |height, **options|
  oval(height / 2, height, fill: "white") # white
  oval(height / 4, height / 2)[height * 0.1, height * 0.3] # pupil
end

move(size / 2, size / 2) do
  pentagon(r, body_style)

  eye(r / 2).move(-r * 0.3, 0)
  eye(r / 2).move(r * 0.3, 0)

  circle(r / 4, body_style)[-r * 0.6, r * 0.8] # left hand
  circle(r / 4, body_style)[r * 0.6, r * 0.8] # right hand
end
```

There, you've got a rundown of the basics (and some of the not-so-basics) of VectorSalad. Don't be afraid to experiment, that's how you learn best. If you ever make a mistake then fresh_vector_salad will show a red border around your image; see if you can find your mistake or check the console for error details.

_Play with the colors, numbers, shapes... whatever you fancy. I'll be very surprised if you haven't made our little pal round and pink with a hat by now. Try adding grass, and maybe a tree? Or a rock. Rocks are like trees you can trust._
