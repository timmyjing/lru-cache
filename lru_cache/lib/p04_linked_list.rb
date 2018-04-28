
class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @next = nil
    @prev = nil
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    node = Node.new(key, val)
    previous = @tail.prev
    previous.next = node
    @tail.prev = node
    node.prev = previous
    node.next = @tail
  end

  def update(key, val)
    each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    bye_node = nil
    each do |node|
      bye_node = node if node.key == key
    end
    node_prev = bye_node.prev
    node_next = bye_node.next
    node_prev.next = node_next
    node_next.prev = node_prev
    bye_node.remove
  end

  def each
    current_node = @head.next
    until current_node == @tail
      yield(current_node)
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
