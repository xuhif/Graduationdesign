function value=getValue_Bagging(model,data,flag)
% model 是分类器如j48 data 是instances 如test
    sum=data.numInstances();
    value=[];
    for i=0:sum-1
%   因为返回的类型从下标0开始的，当文件类型含0时，不会出错，不含0的要加1
       val=model.classifyInstance(data.instance(i))+flag;
       value=[value,val];
    end
end