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
    def each(&_)
      @canvas.each do |shape|
        shape = to_shape(shape)
        next if shape.class == VectorSalad::StandardShapes::Custom ||
                !shape.is_a?(VectorSalad::StandardShapes::BasicShape)

        if shape.is_a?(VectorSalad::StandardShapes::Group) ||
           (shape.is_a?(VectorSalad::StandardShapes::Custom) &&
            shape.to_path.class == VectorSalad::StandardShapes::Group)
          shape.canvas.each { |s| yield(s) }
        else
          yield(shape)
        end
      end
    end

    # Count of how many shapes are on the canvas
    def length
      @canvas.length
    end

    # Access a specific shape in the canvas.
    # Often used to get the first shape [0] for situations where only
    # a single shape is allowed.
    def [](i)
      to_shape @canvas[i]
    end

    private

    def to_shape(shape)
      shape.class == VectorSalad::ShapeProxy ? shape.shape : shape
    end
  end
end
