function value=getValue_Bagging(model,data,flag)
% model �Ƿ�������j48 data ��instances ��test
    sum=data.numInstances();
    value=[];
    for i=0:sum-1
%   ��Ϊ���ص����ʹ��±�0��ʼ�ģ����ļ����ͺ�0ʱ�������������0��Ҫ��1
       val=model.classifyInstance(data.instance(i))+flag;
       value=[value,val];
    end
end