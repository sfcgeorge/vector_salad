# Monkeypatches to core Ruby Fixnum class
class Fixnum
  # Multiply number self by UNIT constant
  def ~
    self * UNIT
  end
end

# Monkeypatches to core Ruby Float class
class Float
  # Multiply number self by UNIT constant
  def ~
    self * UNIT
  end
end
