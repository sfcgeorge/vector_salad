require "minitest_helper"
require "ostruct"

class TestVectorSalad < Minitest::Test
  EXAMPLES = "#{__dir__}/../examples"

  # Integration tests
  # Run VectorSalad on each example to
  # test that the output is still the same
  Dir.glob("#{EXAMPLES}/*.rb").each do |file|
    example = File.basename(file, ".rb")

    define_method("test_example_#{example}".to_sym) do
      srand 1 # seed random to keep example tests constant
      exporter = VectorSalad::ExportWithMagic.new OpenStruct.new(
        file: "#{EXAMPLES}/#{example}.rb"
      )
      svg = File.read("#{EXAMPLES}/#{example}.svg")

      assert_equal svg, exporter.export
    end
  end
end
