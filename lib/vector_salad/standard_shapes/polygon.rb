require 'contracts_contracts'
require 'vector_salad/standard_shapes/path'
require 'vector_salad/mixins/at'

module VectorSalad
  module StandardShapes
    class Polygon < BasicShape
      include VectorSalad::Mixins::At
      attr_reader :sides

      # Create a regular polygon with a specified number of sides.
      #
      # Examples:
      #   new(6, 100)
      #   new(5, 100, at: [50,50])
      Contract PolySides, Pos, { at: Coords } => Polygon
      def initialize(sides, radius, at: [0,0], **options)
        @sides, @radius = sides, radius
        @options = options
        @at = at
        self
      end

      def to_path
        nodes = []
        angle = 2 * Math::PI / @sides
        theta = angle / 2 + Math::PI / 2
        @sides.times do |n|
          nodes[n] = []
          nodes[n][0] = @radius * Math.cos(angle * n + theta) + @at[0]
          nodes[n][1] = @radius * Math.sin(angle * n + theta) + @at[1]
        end

        Path.new(*nodes, **@options)
      end
    end
  end
end
