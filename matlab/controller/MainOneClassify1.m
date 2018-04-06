clc;
clear all;
import weka.classifiers.*;
import java.util.*
train=getInstances('D:\pc_桌面\dealt_data\my_tran1000.arff');
test=getInstances('D:\pc_桌面\dealt_data\my_test1000.arff');
model = javaObject('weka.classifiers.trees.J48');

model.buildClassifier(train);

e = javaObject('weka.classifiers.Evaluation',train);

plainText = javaObject('weka.classifiers.evaluation.output.prediction.PlainText');
buffer = javaObject('java.lang.StringBuffer');
plainText.setBuffer(buffer);
% 词句很重要
plainText.setHeader(test);
array = javaArray('java.lang.Object',1);
array(1) = plainText;

e.evaluateModel(model,test,array);
e.toClassDetailsString
e.getAllEvaluationMetricNames
e.confusionMatrix
e.kappa
1-e.errorRate()

% err=getErr(model,test)
% confusionMatrix=getConfusionMatrix(model,test)
% ka=getKa(confusionMatrix,test)