% ����CM������
Init();
trainPath='C:\Users\65751\Desktop\data2017_7_26\sonar_traindata.csv';
A=load(trainPath);

S=[];I=[];
str={'CorrelationAttributeEval','GainRatioAttributeEval',...
    'InfoGainAttributeEval','OneRAttributeEval','ReliefFAttributeEval','SymmetricalUncertAttributeEval'};
for i=1:5
    % ѡ��train�ռ䣬ֻҪnewA������60%
   [newA,unnewA]=SelectPart(A,0.6); 
%    �Լ���Լ��������
   [M,C]=DivideCMData(newA);
   Cr=getCS(newA,M,C);
   [s1,i1]=sort(Cr);
   S=[S;s1];
   I=[I;i1];
%    weka������
   tran_arff_path=[trainPath(1:end-4),num2str(i),'.arff'];
   for x=1:length(str)
       val=[];
       Mat2Arff(newA,tran_arff_path); 
       train=getInstances(tran_arff_path);
       rank = javaObject('weka.attributeSelection.Ranker');
       atrsel=['weka.attributeSelection.',str{x}];
       eval = javaObject(atrsel);
       eval.buildEvaluator(train);
       attrIndex = rank.search(eval,train)';
       for y=1:length(attrIndex)
          valitem=eval.evaluateAttribute(attrIndex(y));
          val=[val;valitem];
       end
       S=[S;val'];
       I=[I;attrIndex];
   end
end
[Sw,Sr,Ss]=getCMevaluation(S,I)


