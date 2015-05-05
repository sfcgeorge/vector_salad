require 'vector_salad/standard_shapes/path'
require 'vector_salad/standard_shapes/n'
require 'vector_salad/mixins/at'

module VectorSalad
  module StandardShapes
    class Oval < BasicShape
      include VectorSalad::Mixins::At
      attr_reader :width, :height

      # Create an oval.
      #
      # Examples:
      #   new(100, 200)
      #   new(100, 200, at: [50,50])
      Contract Pos, Pos, { at: Maybe[Coords] } => Oval
      def initialize(width, height, at: [0,0], **options)
        @options = options
        @width, @height = width, height
        @at = at
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
          N.n(@at[0]+@width, @at[1]),
          N.c(@at[0]+@width, @at[1]+dh),
          N.c(@at[0]+dw, @at[1]+@height),
          N.n(@at[0], @at[1]+@height),
          N.c(@at[0]-dw, @at[1]+@height),
          N.c(@at[0]-@width, @at[1]+dh),
          N.n(@at[0]-@width, @at[1]),
          N.c(@at[0]-@width, @at[1]-dh),
          N.c(@at[0]-dw, @at[1]-@height),
          N.n(@at[0], @at[1]-@height),
          N.c(@at[0]+dw, @at[1]-@height),
          N.c(@at[0]+@width, @at[1]-dh),
          N.n(@at[0]+@width, @at[1]),
          @options
        )
      end
    end
  end
end
