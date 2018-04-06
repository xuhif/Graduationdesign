% 单分裂
clc;
close all;
clear ;
trainPath='D:\pc_桌面\testdata\sonar_traindata.csv';
arfftrainPath=[trainPath(1:end-4),'.arff'];
Mat2Arff(trainPath,arfftrainPath); 
% %    调用weka ____计算err
train=getInstances(arfftrainPath);
model = javaObject('weka.classifiers.trees.J48');
model.buildClassifier(train);
eval=javaObject('weka.classifiers.Evaluation',train);