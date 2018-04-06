function [SwRes,SrRes,SsRes]=getCMevaluation(S,I)
     [Row,Col]=size(S);
     SwRes=[];SrRes=[];SsRes=[];
     for x=1:7
       SwList=[];SrList=[];SsList=[];
       for i=x:7:Row
           for j=i+7:7:Row
               if(i~=j)
                    %«ÛSw                   
                    s1=S(i,:)-mean(S(i,:));
                    s2=S(j,:)-mean(S(j,:));
                    SwM=sum(s1.*s2);
                    SwP=sqrt(sum(s1.^2)*sum(s2.^2));
                    Sw=SwM/SwP;
                    SwList=[SwList,Sw];
                    %«ÛSr
                    r1=sum((I(i,:)-I(j,:)).^2)/(Col*(Col^2-1));
                    Sr=1-6*r1;
                    SrList=[SrList,Sr];
                    %«ÛSs
                    ss1=I(i,1:floor(Col/2));
                    ss2=I(j,1:floor(Col/2));
                    h=length(intersect(ss1,ss2));
                    a=length(ss1); b=length(ss2);
                    Ss=1-(a+b-2*h)/(a+b-h);
                    SsList=[SsList,Ss];
               end
           end
       end
       SwMean=sum(SwList)/10;SwRes=[SwRes,SwMean];
       SrMean=sum(SrList)/10;SrRes=[SrRes,SrMean];
       SsMean=sum(SsList)/10;SsRes=[SsRes,SsMean];
     end
end