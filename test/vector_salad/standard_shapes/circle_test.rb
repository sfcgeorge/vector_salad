require 'vrs'
require 'vector_salad/standard_shapes/circle'

module VectorSalad
  module StandardShapes
    class Circle
      VRS.screen(self).class_method(:new).examples do
        new('2').must_raise
          .detail 'radius argument must be Numeric.'

        new(50, at: :foo).must_raise
          .detail 'at argument must be Array or N.'
      end
    end
  end
end
