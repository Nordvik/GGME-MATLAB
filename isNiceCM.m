function [passedAllTests arrMean_nice arrWit_nice arrCM_nice] = isNiceCM(cm_in, wit_in, roundCM_max, roundWit_max, maxEntryAllowed)
% %%%%%%%%%%%%%%%%%%%%% %
% Test settings         %
% roundCM_max = 1;        %
% roundWit_max = 20;      %
% maxEntryAllowed = 25;   %
% %%%%%%%%%%%%%%%%%%%%% %

% %%% OUTPUTS %%% %

arrMean_nice=[]; 
arrWit_nice=[]; 
arrCM_nice=[];
passedAllTests = false;


[N m] = size(cm_in);

if not(N == m)
    error('Matrix must be square.')
    return;
end

if not(mod(N,2)==0) %not even
    error('Input matrix dimensions should be even.')
    return;
end
N = length(cm_in)/2;

% Definitions and calculations

boolRoundSignificant = false;

boolDisplayMessages = true;
boolDisplayVariables = false;

omg = symplecticform(N);
round_best = roundCM_max + 50;
maxEntry_best = maxEntryAllowed+1;
originalWitness_mean = trace(cm_in*wit_in)-1;
foundNicestCM = 0;

witness_mean_roundedCM = 42;

round_wit = roundWit_max;
for round_cm = 1:roundCM_max % Will break when first best is found

    if boolRoundSignificant
        thiscm = round(cm_in,round_cm,'significant');
        thiswit = round(wit_in,round_wit,'significant');
    else
        thiscm = round(cm_in,round_cm);
        thiswit = round(wit_in,round_wit);
    end    

    witness_avg = trace(thiscm*thiswit);
    maxEntry = max(abs(thiscm(:)));
    
    % The tests to pass
    isQuantumCM = isPositiveDefinite(thiscm + 1i*omg);
    hasNonSepMargArray = hasSeparableMarginals(thiscm);
    hasAllowedMaxEntry = (maxEntry <= maxEntryAllowed);
    hasAllowedWitnessMean = (witness_avg - 1 < 0);
    
    passedAllCMTests = isQuantumCM && isempty(hasNonSepMargArray)&& hasAllowedMaxEntry
    if passedAllCMTests
        % Found best!
        foundNicestCM = 1;
        round_best = round_cm;
        maxEntry_best = maxEntry;

        % Witness means - original and newly calculated
        originalWitness_mean = trace(thiscm*wit_in)-1;
        if N == 3
            [witness_mean_roundedCM tempwit yalmipstatus] = findOptimalWitness_3modes(thiscm,N);
        elseif N == 4
            [witness_mean_roundedCM tempwit yalmipstatus] = findOptimalWitness_4modes(thiscm,N);
            disp('cake')
        else
            error('Can only deal with 3 or 4(T-graph) modes at the moment.');
            break
        end
        
        arrCM_nice   = thiscm
        arrWit_nice  = tempwit
        arrMean_nice = witness_mean_roundedCM;
        
        
%         arrCM_nice   = cat(3,arrCM_nice, thiscm);
%         arrWit_nice  = cat(3,arrWit_nice, tempwit);
%         arrMean_nice = [arrMean_nice, witness_mean_roundedCM];

        passedAllTests = passedAllCMTests && (witness_mean_roundedCM < 0);
        
        if passedAllTests 
            break
        end
    end
end


witness_ok = isreal(thiswit)&& isPositiveDefinite(round(thiswit,5)) && hasAllowedWitnessMean;


Rounding_msg = ['Rounding:  CM = ', num2str(round_cm), '  Wit = ', num2str(round_wit)];
TraceOG_msg = ['With an expectation value of the original witness (minus 1): ', num2str(originalWitness_mean) ];
TraceRounded_msg = [' and the witness for the rounded CM(minus 1): ', num2str(witness_mean_roundedCM) ];
Trace_msg = [[TraceOG_msg], [TraceRounded_msg]];
BestValues_msg = ['Best CM rounding is ' num2str(round_best), ', with maximum entry: ', num2str(maxEntry_best), '; Tr(W*g)-1 = ', num2str(witness_mean_roundedCM)];


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
if isempty(hasNonSepMargArray)
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

if boolDisplayMessages
    disp(BestValues_msg);
end

%%                  Putting all conditions together
allowedPair = isQuantumCM && isempty(hasNonSepMargArray)&& witness_ok;
% % inside for loop
% testResult = isQuantumCM && isempty(hasNonSepMargArray)&& hasAllowedMaxEntry; 

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