function S_max=component_largest(G,n)
if(isempty(G))
    S_max=0;
else
%Tarjan算法求最大连通片
A= sparse(G);
[num_comp, C] = graphconncomp(A);
S(1:1:num_comp)=0;
for i=1:num_comp
    numi=find(C==i);
    S(i)=length(numi);
end
S_max=max(S)/n;
end
    





    
    
    