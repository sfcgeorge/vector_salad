require 'forwardable'
require 'contracts'
require 'contracts_contracts'

module VectorSalad
  module StandardShapes
    class BasicShape
      extend Forwardable
      include Contracts

      attr_accessor :options

      delegate [
        :flip,
        :flip_x,
        :flip_y,
        :rotate,
        :move,
        :jitter,
        :scale,
        :to_simple_path,
        :to_bezier_path,
        :to_cubic_path,
        :to_multi_path,
        :to_a
      ] => :to_path
    end
  end
end
