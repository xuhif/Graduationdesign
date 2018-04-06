% 进行十次CM集合分类求约束分
Init();
trainPath='D:\pc_桌面\testdata\测试数据\data2017_7_26\sonar_traindata.csv';
testPath='D:\pc_桌面\testdata\测试数据\data2017_7_26\sonar_testdata.csv';
A=load(trainPath);
[m,n]=size(A);
% 得到mx，cx
Crs=zeros(1,n-1);
% 用mx，cx获得Cr约束分
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
% Cr约束分排序
[Scr,idx]=sort(res);
for idx_item=0:25  %同时选择的时候20次
    %逆序选择
    %thisidx=idx(1:end-idx_item);
    
    %顺序选择
    % thisidx=idx(1:11+idx_item);
    
    %同时选择
    thisidx=idx(idx_item+2:end-idx_item-1);
    %    保存arff
    [tran_newmat,tran_arff_path]=SaveArff(trainPath,thisidx,idx_item);
    Mat2Arff(tran_newmat,tran_arff_path); 
    [test_newmat,test_arff_path]=SaveArff(testPath,thisidx,idx_item);
    Mat2Arff(test_newmat,test_arff_path);
 %    调用weka计算err
    [err,time]=getClassifyRes(tran_arff_path,test_arff_path,'J48');
    disp(['第',num2str(idx_item),'次: ',num2str(err),'  时间:',num2str(time),'秒']);
end
