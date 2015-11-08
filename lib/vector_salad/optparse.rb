module VectorSalad
  # @api private
  class Optparse
    def self.defaults
      @defaults ||= {
        file: nil,
        magic: true,
        verbose: false,
        width: nil,
        height: nil
      }
    end

    def self.options
      @options ||= OpenStruct.new(defaults)
    end

    def self.tool_name=(name)
      @tool_name = name
    end
    self.tool_name = "vector_salad"

    def self.optparse
      @optparse ||= OptionParser.new do |o|
        o.banner = <<-EOF.gsub(/^.*# ?/, "")
          # Usage:
          #     #{@tool_name} -f path/to/file.rb [options]
          #
          # Options:
        EOF

        o.on_head("-c", "--crop CROP", "Set manual crop, WIDTHxHEIGHT, e.g: 400x600") do |crop|
          options.width, options.height = crop.split("x").map(&:to_i)
        end

        o.on_head("-f", "--file FILE", "Run VectorSalad on the FILE") do |file|
          options.file = file
        end

        # o.on_head("--[no-]magic", "Add some helpful magic to your design") do |m|
          # options.magic = m
        # end

        o.separator ""
        o.separator "General options:"

        o.on_tail("-h", "--help", "Show this message") do
          puts o
          exit
        end

        o.on_tail("--version", "Show version") do
          puts VectorSalad::VERSION
          exit
        end
      end
    end

    # Return a structure describing the options.
    def self.parse(args)
      optparse.parse!(args)
      options
    end
  end
end
