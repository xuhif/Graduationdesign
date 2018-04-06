% 去除冗余
Init();
trainPath='C:\Users\65751\Desktop\testData\vehicle_traindata.csv';
testPath='C:\Users\65751\Desktop\testData\vehicle_testdata.csv';
A=load(trainPath);
B=load(testPath);
[r,c]=size(A);
c=c-1;%去除最后一列
avgnum=[];
for kk=1:10
    Rm=zeros(c,c);
    ResSet=[];
    for i=1:c
        item=[];
        for j=i+1:c
           numerator= abs(sum(A(:,i).*A(:,j)));
           denominator=sqrt(sum(A(:,i).^2))*sqrt(sum(A(:,j).^2));
           Rm(i,j)=numerator/denominator;
           item=[item,numerator/denominator];
        end
        ResSet=[ResSet,item];
    end
    % 设置阈值
    threshod=min(ResSet)+0.9*(max(ResSet)-min(ResSet));
    RmNo=Rm+Rm';
    % 归一化
    RmNorm=RmNo-threshod;
    RmNorm(RmNorm>0)=1;
    RmNorm(RmNorm<=0)=0;
    % 排除0
    [idx,n]=find(RmNorm==1);
    isoneList=[idx,n];
    reidx=unique(idx);
    newA=A(:,[reidx',end]);
    newB=B(:,[reidx',end]);

    % 约束分计算
    [M,C]=DivideCMData(newA);
    Cr=zeros(1,length(reidx));
    % 用mx，cx获得Cr约束分
    for x=1:length(reidx)
        mx=0;cx=0;
        for y=1:length(M)
            mx=mx+(newA(M(y,1),x)-newA(M(y,2),x))^2;
            cx=cx+(newA(C(y,1),x)-newA(C(y,2),x))^2;
        end
        Cr(x)=mx-0.1*cx;
    end
    % 统计票数
    voteIdx=zeros(1,length(reidx));
    for h=1:length(isoneList)
        idleft=find(reidx==isoneList(h,1));
        idright=find(reidx==isoneList(h,2));
        if Cr(idleft)>=Cr(idright)
            voteIdx(idleft)=voteIdx(idleft)+1;
        else
            voteIdx(idright)=voteIdx(idright)+1;
        end
    end
    [res,newidx]=sort(voteIdx,'descend');
    f=0.9;
    finalA=A(:,[reidx(newidx(1:int32(end*f)))',end]);
    finalB=B(:,[reidx(newidx(1:int32(end*f)))',end]);

    tran_arff_path=SaveArff(trainPath);
    test_arff_path=SaveArff(testPath);
    Mat2Arff(finalA,tran_arff_path); 
    Mat2Arff(finalB,test_arff_path);
    %    调用weka ____计算err
    [err,time]=getClassifyRes(tran_arff_path,test_arff_path,'J48');
    disp(['第',num2str(kk),'次：err为 ',num2str(err),'时间：',num2str(time)]);
    avgnum=[avgnum,err];
end
avg=mean(avgnum)
std=std(avgnum)
