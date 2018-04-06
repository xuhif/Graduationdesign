%
Init();
trainPath='C:\Users\65751\Desktop\data2017_7_26\sonar_traindata.csv';
testPath='C:\Users\65751\Desktop\data2017_7_26\sonar_testdata.csv';
A=load(trainPath);
[M,N]=size(A);
[tran_newmat,tran_arff_path0]=SaveArff(trainPath,(1:N-1),0);
Mat2Arff(tran_newmat,tran_arff_path0); 

train=getInstances(tran_arff_path0);
rank = javaObject('weka.attributeSelection.Ranker');
str={'CorrelationAttributeEval','GainRatioAttributeEval','InfoGainAttributeEval','OneRAttributeEval','ReliefFAttributeEval','SymmetricalUncertAttributeEval'};
for i=1:length(str)
    atrsel=['weka.attributeSelection.',str{i}];
    eval = javaObject(atrsel);
    eval.buildEvaluator(train);
    attrIndex = rank.search(eval,train);
    inx=(attrIndex(1:int32(length(attrIndex)/2))+1)';
    [tran_newmat,tran_arff_path]=SaveArff(trainPath,inx,100);
    Mat2Arff(tran_newmat,tran_arff_path);
            
    [test_newmat,test_arff_path]=SaveArff(testPath,inx,100);
    Mat2Arff(test_newmat,test_arff_path);
   [err,time]=getClassifyRes(tran_arff_path,test_arff_path,'J48');
    disp(['类型:',str{i},'   err: ',num2str(time),'   时间:',num2str(toc)]);
end