require "vector_salad/canvas"
require "vector_salad/dsl"
Dir.glob(File.expand_path("../standard_shapes/*.rb", __FILE__)).each do |file|
  require file
end

module VectorSalad
  # @api private
  module Magic
    def canvas
      @canvas ||= VectorSalad::Canvas.new
    end
  end
end

extend VectorSalad::DSL
extend VectorSalad::Magic
include VectorSalad::StandardShapes
