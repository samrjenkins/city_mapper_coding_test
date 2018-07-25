class Node
  attr_reader :id
  attr_accessor :distance, :current, :visited

  def initialize(id, distance = Float::INFINITY, current = false, visited = false)
    @id = id
    @distance = distance
    @current = current
    @visited = visited
  end
end
