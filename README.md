# VectorSalad

[![Gem Version](https://badge.fury.io/rb/vector_salad.svg)](http://badge.fury.io/rb/vector_salad)
[![Build Status](https://travis-ci.org/sfcgeorge/vector_salad.svg)](https://travis-ci.org/sfcgeorge/vector_salad)
[![Code Climate](https://codeclimate.com/github/sfcgeorge/vector_salad/badges/gpa.svg)](https://codeclimate.com/github/sfcgeorge/vector_salad)
[![Documentation](https://img.shields.io/badge/yard-docs-blue.svg?style=flat)](http://sfcgeorge.github.io/vector_salad/doc/)

![Space---created with VectorSalad](https://raw.githubusercontent.com/sfcgeorge/vector_salad/gh-pages/examples/space_huge.png)

Create art and practical design such as the space scene above with descriptive Ruby code!

The companion tool for live design can be found here: [fresh_vector_salad](https://github.com/sfcgeorge/fresh_vector_salad)


### Features

VectorSalad has a number of features common to graphics tools, and some that are less common. It's still in development so may not have the breadth of features that established tools have, but it has enough to accomplish a range of graphical tasks.

* Basic shapes (square, circle, pentagon etc.)
* Graphical manipulations (flip, rotate, move)
* Boolean path operations
* Cubic and quadratic Bezier curve nodes
* Mirror node for smooth Bezier continuations
* Spiro auto-smooth curve nodes
* Coding capabilities (Ruby)
* SVG standard vector format export
* DPI export setting
* Render images "live" on save (with fresh_vector_salad)
* Automatic cropping to constrain shapes
* Manual crop (via command line flag)
* DSL friendly syntax
* Embeddable in larger applications without DSL


## Quick Start

As most computers come with Ruby installed I won't dwell on this, but a recent version (2.2) is required. It must also be MRI Ruby as C extensions are used.

Installing `vector_salad` and `fresh_vector_salad` is done simply by installing their corresponding gems. At the command line:

```
gem install vector_salad
gem install fresh_vector_salad
```


## Usage

Now you'll need a design document to compile and render. Here's a very simple example VectorSalad design that creates gold stars:

```ruby
rect(390, 200, fill: "beige") # background

(1..5).each do |n| # repeat 5 times
  # make a star from the union of two triangles 
  union(fill: "gold", stroke_width: 3, stroke: "black") do
    triangle(25)
    triangle(25).flip_x
  end.move(n * 65, 100) # move stars at intervals horizontally 
end
```

Save this document as `gold_stars.rb`, then it can be converted to SVG with the following command:

```
vector_salad -f path/to/gold_stars.rb
```

That will output the SVG, you probably want to save it to a file in a standard UNIX way:

```
vector_salad -f path/to/gold_stars.rb > path/to/gold_stars.svg
```

The SVG file can then be viewed with most modern web browsers, image viewers, or rendered with Inkscape (I leave installing and using Inkscape to the reader). A more interactive way of compiling, rendering and viewing VectorSalad files is with the companion `fresh_vector_salad` command line tool. The following command reads a Ruby VectorSalad file, compiles and saves it to an SVG file, renders it using Inkscape (must be in your path) to a PNG image file, and finally displays the image. Note the lack of .rb extension, it will be added automatically, and an absolute path must be provided.

```
fresh_vector_salad -p /absolute/path/to/file/ -f gold_star
```

The window displayed looks as follows on OS X. 

![fresh\_vector\_salad window](https://raw.githubusercontent.com/sfcgeorge/vector_salad/gh-pages/examples/fresh_vector_salad_gui.png)

If you leave `fresh_vector_salad` running, try changing the design file, e.g. making the stars green. When you save, `fresh_vector_salad` will automatically detect the change, re-compile and display the new result. This makes doing "live" design with VectorSalad quick and easy. 

Further information on the usage of these command line tools can be found by running them with the `--help` flag. Further examples can be found in the [examples folder](examples).

See the full [**Documentation**](http://sfcgeorge.github.io/vector_salad/doc/) for more usage info.


## Contributing

1. Fork it ( https://github.com/sfcgeorge/vector_salad/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Run tests (all `rake` or an individual test `rake test:example[circles]`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request


## Testing

The test suite is automatically generated from examples for integration testing. Here's how it works. Each example in the /examples folder was manually created, run, and visually inspected for correctness (both the image and SVG output). The test suite re-runs all of the examples comparing the new SVG output with the old expected output to make sure nothing has changed.

The whole suite can be run with `rake test` or just `rake`. They should all pass, of course. You can see more details including execution time with `rake test TESTOPTS="-v"`.

An individual example test can be run with `rake test:example[circles]`. The name in the square brackets must be the name of a .rb file in the /examples folder. It can also be a partial "starts with" name, e.g. `rake test:example[circle]` will match both "circle_line_segments" and "circles".

Several of the examples use randomness. If you re-run those examples then the output will change each time, this is expected and great for demos. You must not commit this changed output though as the corresponding test will then fail. When the examples were initially created and when running the tests randomness is seeded to 1 (`srand 1`) so that they don't change. If you do need to change behaviour or add an example using randomness, please add `srand 1` at the top of the example, run it, then remove the `srand` line.
