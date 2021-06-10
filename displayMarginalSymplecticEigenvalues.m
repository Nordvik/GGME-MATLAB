function null = displayMarginalSymplecticEigenvalues(array_input)

N = length(array_input);

% Global matrix symplectic eigenvalues
symp2 = symplecticform(2);
symp3 = symplecticform(3);


subarr_AB_sympEig = eig(1.i*symp2*array_input([1:4],[1:4]));
subarr_AC_sympEig = eig(1.i*symp2*array_input([1,2,5,6],[1,2,5,6]));
subarr_BC_sympEig = eig(1.i*symp2*array_input([3:6],[3:6]));

minSympEig_AB = min(abs(subarr_AB_sympEig));
minSympEig_AC = min(abs(subarr_AC_sympEig));
minSympEig_BC = min(abs(subarr_BC_sympEig));

disp('The input covariance matrix is:')
array_input
disp('Whose marginals have the smallest symplectic eigenvalues:');
disp(sprintf('For the sub covariance matrix AB: %f', minSympEig_AB));
disp(sprintf('For the sub covariance matrix AC: %f', minSympEig_AC));
disp(sprintf('For the sub covariance matrix BC: %f', minSympEig_BC));

end

% %%%%%%%%%%%%%%%%%%%% %
% % Helper functions % %
% %%%%%%%%%%%%%%%%%%%% %

function [ OMG ] = symplecticform (N) 
  OMG = [ 0, 1 ; - 1, 0 ];
  while (N > 1)
    OMG = blkdiag(OMG, [ 0, 1, ; - 1, 0 ]);
    N = N - 1;
  end
end