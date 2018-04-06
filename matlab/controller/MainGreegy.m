%贪心法三种顺序选择
Init();
trainPath='D:\pc_桌面\testdata\测试数据\data2017_7_26\sonar_traindata.csv';
testPath='D:\pc_桌面\testdata\测试数据\data2017_7_26\sonar_testdata.csv';
A=load(trainPath);
[m,n]=size(A);
%划分CM集合
[M,C]=DivideCMData(A);
%获取约束分
 Cr=getCS(A,M,C);
[Scr,idx]=sort(Cr);
for idx_item=0:20  %同时选择的时候20次
    %逆序选择
     thisidx=idx(1:end-idx_item);
    %顺序选择
%    thisidx=idx(1:11+idx_item);
    %同时选择
%    thisidx=idx(idx_item+2:end-idx_item-1);
    %    保存arff
    [tran_newmat,tran_arff_path]=SaveArff(trainPath,thisidx,idx_item);
    Mat2Arff(tran_newmat,tran_arff_path); 
    [test_newmat,test_arff_path]=SaveArff(testPath,thisidx,idx_item);
    Mat2Arff(test_newmat,test_arff_path);
    %    调用weka计算err
    [err,time]=getClassifyRes(tran_arff_path,test_arff_path,'J48');
    disp(['第',num2str(idx_item),'次: ',num2str(err),'  时间:',num2str(time),'秒']);
end
