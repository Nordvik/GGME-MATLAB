% Run step one and two in one go
function [ c_out, W_opt, g_opt, yalmip_output] = findggme(g, N, only_partial_knowledge, trials, blindfold)

  it = trials;
  
  while (it > 0)
      it = it - 1;
      fprintf('\r\r~~~~~~~~~~~~~~~~~~~~\r'); 
      fprintf('~~ Run Number: %d ~~\r', trials - it); 
      fprintf('~~~~~~~~~~~~~~~~~~~~\r\r\r'); 
  
      if only_partial_knowledge
        [ ~, W, ~ ] = findOptimalWitness(g,N, blindfold);
      else
        [ ~, W, ~ ] = hyllus44(g,N); 
      end
      [ ~, ~, g ] = findOptimalCM(W);
      [ c, W, yalmip_output ] = findOptimalWitness(g,N, blindfold);
      
  end


  
  c_out = c;
  W_opt = W;
  g_opt = g;
  
end