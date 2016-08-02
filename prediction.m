function Prediction = prediction(g,CPT,D)
%PREDICTION Summary of this function goes here
%   Detailed explanation goes here
node_CPT=CPT;
D_columns=size(D,1);
Prediction=zeros(1,D_columns+1);
correct=0;
compute_table=D(:,node_CPT{g}(1,:));
parent_num=length(node_CPT{g}(1,:))-1;
if parent_num>1
    compare=node_CPT{g}(2:end,1:end-1);
    parent=compute_table(:,1:end-1);
    child=compute_table(:,end);
    prob=node_CPT{g}(2:end,end);
else
    if parent_num==1
        compare=node_CPT{g}([2,3],1);
        parent=compute_table(:,1);
        child=compute_table(:,2);
        prob=node_CPT{g}([2,3],2);
    else
        child=compute_table;
        prob=node_CPT{g}(2);
    end
end
if parent_num~=0
    for j=1:D_columns
        for k=1:2^parent_num
            if isequal(parent(j,:),compare(k,:))
                if prob(k)>0.5
                    Prediction(j)=1;
                    if child(j)==1
                        correct=correct+1;
                    end
                    break;
                else
                    Prediction(j)=0;
                    if child(j)==0
                        correct=correct+1;
                    end
                    break;
                end
            end
        end
    end
else
    for j=1:D_columns
        if prob>0.5
            Prediction(j)=1;
            if child(j)==1
                correct=correct+1;
            end
        else
            Prediction(j)=0;
            if child(j)==0
                correct=correct+1;
            end
        end
    end
end
Prediction(end)=correct/D_columns;
end

