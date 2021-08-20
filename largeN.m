mode = 6;
adjList = [0 1 2 3 4 5];
while true 
   mode = mode + 1;
   adjList = [adjList, max(adjList)+1];
   
   for n=1:20
        outputggme(5, mode, 10, adjList)
   end
end

