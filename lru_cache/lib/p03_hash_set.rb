require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    unless include?(key)
      self[key] << key 
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    @count -= 1 if include?(key)
    self[key].delete(key)
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_length = num_buckets * 2
    @count = 0
    old_set = @store
    @store = Array.new(new_length) { Array.new }  
    old_set.each do |bucket|
      bucket.each { |el| insert(el) }
    end
  end
end








# 
