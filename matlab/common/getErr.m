function Err=getErr(model,data)
% model 是分类器如j48
% data 是instances 如test
    sum=data.numInstances();
    right =0;
    for i=0:sum-1
        if model.classifyInstance(data.instance(i))==data.instance(i).classValue()
            right=right+1;
        end
    end
    Err=right/sum;
end