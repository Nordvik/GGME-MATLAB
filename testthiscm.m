function allowedPair = testthiscm(cm, round_cm, wit, round_wit)

[N m] = size(cm);

if not(N == m)
    error('Matrix must be square.')
    return;
end

if not(mod(N,2)==0) %not even
    error('Input matrix dimensions should be even.')
    return;
end
N = length(cm)/2;

% Definitions and calculations

boolRoundSignificant = false;

boolDisplayMessages = true;
boolDisplayVariables = true;

if boolRoundSignificant
thiscm = round(cm,round_cm,'significant');
thiswit = round(wit,round_wit,'significant');
else
thiscm = round(cm,round_cm);
thiswit = round(wit,round_wit);
end    

omg = symplecticform(N);

isQuantumCM = isPositiveDefinite(thiscm + 1i*omg);

NonSepMargArray = hasSeparableMarginals(thiscm);

witness_avg = trace(thiscm*thiswit);

% Now test witness: Real and positive semidefinite
witness_ok = isreal(thiswit)&& all(eig(round(thiswit,10))>=0) && (witness_avg - 1 < 0);


Rounding_msg = ['Rounding:  CM = ', num2str(round_cm), '  Wit = ', num2str(round_wit)];
Trace_msg = ['With an expectation value of the witness (minus 1): ', num2str(witness_avg-1) ];


if boolDisplayMessages
    disp('--------------------------------------------------------------')
    disp(' ')
end

if boolDisplayVariables
    disp(' ')
    disp(' Displaying variables: ')
    disp(' ')
    disp('--------------------------------------------------------------')
    disp(Rounding_msg)

    disp('For the Covariance Matrix')
    thiscm

    disp('and witness')
    thiswit
end

disp(Trace_msg)

%%                             CM messages
if isQuantumCM
    if boolDisplayMessages
        disp('  - The CM can be related to a quantum state')
    end
else
    if boolDisplayMessages
        disp('  - The CM CANNOT be related to a quantum state')
    end
end

% Has separable marginals
if isempty(NonSepMargArray)
    if boolDisplayMessages
        disp('  - The CM has all marginals separable')
    end
else
    if boolDisplayMessages
        disp('  - The CM has some marginal NON-separable')
    end
end

%%                             Witness messages
if boolDisplayMessages
    if not(witness_ok) 
        disp('  - The witness is NOT an allowed CM entanglement witness.')
    else
        disp('  - The witness is an allowed CM entanglement witness.')
    end
end

%%                  Putting all conditions together
allowedPair = isQuantumCM && isempty(NonSepMargArray)&& witness_ok;

disp(' ')
disp(' ')
if allowedPair
    disp('All good.')
else
    disp('Something went wrong.')
end
disp(' ')

if boolDisplayMessages
    disp('--------------------------------------------------------------')
    disp(' ')
end

end

%%
%%%--------------------------------------------------------------------%%%
%%%                       Helper Functions                             %%%
%%%--------------------------------------------------------------------%%%

function [ OMG ] = symplecticform (N) 
  OMG = [ 0, 1 ; - 1, 0 ];
  while (N > 1)
    OMG = blkdiag(OMG, [ 0, 1, ; - 1, 0 ]);
    N = N - 1;
  end
end

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
