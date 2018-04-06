%保存为Arff文件
function varargout=SaveArff(varargin)
%varargin{1}将要转arff的数据路径trainPath
%varargin{2} 约束分排序idx
%varargin{3}   Arff文件标号num
str=regexp(varargin{1},'\','split');
st=str(end);
newpath=varargin{1}(1:end-length(st{1}));
name=st{1}(1:end-4);
if nargin == 3
    A=load(varargin{1});
    varargout{1}=A(:,[varargin{2}(1:end),end]); %返回矩阵
    varargout{2}=[newpath,'ResData\',name,'_',num2str(varargin{3}),'.arff']; %返回路径
elseif nargin==1
    varargout{1}=[newpath,'ResData\',name,'_flag','.arff']; %返回路径
end
end