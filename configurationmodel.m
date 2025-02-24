function G=configurationmodel(d)

n=length(d);
G=sparse(n,n);
Q=zeros(1,sum(d));


for i=1:n
    Q(sum(d(1:i-1))+1:sum(d(1:i)))=ones(1,d(i))*i;
end
count=0;
e=length(Q);
while length(Q)>1 & count<100000000
    count=count+1;
    T=randperm(e,2);
    v1=Q(T(1));
    v2=Q(T(2));
    ind1=sub2ind(size(G),v1,v2);
    
    if v1~=v2 & G(ind1)==0
        G(ind1)=1;
        
        Q(T)=[];
        e=e-2;
    end
end
G=G+G';