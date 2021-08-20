function fiveModes_20210819()

[c w g s t] = produceggme(50,5,10,[0 1 2 3 4]);
save FiveModes_01234_02.mat c w g s t -v7.3;

[c w g s t] = produceggme(50,5,10,[0 1 2 3 3]);
save FiveModes_01233_02.mat c w g s t -v7.3;

[c w g s t] = produceggme(50,5,10,[0 1 2 2 2]);
save FiveModes_01222_02.mat c w g s t -v7.3;

end