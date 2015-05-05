require 'vector_salad/standard_shapes/path'
require 'vector_salad/standard_shapes/n'
require 'vector_salad/mixins/at'

module VectorSalad
  module StandardShapes
    class Square < BasicShape
      include VectorSalad::Mixins::At
      attr_reader :size

      # Create a square with equal width and height.
      #
      # Examples:
      #   new(100).detail 'Square sides 100x100 at 0,0.'
      #   new(100, at: [50,50])
      Contract Pos, { at: Coords } => Square
      def initialize(size, at: [0,0], **options)
        @size = size
        @options = options
        @at = at
        self
      end

      def to_path
        Path.new(
          N.n(@at[0], @at[1]),
          N.n(@at[0], @at[1]+@size),
          N.n(@at[0]+@size, @at[1]+@size),
          N.n(@at[0]+@size, @at[1]),
          **@options
        )
      end
    end
  end
end
