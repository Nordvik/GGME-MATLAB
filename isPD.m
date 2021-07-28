function x = isPD(M)
%Checks if a matrix M is positive definite, up to numerical error.
%Outputs true if it is and false if it is not.
eigenvalues = eig(M);
tolerance = eps(max(eigenvalues));

x = all(eigenvalues > tolerance);

end

