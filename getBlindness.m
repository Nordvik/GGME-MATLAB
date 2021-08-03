function [blindfold, adjList] = getBlindness(N, adjList)
%Takes number of modes as input, requests blindness tree from user and
%outputs blindness conditions on witness

    if N<3 
        error('Expects 3 modes or more.')
    end
    
    if nargin < 2 %if adjList unset
        adjList = [];
    end
    
    if N==3 %automatically set blindness tree to only option for N=3
        adjList=[0 1 2];     
    else
        %get blindness tree from user if not input at start
        if isempty(adjList)
            adjList= input('Input adjacency list of blindness tree (vector of length N with each element \nin the vector the index of its parent in the tree, e.g. for 3 modes [0 1 2]):   \n');
        end
    end
        
        if not(length(adjList)==N) 
            error('Adjacency list should have same length as number of modes.')
        end

        %Plot schematic of witness tree, return error if adjList does not
        %correspond to a tree
        treeplot(adjList)
    

        %Calculate adjacency matrix from list
        adjMat= eye(N);
        for i =1:length(adjList)
            if adjList(i)>0
                adjMat(i,adjList(i))= 1;
                adjMat(adjList(i),i)= 1;
            end
        end
    
    
    adjMat=logical(adjMat);
    
    %create blindness conditions for witness
    blindfold=zeros(2*N);

    for i=1:N
        for j = 1:N  
            if adjMat(i,j)
                [I,J]=ijIJ(i,j);
                blindfold(I:I+1,J:J+1)=1;
            end
        end
    end
end


function [ I, J ] = ijIJ (i, j)
  I = 2 * i - 1;
  J = 2 * j - 1;
end
        