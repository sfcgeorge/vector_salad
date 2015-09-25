# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vector_salad/version'

Gem::Specification.new do |spec|
  spec.name          = "vector_salad"
  spec.version       = VectorSalad::VERSION
  spec.authors       = ["Simon George"]
  spec.email         = ["simon@sfcgeorge.co.uk"]
  spec.summary       = %q{An Intuitive Tool for Creating Art
                          and Practical Design with Code}
  spec.description   = %q{A tool aiming to intuitively enable designers with
  basic programming experience such as front-end designer/developers to create
  2D vector graphics such as designs, icons and art using expressive code rather
  than common GUI applications for a faster workflow.}
  spec.homepage      = "http://sfcg.im"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "pretty_backtrace", "~> 0.1"
  spec.add_dependency "ruby_clipper", "~> 5.0"
  spec.add_dependency "spiro", "~> 0.0.3"
  spec.add_dependency "contracts", "~> 0.12"

  #spec.add_development_dependency "yard", "~> 0.8"
  #spec.add_development_dependency "yard-contracts"#, "~> 0.1"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.8"
end
