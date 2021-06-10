function null = displayPTMarginalSymplecticEigenvalues_3mode(array_input)
N = length(array_input);

% Definitions
% Symplectic forms
symp2 = symplecticform(2);
symp3 = symplecticform(3);

% Partial transposition matrices (p_a -> -p_a) (HERE ASSUME N=3!!!)
sigma_z  = [ 1 0 ; 0 -1]; 
L = blkdiag(sigma_z,eye(2));

subarr_AB = array_input([1:4],[1:4]);
subarr_AC = array_input([1,2,5,6],[1,2,5,6]);
subarr_BC = array_input([3:6],[3:6]);

subarr_AB_PT = L*array_input([1:4],[1:4])*transpose(L);
subarr_AC_PT = L*array_input([1,2,5,6],[1,2,5,6])*transpose(L);
subarr_BC_PT = L*array_input([3:6],[3:6])*transpose(L);


% Alternative
% subarr_AB = RemoveMode(array_input,3);
% subarr_AC = RemoveMode(array_input,2);
% subarr_BC = RemoveMode(array_input,1);

subarr_AB_PT_sympEig = eig(1.i*symp2*subarr_AB_PT);
subarr_AC_PT_sympEig = eig(1.i*symp2*subarr_AC_PT);
subarr_BC_PT_sympEig = eig(1.i*symp2*subarr_BC_PT);

minSympEig_AB_PT = min(abs(subarr_AB_PT_sympEig));
minSympEig_AC_PT = min(abs(subarr_AC_PT_sympEig));
minSympEig_BC_PT = min(abs(subarr_BC_PT_sympEig));

disp('The input covariance matrix is:')
array_input
disp('Whose PT marginals have the smallest symplectic eigenvalues:');
disp(sprintf('For the PT of the sub covariance matrix AB: %f', minSympEig_AB_PT));
disp(sprintf('For the PT of the sub covariance matrix AC: %f', minSympEig_AC_PT));
disp(sprintf('For the PT of the sub covariance matrix BC: %f', minSympEig_BC_PT));


end

%%
%%%--------------------------------------------------------------------%%%
%%%                       Helper Functions                             %%%
%%%--------------------------------------------------------------------%%%
    

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
