require 'vrs'
require 'vector_salad/standard_shapes/n'
require 'vector_salad/standard_shapes/path'

module VectorSalad
  module StandardShapes
    class Path
      VRS.screen(self).class_method(:new).examples do
        new(N.q(1,2), [4,5], [1,2]).must_raise
          .detail 'First node must be :node or :spiro.'

        new([0,0], N.q(1,2), N.q(3,4), [1,2]).must_raise
          .detail ':quadratic nodes must follow a :node.'

        new([0,0], N.c(1,2), N.c(3,4), N.c(2,2), [1,2]).must_raise
          .detail ':cubic nodes must follow a :node and at most 1 other :cubic.'

        new([0,0], N.c(1,2), N.r, [1,2]).must_raise
          .detail ':reflect must be preceded by a :node.'

        new([0,0], [1,1], N.r, [1,2]).must_raise
          .detail ':reflect must be preceded by a :node with a :cubic or :quadratic before that.'
      end
    end
  end
end
