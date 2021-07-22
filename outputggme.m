function  [carray, warray, garray, seedarray] = outputggme(instancesWanted,modesWanted,trials, adjList)
%Run produceggme and output findings to file
    
%Set max number of trials (iterations in findggme)
maxTrials = 50;

    % Set adjList if unset
    if nargin < 4
        adjList = [];
    end

[carray, warray, garray, seedarray, tree] = produceggme(instancesWanted,modesWanted,trials,maxTrials,adjList);
    N = modesWanted;
    time=datestr(datetime, 'dd-mmmm-yyyy HH.MM.ss');

    
    %for writing to optimalTrials file
    trialsString = repelem("",2*maxTrials);
    trialsString(1)= strcat("last ",string(instancesWanted)," instances in ",time);
    
    
    %Print data to output file
    
    save(strcat('OutputMatrices\',string(N),'modes\',tree,'\',time,'.mat'),'warray', 'garray','carray','seedarray');
    
    
    %write timestamp and number of instances to optimalTrials file
    writematrix(trialsString,strcat('OutputMatrices\optimalTrials\',string(N),'modes','\',tree,'.xls'),'WriteMode','append');
    
end

