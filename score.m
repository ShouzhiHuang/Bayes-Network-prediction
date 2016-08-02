function S = score(G,D) %G is graph D is data set
%SCORE Summary of this function goes here
%   Detailed explanation goes here
node_CPT=CPT(G,D);
S=0;
D_columns=size(D,1);
for i=1:6
    compute_table=D(:,node_CPT{i}(1,:));
    parent_num=length(node_CPT{i}(1,:))-1;
    if parent_num>1
        compare=node_CPT{i}(2:end,1:end-1);
        parent=compute_table(:,1:end-1);
        child=compute_table(:,end);
        prob=node_CPT{i}(2:end,end);
    else
        if parent_num==1
            compare=node_CPT{i}([2,3],1);
            parent=compute_table(:,1);
            child=compute_table(:,2);
            prob=node_CPT{i}([2,3],2);
        else
            %compare=node_CPT{i}(2);
            %parent=compute_table;
            child=compute_table;
            prob=node_CPT{i}(2);
        end
    end
    if parent_num~=0
        for j=1:D_columns
            for k=1:2^parent_num
                if isequal(parent(j,:),compare(k,:))
                    if child(j)==1
                        S=S+log(prob(k));break;
                    else
                        S=S+log(1-prob(k));break;
                    end
                end
            end
        end
    else
        for j=1:D_columns
            if child(j)==1
                S=S+log(prob);
            else
                S=S+log(1-prob);
            end
        end
    end
end
end

