module VectorSalad
  # All shapes must be added to the global canvas for export,
  # and block transform shapes like {Union} or {Move} have an internal
  # canvas that shapes must be added to.
  #
  # In most cases you'll want to use the DSL which abstracts away the canvas
  # so you don't have to think about it.
  #
  # @example Manually adding a circle to a canvas:
  #   canvas << Circle.new(100)
  #
  # @example Implicitly adding a circle to a canvas using DSL:
  #   circle(100)
  class Canvas
    include Enumerable

    def initialize
      @canvas = []
    end

    # Add a shape to the canvas
    def <<(shape)
      @canvas << shape
    end

    # Loop over the shapes in the canvas.
    def each(&block)
      @canvas.each do |shape|
        shape = shape.shape if shape.class == VectorSalad::ShapeProxy
        unless shape.class == VectorSalad::StandardShapes::Custom ||
              !shape.kind_of?(VectorSalad::StandardShapes::BasicShape)
          yield(shape)
        end
      end
    end

    # Access a specific shape in the canvas.
    # Often used to get the first shape [0] for situations where only
    # a single shape is allowed.
    def [](i)
      @canvas[i].class==VectorSalad::ShapeProxy ? @canvas[i].shape : @canvas[i]
    end
  end
end
