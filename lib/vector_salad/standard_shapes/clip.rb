require 'clipper'

require 'vector_salad/dsl'
require 'vector_salad/canvas'
require 'vector_salad/standard_shapes/multi_path'

module VectorSalad
  module StandardShapes
    class Clip < BasicShape
      include VectorSalad::DSL
      include VectorSalad::StandardShapes

      # Perform a clipping operation on a set of paths or shapes.
      # The first path is used as the subject, subsequent paths are applied to
      # the first using the specified operation.
      #
      # It's easier to use one of the subclasses;
      # (see {Difference}, {Intersection}, {Union}, {Exclusion}).
      Contract Or[*%i(difference intersection union xor)], {}, Proc => MultiPath
      def initialize(operation, **options, &block)
        instance_eval(&block) # canvas is populated

        clipper = Clipper::Clipper.new

        i = 0
        canvas.each do |shape|
          method = i == 0 ? 'subject' : 'clip'
          path = shape.to_simple_path.to_a
          if path[0][0].instance_of? Array # MultiPath
            clipper.send("add_#{method}_polygons".to_sym, path)
          else # Path
            clipper.send("add_#{method}_polygon".to_sym, path)
          end
          i += 1
        end

        @path = MultiPath.new(
          *clipper.send(operation, :non_zero, :non_zero), **options
        )
      end

      def canvas
        @canvas ||= VectorSalad::Canvas.new
      end

      def to_path
        @path
      end
    end
  end
end
