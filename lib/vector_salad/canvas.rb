module VectorSalad
  class Canvas
    include Enumerable

    def initialize
      @canvas = []
    end

    def <<(shape)
      @canvas << shape
    end

    def each(&block)
      @canvas.each do |shape|
        shape = shape.shape if shape.class == VectorSalad::ShapeProxy
        unless shape.class == VectorSalad::StandardShapes::Custom ||
              !shape.kind_of?(VectorSalad::StandardShapes::BasicShape)
          yield(shape)
        end
      end
    end

    def [](i)
      @canvas[i].class==VectorSalad::ShapeProxy ? @canvas[i].shape : @canvas[i]
    end
  end
end
