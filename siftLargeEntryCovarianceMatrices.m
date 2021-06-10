function array_out = siftLargeEntryCovarianceMatrices(array_in,size_maxEntry)

[x x N] = size(array_in);
%N = length(array_in);
array_out = [];

for i = 1:N

    arr = array_in(:,:,i);
    n = length(arr);
    % Find largest (modulo) entry
    maxEntry = max(abs(arr(:)));
%     mat = sort(abs(arr));
%     maxEntry = max(mat(n,:));
    
    if maxEntry < size_maxEntry
        array_out = cat(3,array_out,arr);
    end
end

end

