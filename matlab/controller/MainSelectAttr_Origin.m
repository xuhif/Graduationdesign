% 评估CM的属性
Init();
trainPath='C:\Users\65751\Desktop\data2017_7_26\sonar_traindata.csv';
A=load(trainPath);
% 选择train空间，只要newA，按照60%
S=[];I=[];
str={'CorrelationAttributeEval','GainRatioAttributeEval',...
    'InfoGainAttributeEval','OneRAttributeEval','ReliefFAttributeEval','SymmetricalUncertAttributeEval'};
tran_arff_path=SaveArff(trainPath);
Mat2Arff(A,tran_arff_path); 
for x=1:length(str)
   val=[];
   name=[];
   train=getInstances(tran_arff_path);
   rank = javaObject('weka.attributeSelection.Ranker');
   atrsel=['weka.attributeSelection.',str{x}];
   eval = javaObject(atrsel);
   eval.buildEvaluator(train);
   attrIndex = rank.search(eval,train)';
   for y=1:length(attrIndex)
      valitem=eval.evaluateAttribute(attrIndex(y));
      nm=train.attribute(attrIndex(y)).name();
      val=[val,valitem];
      name=[name,nm];
   end
   val
   name
   attrIndex
 end