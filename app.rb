require 'csv'
require_relative 'node'
require_relative 'nodes'
require 'pry'

# parse raw data into array
raw_data_array = []

CSV.foreach(ARGV[0], col_sep: ' ') do |row|
  raw_data_array << row
end

# create array of nodes
nodes = Nodes.new

number_nodes = raw_data_array.first.first.to_i
node_ids = raw_data_array.slice(1, number_nodes).flatten
node_ids.each { |node_id| nodes.new_node(node_id) }

# create hash of edges: { nodes: [node1, node2], distance: 123m }
number_edges = raw_data_array[number_nodes + 1].first.to_i
edges = raw_data_array.slice(number_nodes + 2, number_edges)
edges = edges.map do |array|
  {
    nodes: [array[0], array[1]],
    distance: array[2].to_i
  }
end


# Dijkstra's algorithm
# --------------------


initial_node = nodes.find(ARGV[1])
initial_node.distance = 0
final_node = nodes.find(ARGV[2])

def dijkstra_iteration(nodes, edges)
  nodes.new_current
  current_node = nodes.find_current
  adjacent_edges = edges.select { |edge| edge[:nodes].include?(current_node.id)}
  neighbour_node_ids = adjacent_edges.map { |edge| edge[:nodes].find { |node| node != current_node.id}}
  neighbour_nodes = neighbour_node_ids.map { |id| nodes.find(id) }
  unvisited_neighbour_nodes = neighbour_nodes.select { |node| !node.visited }
  unvisited_neighbour_nodes.each_with_index do |node, i|
    if node.distance > (current_node.distance + adjacent_edges[i][:distance])
      node.distance = current_node.distance + adjacent_edges[i][:distance]
    end
  end
  current_node.visited = true
  current_node.current = false
  p current_node.id
  p current_node.distance
end

until final_node.visited
  dijkstra_iteration(nodes, edges)
end

p final_node.distance
