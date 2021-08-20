function  [carray, warray, garray, seedarray] = outputggme(instancesWanted,modesWanted,trials, adjList)
%Run produceggme and output findings to file

if nargin <4 %if adjList unset
    adjList = [];
end

if nargin < 3 %if trials unset
    trials = 10; %default value
end

[carray, warray, garray, seedarray, timearray, tree] = produceggme(instancesWanted,modesWanted,trials,adjList);
    N = modesWanted;
    time=datestr(datetime, 'dd-mmmm-yyyy HH.MM.ss');

    maxTrials = 50; %if updating this it must also be updated in findggme
    %for writing to optimalTrials file
    trialsString = repelem("",2*maxTrials);
    trialsString(1)= strcat("last ",string(instancesWanted)," instances in ",time);
    
    
    %Print data to output file
    
    save(strcat('OutputMatrices\',string(N),'modes\',tree,'\',time,'.mat'),'warray', 'garray','carray', 'timearray','seedarray');
    
    
    %write timestamp and number of instances to optimalTrials file
    writematrix(trialsString,strcat('OutputMatrices\optimalTrials\',string(N),'modes','\',tree,'.xls'),'WriteMode','append');
    
end

