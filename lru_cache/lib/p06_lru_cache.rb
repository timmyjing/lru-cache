require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'


class LRUCache
  attr_reader :count, :prc
  def initialize(max, prc = Proc.new {|x| x ** 2})
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    #if the key is not cached, call the proc (what does the proc do...?)
    #if the key is cached, do not call the proc
    
    #If the cache is at max capacity, it ejects the LRU item
    # debugger
    if @map.include?(key)
      update_node!(@map.get(key)) # value
    else
      eject! if count == @max
      calc!(key)
    end
    
    @map.get(key).val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    # p value = @prc.call(key)
    @store.append(key, @prc.call(key))
    @map.set(key, @store.last)
    
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    # do we need to update hash?
    @store.remove(node.key)
    @store.append(node.key, node.val)
    # @map.get(key) = @store.last
    @map.set(node.key, @store.last)
  end

  def eject!
    @map.delete(@store.first.key)
    @store.remove(@store.first.key)  
  end
end
