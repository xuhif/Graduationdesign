% ����ʮ��CM���Ϸ�����Լ����
Init();
trainPath='D:\pc_����\testdata\��������\data2017_7_26\sonar_traindata.csv';
testPath='D:\pc_����\testdata\��������\data2017_7_26\sonar_testdata.csv';
A=load(trainPath);
[m,n]=size(A);
% �õ�mx��cx
Crs=zeros(1,n-1);
% ��mx��cx���CrԼ����
for p=1:10
    [M,C]=DivideCMData(A);
    Cr=zeros(1,n-1);
    for x=1:n-1
        mx=0;cx=0;
        for y=1:length(M)
            mx=mx+(A(M(y,1),x)-A(M(y,2),x))^2;
            cx=cx+(A(C(y,1),x)-A(C(y,2),x))^2;
        end
        Cr(x)=mx-0.1*cx;
    end
    Crs=Crs+Cr(x);
end
res=Crs./10;
% CrԼ��������
[Scr,idx]=sort(res);
for idx_item=0:25  %ͬʱѡ���ʱ��20��
    %����ѡ��
    %thisidx=idx(1:end-idx_item);
    
    %˳��ѡ��
    % thisidx=idx(1:11+idx_item);
    
    %ͬʱѡ��
    thisidx=idx(idx_item+2:end-idx_item-1);
    %    ����arff
    [tran_newmat,tran_arff_path]=SaveArff(trainPath,thisidx,idx_item);
    Mat2Arff(tran_newmat,tran_arff_path); 
    [test_newmat,test_arff_path]=SaveArff(testPath,thisidx,idx_item);
    Mat2Arff(test_newmat,test_arff_path);
 %    ����weka����err
    [err,time]=getClassifyRes(tran_arff_path,test_arff_path,'J48');
    disp(['��',num2str(idx_item),'��: ',num2str(err),'  ʱ��:',num2str(time),'��']);
end
