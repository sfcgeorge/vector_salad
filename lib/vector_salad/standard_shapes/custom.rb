require "fancy_to_proc"
require "vector_salad/dsl"
require "vector_salad/canvas"
Dir.glob(File.expand_path("../standard_shapes/*.rb", __FILE__)).each do |file|
  require file
end

module VectorSalad
  module StandardShapes
    # Make your own custom shape.
    class Custom < BasicShape
      # You must name your custom shape to be able to use it later.
      # The block passed to custom shape is what will create your shape.
      # If you create just 1 shape (e.g. with {MultiPath} or
      # one of the {Clip} operations which return a {MultiPath})
      # then that's what's added to the canvas,
      # but if you create multiple shapes they will be wrapped in a {Group}.
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
        const = name.to_s.capitalize.to_sym
        ::VectorSalad::StandardShapes.const_set(const, Class.new(Custom) do
          include VectorSalad::DSL
          include VectorSalad::StandardShapes

          define_method(:initialize, &block)

          def canvas
            @canvas ||= VectorSalad::Canvas.new
          end

          def to_path
            if canvas.length == 1
              canvas[0]
            else
              Group.new.tap(&:canvas=.(@canvas))
            end
          end
        end)
      end
    end
  end
end
