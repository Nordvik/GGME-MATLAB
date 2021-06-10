function [arrMean_nice_out arrWit_nice_out arrCM_nice_out arrMeanOG_nice_out arrWitOG_nice_out arrCMOG_nice_out] = siftNiceStates(arrCM_in, arrWit_in, roundCM_max, roundWit_max, maxEntryAllowed)

% roundCM_max = 1;        
% roundWit_max = 20;      
% maxEntryAllowed = 25;   

[m n numberTotal] = size(arrCM_in);

arrMean_nice_out=[];
arrWit_nice_out=[];
arrCM_nice_out = [];
arrMeanOG_nice_out=[];
arrWitOG_nice_out=[];
arrCMOG_nice_out=[];

for i = 1:numberTotal
thiscm = arrCM_in(:,:,i);
thiswit = arrWit_in(:,:,i);
testResult = 0;
% i
% arrCM_nice_out
[testResult nicemean nicewit nicecm] = isNiceCM(thiscm, thiswit, roundCM_max, roundWit_max, maxEntryAllowed);
% arrCM_nice_out
% testResult
    if testResult
%         disp('cake1');
%         tempcm
%         arrCM_nice_out
        arrCM_nice_out   = cat(3,arrCM_nice_out, nicecm);
%         disp('cake2');
        arrWit_nice_out  = cat(3,arrWit_nice_out, nicewit);
%         disp('cake3');
        arrMean_nice_out = [arrMean_nice_out, nicemean];
%         disp('cake4');
        arrCMOG_nice_out   = cat(3,arrCMOG_nice_out, thiscm);
%         disp('cake5');
        arrWitOG_nice_out  = cat(3,arrWitOG_nice_out, thiswit);
%         disp('cake6');
        arrMeanOG_nice_out = [arrMeanOG_nice_out, trace(nicecm*nicewit)-1];
    end
end