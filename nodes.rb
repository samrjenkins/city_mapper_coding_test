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

  def visited
    @nodes.select { |node| node.visited }
  end

  def unvisited
    @nodes.select { |node| !node.visited }
  end

  def find(id)
    all.find { |node| node.id == id }
  end

  def min_unvisited_distance
    unvisited.sort { |a,b| a.distance <=> b.distance }
  end

  def new_current
    node = unvisited.min_by { |node| node.distance }
    node.current = true
    node
  end
end
