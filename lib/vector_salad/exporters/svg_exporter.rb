require_relative 'base_exporter.rb'
Dir.glob(File.expand_path('../../standard_shapes/*.rb', __FILE__)).each do |file|
  require file
end

module VectorSalad
  module Exporters
    class SvgExporter < BaseExporter
      def header
        puts <<-END.gsub(/^ {10}/, '')
          <svg version="1.1"
               xmlns="http://www.w3.org/2000/svg"
               width="#{canvas_width}"
               height="#{canvas_height}">
        END
      end

      def footer
        puts '</svg>'
      end

      def self.options(options)
        out = ''
        options.each do |k, v|
          out << " #{k.to_s.gsub(/_/, ?-)}=\"#{v.to_s.gsub(/_/, ?-)}\""
        end
        out
      end
    end
  end
end


module VectorSalad
  module StandardShapes
    class Path
      def to_svg
        svg = '<path d="'
        svg << to_svg_d_attribute
        svg << '"'
        svg << VectorSalad::Exporters::SvgExporter.options(@options)
        svg << '/>'
      end

      def to_svg_d_attribute
        nodes = to_bezier_path.nodes
        svg = ''
        svg << "M #{nodes[0].x} #{nodes[0].y}"

        nodes[1..-1].each_index do |j|
          i = j+1

          n = nodes[i]
          case n.type
          when :cubic
            if nodes[i-1].type == :node
              svg << " C #{n.x} #{n.y}"
            elsif nodes[i-2].type == :node && nodes[i-1].type == :cubic
              svg << ", #{n.x} #{n.y}"
            end
          when :quadratic
            svg << " Q #{n.x} #{n.y}"
          when :node
            if nodes[i-1].type == :cubic || nodes[i-1].type == :quadratic
              svg << ", #{n.x} #{n.y}"
            elsif nodes[i-1].type == :node
              svg << " L #{n.x} #{n.y}"
            end
          else
            raise "The SVG exporter doesn't support #{n.type} node type."
          end
        end

        svg << ' Z' if @closed
        svg
      end
    end

    class MultiPath
      def to_svg
        svg = '<path d="'
        paths.each do |path|
          svg << " #{path.to_svg_d_attribute}"
        end
        svg << '"'
        svg << VectorSalad::Exporters::SvgExporter.options(@options)
        svg << '/>'
      end
    end

    class Circle
      def to_svg
        svg = "<circle cx=\"#{at[0]}\" cy=\"#{at[1]}\" r=\"#{radius}\""
        svg << VectorSalad::Exporters::SvgExporter.options(@options)
        svg << '/>'
      end
    end

    class Oval
      def to_svg
        svg = "<ellipse cx=\"#{at[0]}\" cy=\"#{at[1]}\""
        svg << " rx=\"#{width}\" ry=\"#{height}\""
        svg << VectorSalad::Exporters::SvgExporter.options(@options)
        svg << '/>'
      end
    end

    class Square
      def to_svg
        svg = "<rect x=\"#{at[0]}\" y=\"#{at[1]}\""
        svg << " width=\"#{size}\" height=\"#{size}\""
        svg << VectorSalad::Exporters::SvgExporter.options(@options)
        svg << '/>'
      end
    end

    class Rect
      def to_svg
        svg = "<rect x=\"#{at[0]}\" y=\"#{at[1]}\""
        svg << " width=\"#{width}\" height=\"#{height}\""
        svg << VectorSalad::Exporters::SvgExporter.options(@options)
        svg << '/>'
      end
    end
  end
end

#include VectorSalad::StandardShapes
#p = Path.new([0,0], [50,0], [50,50])
#puts p.to_svg

#p1 = Path.new(
  #N.n(0,100),
  #N.q(100,0),
  #N.n(200,100),
  #N.q(300,200),
  #N.n(400,100),
  #N.n(400,200),
  #N.n(0,200)
#)
#puts p1.to_svg

#p2 = Path.new(
  #N.n(0,100),
  #N.c(50,150),
  #N.c(250,150),
  #N.n(300,100),
  #N.n(300,50),
  #N.c(300,0),
  #N.c(200,50),
  #N.n(100,50),
  #N.c(50,0),
  #N.c(0,0),
  #N.n(0,50)
#)
#puts p2.to_svg

#p3 = Path.new(
  #N.n(0,200),
  #N.c(50,000),
  #N.c(300,100),
  #N.n(400,150),
  #N.q(200,500),
  #N.n(50,300)
#)
#puts p3.to_svg

#puts p4.to_svg

#sq = Square.new(100, at: [50,50])
#puts sq.to_path.to_svg

#ci = Circle.new(100, at: [200,200])
#puts ci.to_path.to_svg
