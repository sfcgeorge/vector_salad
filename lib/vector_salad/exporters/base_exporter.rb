require "stringio"

module VectorSalad
  # @api private
  module Exporters
    class BaseExporter
      attr_reader :canvas

      def initialize(options)
        @options = options
        @canvas_width = options.width
        @canvas_height = options.height
        @canvas = options.canvas
        @out = StringIO.new
      end

      def puts(str)
        @out.puts str + "\n"
      end

      def gets
        @out.string
      end

      def export
        header
        body
        footer

        gets
      end

      def header; end

      def body
        format = self.class.name.split('::').last.gsub(/Exporter/, '')
                     .gsub(/(.)([A-Z])/,'\1_\2').downcase
        convert_method = "to_#{format}".to_sym
        canvas.each do |shape|
          begin
            puts shape.send(convert_method)
          rescue NameError, NoMethodError
            puts shape.to_path.send(convert_method)
          end unless shape.nil?
        end
      end

      def footer; end

      def canvas_width
        get_canvas_sizes unless @canvas_width
        @canvas_width
      end

      def canvas_height
        get_canvas_sizes unless @canvas_height
        @canvas_height
      end

      private
      # This method is long and repetetive, for speed. There was a shorter
      # version that converted every shape to a MultiPath but the performance
      # was really terrible. This way is a ton faster.
      def get_canvas_sizes
        @canvas_width = 0
        @canvas_height = 0
        canvas.each do |shape|
          #if shape.respond_to?(:at) && false
            #@canvas_width = shape.at[0] if shape.at[0] > @canvas_width
            #@canvas_height = shape.at[1] if shape.at[1] > @canvas_height
          #else
            #shape = shape.to_path
            shape = shape.to_simple_path

            if shape.class == VectorSalad::StandardShapes::Path
              shape.nodes.each do |node|
                @canvas_width = node.at[0] if node.at[0] > @canvas_width
                @canvas_height = node.at[1] if node.at[1] > @canvas_height
              end
            else # MultiPath
              shape.paths.each do |path|
                path.nodes.each do |node|
                  @canvas_width = node.at[0] if node.at[0] > @canvas_width
                  @canvas_height = node.at[1] if node.at[1] > @canvas_height
                end
              end
            end
          #end
        end
      end
    end
  end
end
