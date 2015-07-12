require "vector_salad/monkeypatches"
require "vector_salad/exporters/svg_exporter"
require "vector_salad/canvas"
require "vector_salad/dsl"
Dir.glob(File.expand_path("../standard_shapes/*.rb", __FILE__)).each do |file|
  require file
end

module VectorSalad
  class ExportWithMagic
    include VectorSalad::DSL
    include VectorSalad::StandardShapes

    def initialize(options)
      @options = options
      @file = options.file
    end

    def canvas
      @canvas ||= VectorSalad::Canvas.new
    end

    def export
      data = File.read(@file)
      instance_eval(data, @file)
      @options.canvas = canvas
      Exporters::SvgExporter.new(@options).export
    end
  end
end
