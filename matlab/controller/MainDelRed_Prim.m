% 应用函数：最大生成树求解
Init();
trainPath='C:\Users\65751\Desktop\testData\sonar_traindata.csv';
testPath='C:\Users\65751\Desktop\testData\sonar_testdata.csv';
A=load(trainPath);
[r,c]=size(A);
% 领接矩阵
adjacency=zeros(c-1,c-1);
% 领接矩阵上三角赋值
for x=1:c-1
    for y=x+1:c-1
        Fr=A(:,x)-mean(A(:,x));
        Fc=A(:,y)-mean(A(:,y));
        Prc=sum(Fr.*Fc)/(sqrt(sum(Fr.^2))*sqrt(sum(Fc.^2)));
        Iitem=-0.5*log2(1-Prc^2);
        adjacency(x,y)=Iitem;
    end
end
% 领接矩阵上三角和下三角赋值产生最终领接矩阵
newadj=adjacency+adjacency';
% 最大生成树
% newadj=[0 6 1 5 0 0;...
%         6 0 5 0 3 0;...
%         1 5 0 5 6 4;...
%         5 0 5 0 0 2;...
%         0 3 6 0 0 6;...
%         0 0 4 2 6 0];
% [c,pp]=size(newadj);
resSet=1;
while length(resSet)<2*(c-2)+1
      selClos=unique(resSet);%选择列
      selRows=setdiff(1:c-1,selClos);%选择行
      [resR,Rid]=max([newadj(selRows,selClos);zeros(length(selRows),length(selClos))]);%idItem得到行的id
      [resC,Cid]=max(resR);%行selRows(Rid(Cid))，列selClos(Cid)
      resSet=[resSet,[selClos(Cid),selRows(Rid(Cid))]];
%       if length(selRows)~=1
%            [resC,Cid]=max(resR);%行selRows(Rid(Cid))，列selClos(Cid)
%            resSet=[resSet,[selClos(Cid),selRows(Rid(Cid))]];
%       else
%            resSet=[resSet,[selClos(Cid),selRows]];
%       end
end


%划分CM集合
[M,C]=DivideCMData(A);
%获取约束分
 Cr=getCS(A,M,C);
[Scr,idx]=sort(Cr);

resSet=resSet(2:end);
newidx=getPrimRes(resSet,idx,idx(1));
% newidx=[];
% for ol=1:length(idx)
%     [rs,cs]=find(resSet==idx(ol));
% end
% newidx=[9	15	6	2	17	8	14	18	1];
% newidx=[9	6	15	2	17	8	14	16	11];
[tran_newmat,tran_arff_path]=SaveArff(trainPath,newidx,0);
Mat2Arff(tran_newmat,tran_arff_path); 
[test_newmat,test_arff_path]=SaveArff(testPath,newidx,0);
Mat2Arff(test_newmat,test_arff_path);
%    调用weka ____计算err
[err,time]=getClassifyRes(tran_arff_path,test_arff_path,'J48');
disp(['第',num2str(0),'次: ',num2str(err),'  时间:',num2str(time),'秒']);





