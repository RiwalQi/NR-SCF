function [comp_final]=attack_one_circle_linear_r(G,location,center_circle,r_final)
n=size(G,1);


for i=1:length(r_final)
    G_attack=G;
    
    attack_id=attack_circle_one(location,r_final(i),center_circle);
    G_attack(attack_id,:)=[];
    G_attack(:,attack_id)=[];
    comp_largest=component_largest(G_attack,n);
    
    comp_final(i)=comp_largest;
    
    
end

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

