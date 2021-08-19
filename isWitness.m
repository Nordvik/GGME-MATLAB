function x = isWitness(W,silence)
%Checks if a matrix W is a linear entanglement witness based on second
%moments that can detect only GME states as per apprendix of hyllus

if nargin <2 % Input required to post messages
    silent = true;
else
    if islogical(silence)
        silent = silence;  
    else
        disp('Second argument must be a boolean. Messages have been disabled.')
        silent = true;
    end
end


%check input is valid%%%%%%%%%%%
[n, m] = size(W);
if not(n == m)
    error('Matrix must be square.')
end

if not(mod(length(W),2)==0) %not even
    error('Input matrix dimensions should be even.')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = length(W)/2;


%CHECK CONDITION A.4
    A4 = isPSD(W);
    x = A4;

%CHECK CONDITION A.5
    %there are K = N choose 2 ways of bipartitioning the system
    K = 2^(N - 1) - 1;
    
    
    A5 = true;   
    for i = 1:K %for each way of bipartitioning
        if x 
            %create lists of logical values where each element is whether
            %that index is a mode in partiton 1
            inPartition1 = dec2bin(i,N);

            %construct  list of modes in each partition
            part1 = find(inPartition1=='1');
            part2 = find(inPartition1=='0');
            
            %Define submatrices for parties on either side of partition
            submat1 = RemoveMode(W,part2);
            submat2 = RemoveMode(W,part1);
                
            %Find symplectic eigenvalues for submatrices
            sympEigs1 = abs(eig(1i*symp(length(submat1)/2)*submat1));
            sympEigs2 = abs(eig(1i*symp(length(submat2)/2)*submat2));
                
            %get numerical errors
            precision1 = sum(eps(sympEigs1));
            precision2 = sum(eps(sympEigs2));
                
            %Evaluate the symplectic trace over the subsystems and check if >= 1/2.
            %Symplectic eigenvalues each appear twice each in the
            %above lists, so actually check if the sum is >=1 to
            %numerical error and update condition
            A5 = A5 & (sum(sympEigs1) + sum(sympEigs2) >= 1 - precision1 - precision2);
            x = x & A5;
        end
    end
    
%CHECK CONDITION A.6

    %define symplectic form
    omega = symp(N);
    
    %Calculate symplectic eigenvalues
    sympEigs = abs(eig(1i*omega*W));
    
    %calculate precision
    precision = sum(eps(sympEigs));
    
    %Evaluate condition
    A6 = sum(sympEigs) < 1 - precision;
    
%OUTPUT
x = x & A6;

if silent
    % Don't output message
else
    if not(x)
        if not(A4)
            warning("Condition A.4 failed. Witness not positive semidefinite.")
        end
        if not(A5)
            warning("Condition A.5 failed. Symplectic traces over bipartitions do not sum >= 1/2 for all bipartitions.")
        end
        if not(A6)
            warning("Condition A.6 failed. Symplectic trace of witness not < 1/2.")
        end
    else
        disp("Witness is valid.")
    end
end

end

%%%--------------------------------------------------------------------%%%
%%%                       Helper Functions                             %%%
%%%--------------------------------------------------------------------%%%

% Symplectic form in the (x1,p1,x2,p2,...) ordering
function J = symp(N)
    J = [ 0 1 ; -1 0 ];
    for i = 1:N-1
        J = blkdiag(J, [ 0 1 ; -1 0 ]);
    end
end

function mat = RemoveMode(g,p)
% ---------------------------------------------------------------------- %
% Removes desired modes defined in array 'p' from input matrix 'g'.
%
% Inputs: 
%   g - matrix
%   p - array of row/column indices to remove. 
%       Removes indices i and i+2 as these correspond to the same mode.
%
% Output:
%   submatrix formed by removing p
% ---------------------------------------------------------------------- %

N = length(g)/2;

% Initialize submatrix indices
X=1;
Y=1;

% Initialize submatrix
%ab = zeros(2*N-2,2*N-2);

    for J = 1:N
        Y=1;
        if ismember(J,p)
            continue
        else
        end
        for K = 1:N
            if ismember(K,p)
                continue
            else
            end
            for j = 0:1
                for k = 0:1
                    mat(2*X-1+j,2*Y-1+k) = g(2*J-1+j,2*K+k-1);
                end
            end
            Y=Y+1;
        end
        X=X+1;
    end
end
    
