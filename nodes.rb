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
end
