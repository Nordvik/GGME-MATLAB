function x = isPSD(M)
%Checks if a matrix M is positive semidefinite, up to numerical error.
%Outputs true if it is and false if it is not.
eigenvalues = eig(M);
tolerance = eps(max(eigenvalues));

x = all(eigenvalues > -tolerance);

end

