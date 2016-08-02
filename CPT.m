function node_CPT = CPT(G,D)
%CPT Summary of this function goes here
%   Detailed explanation goes here
node_CPT=cell(1,6);
for i=1:6
    P=predecessors(G,i);%parent node
    C=[P;i];   %;parent node and child node
    if~isempty(P)
        p_num=length(P);
        t_table_P=tabulate(cellstr(num2str(D(:,P')))); %temp table_P used to convert data (parent node frequence)
        t_table_P=[str2num(cell2mat(t_table_P(:,1))),cell2mat(t_table_P(:,2))];
        
        t_table_C=tabulate(cellstr(num2str(D(:,C')))); %temp table_C used to convert data (parent node and child frequence)
        temp=str2num(cell2mat(t_table_C(:,1)));
        len=length(temp(:,1));
        temp2=tabulate(cellstr(num2str(temp(:,1:end-1))));
        temp3=str2num(cell2mat(temp2(:,1)));
        temp2=cell2mat(temp2(:,2));
        temp4=zeros(len,1);
        for j=1:len
            for k=1:length(temp2)
                if isequal(temp(j,1:end-1),temp3(k,:))
                    temp4(j)=temp2(k);break;
                end
            end
        end
        temp=[temp,temp4];
        t_table_C=[temp,cell2mat(t_table_C(:,2))];
        TF1=t_table_C(:,end-2)==0;   %pick every row in end-1 column have value 0
        TF2=t_table_C(:,end-1)==2;
        TF=TF1&TF2;
        t_table_C(TF,:)=[];
        TF=t_table_C(:,end-2)==0;
        t_table_C(TF,end)=0;
        t_table_C=sortrows(t_table_C,1:p_num);
        t_table_P=sortrows(t_table_P,1:p_num);
        t_table_P(:,end)=t_table_C(:,end)./t_table_P(:,end);

        node_CPT{i}=[C';t_table_P];
        
    else
        t_table_C=tabulate(cellstr(num2str(D(:,C')))); %temp table_C used to convert data (parent node and child frequence)
        t_table_C=[str2num(cell2mat(t_table_C(:,1))),cell2mat(t_table_C(:,3))/100];
        TF=t_table_C(:,end-1)==0;   %pick every row in end-1 column have value 0
        t_table_C(TF,:)=[];
        t_table_C=t_table_C(:,2);
        node_CPT{i}=[C;t_table_C];
    end
end

end

