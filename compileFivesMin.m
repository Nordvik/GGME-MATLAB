function compileFivesMin

%% 01222
f = matfile('FiveModes01222_min.mat');
fives01222 = GMEClass;
fives01222.c = f.c;
fives01222.g = f.g;
fives01222.w = f.w;
fives01222.s = f.s;
fives01222.t = f.t;

%% 01233
f = matfile('FiveModes01233_min.mat');
fives01233 = GMEClass;
fives01233.c = f.c;
fives01233.g = f.g;
fives01233.w = f.w;
fives01233.s = f.s;
fives01233.t = f.t;

%% 01234
f = matfile('FiveModes01234_min.mat');
fives01234 = GMEClass;
fives01234.c = f.c;
fives01234.g = f.g;
fives01234.w = f.w;
fives01234.s = f.s;
fives01234.t = f.t;

%% Save
save fives_min.mat fives01222 fives01233 fives01234 -v7.3;
clear f fives01222 fives01233 fives01234

