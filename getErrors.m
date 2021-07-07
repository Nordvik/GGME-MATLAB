function getErrors(runs,N)
%GETERRORS Generates random matrices and categorises them based on whether
%they cause findOptimalCM or findOptimalWitness to crash or not
S = symplecticform(N);
blindfold = getBlindness(N);

while runs > 0
    runs = runs - 1;
    
    %generate symplectic CM
    check = true;  
    while check
        CM = rndgaussiancmnoxpcorrelations(N);
        if (round(CM*S*CM'-S,10) == zeros(2*N))
            check = false;
        end
    end
    
    [ ~, W1, witness_output ] = findOptimalWitness(CM,N, blindfold);
    [ c, W2, g, CM_output ] = findOptimalCM(W1);

    %prepare for printing
    witString = repelem(" ", 2*N);
    CMString = repelem(" ", 2*N);
    witString(1) = witness_output.info;
    witString(2) = c;
    CMString(1) = CM_output.info;
    CMString(2) = c;
    
    %print CM
    if witness_output.problem ~= 0
        writematrix(witString,strcat('OutputMatrices\whyErrors\',string(N),'modes\BadCMs.xls'),'WriteMode','append');
        writematrix(CM,strcat('OutputMatrices\whyErrors\',string(N),'modes\BadCMs.xls'),'WriteMode','append');
    else
        writematrix(witString,strcat('OutputMatrices\whyErrors\',string(N),'modes\GoodCMs.xls'),'WriteMode','append');
        writematrix(CM,strcat('OutputMatrices\whyErrors\',string(N),'modes\GoodCMs.xls'),'WriteMode','append');
    end
    
    %print witness
    if CM_output.problem ~= 0
        writematrix(CMString,strcat('OutputMatrices\whyErrors\',string(N),'modes\BadWitnesses.xls'),'WriteMode','append');
        writematrix(CM,strcat('OutputMatrices\whyErrors\',string(N),'modes\BadWitnesses.xls'),'WriteMode','append');
    else
        writematrix(CMString,strcat('OutputMatrices\whyErrors\',string(N),'modes\GoodWitnesses.xls'),'WriteMode','append');
        writematrix(CM,strcat('OutputMatrices\whyErrors\',string(N),'modes\GoodWitnesses.xls'),'WriteMode','append');
    end
    
end
end

function cm = rndgaussiancmnoxpcorrelations(N)

        T = orderingconversion(N);
        S = symplecticform(N);
        randommatrix = randn(N);
        
        % This gives a covariance matrix in the 
        %(x1,x2,...,p1,p2,...) ordering
        thismat = blkdiag(randommatrix*eye(N)*randommatrix',(randommatrix')^(-1)*eye(N)*randommatrix^(-1));
       
        % Convert to the wanted ordering
        cm = T'*thismat*T;
end
% Symplectic form in the (x1,p1,x2,p2,...) ordering
function T = orderingconversion(N)
    T = zeros(2*N);
    for j = 1:N
        T(j,2*j-1)= 1;
        T(N+j,2*j)=1;
    end
end

% Symplectic form in the (x1,p1,x2,p2,...) ordering
function J = symplecticform(N)
    J = [ 0 1 ; -1 0 ];
    for i = 1:N-1
        J = blkdiag(J, [ 0 1 ; -1 0 ]);
    end
end