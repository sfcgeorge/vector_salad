require "vector_salad/standard_shapes/path"
require "vector_salad/standard_shapes/n"
require "vector_salad/dsl"
require "vector_salad/canvas"

module VectorSalad
  module StandardShapes
    # Make your own custom shape.
    class Custom < BasicShape
      # You must name your custom shape to be able to use it later.
      # The block passed to custom shape is what will create your shape,
      # it should create just a single shape or MultiPath.
      # This means you should use {MultiPath} or one of the {Clip} operations
      # which return MultiPaths to create complex shapes.
      #
      # @example Using DSL:
      #   custom(:donut) do |size| # name shape and specify parameters
      #     difference do # return a single shape
      #       circle(size / 2)
      #       circle(size / 3)
      #     end
      #   end
      #
      #   donut(100)
      #
      # @param name The name of your shape in snake_case
      Contract Symbol, {}, Proc => Any
      def initialize(name, **options, &block)
        ::VectorSalad::StandardShapes.const_set(name.to_s.capitalize.to_sym, Class.new(BasicShape) do
          include VectorSalad::DSL
          include VectorSalad::StandardShapes

          define_method(:initialize, &block)

          def canvas
            @canvas ||= VectorSalad::Canvas.new
          end

          def to_path
            canvas[0]
          end
        end)
      end
    end
  end
end
