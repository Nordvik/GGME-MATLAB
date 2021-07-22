% Run step one and two in one go
function [ c_out, W_opt, g_opt, witness_output] = findggme(g, N, only_partial_knowledge, trials, blindfold, tree, maxTrials)

  iter = trials;
  erroroutput = "";
  trialsArray = [];   %for checking optimal trials
  
  %initialise arrays for saving witnesses, CMs and witness means
  W = [];
  CM = g;
  c= [];
  
  count = 0;
  
  while (iter > 0)
      count = count + 1;
      iter = iter - 1;
      fprintf('\r\r~~~~~~~~~~~~~~~~~~~~\r'); 
      fprintf('~~ Run Number: %d ~~\r', trials - iter); 
      fprintf('~~~~~~~~~~~~~~~~~~~~\r\r\r'); 
  
      if only_partial_knowledge
          %get witness, save witness and mean to array
        [ c(2*count - 1), W(:,:,count), witness_output ] = findOptimalWitness(CM(:,:,count),N, blindfold);
      else
        [ ~, W(:,:,count), witness_output ] = hyllus44(CM(:,:,count),N); 
      end
       
      %Save c value to array for printing to optimalTrials
      trialsArray = cat(2,trialsArray,[0; c(count*2-1)]);
      
      %Exclude from results if c <= -1: there must have been an error
        if round(c(2*count - 1),2) <= -1
            c(2*count - 1) = 0;
        end
        
      %Catch potentially fatal error
      if lastwarn == "Solver complains about bad data (MOSEK)"
          warning(strcat("Potentially fatal error on trial ", string(trials - iter),", exiting now"))
          erroroutpput = strcat("Fatal error on trial ", string(trials - iter));
          break
      end 
        
       %Get and save CM and witness mean to array 
      [ c(2*count), ~, CM(:,:,count+1), CM_output ] = findOptimalCM(W(:,:,count));
     
      
      %print out identifiers for various events to optimalTrials. If there is no problem
      %print the run number. If there is a problem when finding the witness print -1.
      % If there is a problem when finding the CM print -2. If both print
      % -3.
         
      identifier = 0;
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
      
      %save data to array
      trialsArray = cat(2,trialsArray,[identifier; c(count*2)]);
      
      %Exclude from results if c <= -1: there must have been an error
       if round(c(2*count),2) <= -1
            c(2*count) = 1;
       end
       
        %Catch potentially fatal error
      if lastwarn == "Solver complains about bad data (MOSEK)"
          warning(strcat("Potentially fatal error on trial ", string(trials - iter),", exiting now"))
          erroroutpput = strcat("Fatal error on trial ", string(trials - iter));
          break
      end 
     
    %  %Exit loop and get new random CM if error
    %  if not(lastwarn == "")
    %      break
    %  end
      
  end
  
 %write evolution of witness expectation value with number of trials to
 %file
 trialsArray = cat(2,trialsArray,[repelem(NaN,2*maxTrials-length(trialsArray));repelem(NaN,2*maxTrials-length(trialsArray))]);
 writematrix(trialsArray,strcat('OutputMatrices\optimalTrials\',string(N),'modes','\',tree,'.xls'),'WriteMode','append');
 
 %Write error message to file if quitting early
 if not(erroroutput == "")
     errorString = repelem("",2*maxTrials);
     errorString(1)= erroroutput;
     writematrix(errorString,strcat('OutputMatrices\optimalTrials\',string(N),'modes','\',tree,'.xls'),'WriteMode','append');
 end
 
 %Determine optimal CM-Witness pair from those produced
 
 if not(isempty(hasSeparableMarginals(g)))
     c(1) = 0; %cannot use first CM if it does not have all two-mode marginals seperable
 end
 
 [c_out, index]= min(c);
 W_opt = W(:,:,ceil(index/2));
 g_opt = CM(:,:,floor(index/2+1));
 
 %only select matrices if they are valid
 while not(isWitness(W_opt) && isCM(g_opt))
     c(index) = 1;
     [c_out, index]= min(c);
     W_opt = W(:,:,ceil(index/2));
     g_opt = CM(:,:,floor(index/2+1));
     
     if c(index) == 1
         break
     end
 end
 
  
end