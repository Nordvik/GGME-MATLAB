% Run step one and two in one go
function [ c_out, W_opt, g_opt, witness_output] = findggme(g, N, only_partial_knowledge, trials, blindfold, maxTrials)

  iter = trials;
  trialsArray = [];   %for checking optimal trials
  
  while (iter > 0)
      iter = iter - 1;
      fprintf('\r\r~~~~~~~~~~~~~~~~~~~~\r'); 
      fprintf('~~ Run Number: %d ~~\r', trials - iter); 
      fprintf('~~~~~~~~~~~~~~~~~~~~\r\r\r'); 
  
      if only_partial_knowledge
        [ ~, W, witness_output ] = findOptimalWitness(g,N, blindfold);
      else
        [ ~, W, witness_output ] = hyllus44(g,N); 
      end
      [ c, W, g, CM_output ] = findOptimalCM(W);
      
      
      %print out identifiers for various events. If there is no problem
      %print the run number. If there is a problem when finding the witness print -1.
      % If there is a problem when finding the CM print -2. If both print
      % -3.
      
      identifier = 0;
      witness_output.info
      CM_output.info
      lastwarn
      if (witness_output.problem ~= 0 || CM_output.problem ~= 0)
        if witness_output.problem ~=0
            identifier = identifier - 1;
        end
        if CM_output.problem ~= 0
            identifier = identifier - 2;
        end
      else
          identifier = trials-iter;
      end
      
      %investigate optimal trials
      trialsArray = cat(2,trialsArray,[identifier; c]);
     
      
  end
  
 %write evolution of witness expectation value with number of trials to
 %file
 trialsArray = cat(2,trialsArray,[repelem(NaN,maxTrials-length(trialsArray));repelem(NaN,maxTrials-length(trialsArray))]);
 writematrix(trialsArray,strcat('OutputMatrices\optimalTrials\',string(N),'modes.xls'),'WriteMode','append');
  
  c_out = c;
  W_opt = W;
  g_opt = g;
  
end