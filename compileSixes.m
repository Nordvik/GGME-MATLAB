function compileSixes
%%%%%%%%%%%%
%% 012222 %%
%%%%%%%%%%%%

sixes012222_1 = matfile('SixModes_012222_01.mat');
sixes012222_2 = matfile('SixModes_012222_02.mat');
sixes012222_3 = matfile('SixModes_012222_03.mat');
sixes012222_4 = matfile('SixModes_012222_04.mat');
sixes012222_5 = matfile('SixModes_012222_05.mat');

c1 = sixes012222_1.c;
w1 = sixes012222_1.w;
g1 = sixes012222_1.g;
s1 = sixes012222_1.s;
t1 = sixes012222_1.t;

c2 = sixes012222_2.c;
w2 = sixes012222_2.w;
g2 = sixes012222_2.g;
s2 = sixes012222_2.s;
t2 = sixes012222_2.t;

c3 = sixes012222_3.c;
w3 = sixes012222_3.w;
g3 = sixes012222_3.g;
s3 = sixes012222_3.s;
t3 = sixes012222_3.t;

c4 = sixes012222_4.c;
w4 = sixes012222_4.w;
g4 = sixes012222_4.g;
s4 = sixes012222_4.s;
t4 = sixes012222_4.t;

c5 = sixes012222_5.c;
w5 = sixes012222_5.w;
g5 = sixes012222_5.g;
s5 = sixes012222_5.s;
t5 = sixes012222_5.t;

c = [c1,c2,c3,c4,c5];

w = cat(3,w1,w2);
w = cat(3,w,w3);
w = cat(3,w,w4);
w = cat(3,w,w5);

g = cat(3,g1,g2);
g = cat(3,g,g3);
g = cat(3,g,g4);
g = cat(3,g,g5);

s = cat(3,s1,s2);
s = cat(3,s,s3);
s = cat(3,s,s4);
s = cat(3,s,s5);

t = t1;

save SixModes_012222_all.mat c w g s t -v7.3;
clear sixes012222_1 sixes012222_2 sixes012222_3 sixes012222_4 sixes012222_5;

%%%%%%%%%%%%
%% 012233 %%
%%%%%%%%%%%%

sixes012233_1 = matfile('SixModes_012233_01.mat');
sixes012233_2 = matfile('SixModes_012233_02.mat');
sixes012233_3 = matfile('SixModes_012233_03.mat');
sixes012233_4 = matfile('SixModes_012233_04.mat');
sixes012233_5 = matfile('SixModes_012233_05.mat');

c1 = sixes012233_1.c;
w1 = sixes012233_1.w;
g1 = sixes012233_1.g;
s1 = sixes012233_1.s;
t1 = sixes012233_1.t;

c2 = sixes012233_2.c;
w2 = sixes012233_2.w;
g2 = sixes012233_2.g;
s2 = sixes012233_2.s;

c3 = sixes012233_3.c;
w3 = sixes012233_3.w;
g3 = sixes012233_3.g;
s3 = sixes012233_3.s;

c4 = sixes012233_4.c;
w4 = sixes012233_4.w;
g4 = sixes012233_4.g;
s4 = sixes012233_4.s;

c5 = sixes012233_5.c;
w5 = sixes012233_5.w;
g5 = sixes012233_5.g;
s5 = sixes012233_5.s;

c = [c1,c2,c3,c4,c5];

w = cat(3,w1,w2);
w = cat(3,w,w3);
w = cat(3,w,w4);
w = cat(3,w,w5);

g = cat(3,g1,g2);
g = cat(3,g,g3);
g = cat(3,g,g4);
g = cat(3,g,g5);

s = cat(3,s1,s2);
s = cat(3,s,s3);
s = cat(3,s,s4);
s = cat(3,s,s5);

t = t1;

save SixModes_012233_all.mat c w g s t -v7.3;
clear sixes012233_1 sixes012233_2 sixes012233_3 sixes012233_4 sixes012233_5;

%%%%%%%%%%%%
%% 012333 %%
%%%%%%%%%%%%

sixes012333_1 = matfile('SixModes_012333_01.mat');
sixes012333_2 = matfile('SixModes_012333_02.mat');
sixes012333_3 = matfile('SixModes_012333_03.mat');
sixes012333_4 = matfile('SixModes_012333_04.mat');
sixes012333_5 = matfile('SixModes_012333_05.mat');

c1 = sixes012333_1.c;
w1 = sixes012333_1.w;
g1 = sixes012333_1.g;
s1 = sixes012333_1.s;
t1 = sixes012333_1.t;

c2 = sixes012333_2.c;
w2 = sixes012333_2.w;
g2 = sixes012333_2.g;
s2 = sixes012333_2.s;

c3 = sixes012333_3.c;
w3 = sixes012333_3.w;
g3 = sixes012333_3.g;
s3 = sixes012333_3.s;

c4 = sixes012333_4.c;
w4 = sixes012333_4.w;
g4 = sixes012333_4.g;
s4 = sixes012333_4.s;

c5 = sixes012333_5.c;
w5 = sixes012333_5.w;
g5 = sixes012333_5.g;
s5 = sixes012333_5.s;

c = [c1,c2,c3,c4,c5];

w = cat(3,w1,w2);
w = cat(3,w,w3);
w = cat(3,w,w4);
w = cat(3,w,w5);

g = cat(3,g1,g2);
g = cat(3,g,g3);
g = cat(3,g,g4);
g = cat(3,g,g5);

s = cat(3,s1,s2);
s = cat(3,s,s3);
s = cat(3,s,s4);
s = cat(3,s,s5);

t = t1;

save SixModes_012333_all.mat c w g s t -v7.3;
clear sixes012333_1 sixes012333_2 sixes012333_3 sixes012333_4 sixes012333_5;


%%%%%%%%%%%%
%% 012335 %%
%%%%%%%%%%%%

sixes012335_1 = matfile('SixModes_012335_01.mat');
sixes012335_2 = matfile('SixModes_012335_02.mat');
sixes012335_3 = matfile('SixModes_012335_03.mat');
sixes012335_4 = matfile('SixModes_012335_04.mat');
sixes012335_5 = matfile('SixModes_012335_05.mat');

c1 = sixes012335_1.c;
w1 = sixes012335_1.w;
g1 = sixes012335_1.g;
s1 = sixes012335_1.s;
t1 = sixes012335_1.t;

c2 = sixes012335_2.c;
w2 = sixes012335_2.w;
g2 = sixes012335_2.g;
s2 = sixes012335_2.s;

c3 = sixes012335_3.c;
w3 = sixes012335_3.w;
g3 = sixes012335_3.g;
s3 = sixes012335_3.s;

c4 = sixes012335_4.c;
w4 = sixes012335_4.w;
g4 = sixes012335_4.g;
s4 = sixes012335_4.s;

c5 = sixes012335_5.c;
w5 = sixes012335_5.w;
g5 = sixes012335_5.g;
s5 = sixes012335_5.s;

c = [c1,c2,c3,c4,c5];

w = cat(3,w1,w2);
w = cat(3,w,w3);
w = cat(3,w,w4);
w = cat(3,w,w5);

g = cat(3,g1,g2);
g = cat(3,g,g3);
g = cat(3,g,g4);
g = cat(3,g,g5);

s = cat(3,s1,s2);
s = cat(3,s,s3);
s = cat(3,s,s4);
s = cat(3,s,s5);

t = t1;

save SixModes_012335_all.mat c w g s t -v7.3;
clear sixes012335_1 sixes012335_2 sixes012335_3 sixes012335_4 sixes012335_5;

%%%%%%%%%%%%
%% 012344 %%
%%%%%%%%%%%%

sixes012344_1 = matfile('SixModes_012344_01.mat');
sixes012344_2 = matfile('SixModes_012344_02.mat');
sixes012344_3 = matfile('SixModes_012344_03.mat');
sixes012344_4 = matfile('SixModes_012344_04.mat');
sixes012344_5 = matfile('SixModes_012344_05.mat');

c1 = sixes012344_1.c;
w1 = sixes012344_1.w;
g1 = sixes012344_1.g;
s1 = sixes012344_1.s;
t1 = sixes012344_1.t;

c2 = sixes012344_2.c;
w2 = sixes012344_2.w;
g2 = sixes012344_2.g;
s2 = sixes012344_2.s;

c3 = sixes012344_3.c;
w3 = sixes012344_3.w;
g3 = sixes012344_3.g;
s3 = sixes012344_3.s;

c4 = sixes012344_4.c;
w4 = sixes012344_4.w;
g4 = sixes012344_4.g;
s4 = sixes012344_4.s;

c5 = sixes012344_5.c;
w5 = sixes012344_5.w;
g5 = sixes012344_5.g;
s5 = sixes012344_5.s;

c = [c1,c2,c3,c4,c5];

w = cat(3,w1,w2);
w = cat(3,w,w3);
w = cat(3,w,w4);
w = cat(3,w,w5);

g = cat(3,g1,g2);
g = cat(3,g,g3);
g = cat(3,g,g4);
g = cat(3,g,g5);

s = cat(3,s1,s2);
s = cat(3,s,s3);
s = cat(3,s,s4);
s = cat(3,s,s5);

t = t1;

save SixModes_012344_all.mat c w g s t -v7.3;
clear sixes012344_1 sixes012344_2 sixes012344_3 sixes012344_4 sixes012344_5;

%%%%%%%%%%%%
%% 012345 %%
%%%%%%%%%%%%

sixes012345_1 = matfile('SixModes_012345_01.mat');
sixes012345_2 = matfile('SixModes_012345_02.mat');
sixes012345_3 = matfile('SixModes_012345_03.mat');
sixes012345_4 = matfile('SixModes_012345_04.mat');
sixes012345_5 = matfile('SixModes_012345_05.mat');

c1 = sixes012345_1.c;
w1 = sixes012345_1.w;
g1 = sixes012345_1.g;
s1 = sixes012345_1.s;
t1 = sixes012345_1.t;

c2 = sixes012345_2.c;
w2 = sixes012345_2.w;
g2 = sixes012345_2.g;
s2 = sixes012345_2.s;

c3 = sixes012345_3.c;
w3 = sixes012345_3.w;
g3 = sixes012345_3.g;
s3 = sixes012345_3.s;

c4 = sixes012345_4.c;
w4 = sixes012345_4.w;
g4 = sixes012345_4.g;
s4 = sixes012345_4.s;

c5 = sixes012345_5.c;
w5 = sixes012345_5.w;
g5 = sixes012345_5.g;
s5 = sixes012345_5.s;

c = [c1,c2,c3,c4,c5];

w = cat(3,w1,w2);
w = cat(3,w,w3);
w = cat(3,w,w4);
w = cat(3,w,w5);

g = cat(3,g1,g2);
g = cat(3,g,g3);
g = cat(3,g,g4);
g = cat(3,g,g5);

s = cat(3,s1,s2);
s = cat(3,s,s3);
s = cat(3,s,s4);
s = cat(3,s,s5);

t = t1;

save SixModes_012345_all.mat c w g s t -v7.3;
clear sixes012345_1 sixes012345_2 sixes012345_3 sixes012345_4 sixes012345_5;

%%
% Clean up

clear c g w s t
clear c1 g1 w1 s1 t1
clear c2 g2 w2 s2 t2
clear c3 g3 w3 s3 t3
clear c4 g4 w4 s4 t4
clear c5 g5 w5 s5 t5

end