function idx=getPrimRes(resSet,idx,value)
%   1.�ҵ�value���±겢�ж��Ƿ�Ϊ�������һ�������������ѭ��
    thisId=find(idx==value);
%   2.�ҵ���Ӧ����±�Ȼ�����
    rids=find(resSet==idx(thisId));
    idx=dislodgeidx(resSet,idx,rids);
    newId=find(idx==value);
    if(newId==length(idx))
        return;
    end
    idx=getPrimRes(resSet,idx,idx(newId+1));
end
function idx=dislodgeidx(resSet,idx,rids)
% redellist�ó�resSet�����ڽ����
    redellist=[];
    for i=1:length(rids)
        if mod(rids(i),2)==0
            delitem=rids(i)-1;
        else
            delitem=rids(i)+1;
        end  
        redellist=[redellist,delitem];
    end
    idxlist=resSet(redellist);
% ��idx����ɾ��
    for j=1:length(idxlist)
        id=find(idx==idxlist(j));
        if ~isempty(id)
            idx(id)=[];
        end
    end
end