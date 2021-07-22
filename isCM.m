function x = isCM(M)
%Checks if M is a valid quantum covariance matrix, i.e.

%check input is valid%%%%%%%%%%%
[n, m] = size(M);
if not(n == m)
    error('Matrix must be square.')
end

if not(mod(length(M),2)==0) %not even
    error('Input matrix dimensions should be even.')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = length(M)/2;

S = symp(N);

x = isPSD(M + 1i*S);

if not(x)
    "CM does not satisfy the Heisenberg uncertainty principle."
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
