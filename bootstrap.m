function bootstrap
  
  % GENERIC SOLVER INTERFACE
  addpath(genpath('C:\Users\adamj\OneDrive\Desktop\lib\YALMIP-master'))
  addpath(genpath('../lib/yalmip'))
  
  % SOLVER: SEDUMI
  addpath(genpath('../lib/sedumi'))
  
  % SOLVER: MOSEK
  addpath(genpath('C:\Users\adamj\OneDrive\Desktop\lib\Mosek'))
  addpath(genpath('../lib/Mosek/8/toolbox/r2014a'))
  
% Some notes:
%
%   - make sure that the license has the following path and name:
%   %userprofile%\mosek\mosek.lic
  
%   % SOLVER: MOSEK
%   javaaddpath('/opt/mosek-8/tools/platform/linux64x86/bin/mosekmatlab.jar')
%   addpath(genpath('/opt/mosek-8/toolbox/r2014a'))

%   % PPT MIXER JUST FOR THE KICKS?
%   addpath(genpath('./lib/pptmixer'))
  
end
