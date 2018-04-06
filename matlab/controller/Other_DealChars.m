clc;
clear all;
str=waveletfamilies('n');
[r,c]=size(str);
res=[];
for i=1:r
    if sum(isletter(str(i,:)))
        S = regexp(str(i,:), '\s+', 'split');
        res=[res,S];
    end
end
res(cellfun(@isempty,res))=[];