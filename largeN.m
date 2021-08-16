mode = 7;
adjList = [0 1 2 3 4 5 6];
while true 
   mode = mode + 1;
   adjList = [adjList, max(adjList)+1];
   outputggme(1, mode, 20, adjList)
end

