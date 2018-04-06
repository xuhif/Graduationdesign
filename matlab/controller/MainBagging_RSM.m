% 选子集
Init();
trainPath='C:\Users\65751\Desktop\data2017_7_26\sonar_traindata.csv';
testPath='C:\Users\65751\Desktop\data2017_7_26\sonar_testdata.csv';

A=load(trainPath);
[m,n]=size(A);
score=zeros(1,n-1);
I=zeros(1,n-1);
for num=30:50 
    for i=1:10
        F=randperm(n-1,num);
        newA=A(:,[F,end]);
        [M,C]=DivideCMData(newA);
        Cr=zeros(1,num);
        for x=1:num
            mx=0;cx=0;
            for y=1:length(M)
                mx=mx+(newA(M(y,1),x)-newA(M(y,2),x))^2;
                cx=cx+(newA(C(y,1),x)-newA(C(y,2),x))^2;
            end
            Cr(x)=mx-0.1*cx;
        end
        score(F)=score(F)+Cr;
        I(F)=I(F)+1;
    end
    score=score./I;
    [Scr,idx]=sort(score);
    %tran转arff
    
    [tran_newmat,tran_arff_path]=SaveArff(trainPath,idx(1:int32(length(idx)/2)),0);
    Mat2Arff(tran_newmat,tran_arff_path); 
    %test转arff
    [test_newmat,test_arff_path]=SaveArff(testPath,idx(1:int32(length(idx)/2)),0);
    Mat2Arff(test_newmat,test_arff_path);
    %    调用weka计算err
    [err,time]=getClassifyRes(tran_arff_path,test_arff_path,'J48');
    disp(['第',num2str(num),'次: ',num2str(err),'  时间:',num2str(time),'秒']);
end




% 
% A=load(tranPath);
% [m,n]=size(A);
% for flag=1:10
%     [M,C]=ProdData(A);
%      Cr=zeros(1,n-1);
%     for x=1:n-1
%         mx=0;cx=0;
%         for y=1:length(M)
%             mx=mx+(A(M(y,1),x)-A(M(y,2),x))^2;
%             cx=cx+(A(C(y,1),x)-A(C(y,2),x))^2;
%         end
%         Cr(x)=mx-0.1*cx;
%     end
%     [Scr,idx]=sort(Cr);
%     idx(1:int32(length(idx)/2));
%     %tran转arff
%     tic;
%     [tran_newmat,tran_arff_path]=saveArff(tranPath,idx(1:int32(length(idx)/2)),flag);
%     Mat2Arff(tran_newmat,tran_arff_path); 
%     %test转arff
%     [test_newmat,test_arff_path]=saveArff(testPath,idx(1:int32(length(idx)/2)),flag);
%     Mat2Arff(test_newmat,test_arff_path);
%     %j48求分类
%     train=getInstances(tran_arff_path);
%     test=getInstances(test_arff_path);
%     model = javaObject('weka.classifiers.trees.J48');
%     model.buildClassifier(train);
%     err=getErr(model,test);
%     disp(['第',num2str(flag),'次: ',num2str(err),'  时间:',num2str(toc),'秒']);
% end



% 
% for i=1:10
%     tic;
%     trainpath=['C:\Users\asus\Desktop\8\sonar_traindata',num2str(i),'.arff'];
%     testpath=['C:\Users\asus\Desktop\8\sonar_testdata',num2str(i),'.arff'];
%     train=getInstances(trainpath);
%     test=getInstances(testpath);
%     model = javaObject('weka.classifiers.trees.J48');
%     model.buildClassifier(train);
%     err=getErr(model,test);
%     disp(['第',num2str(i),'次: ',num2str(err),'  时间:',num2str(toc),'秒']);
% end

