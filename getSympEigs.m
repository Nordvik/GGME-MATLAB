function sympEigs = getSympEigs(M)
%get synplectic eigenvalues of a matrix M

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

 %define symplectic form
    omega = symp(N);
    
    %Calculate symplectic eigenvalues
    sympEigs = abs(eig(1i*omega*M));
    
end

% Symplectic form in the (x1,p1,x2,p2,...) ordering
function J = symp(N)
    J = [ 0 1 ; -1 0 ];
    for i = 1:N-1
        J = blkdiag(J, [ 0 1 ; -1 0 ]);
    end
end

