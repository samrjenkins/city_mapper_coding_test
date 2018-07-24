require 'csv'
require_relative 'node'

# parse raw data into array
csv_options = { col_sep: ' ' }
filepath    = ARGV[0]

raw_data_array = []

CSV.foreach(filepath, csv_options) do |row|
  raw_data_array << row
end

# create array of nodes
number_nodes = raw_data_array.first.first.to_i
nodes = raw_data_array.slice(1, number_nodes).flatten

# create hash of edges: { nodes: [node1, node2], distance: 123m }
number_edges = raw_data_array[number_nodes + 1].first.to_i
edges = raw_data_array.slice(number_nodes + 2, number_edges)
edges = edges.map do |array|
  {
    nodes: [array[0], array[1]],
    distance: array[2]
  }
end


# Dijkstra's algorithm
#####
unvisited_nodes = []
#####

# assign tentative distance value to every node
# tentative distance is 0 for starting node and infinity for all others
# assign to each node a way of identifying the current node
nodes.each do |node|
  unvisited_nodes << Node.new(node)
end

initial_node = unvisited_nodes.find { |node| node.id == ARGV[1]}
initial_node.current = true
initial_node.tentative_distance = 0
final_node = unvisited_nodes.find { |node| node.id == ARGV[2]}

p initial_node
