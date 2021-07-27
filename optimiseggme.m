function [bestCs, bestCMs, bestWs] = optimiseggme(N, adjList,instancesToProcess, instancesToOutput)
%gets previously generated CMs and witnesses and selects the best ones,
%then further processes them to see if they can be improved and outputs the
%new best instance

%set parameters if unset
if nargin < 4
    instancesToOutput = 5;
end

if nargin < 3
    instancesToProcess = 20;
end

%load in data
filenames = dir(strcat('OutputMatrices\',string(N),'modes\',adjList,'\*.mat');
CMarray=[];Warray=[];Clist=[];

for i=1:length(filenames)
    CMarray = cat(3, CMarray, load(strcat('OutputMatrices\',string(N),'modes\',adjList,'\',filenames(i),'.mat'),garray));
    Warray = cat(3, Warray, load(strcat('OutputMatrices\',string(N),'modes\',adjList,'\',filenames(i),'.mat'),warray));
    Clist = [Clist, load(strcat('OutputMatrices\',string(N),'modes\',adjList,'\',filenames(i),'.mat'),carray)];
end

%find most optimal instances
indexes = repelem(0,instancesToProcess);
tempClist = Clist;
for i=1:instancesToProcess
    [~,indexes(i)] = min(tempClist);
    tempClist(indexes(i)) = 1;
end

%attempt optimisation
improved = repelem(false, instancesToProcess); %log if an improvement is made
blindfold = getBlindness(N, adjList); %get blindfold
for i=1:instancesToProcess
    [c, W, CM] = findggme(CMarray(i), N, true, 30, blindfold, adjList);
    if c < Clist(i)
        improved(i) = true;
        %add new improved instance to arrays
        CMarray = cat(3, CMarray, CM);
        Warray = cat(3, Warray, W);
        Clist = [Clist, c];
    end
end
    
%Find instances to output

outputindexes = repelem(0,instancesToOutput);
tempClist = Clist;
bestCMs=[]; bestWs=[]; bestCs=[];
for i=1:instancesToOutput
    [~,outputindexes(i)] = min(Clist);
    bestCMs = cat(3,bestCMs,CMarray(:,:,outputindexes(i)));
    bestWs = cat(3,bestWs,Warray(:,:,outputindexes(i))); 
    bestCs = [bestCs, Clist(outputindexes(i))];
    tempClist(outputindexes(i)) = 1;
end

save(strcat('OutputMatrices\',string(N),'modes\',adjList,'\optimalCases.mat',bestCMs, bestWs, bestCs);

end

