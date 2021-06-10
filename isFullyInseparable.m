function testresult = isFullyInseparable(input_matrix)
% Aim: test whether an input covariance matrix is fully inseparable. 
%    Full inseparability means that the state to which the input 
%    covariance matrix is not separable across any mode partition. 
%     We will say "a covariance matrix is separable" whenever it corresponds
%     to a state that is separable (ditto entangled).

% Current: 3 modes only

% Initial definitions and tests

if rem(length(input_matrix),2) == 0
    modes = length(input_matrix)/2;
else
    disp("Incorrect number of modes. Now aborting.");
    return 
    % Error! not an allowed covariance matrix
end

% How to test for full inseparability? 
%
% -Sufficiency theorem: (From Serafini's "Quantum continuous variables")
%   
%   Thm 1. An n-mode covariance matrix with gamma >= I is separable across
%   all bipartitions.
%
% -PPT criterion. Sufficient and necessary for the 1 vs n mode case

if isPositiveDefinite(input_matrix - eye(2*modes)) %Sufficiency test
   
    disp("Covariance matrix is separable across all bipartitions.");
    testresult = false;
    return 
    
else 
    %more tests required
    
    % For three modes, separability acorss all bipartitions is sufficient
    % so we can use the 1 vs. n mode the PPT test which is a sufficient and
    % necessary criterion
    
    ppt_result = isPPT_1vN_tripartite(input_matrix);
    
    if ppt_result == 1
        disp("Covariance matrix is separable across all bipartitions.");
    elseif ppt_result == 0 
        disp("Covariance matrix is fully inseparable.");
    else
        disp("PPT test could not be applied.");
    end

  
end


end % main function definition end


% % Function definitions


function x=isPositiveDefinite(A)
%Function to check whether a given matrix A is positive definite
%Author Mathuranathan for https://www.gaussianwaves.com
%Returns x=1, if the input matrix is positive definite
%Returns x=0, if the input matrix is not positive definite
%Throws error if the input matrix is not symmetric

% Comment by Viktor:
% This code uses what is known as "Sylvester's Criterion":
%   Hermitian A > 0 <=> all leading principal minors have
%                       positive determinant


    %Check if the matrix is symmetric
    [m,n]=size(A); 
    if m~=n,
        error('A is not Symmetric');
    end
    
    %Test for positive definiteness
    x=1; %Flag to check for positiveness
    for i=1:m
        subA=A(1:i,1:i); %Extract upper left kxk submatrix
        if(det(subA)<=0); %Check if the determinent of the kxk submatrix is +ve
            x=0;
            break;
        end
    end
    
    if x
    %    display('Given Matrix is Positive definite');
    else
    %    display('Given Matrix is NOT positive definite');
    end      
end


function testresult = isPPT_1vN_tripartite(M)

    n = length(M)/2;
    
    % Test: 3 modes only!
    if n ~= 3
        disp("PPT test works only for covariance matrices of three modes; generalisation to come.");
        testresult = 2;
        return
    end

    % Necessary definitions
    omg2 = [0 1; -1 0];
    omg = [];
    for i = 1:n
        omg = blkdiag(omg, omg2);
    end
    
    %Defining transposition matrices (p_a -> -p_a) for all three partitions
    sigma_z  = [ 1 0 ; 0 -1]; 
    L1 = blkdiag(sigma_z,eye(4)); 
    L2 = blkdiag(eye(2),sigma_z,eye(2));
    L3 = blkdiag(eye(4),sigma_z);

    ppt1 = isPositiveDefinite(L1*M*transpose(L1) + 1i*omg);
    ppt2 = isPositiveDefinite(L2*M*transpose(L2) + 1i*omg);
    ppt3 = isPositiveDefinite(L3*M*transpose(L3) + 1i*omg);
    
    if ppt1
        disp("Separable across A|BC partition");
    elseif ppt2
        disp("Separable across A|B|C partition");
    elseif ppt3
        disp("Separable across AB|C partition");
    end
    
    testresult = ppt1 && ppt2 && ppt3;
end   