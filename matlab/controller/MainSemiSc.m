% 半监督聚类
Init();
trainPath='D:\pc_桌面\testdata\sonar_traindata.csv';
A=load(trainPath);
[m,n]=size(A);
lable=A(:,end);
cla=unique(lable);
k=length(cla);
% 得出MC约束条件
[M,C]=DivideCMData(A);
D=zeros(k,n-1);
newD=A(randperm(m,k),1:n-1);
gflag=true;
while ~isequal(D,newD);
    D=newD;
    Cr=cell(1,k);
    for i=1:m
%         求距离
        item=D-repmat(A(i,1:n-1),k,1);
        dist=sqrt(sum(item.^2,2));
        newK=1:k;
        flag=false;
        
        while ~flag
            [val,id]=min(dist);
       %检测是否存在c中是否存在
            if ~is_voilated(C,M,Cr{newK(id)},i)
                Cr{newK(id)}=[Cr{newK(id)},i];
                flag=true;
            else
%                 thisid=find(newK==newK(id));
                newK(id)=[];
                dist(id)=[];
                if isempty(newK)
                    gflag=false;
                    disp('error!');
                    return;
                end
            end  
        end
    end
    newD=[];
    for x=1:k
        data=A(Cr{x},1:end-1);
        newD=[newD;mean(data)];
    end
end

if gflag
    newclassId=lable;
    for y=1:k
        newclassId(Cr{y})=y;
    end 
    res=getRi(newclassId,lable,m)
end


