clc;
clear all;
import weka.classifiers.*;
import java.util.*
train=getInstances('D:\pc_×ÀÃæ\testdata\my_train1000.arff');
test=getInstances('D:\pc_×ÀÃæ\testdata\my_test1000.arff');
model = javaObject('weka.classifiers.trees.RandomForest');
model.buildClassifier(train);

e = javaObject('weka.classifiers.Evaluation',train);
myrand = Random(1);

plainText = javaObject('weka.classifiers.evaluation.output.prediction.PlainText');
buffer = javaObject('java.lang.StringBuffer');
plainText.setBuffer(buffer)
bool = javaObject('java.lang.Boolean',true);
range = javaObject('weka.core.Range','1');
array = javaArray('java.lang.Object',3);
array(1) = plainText;
array(2) = range;
array(3) = bool;

e.crossValidateModel(model,train,10,myrand,array);
e.toClassDetailsString
e.getAllEvaluationMetricNames
e.confusionMatrix
e.kappa





% err=getErr(model,test)
% confusionMatrix=getConfusionMatrix(model,test)
% ka=getKa(confusionMatrix,test)