% ������
clc;
close all;
clear ;
trainPath='D:\pc_����\testdata\sonar_traindata.csv';
arfftrainPath=[trainPath(1:end-4),'.arff'];
Mat2Arff(trainPath,arfftrainPath); 
% %    ����weka ____����err
train=getInstances(arfftrainPath);
model = javaObject('weka.classifiers.trees.J48');
model.buildClassifier(train);
eval=javaObject('weka.classifiers.Evaluation',train);