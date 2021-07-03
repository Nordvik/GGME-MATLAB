function [carray, warray, garray, seedarray] = produceggme(instancesWanted,modesWanted,trials,maxTrials)
  
    bootstrap;

    
    % Set trials if unset
    if nargin<3
        trials=1;
    end
    
    % Number of examples wanted
    it = instancesWanted;
    
    carray = [];warray = []; garray = [];count=0;
    
    N = modesWanted;
    S = symplecticform(N);
    
    %Use additional constraints on witness
    only_partial_knowlege = true;
    
    if only_partial_knowlege
        %Get blindness tree from user and generate blindness condition on
        %witness
        blindfold=getBlindness(N);
    else
        blindfold=1;
    end
    
    % Fill in the arrays with the covariance matrices, witnesses and
    % expectation values. 
    while (it > 0)
        % The warning messages are used for detecting errors appearing when
        % solving the SDP's. There is probably a better way - if you know
        % it then please let me know. 
        lastwarn("");

        randomCM = rndgaussiancmnoxpcorrelations(N); %save this for reference (output it)
        
        % Check that the produced CM is symplectic, up to numerical error.
        % We will probably not want results that are sensitive to any
        % greater number of decimal places. 
        c=0;
        round(randomCM*S*randomCM'-S,10);
        
        if (round(randomCM*S*randomCM'-S,10) == zeros(2*N))
            [c, W, gamma, status] = findggme(randomCM, N, only_partial_knowlege, trials, blindfold, maxTrials); %automate trials
        end
        
        % Choose error-free runs and those CM's that are linked to an
        % entangled state. The first criterion might be too strict as there
        % are cases when there are error warnings but the (cm, witness)
        % pair satisfies our requirements. 
%         if (lastwarn == "" && c < 0)
status.problem
        if (status.problem == 0 && c < 0)
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
        S = symplecticform(N);
        randommatrix = randn(N);
        
        % This gives a covariance matrix in the 
        %(x1,x2,...,p1,p2,...) ordering
        thismat = blkdiag(randommatrix*eye(N)*randommatrix',(randommatrix')^(-1)*eye(N)*randommatrix^(-1));
       
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