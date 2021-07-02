% Run step one and two in one go
function [ c_out, W_opt, g_opt, yalmip_output] = findggme(g_in, N, only_partial_knowledge, trials, blindfold)

  
  it = trials;
 
  fprintf('\r\r~~~~~~~~~~~~~~~~~~~~\r'); 
  fprintf('~~ Run Number: %d ~~\r', trials - it+1); 
  fprintf('~~~~~~~~~~~~~~~~~~~~\r\r\r'); 
  
      if only_partial_knowledge
        [ ~, W1, ~ ] = findOptimalWitness(g_in,N, blindfold);
      else
        [ ~, W1, ~ ] = hyllus44(g_in,N); 
      end
      [ ~, ~, g2 ] = findOptimalCM(W1);
      [ c2, W2, yalmip_output ] = findOptimalWitness(g2,N, blindfold);


  while (it > 0)
      it = it - 1;
      fprintf('\r\r~~~~~~~~~~~~~~~~~~~~\r'); 
      fprintf('~~ Run Number: %d ~~\r', trials - it); 
      fprintf('~~~~~~~~~~~~~~~~~~~~\r\r\r');


          [ ~, ~, g2 ] = findOptimalCM(W2);
          % Get optimal witness for the cm
          [ c2, W2, yalmip_output ] = findOptimalWitness(g2,N,blindfold);
   end
  
  c_out = c2;
  W_opt = W2;
  g_opt = g2;
  
end