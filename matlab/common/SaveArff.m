%����ΪArff�ļ�
function varargout=SaveArff(varargin)
%varargin{1}��Ҫתarff������·��trainPath
%varargin{2} Լ��������idx
%varargin{3}   Arff�ļ����num
str=regexp(varargin{1},'\','split');
st=str(end);
newpath=varargin{1}(1:end-length(st{1}));
name=st{1}(1:end-4);
if nargin == 3
    A=load(varargin{1});
    varargout{1}=A(:,[varargin{2}(1:end),end]); %���ؾ���
    varargout{2}=[newpath,'ResData\',name,'_',num2str(varargin{3}),'.arff']; %����·��
elseif nargin==1
    varargout{1}=[newpath,'ResData\',name,'_flag','.arff']; %����·��
end
end