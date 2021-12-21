require 'pry'
require 'pp'

graph = {}
File.open("input.txt").each do |line|
  node1, node2 = line.rstrip.split("-")
  graph[node1] = [] if !graph.key?(node1)
  graph[node2] = [] if !graph.key?(node2)
  graph[node1] << node2
  graph[node2] << node1
end

pp graph

def find_paths(current, graph, path, paths, visited_twice)
  if current == "end"
    paths << path.clone
    return
  end

  next_nodes = graph[current]
  next_nodes.each do |next_node|
    visited_lower_case_node = next_node == next_node.downcase && path.include?(next_node)
    next if next_node == "start" || (visited_lower_case_node && visited_twice)
    path << next_node
    find_paths(next_node, graph, path, paths, visited_twice || visited_lower_case_node)
    path.pop
  end
end

paths = []
find_paths("start", graph, ["start"], paths, false)

# paths.each { |path| puts path.join(",") }
puts paths.size