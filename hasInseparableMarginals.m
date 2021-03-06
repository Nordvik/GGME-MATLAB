function notSepMarginalsArray = hasInseparableMarginals(CM)
% Function to check whether all marginals, of A, are separable 

boolDisplayMessages = false;

% checking that dimensions are alright
[n, m] = size(CM);

if not(n == m)
    error('Matrix must be square.')
    return;
end

if not(mod(n,2)==0) %not even
    error('Input matrix dimensions should be even.')
    return;
end

N = length(CM)/2;

omg = symplecticform(2);

%Defining transposition matrices (p_a -> -p_a)
sigma_z  = [ 1 0 ; 0 -1]; 
L1 = blkdiag(sigma_z,eye(2)); 
L2 = blkdiag(eye(2),sigma_z);

% Defining array of marginals which are not separable
notSepMarginalsArray = [];

% Cut submatrices and check for positivity
arrModeList = [];
for i = 1:N
    arrModeList(i) = i;
end

for i = 1:N
    for j = i+1:N
        arrModesToRemove = setdiff(arrModeList,[i,j]); % Remove all but two modes
        submat = RemoveMode(CM,arrModesToRemove);
    
        ppt1 = isPositiveDefinite(L1*submat*transpose(L1) + 1i*omg);  
        ppt2 = isPositiveDefinite(L2*submat*transpose(L2) + 1i*omg);
        
        if (ppt1 && ppt2)
            if boolDisplayMessages
                MSG = ['Submatrix for modes ',num2str(i), ' and ',num2str(j),' is PPT'];
                disp(MSG)
            end
        else
            if boolDisplayMessages
                MSG = ['Submatrix for modes ',num2str(i), ' and ',num2str(j),' is not PPT'];
                disp(MSG)
            end
            notSepMarginalsArray = cat(3,notSepMarginalsArray,[i, j]);
        end
    end
end

end

%%
%%%--------------------------------------------------------------------%%%
%%%                       Helper Functions                             %%%
%%%--------------------------------------------------------------------%%%

% Symplectic form in the (x1,p1,x2,p2,...) ordering
function J = symplecticform(N)
    J = [ 0 1 ; -1 0 ];
    for i = 1:N-1
        J = blkdiag(J, [ 0 1 ; -1 0 ]);
    end
end

function x=isPositiveDefinite(A)
%Function to check whether a given matrix A is positive definite
%Author Mathuranathan for https://www.gaussianwaves.com
%Returns x=1, if the input matrix is positive definite
%Returns x=0, if the input matrix is not positive definite
%Throws error if the input matrix is not symmetric

% Comment by Viktor:
% This code uses what is known as "Sylvester's Criterion":
%   Hermitian A > 0 <=> all leading principal minors have
%                       positive determinant


    %Check if the matrix is symmetric
    [m,n]=size(A); 
    if m~=n
        error('A is not Symmetric');
    end
    
    %Test for positive definiteness
    x=1; %Flag to check for positiveness
    for i=1:m
        subA=A(1:i,1:i); %Extract upper left kxk submatrix
        if(det(subA)<=0) %Check if the determinent of the kxk submatrix is +ve
            x=0;
            break;
        end
    end
    
    if x
    %    display('Given Matrix is Positive definite');
    else
    %    display('Given Matrix is NOT positive definite');
    end      
end

function mat = RemoveMode(g,p)
% ---------------------------------------------------------------------- %
% Removes desired modes defined in array 'p' from input matrix 'g'.
%
% Inputs: 
%   g - matrix
%   p - array of row/column indeces to remove. 
%       Removes indeces i and i+2 as these corresponds to the same mode.
%
% Output:
%   submatrix formed by removing p
% ---------------------------------------------------------------------- %

N = length(g)/2;

% Initialize submatrix indeces
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
    
    

