class DollarValue
  def initialize(value)
    if value.respond_to? :gsub
      value = value.gsub(/[^\d.]/, '')
    end
    @value = value.to_f
  end
  
  def to_s
    "$%.2f" % @value
  end
  
  def to_f
    @value
  end
  
  def inspect
    to_s
  end
  
  def coerce(other)
    if other.class == String
      value = to_s
    else
      value = to_f
      other = other.to_f
    end
  
    [other, value]
  end
end
