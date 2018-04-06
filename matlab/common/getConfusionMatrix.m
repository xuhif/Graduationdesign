function confusionMatrix=getConfusionMatrix(model,test)
% model �Ƿ�������j48
% data ��instances ��test
    sum=test.numInstances();
    confusionMatrix=zeros(test.numClasses(),test.numClasses());
    for i=0:sum-1
       colV=model.classifyInstance(test.instance(i))+1;
       rowV=test.instance(i).classValue()+1;
       confusionMatrix(colV,rowV) =confusionMatrix(colV,rowV)+1;
    end   
end