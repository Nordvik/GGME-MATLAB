function array_out = displayPTMarginalEigenValuesHUP_3mode(array_input)

if rem(length(array_input),2)==0
    N = length(array_input)/2;
else
    disp('Error! Even number of columnts expected');
    return;
end

if N ~= 3
    disp('Error! Number of modes expected: 3');
    return
end

% Definitions
% Symplectic forms
S = symplecticform(2);

% Partial transposition matrices (p_a -> -p_a) (HERE ASSUME N=3!!!)
sigma_z  = [ 1 0 ; 0 -1]; 
L = blkdiag(sigma_z,eye(2));

subarr_AB = RemoveMode(array_input,3)
subarr_AC = RemoveMode(array_input,2)
subarr_BC = RemoveMode(array_input,1)

subarr_AB_PT = L*array_input([1:4],[1:4])*transpose(L)
subarr_AC_PT = L*array_input([1,2,5,6],[1,2,5,6])*transpose(L)
subarr_BC_PT = L*array_input([3:6],[3:6])*transpose(L)


subarr_AB_PT_Eig = eig(subarr_AB_PT + 1.i*S)
subarr_AC_PT_Eig = eig(subarr_AC_PT + 1.i*S)
subarr_BC_PT_Eig = eig(subarr_BC_PT + 1.i*S)

minEig_AB_PT = min(abs(subarr_AB_PT_Eig));
minEig_AC_PT = min(abs(subarr_AC_PT_Eig));
minEig_BC_PT = min(abs(subarr_BC_PT_Eig));

disp('The input covariance matrix is:')
array_input
disp('Whose (PT marginals + i\Omega) have the smallest eigenvalues:');
disp(sprintf('For the sub-covariance matrix AB: %f', minEig_AB_PT));
disp(sprintf('For the sub-covariance matrix AC: %f', minEig_AC_PT));
disp(sprintf('For the sub-covariance matrix BC: %f', minEig_BC_PT));

end

%%%%%%%%%%%%%%%%%%%%%%%%
% % Helper functions % %
%%%%%%%%%%%%%%%%%%%%%%%%

function mat = RemoveMode(g,p)

N = length(g)/2;

% Initialize submatrix indeces
X=1;
Y=1;

% Initialize submatrix
ab = zeros(2*N-2,2*N-2);

for J = 1:N
    Y=1;
    if J == p
        continue
    else
    end
    for K = 1:N
        if K == p
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