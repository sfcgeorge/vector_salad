require "bundler/gem_tasks"
require "rake/testtask"

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

task default: :test
