function G_best = GenerateBN(D)
    G0=digraph;
    s=[1 1 1 2 4];
    t=[4 2 3 6 5];
    G0=addedge(G0,s,t);%generate a initial graph
    G_best=G0;
    for i=1:1000
        G=G_best;
        N=1+5*rand(1,2);     %randomly pick pair of nodes
        N(1)=round(N(1));
        N(2)=round(N(2));
        if N(2)~=N(1)  %check if those nodes are the same node
            no_positive_d=~findedge(G,N(1),N(2));
            no_negetive_d=~findedge(G,N(2),N(1));
        else
            continue;
        end
        if no_positive_d&&no_negetive_d   %N(1) and N(2) didn't connect
            op=1+rand(1,1);
            op=round(op);
            if op==1
                G_new=addedge(G,N(1),N(2));
                if indegree(G_new,N(2))>3
                   continue;
                end
            else
                G_new=addedge(G,N(2),N(1));
                if indegree(G_new,N(1))>3
                    continue;
                end
            end
        else
            if ~no_positive_d
                op=1+rand(1,1);
                op=round(op);
                if op==1
                    G_new=rmedge(G,N(1),N(2));
                else
                    G_new=rmedge(G,N(1),N(2));
                    G_new=addedge(G_new,N(2),N(1));
                    if indegree(G_new,N(1))>3
                        continue;
                    end
                end
            else
                op=1+rand(1,1);
                op=round(op);
                if op==1
                    G_new=rmedge(G,N(2),N(1));
                else
                    G_new=rmedge(G,N(2),N(1));
                    G_new=addedge(G_new,N(1),N(2));
                    if indegree(G_new,N(2))>3
                        continue;
                    end
                end
            end
        end
        if isdag(G_new)
            if score(G_new,D)>=score(G_best,D)
                G_best=G_new;
            end
        else
            continue;
        end
    end
end

