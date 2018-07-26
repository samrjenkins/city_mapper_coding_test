require 'csv'
require_relative 'nodes'

# parse raw data into array
raw_data_array = []
CSV.foreach(ARGV[0], col_sep: ' ') do |row|
  raw_data_array << row
end

# Create and populate node repository with Node instances
nodes = Nodes.new
number_nodes = raw_data_array.first.first.to_i
node_ids = raw_data_array.slice(1, number_nodes).flatten
node_ids.each { |node_id| nodes.new_node(node_id) }

# create array of edge hashes. eg: [{ nodes: [node1, node2], distance: 123m }, ...]
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

# Define origin and destination
initial_node = nodes.find(ARGV[1])
initial_node.distance = 0
final_node = nodes.find(ARGV[2])


# This function is run for every visited node
def dijkstra_iteration(nodes, edges)
  current_node = nodes.new_current # Selects the unvisited node with the shortest distance attribute
  adjacent_edges = edges.select { |edge| edge[:nodes].include?(current_node.id) } # Array of edges connected to current node
  neighbour_node_ids = adjacent_edges.map { |edge| edge[:nodes].find { |node| node != current_node.id}}
  neighbour_nodes = neighbour_node_ids.map { |id| nodes.find(id) } # Array of nodes connected to current by edges
  unvisited_neighbour_nodes = neighbour_nodes.select { |node| !node.visited } # Select unvisited neighbouring nodes
  unvisited_neighbour_nodes.each_with_index do |node, i| # Calculate distance of unvisited neighbour
    if node.distance > (current_node.distance + adjacent_edges[i][:distance])
      node.distance = current_node.distance + adjacent_edges[i][:distance]
    end
  end
  # Mark current node as visited (will not be considered again)
  current_node.visited = true
  current_node.current = false
end

# Run dijkstra_iteration until the destination has been "visited"
until final_node.visited
  dijkstra_iteration(nodes, edges)
end

p final_node.distance
