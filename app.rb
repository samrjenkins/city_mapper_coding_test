require 'csv'
require_relative 'node'
require_relative 'nodes'

# parse raw data into array
raw_data_array = []

CSV.foreach(ARGV[0], col_sep: ' ') do |row|
  raw_data_array << row
end

# create array of nodes
nodes = Nodes.new

number_nodes = raw_data_array.first.first.to_i
node_ids = raw_data_array.slice(1, number_nodes).flatten
unvisited_nodes = node_ids.map { |node| Node.new(node)}

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
# assign tentative distance value to every node
# tentative distance is 0 for starting node and infinity for all others
# assign to each node a way of identifying the current node

initial_node = unvisited_nodes.find { |node| node.id == ARGV[1]}
initial_node.current = true
initial_node.tentative_distance = 0
final_node = unvisited_nodes.find { |node| node.id == ARGV[2]}


def dijkstra_iteration(unvisited_nodes, edges)
  current_node = unvisited_nodes.find { |node| node.current }
  adjacent_edges = edges.select { |edge| edge[:nodes].include?(current_node.id)}
  neighbour_node_ids = adjacent_edges.map { |edge| edge[:nodes].find { |node| node != current_node.id}}
  neighbour_nodes = neighbour_node_ids.map { |id| unvisited_nodes.find { |node| node.id == id } }
end

p dijkstra_iteration(unvisited_nodes, edges)
