% Run step one and two in one go
function [ c_out, W_opt, g_opt, yalmip_output] = findggme(g_in, N, only_partial_knowledge, trials, blindfold)

  if nargin < 4
      % One run of the program only ??
      trials = 1;
      if nargin < 3
          % Use the extra constraints on the Witness ??
          % unless specified otherwise               ??
          only_partial_knowledge = true;
      end
  end
  
  only_partial_knowledge = logical(only_partial_knowledge);   %??
  
  it = trials;
  it = it - 1;
 
  fprintf('\r\r~~~~~~~~~~~~~~~~~~~~\r'); 
  fprintf('~~ Run Number: %d ~~\r', trials - it); 
  fprintf('~~~~~~~~~~~~~~~~~~~~\r\r\r'); 
  
      if only_partial_knowledge
        [ c1, W1, g1 ] = findOptimalWitness(g_in,N, blindfold);
      else
        [ c1, W1, g1 ] = hyllus44(g_in,N); 
      end
      [ c2, W2, g2 ] = findOptimalCM(W1);
      [ c2, W2, yalmip_output ] = findOptimalWitness(g2,N, blindfold);


  while (it > 0)
      it = it - 1;
      fprintf('\r\r~~~~~~~~~~~~~~~~~~~~\r'); 
      fprintf('~~ Run Number: %d ~~\r', trials - it); 
      fprintf('~~~~~~~~~~~~~~~~~~~~\r\r\r');

          [ c2, W2, g2 ] = findOptimalCM(W2);
          % Get optimal witness for the cm
          [ c2, W2, yalmip_output ] = findOptimalWitness(g2,N,blindfold);
   end
  
  
  
  c_out = c2;
  W_opt = W2;
  g_opt = g2;
  
end