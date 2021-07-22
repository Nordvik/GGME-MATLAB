function [carray, warray, garray, seedarray, tree] = produceggme(instancesWanted,N,trials, maxTrials, adjList)
  
    bootstrap;

    %Use additional constraints on witness
    only_partial_knowlege = true;
    
    if only_partial_knowlege
        %Get blindness tree from user and generate blindness condition on
        %witness
        [blindfold, tree] = getBlindness(N, adjList);
    else
        blindfold=1;tree=0;
    end
    
    
    % Number of examples wanted
    it = instancesWanted;
    
    carray = [];warray = []; garray = [];count=0;

    S = symplecticform(N);
    
    %format tree name for printing
    tree = strjoin(string(tree));
    
    % Fill in the arrays with the covariance matrices, witnesses and
    % expectation values. 
    while (it > 0)
        % The warning messages are used for detecting errors appearing when
        % solving the SDP's. There is probably a better way - if you know
        % it then please let me know. 
        lastwarn("");   %sets last warning to empty

               
        % Check that the produced CM is a quantum CM, up to numerical error.
        check = true;
        while check
            randomCM = rndgaussiancmnoxpcorrelations(N);
            if isCM(randomCM)
                [c, W, gamma, ~] = findggme(randomCM, N, only_partial_knowlege, trials, blindfold, tree, maxTrials); %automate trials
                check = false;
            end
        end
        
        % Choose runs with valid output matrices and are linked to an
        % entangled state. 
                                     
            if ( c < 0 && isWitness(W) && isCM(gamma)) %all conditions for a valid output. These could be too strong, as tolerances are very small
                it = it - 1;
                if isempty(carray) % first spotting
                    carray = c;
                    warray = W;
                    garray = gamma;
                    seedarray = randomCM;
                    count = 1;
                else
                    count = count + 1;
                    carray = [carray, c];
                    warray = cat(3,warray,W);
                    garray = cat(3,garray,gamma); 
                    seedarray = cat(3,seedarray,randomCM);
                end
            end
        end
    end


%%
%%%--------------------------------------------------------------------%%%
%%%                       Helper Functions                             %%%
%%%--------------------------------------------------------------------%%%


% Creates a random quantum covariance matrix with no x-p correlations
% in the (x1,p1,x2,p2,...) ordering, as per Mista
function cm = rndgaussiancmnoxpcorrelations(N)

        T = orderingconversion(N);
        %create random diagonal matrix (max element 15)
        D = diag(randi(15,N,1));

        randommatrix = randn(N);
        
        % This gives a covariance matrix in the 
        %(x1,x2,...,p1,p2,...) ordering
        thismat = blkdiag(randommatrix*D*randommatrix',(randommatrix')^(-1)*D*randommatrix^(-1));
       
        % Convert to the wanted ordering
        cm = T'*thismat*T;
end

% Matrix for converting between the first and second orderings
function T = orderingconversion(N)
    T = zeros(2*N);
    for j = 1:N
        T(j,2*j-1)= 1;
        T(N+j,2*j)=1;
    end
end

% Symplectic form in the (x1,p1,x2,p2,...) ordering
function J = symplecticform(N)
    J = [ 0 1 ; -1 0 ];
    for i = 1:N-1
        J = blkdiag(J, [ 0 1 ; -1 0 ]);
    end
end