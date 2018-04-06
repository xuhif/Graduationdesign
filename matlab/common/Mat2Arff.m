% mat转arff
function Mat2Arff(input_filename,arff_filename)
% read file data
if ischar(input_filename)
    if strfind(input_filename,'.mat')
        matdata=impoerdata(input_filename);
    elseif strfind(input_filename,'.txt')
        matdata=textread(input_filename);
    elseif strfind(input_filename,'.csv')
        matdata=csvread(input_filename);
    end
else
    matdata=input_filename;
end
[row,col]=size(matdata);
% 判断文件是否存在，不存在则创建 tr_dir=uigetdir({},trainPath)文件夹
if ~exist(arff_filename,'file')
    str=regexp(arff_filename,'\','split');
    dirpath=arff_filename(1:end-length(str{end}));
    if ~exist(dirpath,'dir')
        mkdir(dirpath);
    end
end
f=fopen(arff_filename,'wt');
if f<0
    error(sprintf('unable to open the file %s'),arff_filename);
    return;
end
% write the realtion infonmation
fprintf(f,'%s\n\n',['@relation ',arff_filename]);

for i=1:col-1
    st=['@attribute att_',num2str(i),' numeric'];
    fprintf(f,'%s\n',st);
end

% save last header class infomation 
floatformat='%.16g';
Y=matdata(:,col);
uY=unique(Y);
st='@attribute class {';
for j=1:size(uY)-1
    st = [st sprintf([floatformat ','],uY(j))];
end
st = [st sprintf([floatformat '}'],uY(length(uY)))];
fprintf(f,'%s\n\n',st);
% 开始保存数据 ...
labelformat = [floatformat ' '];
fprintf(f,'@data\n');
for i = 1 : row
    Xi = matdata(i,1:col-1);
    s = sprintf(labelformat,Y(i));
    s = [sprintf([floatformat ' '],[; Xi]) s];
    fprintf(f,'%s\n',s);
end;
fclose(f);

