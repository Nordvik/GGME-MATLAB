function [carray warray garray] = produceggme_rounding_smallentries(n,rounding,maxEntrySize)
  
    bootstrap;
    
    % Rounding levels (decimal places)
    round_cm = rounding;
    round_wit = 9;
    
    % Number of examples wanted
    it = n;
    
    carray = [];warray = []; garray = [];count=0;
    
    % Only look at the tripartite case 
    N = 3;
    S = symplecticform(N);
    
    % Fill in the arrays with the covariance matrices, witnesses and
    % expectation values. 
    while (it > 0)
        % The warning messages are used for detecting errors appearing when
        % solving the SDP's. There is probably a better way - if you know
        % it then please let me know. 
        lastwarn("");
        
        randomCM = rndgaussiancmnoxpcorrelations(3);
        
        % Check that the produced CM is symplectic, up to numerical error.
        % We will probably not want results that are sensitive to any
        % greater number of decimal places. 
        if (round(randomCM*S*randomCM'-S,10) == zeros(6))
            [c W gamma] = findggme(randomCM,3,1,1) 
        end
        
        % Choose error-free runs and those CM's that are linked to an
        % entangled state. The first criterion might be too strict as there
        % are cases when there are error warnings but the (cm, witness)
        % pair satisfies our requirements. 
        if (lastwarn == "" && c < 0)
           % Test for suitable entry size
           maxEntryRequirement = max(abs(gamma(:)));
           hasSmallEntries = maxEntryRequirement <= maxEntrySize;
           % Test for rounding 'resilience'
           isAllowed_cm_wit = testthiscm(gamma,round_cm,W,round_wit)&&hasSmallEntries;
           if isAllowed_cm_wit
               it = it - 1;
               % Fill output arrays
               if (length(carray) == 0) % first spotting
                   carray = c;
                   warray = W;
                   garray = gamma;
                   count = 1;
               else
                   count = count + 1;
                   carray = [carray, c];
                   warray = cat(3,warray,W);
                   garray = cat(3,garray,gamma); 
               end
           else % Not fine up to rounding
                %nu'n
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
        T(3+j,2*j)=1;
    end
end

% Symplectic form in the (x1,p1,x2,p2,...) ordering
function J = symplecticform(N)
    J = [ 0 1 ; -1 0 ];
    for i = 1:N-1
        J = blkdiag(J, [ 0 1 ; -1 0 ]);
    end
end