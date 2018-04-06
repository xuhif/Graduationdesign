function Cr=getCS(A,M,C)
% A代表矩阵，C,M代表集合
    [m,n]=size(A);
    % 得到mx，cx
    Cr=zeros(1,n-1);
    % 用mx，cx获得Cr约束分
    for x=1:n-1
        mx=0;cx=0;
        for y=1:length(M)
            mx=mx+(A(M(y,1),x)-A(M(y,2),x))^2;
            cx=cx+(A(C(y,1),x)-A(C(y,2),x))^2;
        end
        Cr(x)=mx-0.1*cx;
    end
end
