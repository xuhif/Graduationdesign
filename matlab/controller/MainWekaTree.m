clc;
clear all;
import weka.classifiers.*;
import java.util.*
% ��ȡcsv����
trainCsv='D:\pc_����\testdata\mfcc_celp_traindata.csv';
testCsv='D:\pc_����\testdata\mfcc_celp_testdata.csv';
%��ȡ
A=load(trainCsv);
B=load(testCsv);

tran_arff_path=SaveArff(trainCsv);
test_arff_path=SaveArff(testCsv);
Mat2Arff(A,tran_arff_path); 
Mat2Arff(B,test_arff_path);
% tr_dir=uigetdir({},trainPath)�ļ���

train=getInstances(tran_arff_path);
test=getInstances(test_arff_path);



model = javaObject('weka.classifiers.trees.J48');
tic;
model.buildClassifier(train);

e = javaObject('weka.classifiers.Evaluation',train);

plainText = javaObject('weka.classifiers.evaluation.output.prediction.PlainText');
buffer = javaObject('java.lang.StringBuffer');
plainText.setBuffer(buffer);
% �ʾ����Ҫ
plainText.setHeader(test);
array = javaArray('java.lang.Object',1);
array(1) = plainText;
disp(num2str(toc));
e.evaluateModel(model,test,array);
e.toClassDetailsString
e.getAllEvaluationMetricNames
e.confusionMatrix
e.kappa
1-e.errorRate()