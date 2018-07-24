require_relative 'node'

class Nodes
  def initialize
    @nodes = []
  end

  def new_node(id)
    @nodes << Node.new(id)
  end

  def all
    @nodes
  end

  def find(id)
    all.find { |node| node.id == id }
  end

  def find_current
    all.find { |node| node.current}
  end
end
