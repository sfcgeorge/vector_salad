require "vector_salad/mixins/at"

module VectorSalad
  module StandardShapes
    # N node. A node is the simplest primitive but useless on its own.
    # Use nodes to build up a path (see Path).
    # A node is a point in space with x and y coordinates.
    class N
      include VectorSalad::Mixins::At
      include Contracts

      attr_accessor :x, :y, :type

      Contract nil, nil, :mirror => N
      def initialize(x, y, type)
        create(x, y, type)
        self
      end

      # Create an N node.
      #
      # The coordinates must be nil if the node type is :mirror,
      # else they must be numeric.
      #
      # A node also has a type, the simplest is :node for corners.
      # To create node types other than :node see the shorthand class methods.
      #
      # Examples:
      #   new(50, 100)
      #   new(50, 100, :cubic)
      #   new(nil, nil, :mirror)
      Contract Coord, Coord,
               Maybe[*%i(node quadratic cubic g2 g4 left right)] => N
      def initialize(x, y, type = :node)
        create(x, y, type)
        self
      end

      # Shorthand for calling `new` to create a node.
      # The type defaults to :node for basic corner or line segment nodes.
      # See the documentation for `new` for usage.
      Contract Maybe[Coord], Maybe[Coord], Maybe[Symbol] => N
      def self.n(x, y, type = :node)
        new(x, y, type)
      end

      # Creates a :mirrored type node. It makes it easier to make smooth curves.
      # The reflection is based on the cubic or quadratic node
      # before the last standard :node so there must be one.
      Contract None => N
      def self.m
        new(nil, nil, :mirror)
      end

      # Shorthand that creates a :cubic type bezier curve handle node.
      # This "off curve" node isn't part of the path but distorts pulling it.
      # Two :cubic nodes must come between two :node type nodes. E.g. n c c n.
      # As the interaction of two cubic nodes distorts the line segment this
      # can be quite difficult to imagine, see :quadratic or :spiro for
      # easier alternatives to make curves.
      Contract Coord, Coord => N
      def self.c(x, y)
        new(x, y, :cubic)
      end

      # Shorthand that creates a :quadratic type bezier curve handle node.
      # This "off curve" node isn't part of the path but distorts pulling it.
      # One :quadratic node must come between two :node type nodes. E.g. n q n.
      # Only one quadratic node is needed to make a curve, however :spiro type
      # nodes are even easier for making smooth curves.
      Contract Coord, Coord => N
      def self.q(x, y)
        new(x, y, :quadratic)
      end

      # Shorthand that creates a smooth spiro :g2 node.
      # Spiro nodes are "on curve" so the path bends through them, finding the
      # smoothest possible route. They are perfect for making organic curves.
      # There are :g2 and :g4 spiro node types;
      # :g2 is most robust and a good all rounder.
      Contract Coord, Coord => N
      def self.s(x, y)
        new(x, y, :g2)
      end

      # Shorthand that creates a smooth spiro :g4 node.
      # There are :g2 and :g4 spiro node types;
      # :g4 is smoothest but has longer distance effects and may sometimes fail.
      Contract Coord, Coord => N
      def self.g(x, y)
        new(x, y, :g4)
      end

      # Shorthand that creates a :right spiro node.
      # It joins a straight line segment on the left to a curve on the right.
      Contract Coord, Coord => N
      def self.r(x, y)
        new(x, y, :right)
      end

      # Shorthand that creates a :left spiro node.
      # It joins a straight line segment on the right to a curve on the left.
      Contract Coord, Coord => N
      def self.l(x, y)
        new(x, y, :left)
      end

      private

      def create(x, y, type)
        @x, @y, @type = x, y, type
      end
    end
  end
end
