load('USAir97.mat')
G=Problem.A;
location(:,1)=usair(:,2);
location(:,2)=usair(:,1);
id1=find(location(:,1)<-130);
location(id1,:)=[];
G(id1,:)=[];
G(:,id1)=[];
id2=find(location(:,1)>-65);
location(id2,:)=[];
G(id2,:)=[];
G(:,id2)=[];
id3=find(location(:,2)<20);
location(id3,:)=[];
G(id3,:)=[];
G(:,id3)=[];
A=G;
n=length(G);
for i=1:n
    for j=1:n
        if G(i,j)>0
            G(i,j)=1;
        end
    end
end
lon_min=min(location(:,1));
lon_max=max(location(:,1));
lon_mid=(lon_min+lon_max)/2;
location(:,1)=location(:,1)-lon_mid;
for i=1:length(location)
    location(i,1)=location(i,1)*cos(location(i,2)*pi/180);
end
len_x=max(location(:,1))-min(location(:,1));
len_y=max(location(:,2))-min(location(:,2));
if len_y>=len_x
    move0=(len_y-len_x)/2;
    move=move0-min(location(:,1));
    location(:,1)=location(:,1)+move;
    location(:,2)=location(:,2)-min(location(:,2));
    location=location/len_y;
else
    move0=(len_x-len_y)/2;
    move=move0-min(location(:,2));
    location(:,2)=location(:,2)+move;
    location(:,1)=location(:,1)-min(location(:,1));
    location=location/len_x;
end
clear id
r=0:0.05:1;
num_grid=100;
tic
for i=1:length(r)
    i
    c(i)=R_spatial_comp_square(A,location,r(i),num_grid);
end
toc
plot(r,c,'-o')
xlabel('R')
ylabel('S_u')
save exp_usair_R.mat
%semilogx(r,c)