%
Init();
trainPath='C:\Users\65751\Desktop\data2017_7_26\sonar_traindata.csv';
testPath='C:\Users\65751\Desktop\data2017_7_26\sonar_testdata.csv';
A=load(trainPath);
B=load(testPath);
[M,N]=size(A);
%����CM����
[csm,csc]=DivideCMData(A);
%��ȡԼ����
 Cr=getCS(A,csm,csc);
[Scr,ids]=sort(Cr);

% ����±�
lable=B(:,end)';
flag=1;
% �ҵ��Ƿ���0���еĵĻ��±겻��find(lable==0, 1)�жϺ�0��������
if ~isempty(find(lable==0, 1))
    flag=0;
end
% ���ðٷֱ�
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
% ÿ��������
maxsel=mode(value);
% ������ȷ��
right=0;
for pp=1:length(lable)
    if maxsel(pp)==lable(pp)
        right=right+1;
    end
end
err=right/length(lable)


