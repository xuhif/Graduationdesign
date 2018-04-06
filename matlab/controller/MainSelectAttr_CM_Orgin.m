%
Init();
trainPath='C:\Users\65751\Desktop\data2017_7_26\sonar_traindata.csv';
testPath='C:\Users\65751\Desktop\data2017_7_26\sonar_testdata.csv';
A=load(trainPath);
B=load(testPath);
[M,N]=size(A);
%划分CM集合
[csm,csc]=DivideCMData(A);
%获取约束分
 Cr=getCS(A,csm,csc);
[Scr,ids]=sort(Cr);

% 检测下标
lable=B(:,end)';
flag=1;
% 找到是否有0，有的的话下标不变find(lable==0, 1)判断含0还不不含
if ~isempty(find(lable==0, 1))
    flag=0;
end
% 设置百分比
percent=2.0/3;

[tran_newmat,tran_arff_path0]=SaveArff(trainPath,(1:N-1),0);
Mat2Arff(tran_newmat,tran_arff_path0); 

train=getInstances(tran_arff_path0);
rank = javaObject('weka.attributeSelection.Ranker');
str={'CorrelationAttributeEval','GainRatioAttributeEval','InfoGainAttributeEval','OneRAttributeEval','ReliefFAttributeEval','SymmetricalUncertAttributeEval','CS'};
value=[];
for i=1:length(str)
    if i~=7
        atrsel=['weka.attributeSelection.',str{i}];
        eval = javaObject(atrsel);
        eval.buildEvaluator(train);
        attrIndex = rank.search(eval,train);
        inx=(attrIndex(1:int32(length(attrIndex)*percent))+1)';
    else
        inx=ids(1:int32(length(ids)*percent));
    end 
    [tran_newmat,tran_arff_path]=SaveArff(trainPath,inx,str{i});
    Mat2Arff(tran_newmat,tran_arff_path);
    [test_newmat,test_arff_path]=SaveArff(testPath,inx,str{i});
    Mat2Arff(test_newmat,test_arff_path);
    
   train=getInstances(tran_arff_path);
   model = javaObject('weka.classifiers.trees.J48');
   model.buildClassifier(train);
      
   test=getInstances(test_arff_path);
   itemvalue=getValue_Bagging(model,test,flag);
   value=[value;itemvalue];
end
% 每列最大的数
maxsel=mode(value);
% 计算正确率
right=0;
for pp=1:length(lable)
    if maxsel(pp)==lable(pp)
        right=right+1;
    end
end
err=right/length(lable)


