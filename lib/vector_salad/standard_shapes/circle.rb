require 'vector_salad/standard_shapes/path'
require 'vector_salad/standard_shapes/n'
require 'vector_salad/mixins/at'

module VectorSalad
  module StandardShapes
    class Circle < Path
      include VectorSalad::Mixins::At
      attr_reader :radius

      # Create a perfectly round circle.
      #
      # Examples do
      #   new(100)
      #   new(100, at: [50,50])
      Contract Pos, { at: Maybe[Coords] } => Circle
      def initialize(radius, at: [0,0], **options)
        @options = options
        @radius = radius
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
        d = c * @radius
        Path.new(
          N.n(@at[0] + @radius, @at[1]),
          N.c(@at[0] + @radius, @at[1] + d),
          N.c(@at[0] + d, @at[1] + @radius),
          N.n(@at[0], @at[1] + @radius),
          N.c(@at[0] - d, @at[1] + @radius),
          N.c(@at[0] - @radius, @at[1] + d),
          N.n(@at[0] - @radius, @at[1]),
          N.c(@at[0] - @radius, @at[1] - d),
          N.c(@at[0] - d, @at[1] - @radius),
          N.n(@at[0], @at[1] - @radius),
          N.c(@at[0] + d, @at[1] - @radius),
          N.c(@at[0] + @radius, @at[1] - d),
          N.n(@at[0] + @radius, @at[1]),
          **@options
        )
      end

      def to_simple_path(fn = nil)
        fn ||= (@radius * 2).ceil

        nodes = []
        arc = (2.0 * Math::PI) / fn
        fn.times do |t|
          a = arc * t
          x = @radius * Math.cos(a) + @at[0]
          y = @radius * Math.sin(a) + @at[1]
          nodes << N.n(x, y)
        end
        Path.new(*nodes, **@options)
      end
    end
  end
end
