require "forwardable"
require "contracts"
require "contracts_contracts"

module VectorSalad
  module StandardShapes
    # All shapes must inherit from BasicShape,
    # with the exception of N node.
    # It alows many usefulmethods in {Path} to be called on the shape
    # by delegating them, so see {Path} for more information on all the
    # methods that shapes can use.
    #
    # You can't use BasicShape directly.
    class BasicShape
      extend Forwardable
      include Contracts

      attr_accessor :options

      # @!macro [attach] property
      #   @!method $1
      #     @see Path#$1
      def_instance_delegator :flip, :to_path
      def_instance_delegator :flip_x, :to_path
      def_instance_delegator :flip_y, :to_path
      def_instance_delegator :rotate, :to_path
      def_instance_delegator :move, :to_path
      def_instance_delegator :jitter, :to_path
      def_instance_delegator :scale, :to_path
      def_instance_delegator :to_simple_path, :to_path
      def_instance_delegator :to_bezier_path, :to_path
      def_instance_delegator :to_cubic_path, :to_path
      def_instance_delegator :to_multi_path, :to_path
      def_instance_delegator :to_a, :to_path
    end
  end
end
