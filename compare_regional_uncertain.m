load('exp_usair_R.mat')
plot(r,c,'k-')
hold on
load('exp_usair_uncertain.mat')
errorbar(r,p_uncertain,p_uncertain_err,'o')
legend('regional','uncertain')
xlabel('R')
ylabel('S_R')
