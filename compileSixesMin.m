function compileSixesMin

%% 012222
sixes012222 = matfile('SixModes_012222_all.mat');
[c012222 id012222] = min(sixes012222.c);
c = c012222;
g = sixes012222.g(:,:,id012222);
w = sixes012222.w(:,:,id012222);
s = sixes012222.s(:,:,id012222);
t = sixes012222.t;
sixes012222 = GMEClass;
sixes012222.c = c;
sixes012222.g = g;
sixes012222.w = w;
sixes012222.s = s;
sixes012222.t = t;
save SixModes012222_min.mat c g w s t -v7.3

%% 012233
sixes012233 = matfile('SixModes_012233_all.mat');
[c012233 id012233] = min(sixes012233.c);
c = c012233;
g = sixes012233.g(:,:,id012233);
w = sixes012233.w(:,:,id012233);
s = sixes012233.s(:,:,id012233);
t = sixes012233.t;
sixes012233 = GMEClass;
sixes012233.c = c;
sixes012233.g = g;
sixes012233.w = w;
sixes012233.s = s;
sixes012233.t = t;
save SixModes012233_min.mat c g w s t -v7.3

%% 012333
sixes012333 = matfile('SixModes_012333_all.mat');
[c012333 id012333] = min(sixes012333.c);
c = c012333;
g = sixes012333.g(:,:,id012333);
w = sixes012333.w(:,:,id012333);
s = sixes012333.s(:,:,id012333);
t = sixes012333.t;
sixes012333 = GMEClass;
sixes012333.c = c;
sixes012333.g = g;
sixes012333.w = w;
sixes012333.s = s;
sixes012333.t = t;
save SixModes012333_min.mat c g w s t -v7.3

%% 012335
sixes012335 = matfile('SixModes_012335_all.mat');
[c012335 id012335] = min(sixes012335.c);
c = c012335;
g = sixes012335.g(:,:,id012335);
w = sixes012335.w(:,:,id012335);
s = sixes012335.s(:,:,id012335);
t = sixes012335.t;
sixes012335 = GMEClass;
sixes012335.c = c;
sixes012335.g = g;
sixes012335.w = w;
sixes012335.s = s;
sixes012335.t = t;
save SixModes012335_min.mat c g w s t -v7.3

%% 012344
sixes012344 = matfile('SixModes_012344_all.mat');
[c012344 id012344] = min(sixes012344.c);
c = c012344;
g = sixes012344.g(:,:,id012344);
w = sixes012344.w(:,:,id012344);
s = sixes012344.s(:,:,id012344);
t = sixes012344.t;
sixes012344 = GMEClass;
sixes012344.c = c;
sixes012344.g = g;
sixes012344.w = w;
sixes012344.s = s;
sixes012344.t = t;
save SixModes012344_min.mat c g w s t -v7.3

%% 012345
sixes012345 = matfile('SixModes_012345_all.mat');
[c012345 id012345] = min(sixes012345.c);
c = c012345;
g = sixes012345.g(:,:,id012345);
w = sixes012345.w(:,:,id012345);
s = sixes012345.s(:,:,id012345);
t = sixes012345.t;
sixes012345 = GMEClass;
sixes012345.c = c;
sixes012345.g = g;
sixes012345.w = w;
sixes012345.s = s;
sixes012345.t = t;
save SixModes012345_min.mat c g w s t -v7.3

%% Save all in file
save sixes_min.mat sixes012222 sixes012233 sixes012333 sixes012335 sixes012344 sixes012345 -v7.3;

%% Cleanup
clear c g w s t
clear sixes012222 sixes012233 sixes012333 sixes012335 sixes012344 sixes012345
