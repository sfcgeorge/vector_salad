require "vector_salad/standard_shapes/path"
require "vector_salad/standard_shapes/n"
require "vector_salad/mixins/at"

module VectorSalad
  module StandardShapes
    class Oval < BasicShape
      include VectorSalad::Mixins::At
      attr_reader :width, :height

      # Create an oval.
      #
      # Examples:
      #   new(100, 200)
      Contract Pos, Pos, {} => Oval
      def initialize(width, height, **options)
        @options = options
        @width, @height = width, height
        @x, @y = 0, 0
        self
      end

      def to_path
        # http://stackoverflow.com/a/13338311
        # c = 4 * (Math.sqrt(2) - 1) / 3
        # c = 0.5522847498307936
        #
        # http://spencermortensen.com/articles/bezier-circle/
        c = 0.551915024494
        dw = c * @width
        dh = c * @height
        Path.new(
          N.n(@x + @width, @y),
          N.c(@x + @width, @y + dh),
          N.c(@x + dw, @y + @height),
          N.n(@x, @y + @height),
          N.c(@x - dw, @y + @height),
          N.c(@x - @width, @y + dh),
          N.n(@x - @width, @y),
          N.c(@x - @width, @y - dh),
          N.c(@x - dw, @y - @height),
          N.n(@x, @y - @height),
          N.c(@x + dw, @y - @height),
          N.c(@x + @width, @y - dh),
          N.n(@x + @width, @y),
          @options
        )
      end
    end
  end
end
