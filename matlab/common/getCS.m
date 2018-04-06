function Cr=getCS(A,M,C)
% A�������C,M������
    [m,n]=size(A);
    % �õ�mx��cx
    Cr=zeros(1,n-1);
    % ��mx��cx���CrԼ����
    for x=1:n-1
        mx=0;cx=0;
        for y=1:length(M)
            mx=mx+(A(M(y,1),x)-A(M(y,2),x))^2;
            cx=cx+(A(C(y,1),x)-A(C(y,2),x))^2;
        end
        Cr(x)=mx-0.1*cx;
    end
end
