require 'vrs'
require 'vector_salad/standard_shapes/n'

module VectorSalad
  module StandardShapes
    class N
      VRS.screen(self).class_method(:new).examples do
        new('2', '4').must_raise
          .detail 'x and y arguments must be Numeric.'

        new(1,2, :foo).must_raise
          .detail 'Invalid node type.'
      end

      #VRS.screen(self).class_method(:at=).examples do
        #(at = :foo).must_raise.detail 'Not an array.'
        #(at = [:x,:y]).must_raise.detail 'X and Y must be numeric.'
      #end
    end
  end
end
