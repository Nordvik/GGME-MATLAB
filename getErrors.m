function getErrors(runs,N, trials)
%GETERRORS Generates witnesses and covariance matrices and categorises them based on whether
%there is a warning associated with their production or not
S = symplecticform(N);
blindfold = getBlindness(N);

while runs > 0
    runs = runs - 1;
    
    %generate symplectic CM
    check = true;  
    while check
        CM = rndgaussiancmnoxpcorrelations(N);
        errorlevel = floor(-log10(eps(max(max(CM)))));
        if (round(CM*S*CM'-S,errorlevel) == zeros(2*N))
            check = false;
        end
    end
    
    it=trials;
    eiglist = [];
    
    witString = repelem(" ", trials*2*N);
    CMString = repelem(" ", trials*2*N);
    W=[];
    c=[];
    while it>0
        
        [ ~, W(:,:,trials-it+1), witness_output ] = findOptimalWitness(CM(:,:,trials-it+1),N, blindfold);
        [ c(:,:,trials-it+1), ~, CM(:,:,trials-it+2), CM_output ] = findOptimalCM(W(:,:,trials-it+1));
        
        eiglist = [eiglist, min(eig(W(:,:,trials-it+1)))];
        
        %prepare for printing

        witString(2*N*(trials-it)+1) = witness_output.info;
        witString(2*N*(trials-it)+2) = c(:,:,trials-it+1);
        witString(2*N*(trials-it)+3) = string(isPSD(W(:,:,trials-it+1)));
        CMString(2*N*(trials-it)+1) = CM_output.info;
        CMString(2*N*(trials-it)+2) = c(:,:,trials-it+1);
        
        it=it-1;
    end
    
    time=datestr(datetime, 'dd-mmmm-yyyy HH.MM.ss');
    %print CM

        writematrix(CMString,strcat('OutputMatrices\whyErrors\',string(N),'modes\',time,'.xls'),'WriteMode','append');
        writematrix(CM,strcat('OutputMatrices\whyErrors\',string(N),'modes\',time,'.xls'),'WriteMode','append');
    
    %print witness
        writematrix(witString,strcat('OutputMatrices\whyErrors\',string(N),'modes\',time,'.xls'),'WriteMode','append');
        writematrix(W,strcat('OutputMatrices\whyErrors\',string(N),'modes\',time,'.xls'),'WriteMode','append');
end
    eiglist
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