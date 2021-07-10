function [omega, S, L, sympEigs1, sympEigs2, sympEigs3] = whichalgorithm(W)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
 %Find symplectic trasformation S that diagonalises M (see Serafini
    %pg44)
    
    N = length(W)/2;
    omega = symp(N);
    
    [~, ~, L] = eig(omega*W);
    L = L';
    U = [1 1i; 1 -1i]/sqrt(2);
    for j = 1:N-1 
        U = blkdiag(U,[1 1i; 1 -1i]/sqrt(2));
    end   
    S = ctranspose(U)*inv(ctranspose(L));
    
    %Find the symplectic normal form of W, D 
    D = S*W*S';
    
    %Get precision for trace of D
    precision = sum(eps(diag(D)));
    

    sympEigs1 = diag(D)
    
    sympEigs2  = eig(sqrtm(W)*1i*omega*sqrtm(W))
    
    sympEigs3 = abs(eig(1i*omega*W))

end

function J = symp(N)
    J = [ 0 1 ; -1 0 ];
    for i = 1:N-1
        J = blkdiag(J, [ 0 1 ; -1 0 ]);
    end
end