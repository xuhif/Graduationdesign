function [err,time]=getClassifyRes(tran_arff_path,test_arff_path,ClaName)
%ClaName分类器名称
    train=getInstances(tran_arff_path);
    test=getInstances(test_arff_path);
    %设置分类器名称
    cla=['weka.classifiers.trees.',ClaName];
    model = javaObject(cla);
    tic;
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
    time=toc;
    e.toClassDetailsString;
    e.getAllEvaluationMetricNames;
    e.confusionMatrix;
    e.kappa;
    err=1-e.errorRate();
end
