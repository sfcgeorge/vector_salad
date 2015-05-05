require 'vector_salad/standard_shapes/path'
require 'vector_salad/standard_shapes/n'
require 'vector_salad/mixins/at'

module VectorSalad
  module StandardShapes
    class Rect < BasicShape
      include VectorSalad::Mixins::At
      attr_reader :width, :height

      # Create a rectangle with specified width and height.
      #
      # Examples:
      #   new(100, 200)
      #   new(100, 200, at: [50,50])
      Contract Pos, Pos, { at: Maybe[Coords] } => Rect
      def initialize(width, height, at: [0, 0], **options)
        @width, @height = width, height
        @options = options
        @at = at
        self
      end

      def to_path
        Path.new(
          N.n(@at[0], @at[1]),
          N.n(@at[0], @at[1] + @height),
          N.n(@at[0] + @width, @at[1] + @height),
          N.n(@at[0] + @width, @at[1]),
          **@options
        )
      end
    end
  end
end
