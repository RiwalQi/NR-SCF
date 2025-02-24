# Code of “Robustness of networked systems under spatially-correlated failure”
Overview
This is the code for the paper “Robustness of networked systems under spatially-correlated failure”, which proposes a general framework to investigate the robustness of networks under spatially correlated failure. Here we show the simulation code for the critical experiments and results in this paper. The main function for each experiment is shown below.
Main Files
exp_negative_q.m
Running this code will produce the variation of S with R for NC networks with different negative correlation strength.

exp_positive_q.m
Running this code will produce the variation of S with R for PC networks with different positive correlation strength.

exp_usair_R.m
Running this code will produce the variation of regional robustness of US Air Transportation.

exp_usair_uncertain.m
Running this code will produce the uncertain results in US Air Transportation with uncertain damage locations.

compare_regional_uncertain.m
Running this code will produce a plot of the comparison between the above uncertainty results and the regional robustness.

If there are any problems, please feel free to contact Yuan Liang (yliang20@nudt.edu.cn) or Mingze Qi (qimingze17@nudt.edu.cn).
