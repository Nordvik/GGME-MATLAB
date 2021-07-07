function  [carray, warray, garray, seedarray] = outputggme(instancesWanted,modesWanted,trials)
%Run produceggme and output findings to file
    
%Set max number of trials (iterations in findggme)
maxTrials = 50;

    % Set trials if unset
    if nargin < 3
        trials = 1;
    end

[carray, warray, garray, seedarray, tree] = produceggme(instancesWanted,modesWanted,trials,maxTrials);
    N = modesWanted;
    time=datestr(datetime, 'dd-mmmm-yyyy HH.MM.ss');
    
    %format for printing
    
    %All matrices must have same number of columns for output. Pad to make
    %sure this is the case.
    
    %horizontal padding
    horpad=repelem(" ",instancesWanted*2*N+1);
    
    %vertical padding
    verpad=repelem(" ",2*N).';
    verpad3d=verpad;
    for i=1:instancesWanted-1
        verpad3d=cat(3,verpad3d,verpad);
    end
    
    %format strings for printing

    witString=horpad;
    witString(1)="Witnesses";
    
    covMatString=horpad;
    covMatString(1)="Covariance Matrices";
    
    meanString=horpad;
    meanString(1)="Witness means";
    
    seedString=horpad;
    seedString(1)="Random seeds";
    
    %for writing to optimalTrials file
    trialsString = repelem("",2*maxTrials);
    trialsString(1)= strcat("last ",string(instancesWanted)," instances in ",time);
    
    %create list of c values to be output with relevant witness and CM
    clist=horpad;
    for i=1:length(carray)
        %format c values
        clist((i-1)*((2*N)+1)+1)=carray(i);
    end
    
    %pad witnesses
    warray = cat(2,warray,verpad3d);
    %pad covariance matrices
    garray = cat(2,garray,verpad3d);
    %pad seeds
    seedarray = cat(2,seedarray,verpad3d);
    
    
    %Print data to output file
    writematrix(witString,strcat('OutputMatrices\',string(N),'modes\',tree,'\',time,'.xls'),'WriteMode','append');
    writematrix(warray,strcat('OutputMatrices\',string(N),'modes\',tree,'\',time,'.xls'),'WriteMode','append');
    
    writematrix(covMatString,strcat('OutputMatrices\',string(N),'modes\',tree,'\',time,'.xls'),'WriteMode','append');
    writematrix(garray,strcat('OutputMatrices\',string(N),'modes\',tree,'\',time,'.xls'),'WriteMode','append');
    
    writematrix(meanString,strcat('OutputMatrices\',string(N),'modes\',tree,'\',time,'.xls'),'WriteMode','append');
    writematrix(clist,strcat('OutputMatrices\',string(N),'modes\',tree,'\',time,'.xls'),'WriteMode','append');
    
    writematrix(seedString,strcat('OutputMatrices\',string(N),'modes\',tree,'\',time,'.xls'),'WriteMode','append');
    writematrix(seedarray,strcat('OutputMatrices\',string(N),'modes\',tree,'\',time,'.xls'),'WriteMode','append');
    
    %write timestamp and number of instances to optimalTrials file
    writematrix(trialsString,strcat('OutputMatrices\optimalTrials\',string(N),'modes','\',tree,'.xls'),'WriteMode','append');
    
end

