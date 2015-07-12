require 'vector_salad/standard_shapes/path'
require 'vector_salad/standard_shapes/n'
require 'vector_salad/dsl'
require 'vector_salad/canvas'

module VectorSalad
  module StandardShapes
    class Custom < BasicShape
      def initialize(name, **options, &block)
        #instance_eval(&block)
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
