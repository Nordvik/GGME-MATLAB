mode = 10;
adjList = [0 1 2 3 4 5 6 7 8 9];
while true 
   mode = mode + 1;
   adjList = [adjList, max(adjList)+1];
   
   for n=1:20
        outputggme(1, mode, 20, adjList)
   end
end

