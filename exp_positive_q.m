n=10000;
m=2;
cl=100;
distance_n=1;
lamada=2.5;
r_final=0:0.1:2;
num_exp=10;
q=[0,0.4,0.8,1];
parfor j=1:num_exp
    d_configuration1{j}=generate_degree_sequence_sf6(n,m,lamada,cl);
    G{j}=configurationmodel(d_configuration1{j});
    location_r{j}=distance_n*sqrt(rand(n,1));
    location_theta{j}=2*pi*rand(n,1);
    location{j}=[location_r{j}.*cos(location_theta{j}),location_r{j}.*sin(location_theta{j})];
    d_configuration1{j}=[];
    location_r{j}=[];
    location_theta{j}=[];
end
for i=1:length(q)
    parfor j=1:num_exp
        [G_new{j},location_new{j}] = degree_location_positive_id_alpha(G{j},location{j},[0,0],q(i));
        comp_final{i,j}=attack_one_circle_linear_r(G_new{j},location_new{j},[0,0],r_final);
    end
end
for i=1:length(q)
    comp_aver{i}=zeros(1,length(r_final));
    for j=1:num_exp
        comp_aver{i}=comp_aver{i}+comp_final{i,j};
    end
    comp_aver{i}=comp_aver{i}/num_exp;
end
save exp_positive_q.mat
plot(r_final,comp_aver{1},'-o')
hold on
plot(r_final,comp_aver{2},'-v')
hold on
plot(r_final,comp_aver{3},'-d')
hold on
plot(r_final,comp_aver{4},'-^')
legend('\eta=0','\eta=0.4','\eta=0.8','\eta=1')