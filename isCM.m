function x = isCM(M,silence)
%Checks if M is a valid quantum covariance matrix, i.e.

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

if silent
else
    if not(x)
        warning("CM does not satisfy the Heisenberg uncertainty principle.")
    else
        disp("CM is valid.")
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
