% constraint score --C M¼¯ºÏ
function [M,C]=DivideDataCM(A)
    la=A(:,end);  
    M=[];C=[]; 
    while 1
       a=randperm(length(la),2);
       if (la(a(1))==la(a(2))) && (length(M)<length(A))
           M=[M;a];
       elseif (la(a(1))~=la(a(2))) && (length(C)<length(A))
           C=[C;a];
       end
%        if length(M)==length(A) && length(C)==length(A)
       if length(M)==length(A) && length(C)==length(A)
           M=unique(M,'rows');
           M=setdiff(M,fliplr(M),'rows');
           C=unique(C,'rows');
           C=setdiff(C,fliplr(C),'rows');
       end
       if length(M)==length(A) && length(C)==length(A)
           break;
       end
    end
end
% function res=Dup(m,a)
%       if size(m,1)==0
%           res=[m;a];
%           return;
%       end
%       for x=1:size(m,1)
%           if sum(m(x,:)==a)<2||sum(m(x,:)==fliplr(a))<2
%               res=[m;a];
%           else
%               res=m;
%           end
%       end
% end