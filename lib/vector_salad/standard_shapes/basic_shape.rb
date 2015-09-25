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
      #   @!method $2
      #     @see Path#$2
      def_instance_delegator :to_path, :flip
      def_instance_delegator :to_path, :flip_x
      def_instance_delegator :to_path, :flip_y
      def_instance_delegator :to_path, :rotate
      def_instance_delegator :to_path, :[]
      def_instance_delegator :to_path, :move
      def_instance_delegator :to_path, :jitter
      def_instance_delegator :to_path, :scale
      def_instance_delegator :to_path, :to_simple_path
      def_instance_delegator :to_path, :to_bezier_path
      def_instance_delegator :to_path, :to_cubic_path
      def_instance_delegator :to_path, :to_multi_path
      def_instance_delegator :to_path, :to_a
    end
  end
end
