module VectorSalad
  # @api private
  class ShapeProxy
    attr_reader :shape

    def initialize(shape)
      @shape = shape
    end

    def method_missing(name, *args, &block)
      @shape = shape.send(name, *args, &block)
      self
    end
  end
end
