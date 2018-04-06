% ∞Îº‡∂Ωæ€¿‡
function resRi=getRi(C_IdxClass1,C_testClass,m)
    a=0;b=0;c=0;d=0;
    for i=1:m-1
        for j=i+1:m
            if C_IdxClass1(i)==C_IdxClass1(j) && C_testClass(i)==C_testClass(j)
                a=a+1;
            elseif C_IdxClass1(i)~=C_IdxClass1(j) && C_testClass(i)==C_testClass(j)
                b=b+1;
            elseif C_IdxClass1(i)==C_IdxClass1(j) && C_testClass(i)~=C_testClass(j)
                c=c+1;
            else
                d=d+1;
            end       
        end
    end
    JC=a/(a+b+c);
    FMI=sqrt(a/(a+b)*a/(a+c));
    M=2*(a+b+c+d);
    RI=2*(a+d)/M;
    resRi=[JC,FMI,RI];
end