%���ձ���ѡ������
function [newA,unnewA]=SelectPart(A,pro)
%A�Ǿ���pro��0-1֮�����
    la=A(:,end);
    cla=unique(la);
    newA=[];unnewA=[];
    for i=1:length(cla)
        total=find(la==cla(i));
        thispro=floor(length(total)*pro);
        ids=randsample(total,thispro);
        unidx=setdiff(total,ids);
        item=A(ids,:);
        unitem=A(unidx,:);
        newA=[newA;item];
        unnewA=[unnewA;unitem];
    end
end