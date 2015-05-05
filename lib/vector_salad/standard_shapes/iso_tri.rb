require 'vector_salad/standard_shapes/path'
require 'vector_salad/standard_shapes/n'
require 'vector_salad/mixins/at'

module VectorSalad
  module StandardShapes
    class IsoTri < BasicShape
      include VectorSalad::Mixins::At

      attr_reader :height

      # Create an isosceles or right-angle triangle.
      #
      # Examples:
      #
      #   new(100)
      #   new(100, 150)
      #   new(100, at: [50,50])
      #
      # @param width (defaults to height*2).
      Contract Args[Pos], { at: Maybe[Coords] } => IsoTri
      def initialize(width = nil, height, at: [0, 0], **options)
        width = height * 2 if width.nil?
        @width, @height = width, height
        @options = options
        @at = at
        self
      end

      def to_path
        Path.new(
          N.n(@at[0], @at[1]),
          N.n(@at[0]-@width/2, @at[1]+@height),
          N.n(@at[0]+@width/2, @at[1]+@height),
          **@options
        )
      end
    end
  end
end
