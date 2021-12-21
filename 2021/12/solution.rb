require 'pry'
require 'pp'

graph = {}
File.open("test.txt").each do |line|
  node1, node2 = line.rstrip.split("-")
  graph[node1] = [] if !graph.key?(node1)
  graph[node2] = [] if !graph.key?(node2)
  graph[node1] << node2
  graph[node2] << node1
end

pp graph

def find_paths(current, graph, path, paths)
  if current == "end"
    paths << path.clone
    return
  end

  next_nodes = graph[current]
  next_nodes.each do |next_node|
    next if next_node == "start" || (next_node == next_node.downcase && path.include?(next_node))
    path << next_node
    find_paths(next_node, graph, path, paths)
    path.pop
  end
end

paths = []
find_paths("start", graph, ["start"], paths)

paths.each { |path| puts path.join(",") }
puts paths.size