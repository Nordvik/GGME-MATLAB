function compileFives

%%%%%%%%%%%
%% 01222 %%
%%%%%%%%%%%

fives01222_1 = matfile('FiveModes_01222_01.mat');
fives01222_2 = matfile('FiveModes_01222_02.mat');

c1 = fives01222_1.c;
w1 = fives01222_1.w;
g1 = fives01222_1.g;
s1 = fives01222_1.s;
t1 = fives01222_1.t;

c2 = fives01222_2.c;
w2 = fives01222_2.w;
g2 = fives01222_2.g;
s2 = fives01222_2.s;
t2 = fives01222_2.t;

c = [c1,c2];
w = cat(3,w1,w2);
g = cat(3,g1,g2);
s = cat(3,s1,s2);
t = t1;

save FiveModes_01222_all.mat c w g s t -v7.3;
clear fives01222_1 fives01222_2;

%%%%%%%%%%%
%% 01233 %%
%%%%%%%%%%%

fives01233_1 = matfile('FiveModes_01233_01.mat');
fives01233_2 = matfile('FiveModes_01233_02.mat');


c1 = fives01233_1.c;
w1 = fives01233_1.w;
g1 = fives01233_1.g;
s1 = fives01233_1.s;
t1 = fives01233_1.t;

c2 = fives01233_2.c;
w2 = fives01233_2.w;
g2 = fives01233_2.g;
s2 = fives01233_2.s;
t2 = fives01233_2.t;

c = [c1,c2];
w = cat(3,w1,w2);
g = cat(3,g1,g2);
s = cat(3,s1,s2);
t = t1;

save FiveModes_01233_all.mat c w g s t -v7.3;
clear fives01233_1 fives01233_2;
%%%%%%%%%%%
%% 01234 %%
%%%%%%%%%%%

fives01234_1 = matfile('FiveModes_01234_02.mat');
fives01234_2 = matfile('FiveModes_01234_02.mat');

c1 = fives01234_1.c;
w1 = fives01234_1.w;
g1 = fives01234_1.g;
s1 = fives01234_1.s;
t1 = fives01234_1.t;

c2 = fives01234_2.c;
w2 = fives01234_2.w;
g2 = fives01234_2.g;
s2 = fives01234_2.s;
t2 = fives01234_2.t;

c = [c1,c2];
w = cat(3,w1,w2);
g = cat(3,g1,g2);
s = cat(3,s1,s2);
t = t1;

save FiveModes_01234_all.mat c w g s t -v7.3;
clear fives01234_1 fives01234_2;

end