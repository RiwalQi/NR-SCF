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
num_exp=2000;
x_min=min(location(:,1));
x_max=max(location(:,1));
y_min=min(location(:,2));
y_max=max(location(:,2));
tic
parfor j=1:length(r)
    [p_uncertain(j),p_uncertain_err(j),p_all(:,j)]=attack_one_circle_linear_random_comp_test_new(A,location,r(j),num_exp,1,x_min,x_max,y_min,y_max);
end
toc
errorbar(r,p_uncertain,p_uncertain_err,'o')
xlabel('R')
ylabel('S')
save exp_usair_uncertain.mat
function [p_final,p_err,p_all]=attack_one_circle_linear_random_comp_test_new(G,location,r,num_exp,test,x_min,x_max,y_min,y_max)
n=size(location,1);
p_all=zeros(num_exp,1);
for i=1:num_exp
    center_circle(1)=x_min+(x_max-x_min)*rand;
    center_circle(2)=y_min+(y_max-y_min)*rand;
    p=zeros(test,1);
    for j=1:test
        %location_new=location(randperm(n),:);
        % while(comp_largest>(sqrt(n)/(10*n)))
        G_attack=G;
        attack_id=attack_circle_one(location,r,center_circle);
        G_attack(attack_id,:)=[];
        G_attack(:,attack_id)=[];
        p(j)=component_largest(G_attack,n); 
    end
    p_all(i)=mean(p);
end
p_err=std(p_all);
p_final=mean(p_all);
end

function attack_id=attack_circle_one(location,r,center_circle)
distance_node=sqrt((location(:,1)-center_circle(1)).^2+(location(:,2)-center_circle(2)).^2);
in_id=find(distance_node<=r);
t=0;
attack_id=[];
for i=1:length(in_id)
    p=rand;
    p_remove=(r-distance_node(in_id(i)))/r;
    if p<p_remove
        t=t+1;
        attack_id(t)=in_id(i);
    end
end
end