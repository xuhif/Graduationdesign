function [err,time]=getClassifyRes(tran_arff_path,test_arff_path,ClaName)
%ClaName����������
    train=getInstances(tran_arff_path);
    test=getInstances(test_arff_path);
    %���÷���������
    cla=['weka.classifiers.trees.',ClaName];
    model = javaObject(cla);
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

    e.evaluateModel(model,test,array);
    time=toc;
    e.toClassDetailsString;
    e.getAllEvaluationMetricNames;
    e.confusionMatrix;
    e.kappa;
    err=1-e.errorRate();
end
