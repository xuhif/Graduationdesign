% 约束分1/2选择
Init();
trainPath='D:\pc_桌面\testdata\sonar_traindata.csv';
testPath='D:\pc_桌面\testdata\sonar_testdata.csv';
A=load(trainPath);
[m,n]=size(A);
for flag=1:10
    %划分CM集合
    [M,C]=DivideCMData(A);
    %获取约束分
     Cr=getCS(A,M,C);
    [Scr,idx]=sort(Cr);
    idx(1:int32(length(idx)/2));
    %tran转arff
    [tran_newmat,tran_arff_path]=SaveArff(trainPath,idx(1:int32(length(idx)/2)),flag);
    Mat2Arff(tran_newmat,tran_arff_path); 
    %test转arff
    [test_newmat,test_arff_path]=SaveArff(testPath,idx(1:int32(length(idx)/2)),flag);
    Mat2Arff(test_newmat,test_arff_path);
    %j48求分类
   [err,time]=getClassifyRes(tran_arff_path,test_arff_path,'J48');
    disp(['第',num2str(flag),'次: ',num2str(err),'  时间:',num2str(time),'秒']);
end
