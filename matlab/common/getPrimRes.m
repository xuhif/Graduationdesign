function idx=getPrimRes(resSet,idx,value)
%   1.找到value的下标并判断是否为数组最后一个如果是则跳出循环
    thisId=find(idx==value);
%   2.找到对应点的下标然后清除
    rids=find(resSet==idx(thisId));
    idx=dislodgeidx(resSet,idx,rids);
    newId=find(idx==value);
    if(newId==length(idx))
        return;
    end
    idx=getPrimRes(resSet,idx,idx(newId+1));
end
function idx=dislodgeidx(resSet,idx,rids)
% redellist得出resSet中相邻结果集
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
% 对idx进行删除
    for j=1:length(idxlist)
        id=find(idx==idxlist(j));
        if ~isempty(id)
            idx(id)=[];
        end
    end
end