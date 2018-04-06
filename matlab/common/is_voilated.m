function res=is_voilated(SetC,setM,Citem,id)     
         if isempty(Citem)
             res=false;
             return;
         end
         
         [midx,mval]=find(setM==id);
         mres=setdiff(setM(midx,:),id);
%          mresΪD=
         for i=1:length(mres)
             if ~ismember(mres(i),Citem)
                 res=true;
                 return;
             end   
         end
         
         [cidx,cval]=find(SetC==id);
         cres=setdiff(SetC(cidx,:),id);
%          cresΪd~=
         for j=1:length(cres)
             if ismember(cres(j),Citem)
                 res=true;
                 return;
             end   
         end
         
         res=false;
                  
end         
   
% %          Mvalue=0; Cvalue=0;
% % step 1
% 
% 
% 
% 
% 
%          for i=1:length(Citem)
%              Vitem=[id,Citem(i)];
%              if ismember(Vitem,setM,'rows') || ismember(fliplr(Vitem),setM,'rows')
%                  res=false;
%                  return;
%              end
%          end
% % step 2
%          for i=1:length(Citem)
%              Vitem=[id,Citem(i)];
%              if ismember(Vitem,SetC,'rows') || ismember(fliplr(Vitem),SetC,'rows')
%                 res=false;
%                 return;
%              end
%          end
%  % step 3        
%          res=true;
%          
         
%          if Mvalue>=Cvalue
%               res=true;
%          else
%               res=false;
%          end
