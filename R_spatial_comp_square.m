function c=R_spatial_comp_square(A,location,r,num_grid)
n=length(A);
x_min=min(location(:,1));
x_max=max(location(:,1));
y_min=min(location(:,2));
y_max=max(location(:,2));
len_grid_x=(x_max-x_min)/num_grid;
len_grid_y=(y_max-y_min)/num_grid;
num_grid_all=num_grid*num_grid;
location_grid=zeros(num_grid_all,2);
for i=1:num_grid_all
    if mod(i,num_grid)==0
        location_grid(i,1)=x_max-len_grid_x/2;
        location_grid(i,2)=(fix(i/num_grid)-1)*len_grid_y+len_grid_y/2+y_min;
    else
        location_grid(i,1)=(mod(i,num_grid)-1)*len_grid_x+len_grid_x/2+x_min;
        location_grid(i,2)=fix(i/num_grid)*len_grid_y+len_grid_y/2+y_min;
    end
end
t=0;
num_grid_all=size(location_grid,1);
comp_all=zeros(num_grid_all,1);
parfor i=1:num_grid_all
    comp_all(i)=Fx_comp(location_grid(i,:),location,r,A,n);
end
%comp_all=(component_largest(A,n)-comp_all)/num_grid_all;
comp_all=comp_all/num_grid_all;
c=sum(comp_all);
end

function fx=Fx_comp(x,location,R,A,n)
num_exp=10;
fx=0;
for i=1:num_exp
    G_attack=A;    
    attack_id=attack_circle_one(location,R,x);
    G_attack(attack_id,:)=[];
    G_attack(:,attack_id)=[];   
    fx=fx+component_largest(G_attack,n);
end
fx=fx/num_exp;
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
