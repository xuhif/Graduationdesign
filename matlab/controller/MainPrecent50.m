% Լ����1/2ѡ��
Init();
trainPath='D:\pc_����\testdata\sonar_traindata.csv';
testPath='D:\pc_����\testdata\sonar_testdata.csv';
A=load(trainPath);
[m,n]=size(A);
for flag=1:10
    %����CM����
    [M,C]=DivideCMData(A);
    %��ȡԼ����
     Cr=getCS(A,M,C);
    [Scr,idx]=sort(Cr);
    idx(1:int32(length(idx)/2));
    %tranתarff
    [tran_newmat,tran_arff_path]=SaveArff(trainPath,idx(1:int32(length(idx)/2)),flag);
    Mat2Arff(tran_newmat,tran_arff_path); 
    %testתarff
    [test_newmat,test_arff_path]=SaveArff(testPath,idx(1:int32(length(idx)/2)),flag);
    Mat2Arff(test_newmat,test_arff_path);
    %j48�����
   [err,time]=getClassifyRes(tran_arff_path,test_arff_path,'J48');
    disp(['��',num2str(flag),'��: ',num2str(err),'  ʱ��:',num2str(time),'��']);
end
