# Citymapper Router Challenge - Sam Jenkins


## Getting started
This code was developed using Ruby version 2.4.4
The code can be run from the coding_test directory using:

```ruby app.rb citymapper-coding-test-graph.dat <from node OSM id> <to node OSM id>```


## Design
The programme follows Dijkstra's Algorithm for calculating the shortest path between two nodes. I chose this algorithm because the data provides no indication as to the direction one might expect to move in at any stage. That is to say, there is no indication as to whether a particular step moves towards or away from the destination. This means the algorithm must progress in all directions until the result is found. However, while being computationally intensive and slow, Dijkstra's algorithm does guarantee to return the shortest walkable distance, as required.

My initial solution involved creating an instance of the Node class for every OSM node ID. Each Node instance is pushed into an array contained within an instance of the Nodes class (a repository for the nodes). Edges (in the form of a hash) are stored in a separate array.

In this form the programme runs successfully but slowly for long routes. I attempted to improve the running speed as follows:

The 'until' loop occupies the majority of the running time, particularly for longer routes.
Each iteration of the loop's dijkstra algorithm involves multiple Node lookups within the Nodes repository array.
I understand that the lookup time for values in a hash is faster than that for elements in an array.
The Nodes repository array could be simply reformatted as a hash, eg:

```@nodes = {
  <node_id>: <instance of Node class>
  ...
  <node_id>: <instance of Node class>
}```

Upon testing, the runtime of the programme did not improve (it actually got worse) with the use of a hash so I returned to the initial array format.
