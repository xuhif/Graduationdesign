function Instances=getInstances(path)
% path ÊÇinstances 
    Instances_reader=javaObject('java.io.FileReader', path);
    Instances = javaObject('weka.core.Instances', Instances_reader);
    Instances.setClassIndex(Instances.numAttributes() - 1);
end



% clc;
% clear all;
% train_reader=javaObject('java.io.FileReader', 'C:\Users\asus\Desktop\7\sonar_traindata0.arff');
% train = javaObject('weka.core.Instances', train_reader);
% train.setClassIndex(train.numAttributes() - 1);
% 
% test_reader=javaObject('java.io.FileReader', 'C:\Users\asus\Desktop\7\sonar_testdata0.arff');
% test = javaObject('weka.core.Instances', test_reader);
% test.setClassIndex(test.numAttributes() - 1);
% 
% model = javaObject('weka.classifiers.trees.J48');
% model.buildClassifier(train);
% 
% sum=test.numInstances();
% right =0;
% for i=0:sum-1
%     if model.classifyInstance(test.instance(i))==test.instance(i).classValue()
%         right=right+1;
%     end
% end
% err=right/sum;
% 
% confusionMatrix=zeros(test.numClasses(),test.numClasses());
% for i=0:sum-1
%    colV=model.classifyInstance(test.instance(i))+1;
%    rowV=test.instance(i).classValue()+1;
%    confusionMatrix(colV,rowV) =confusionMatrix(colV,rowV)+1;
% end
% 
% ka=0;
% n=test.numClasses();
% N=test.numInstances();
% CMatrix=confusionMatrix;
% Pe=0.0;
% Pa=0.0;
% SumR=zeros(1,n);
% SumC=zeros(1,n);
% for x=1:n
%     for y=1:n
%          SumR(x)=SumR(x)+CMatrix(x,y);
%          SumC(x)=SumC(x)+CMatrix(y,x);
%     end
% end
% for o=1:n
%     Pe=Pe+SumR(o)*SumC(o);
%     Pa=Pa+CMatrix(o,o);
% end
% Pe=(Pe/N)/N;
% Pa=Pa/N;
% ka=(Pa-Pe)/(1-Pe)
% % eval = weka.classifiers.Evaluation(train);
% % Evaluation.evaluateModel(model, test);
% % eval.evaluateModel(model,);
% % eval.errorRate();
