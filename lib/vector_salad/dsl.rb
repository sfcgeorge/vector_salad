require "vector_salad/shape_proxy"

module VectorSalad
  # @api private
  module DSL
    def method_missing(name, *args, **options, &block)
      # This automatic require doesn't work properly
      # require "vector_salad/standard_shapes/#{name}.rb"

      ns = VectorSalad::StandardShapes
      shape_string = name.to_s.split("_").collect(&:capitalize).join
      shape_class = ns.const_get(shape_string)

      # No built in is_superclass_of? so implement it ourselves
      # inlined so it doesn't polute the namespace
      is_superclass_of_transform = false
      sub_class = shape_class
      while sub_class != Object
        sub_class = sub_class.superclass
        if sub_class == VectorSalad::StandardShapes::Transform
          is_superclass_of_transform = true
          break
        end
      end

      if is_superclass_of_transform
        shape_instance = shape_class.new(
          *args, canvas: canvas, **options, &block
        )
      else
        shape_instance = shape_class.new(*args, **options, &block)
      end

      shape_proxy = VectorSalad::ShapeProxy.new(shape_instance)

      canvas << shape_proxy
      shape_proxy
    rescue NameError # no shape available
      super
    end
  end
end
