% 集成
Init();
trainPath='C:\Users\65751\Desktop\data2017_7_26\vehicle_traindata.csv';
testPath='C:\Users\65751\Desktop\data2017_7_26\vehicle_testdata.csv';

A=load(trainPath);
B=load(testPath);

lable=B(:,end)';
[m,n]=size(A);
score=zeros(1,n-1);
I=zeros(1,n-1);
resSet=[];
flag=1;
% 找到是否有0，有的的话下标不变
if ~isempty(find(lable==0, 1))
    flag=0;
end

for ii=1:10 
    num=13;
    for i=1:10
        F=randperm(n-1,num);
        newA=A(:,[F,end]);
        [M,C]=DivideCMData(newA);
        Cr=zeros(1,num);
        for x=1:num
            mx=0;cx=0;
            for y=1:length(M)
                mx=mx+(newA(M(y,1),x)-newA(M(y,2),x))^2;
                cx=cx+(newA(C(y,1),x)-newA(C(y,2),x))^2;
            end
            Cr(x)=mx-0.1*cx;
        end
        score(F)=score(F)+Cr;
        I(F)=I(F)+1;
    end
    score=score./I;
    [Scr,idx]=sort(score);
    idxMid=int32(length(idx)/2);
    value=[];
    %选择部分属性
    for j=1:10
%         二分选择
        idxFront=randsample(idx(1:idxMid),idxMid/2);
        idxAfter=randsample(idx(idxMid+1:end),idxMid/2);
%         间隔选择
%         idsitem=idx((1:2:60)+randi([0,1],1,30));
        [tran_newmat,tran_arff_path]=SaveArff(trainPath,[idxFront,idxAfter],j);
        Mat2Arff(tran_newmat,tran_arff_path);
        
        [test_newmat,test_arff_path]=SaveArff(testPath,[idxFront,idxAfter],j);
        Mat2Arff(test_newmat,test_arff_path);
        
        train=getInstances(tran_arff_path);
        model = javaObject('weka.classifiers.trees.J48');
        model.buildClassifier(train);
      
        test=getInstances(test_arff_path);
        itemvalue=getValue_Bagging(model,test,flag);
        value=[value;itemvalue];
    end
    maxsel=mode(value);
    right=0;
    for pp=1:length(lable)
        if maxsel(pp)==lable(pp)
            right=right+1;
        end
    end
    err=right/length(lable);
    resSet=[resSet,err];
end

avg=mean(resSet)
std=std(resSet)
