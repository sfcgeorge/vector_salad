# Monkeypatches to core Ruby Fixnum class
class Numeric
  # Get unit value
  def unit
    @@unit ||= 1
  end

  # Set the global unit value
  # for multiplying numbers by using tilde (~)
  # to scale designs
  def self.unit=(unit)
    @@unit = unit
  end
end

# Monkeypatches to core Ruby Fixnum class
class Fixnum
  # Multiply number self by unit
  def ~
    self * unit
  end
end

# Monkeypatches to core Ruby Float class
class Float
  # Multiply number self by unit
  def ~
    self * unit
  end

  # @api private
  def to_s
    round(8).inspect
  end
end
