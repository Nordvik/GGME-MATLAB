% Finds the covariance matrix that minimizes the exp. val of input witness
% subject to having all marginals separable (as per Mista Eq. 29)
% 
% It is the second step for finding a GME state with separable marginals
% along with the witness on covariance matrices that detects Gaussian
% entanglement. 
%
% We want to find the covariance matrix that minimizes the mean value of
% the witness found in the previous step. 
%
% The constraints on the covariance matrix are that it should:
% 
% 1. be a quantum covariance matrix
% 2. have all marginals separable
% 3. have no x-p correlations (end of section 1 in document by Lada)
% 4. have no diagonal elements greater than the specified maxElem or less
% than the specified minElem
% 5. have no eigenvalues less than or equal to the specified minEig
%(6. correspond to a pure state -- NOT IMPLEMENTED)
%
%
% Log: 2019-12-11
%       Generalised code to the N mode

function [ c, CM, output] = findOptimalCM (W)

yalmip('clear')

  if rem(length(W),2) ~= 0
      disp('Error! Witness should have an even number of rows/columns');
      return
  else
      N = length(W)/2;
  end
  
  % Set maximum and minimum diagonal element size.
  
  maxElem = 10;
  minElem = 1;
  
  %Set minimum eigenvalue size
  
  minEig = 0.2;

  % Construct the symplectic form in the (x1,p2,x2,p2,...) ordering.
  
  OMG = symplecticform(N);
  
  % Variance matrix dimension.
  
  D = 2 * N;
  
  % This is the covariance matrix we will minimize over.
  
  G = sdpvar(D, D, 'symmetric', 'real');

  %-----------------------------------------------------------------------%
  % Constraints
  %-----------------------------------------------------------------------%
 
  % 1. G must correspond to a covariance matrix
  
  F = [ G + 1i*OMG >= 0 ];

                   %------------0------------%  
 
  % 2. G should have all marginals separable  
  
  % W do this by forcing all marginals to be PPT. PPT is stronger than 
  % separability in general, but the two coincide for bipartite states. 
  % [Simon, PRL 84, 12, (2000)]

  % in terms of covariance matrices, taking the PT of a certain mode is
  % the same as changing the sign in all appearances of the momentum of
  % that mode. 
  % Using the result from [Werner & Wolf (2001) PRL 86.3658] for the case 
  % of three modes only, that
  %     PPT <=> g + i omg_inv >= 0 , 
  %     where omg_inv has the j-th 2x2 block change sign where j PT mode
 
  arrModeList = [];
  for i = 1:N
  arrModeList = [arrModeList,i];
  end
  
  for k = 1:N
      for j = k+1:N
        arrModesToRemove = setdiff(arrModeList,[j,k]); % Remove all but two modes
        F = [ F, RemoveMode(G,arrModesToRemove) + 1i*InvertModeOmega(2,2) >= 0 ];
      end
  end

                   %------------0------------%  
                   
 % 3. G should have no x-p correlations 
 %
 % We do this by noting the form of the covariance matrix and force zeros
 % whenever the index is even-odd and odd-even

  for i = 1:2*N
      for j = 1:2*N
          if( even(i) && not(even(j)) )
               F = [ F , G(i,j) == 0 ];
          elseif ( not(even(i)) && even(j) )
               F = [ F , G(i,j) == 0 ];
          end
      end
  end
  
   % *NOTE*
 % It seems that the inclusion of these constraints are not necessary as
 % all output covariance matrices don't have x-p correlations - up to
 % numerical noise. However, we should check whether they remove too many
 % potential solutions as even when the outputs are rounded (say to 0(-10))
 % they are still acceptable solutions. 
  
  
 % 4. All diagonal elements of G should be less than the maximum element size 
 % and greater than the minimum element size specified above.
 
 F = [F, max(diag(G)) <= maxElem,  min(diag(G)) >= minElem];
 
 
 % 5. The smallest eigenvalue of G should be greater than the minimum eigenvalue specified above (greater than or equal to minEig + 10^(-9)).
 
 F = [F, G >= minEig + 10^-9];
 
                   %------------0------------%  
                   
  % Next we add the constraint of purity:
  % NOT SUITABLE FOR SOLVING WITH THE SOLVERS TRIED
  % Equivalent statements:
  % F = [ F, (OMG*G)*(OMG*G) + eye(D) == 0 ];   % Solver not applicable
  % F = [ F, norm(G) == 1];                     % "Model creation failed"
  % F = [ F, 1/(sqrt(det(G))) == 1 ];           % "Model creation failed"
  
  % Question: 
  %     Is this because the constraint is not linear in G?
  
 %-----------------------------------------------------------------------%
 % Optimization objective
 %-----------------------------------------------------------------------%
  
  X = (trace(G * W)-1);
   
  
 %-----------------------------------------------------------------------%
 % Minimise using the preferred solver: mosek or SEDUMI
 %-----------------------------------------------------------------------%
 
  O = sdpsettings('solver', 'mosek', 'verbose', 1, 'debug', 0);
  S = optimize(F, X, O);
 
  
 %-----------------------------------------------------------------------%
 % Outputs
 %-----------------------------------------------------------------------%
  
  c  = double(X);
  witness = real(double(W));
  CM   = double(G);
  output = S;
  
  % Print out a warning if neccessary. 
  
  lastwarn("");
  if not(S.problem == 0)
    warning(S.info)
  end
  
end

%%
%%%--------------------------------------------------------------------%%%
%%%                       Helper Functions                             %%%
%%%--------------------------------------------------------------------%%%


% Symplectic form on 'N' modes in the (x1,p1,x2,p2,...) ordering
function [ OMG ] = symplecticform (N) 
  OMG = [ 0, 1 ; - 1, 0 ];
  while (N > 1)
    OMG = blkdiag(OMG, [ 0, 1, ; - 1, 0 ]);
    N = N - 1;
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

function [ omg ] = InvertModeOmega ( modes_total, modes_to_invert )
% ---------------------------------------------------------------------- %
% Function to produce the symplectic matrix corresponding to the partial
% transpose in the modes given. 
% 
% We use the result in [Werner & Wolf (2001) PRL 86,3658]
% PPT <=> g + i omg_inv >= 0 , where omg_inv = (-omg_a) (+) omg_b
% ---------------------------------------------------------------------- %

    % Create 2x2 symplectic matrix
    omg2 = [ 0 -1 ; 1 0 ];
    
    % First mode:
    %   Check whether the first mode is to be transposed and begin building
    %   the matrix accordingly
    if ismember( 1 , modes_to_invert)
        omg = -1*omg2;
    else
        omg = omg2;
    end
    
    % The rest N-1 modes
    for j = 2:modes_total
        if ismember(j, modes_to_invert)
            omg = blkdiag(omg, -1*omg2);
        else
            omg = blkdiag(omg, omg2);
        end
    end
end