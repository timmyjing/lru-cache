class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = (length.hash ^ 48112959837082048697)
    each_with_index do |el, idx|
      result += el.hash * (idx + 1).hash
    end
    result
  end
end

class String
  def hash
    chars.each.with_index.reduce(0) do |acc, (str, idx)|
      acc + ((str.ord.hash * (idx + 1).hash) ^ 54673257461630679457)  
    end
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = keys.length.hash ^ 12764787846358441471
    key = keys.sort
    value = values.sort
    result += key.hash + value.hash
  end
end
