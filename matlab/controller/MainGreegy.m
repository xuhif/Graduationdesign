%̰�ķ�����˳��ѡ��
Init();
trainPath='D:\pc_����\testdata\��������\data2017_7_26\sonar_traindata.csv';
testPath='D:\pc_����\testdata\��������\data2017_7_26\sonar_testdata.csv';
A=load(trainPath);
[m,n]=size(A);
%����CM����
[M,C]=DivideCMData(A);
%��ȡԼ����
 Cr=getCS(A,M,C);
[Scr,idx]=sort(Cr);
for idx_item=0:20  %ͬʱѡ���ʱ��20��
    %����ѡ��
     thisidx=idx(1:end-idx_item);
    %˳��ѡ��
%    thisidx=idx(1:11+idx_item);
    %ͬʱѡ��
%    thisidx=idx(idx_item+2:end-idx_item-1);
    %    ����arff
    [tran_newmat,tran_arff_path]=SaveArff(trainPath,thisidx,idx_item);
    Mat2Arff(tran_newmat,tran_arff_path); 
    [test_newmat,test_arff_path]=SaveArff(testPath,thisidx,idx_item);
    Mat2Arff(test_newmat,test_arff_path);
    %    ����weka����err
    [err,time]=getClassifyRes(tran_arff_path,test_arff_path,'J48');
    disp(['��',num2str(idx_item),'��: ',num2str(err),'  ʱ��:',num2str(time),'��']);
end
