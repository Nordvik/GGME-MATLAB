function sixModes_20210818()

[c w g s t] = produceggme(50,6,10,[0 1 2 3 4 5]);
save SixModes_012345_05.mat c w g s t -v7.3;

[c w g s t] = produceggme(50,6,10,[0 1 2 3 4 4]);
save SixModes_012344_05.mat c w g s t -v7.3;

[c w g s t] = produceggme(50,6,10,[0 1 2 3 3 5]);
save SixModes_012335_05.mat c w g s t -v7.3;

[c w g s t] = produceggme(50,6,10,[0 1 2 3 3 3]);
save SixModes_012333_05.mat c w g s t -v7.3;

[c w g s t] = produceggme(50,6,10,[0 1 2 2 3 3]);
save SixModes_012233_05.mat c w g s t -v7.3;

[c w g s t] = produceggme(50,6,10,[0 1 2 2 2 2]);
save SixModes_012222_05.mat c w g s t -v7.3;