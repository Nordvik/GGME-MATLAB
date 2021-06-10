function array_out = displayPTMarginalEigenValuesHUP(array_input)

[N m] = size(array_input);

if rem(N,2)==0
    modes = N/2;
else
    disp('Error! Even number of columnts expected');
    return;
end

array_out = [];

% Definitions
% Symplectic forms
S = symplecticform(2);

% Partial transposition matrices (p_a -> -p_a) (HERE ASSUME N=3!!!)
sigma_z  = [ 1 0 ; 0 -1]; 
L = blkdiag(sigma_z,eye(2));
L1 = blkdiag(sigma_z,eye(2)); 
L2 = blkdiag(eye(2),sigma_z);

arrModeList = [];
for i = 1:modes
    arrModeList(i) = i;
end

disp('The input covariance matrix is:')
array_input

for i = 1:modes
    for j = i+1:modes
        arrModesToRemove = setdiff(arrModeList,[i,j]) % Remove all but two modes
        submat = RemoveMode(array_input,arrModesToRemove)
    
        ppt1 = isPositiveDefinite(L1*submat*transpose(L1) + 1i*S);
        ppt2 = isPositiveDefinite(L2*submat*transpose(L2) + 1i*S);
        
        MSG = ['The minumum eigenvalue of the covariance matrix between modes ', num2str(i), ' and ', num2str(j), ' are:'];
        disp(MSG);
        subarr_PT_Eig = eig(L1*submat*transpose(L1)+1.i*S);
        subarr_PT_Eig = eig(L2*submat*transpose(L2)+1.i*S);
        minEigVal = min(abs(subarr_PT_Eig))
        array_out = [array_out, minEigVal];
        if ppt1 && ppt2
            disp('The marginal covariance matrix is separable');
        else
            disp('The marginal covariance matrix is NOT separable');
        end
       
    end
end

end

%%%%%%%%%%%%%%%%%%%%%%%%
% % Helper functions % %
%%%%%%%%%%%%%%%%%%%%%%%%

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
    
    
function [ OMG ] = symplecticform (N) 
  OMG = [ 0, 1 ; - 1, 0 ];
  while (N > 1)
    OMG = blkdiag(OMG, [ 0, 1, ; - 1, 0 ]);
    N = N - 1;
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
    if m~=n,
        error('A is not Symmetric');
    end
    
    %Test for positive definiteness
    x=1; %Flag to check for positiveness
    for i=1:m
        subA=A(1:i,1:i); %Extract upper left kxk submatrix
        if(det(subA)<=0); %Check if the determinent of the kxk submatrix is +ve
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