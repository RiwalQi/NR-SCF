% 按照度序列从大到小(或从小到大)排列邻接矩阵节点id
function [G1,location] = degree_location_positive_id_alpha(G1,location,center_crcle,alpha)
% alpha = 0.4;
% G1=full(pref(100,4));
% G2=full(pref(100,4));
% G1=full(G1);
% G2=full(G2);
N = length(G1);
alpha_N=round(N*alpha);
% G1_new=zeros(N,N); 
% G2_new=zeros(N,N);
% ID=1:N;
ID_rand=randperm(N);
ID_rand_alpha1=ID_rand(1:alpha_N);% 随机选出来一些点的ID
ID_rand_alpha2=ID_rand(alpha_N+1:N);% 剩下的点ID
DeD1=sum(G1,1);
DeD2=sqrt((location(:,1)-center_crcle(1)).^2+(location(:,2)-center_crcle(2)).^2);
[~,ID_1]=sort(DeD1(ID_rand_alpha1),'descend');
[~,ID_2]=sort(DeD2(ID_rand_alpha1),'descend');
New_ID1 = [ID_rand_alpha1(ID_1) ID_rand_alpha2];
New_ID2 = [ID_rand_alpha1(ID_2) ID_rand_alpha2];
random_id=randperm(N);
New_ID1 = New_ID1(random_id);
New_ID2 = New_ID2(random_id);
G1=G1(New_ID1,New_ID1);
location=location(New_ID2,:);
end

% for i=1:N
%     for j=1:N
%         G1_new(i,j) = G1(New_ID1(i),New_ID1(j));
%         G2_new(i,j) = G2(New_ID2(i),New_ID2(j));
%     end
% end
% G1_new=sparse(G1_new);
% G2_new=sparse(G2_new);
% dd1 = sum(G1_new,1);
% dd2 = sum(G2_new,1);