require "vector_salad/export_with_magic"
require "tempfile"
require "ostruct"

class GuideRender
  def initialize(file)
    @file = file
  end

  def render
    outfile = File.new("#{@file.sub('.markdown', '.md')}", "w")
    code_open = false
    code = tempfile_fresh(nil)

    File.open(@file, "r") do |infile|
      infile.each do |line|
        outfile.puts line

        if line.match("```ruby")
          code_open = true
          code = tempfile_fresh(code)
        elsif line.match("```")
          if code_open
            outfile.puts
            code.rewind
            outfile.write(export_vector_salad code)
          end
          code_open = false
        end

        code.write(line) if code_open && !line.match("```ruby")
      end
    end
  ensure
    tempfile_close(code)
    outfile.close
  end

  private

  def export_vector_salad(code_file)
    VectorSalad::ExportWithMagic.new(OpenStruct.new file: code_file.path).export
  end

  def tempfile_fresh(temp)
    tempfile_close(temp) if temp
    Tempfile.new("code")
  end

  def tempfile_close(temp)
    temp.close
    temp.unlink
  end
end
