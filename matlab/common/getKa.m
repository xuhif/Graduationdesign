function ka=getKa(confusionMatrix,test)
% confusionMatrix»ìÏý¾ØÕó
% test ÊÇtest.arff²âÊÔÊý¾Ý
    ka=0;
    n=test.numClasses();
    N=test.numInstances();
    CMatrix=confusionMatrix;
    Pe=0.0;
    Pa=0.0;
    SumR=zeros(1,n);
    SumC=zeros(1,n);
    for x=1:n
        for y=1:n
             SumR(x)=SumR(x)+CMatrix(x,y);
             SumC(x)=SumC(x)+CMatrix(y,x);
        end
    end
    for o=1:n
        Pe=Pe+SumR(o)*SumC(o);
        Pa=Pa+CMatrix(o,o);
    end
    Pe=(Pe/N)/N;
    Pa=Pa/N;
    ka=(Pa-Pe)/(1-Pe);
end
