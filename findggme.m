% Run step one and two in one go
function [ c_out, W_opt, g_opt, yalmip_output] = findggme(g, N, only_partial_knowledge, trials, blindfold)

  it = trials;
  trialsArray = [];   %for checking optimal trials
  
  while (it > 0)
      it = it - 1;
      fprintf('\r\r~~~~~~~~~~~~~~~~~~~~\r'); 
      fprintf('~~ Run Number: %d ~~\r', trials - it); 
      fprintf('~~~~~~~~~~~~~~~~~~~~\r\r\r'); 
  
      if only_partial_knowledge
        [ ~, W, yalmip_output ] = findOptimalWitness(g,N, blindfold);
      else
        [ ~, W, ~ ] = hyllus44(g,N); 
      end
      [ c, W, g ] = findOptimalCM(W);
      
      %investigate optimal trials
      trialsArray = cat(2,trialsArray,[trials-it; c]);
     
      
  end
 trialsArray = cat(2,trialsArray,[repelem(NaN,30-length(trialsArray));repelem(NaN,30-length(trialsArray))]);
 writematrix(trialsArray,strcat('OutputMatrices\optimalTrials\',string(N),'modes.xls'),'WriteMode','append');
  
  c_out = c;
  W_opt = W;
  g_opt = g;
  
end