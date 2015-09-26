require "bundler/gem_tasks"
require "rake/testtask"
require "vector_salad/export_with_magic"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
end

namespace :test do
  desc "Test specific example [partial_example_title]"
  task :example, [:title] do |_, args|
    fail "No title" unless args[:title]

    ENV["TESTOPTS"] = "-n -/example_#{args[:title]}/"
    Rake::Task[:test].invoke
  end
end

namespace :example do
  desc "WARNING overwrite all example SVGs"
  task :overwrite do
    EXAMPLES = "#{__dir__}/examples"
    Dir.glob("#{EXAMPLES}/*.rb").each do |file|
      example = File.basename(file, ".rb")
      puts example
      srand 1 # seed random to keep example tests constant
      exporter = VectorSalad::ExportWithMagic.new OpenStruct.new(
        file: "#{EXAMPLES}/#{example}.rb"
      )
      File.write("#{EXAMPLES}/#{example}.svg", exporter.export)
    end
  end
end

task default: :test
