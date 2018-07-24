class Node
  attr_reader :id
  attr_accessor :tentative_distance, :current

  def initialize(id, tentative_distance = Float::INFINITY, current = false)
    @id = id
    @tentative_distance = tentative_distance
    @current = current
  end
end
