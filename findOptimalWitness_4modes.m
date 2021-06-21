% 2018 - 2019 Jan Provaznik (provaznik@optics.upol.cz)
%
% Hyllus, Eisert (2006)
% 10.1088/1367-2630/8/4/051
%
% Mista (2018)
% ?
%
% Per equation (H.44) search for a genuine multipartite entanglement witness.
% Per equation (M.59) search for a special type of witness

function [ witvalue, witmatrix, state ] = findOptimalWitness_4modes (G, N)

 shape = 'T';
% shape = 'Linear';

  % This is a specialized modification of (H.44), with condition (M.59)
  % imprinted in the structure of the witness matrix W.

  if not(N == 4)
    error('M.59 expects four modes, exactly four, no more, no less!')
  end

  % Construct the symplectic sigma form.
  
  S = sigma(N);
  
  % Variance matrix dimension, D = 2 * N.
  
  D = 2 * N;

  % The number of unique, unordered partitions of N systems into 2 groups
  % is given by the Stirling's number of the second kind {N, 2}.
  
  K = 2^(N - 1) - 1;
  
  % In (H.44) there is a block diagonal matrix X comprising different matrix
  % types. For the sake of clarity we have relabeled the matrices according
  % to their types.
  
  % This is the W = X_{1} matrix, the Witness matrix.
  
  W = sdpvar(D, D, 'hermitian', 'complex');
  
  % Per (M.52) we have to constrain the structure of the witness. To avoid
  % additional constraints we imprint this onto the actual witness matrix.
  
  if shape == 'T'
      % => (M.53) Prohibit any correlation between the 1st and the 3rd system.

      [ I, J ] = ijIJ(1, 3);

      W(I:(I + 1), J:(J + 1)) = 0;
      W(J:(J + 1), I:(I + 1)) = 0;

      % => (M.54) Prohibit any correlation between the 1st and the 4th system.

      [ I, J ] = ijIJ(1, 4);

      W(I:(I + 1), J:(J + 1)) = 0;
      W(J:(J + 1), I:(I + 1)) = 0;

      % => (M.55) Prohibit any correlation between the 3rd and the 4th system.

      [ I, J ] = ijIJ(3, 4);

      W(I:(I + 1), J:(J + 1)) = 0;
      W(J:(J + 1), I:(I + 1)) = 0;
  elseif shape == 'Linear'
      % => (M.53) Prohibit any correlation between the 1st and the 3rd system.

      [ I, J ] = ijIJ(1, 3);

      W(I:(I + 1), J:(J + 1)) = 0;
      W(J:(J + 1), I:(I + 1)) = 0;

      % => (M.54) Prohibit any correlation between the 1st and the 4th system.

      [ I, J ] = ijIJ(1, 4);

      W(I:(I + 1), J:(J + 1)) = 0;
      W(J:(J + 1), I:(I + 1)) = 0;

      % => (M.55) Prohibit any correlation between the 2nd and the 4th system.

      [ I, J ] = ijIJ(2, 4);

      W(I:(I + 1), J:(J + 1)) = 0;
      W(J:(J + 1), I:(I + 1)) = 0;
  else
      error('Witness shape unsupported - only "T" and "Linear" allowed');
      return
  end
      
      
%   % Utility matrices (used only locally)
%   %
%   % Y_{f} = X_{2},     ..., X_{2 + K}
%   % Z_{f} = X_{K + 4}, ..., X_{3 + K + K}
%   
%   Y = cell(K, 1);
%   Z = cell(K, 1);
%   
%   for f = 1:K
%     Y{f} = sdpvar(D, D, 'hermitian', 'complex');
%     Z{f} = sdpvar(1, 1, 'symmetric', 'real');
%   end
  
  % Utility matrices
  %
  % U = X_{K + 2}
  % V = X_{K + 3}
  
  U = sdpvar(1, 1, 'symmetric', 'real');
  V = sdpvar(1, 1, 'symmetric', 'real');
  
  % Construct the the constraints!
  %
  % U must be positive definite
  % V must be positive definite
  % W must be positive definite to be a Witness
  
  F = [ U >= 0, V >= 0, W >= 0 ];
  
  % Construct the constraints!
  %
  % U - V = 1
  
  F = [ F, U - V == 1 ];
  
  % The only variables that are actually shared between
  % different 'constraints' in (H.44) are U, V and W. 
  
  for f = 1:K
    
    % Construct the partition PI(f), 
    % Construct indices for the 1st group (A) and for the 2nd one (B).
    
    P = arrayfun(@ str2num, dec2bin(f, N));
    
    A =   P .* (1:N);
    B = ~ P .* (1:N);
    
    % Utility matrices, Y_{f} and Z_{f} are only needed locally,
    % this replaces y = Y{f}, z = Z{f}.
    
    Y = sdpvar(D, D, 'hermitian', 'complex');
    Z = sdpvar(1, 1, 'symmetric', 'real');
        
    % The first constraint type is imposed on RE BD(PI(f)) W.
    %
    % To this end we construct 
    % w = BD(PI(f)) [ W    ] 
    % y = BD(PI(f)) [ Y(f) ]
    
    w = W;
    y = Y;
    
    for i = 1:N
      for j = 1:N
        
        if not(A(i)) && not(B(j))
          
          % i, j are the logical indices => I, J are the physical indices.
          
          [ I, J ] = ijIJ(i, j);
          
          % w = BD(PI(f))[ W ]
          
          w(I:(I + 1), J:(J + 1)) = 0;
          w(J:(J + 1), I:(I + 1)) = 0;
          
          % y = BD(PI(f)) [ Y(f) ] 
          
          y(I:(I + 1), J:(J + 1)) = 0;
          y(J:(J + 1), I:(I + 1)) = 0;
          
        end
      end
    end
    
    % Construct the constraints!
    %
    % The utility matrix Y must be positive definite.
    % The utility scalar Z must be positive definite.
    
    F = [ F, Y >= 0, Z >= 0 ];
    
    % Construct the 1st constraint from (H.44)!
    
    F = [ F, real(w) == real(y) ];
    
    % Construct the 2nd constraint from (H.44)!
    
    F = [ F, trace(1i * S * Y) + U - V + Z == 0 ];
    
  end
  
  % Construct the objective, X per (H.44).
  
  X = (trace(G * real(W)) - 1);
  
  % Minimize using the MOSEK solver.
  
  O = sdpsettings('solver', 'mosek', 'verbose', 0, 'debug', 0);
  S = optimize(F, X, O);
  
  % Yield the information.
  
  witvalue  = double(X);
  witmatrix = real(double(W));
  state     = S;
  
  % Print out a warning if neccessary?
  
  if not(S.problem == 0)
    warning(S.info)
  end
  
end

function [ S ] = sigma (N) 
  S = [ 0, 1 ; - 1, 0 ];
  while (N > 1)
    S = blkdiag(S, [ 0, 1, ; - 1, 0 ]);
    N = N - 1;
  end
end

function [ I, J ] = ijIJ (i, j)
  I = 2 * i - 1;
  J = 2 * j - 1;
end
