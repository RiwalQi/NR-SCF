function d=generate_degree_sequence_sf6(n,m,lamada,cl)
% cl=m*n^(1/(lamada-1));
% cl=round(cl);
%cl=1000;
DegreeInterval(1)=((m+1)^(1-lamada)-m^(1-lamada))/((cl+1)^(1-lamada)-m^(1-lamada));
for i=2:(cl-m+1)
    DegreeInterval(i)=DegreeInterval(i-1)+((m+i)^(1-lamada)-(m+i-1)^(1-lamada))/((cl+1)^(1-lamada)-m^(1-lamada));
end
Alldegree=DegreeInterval(length(DegreeInterval));
for i=1:n
    p=Alldegree*rand;
    id_d=find(DegreeInterval>=p);
    d(i)=id_d(1)-1+m;
end
end