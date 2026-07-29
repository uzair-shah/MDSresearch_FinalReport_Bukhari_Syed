h = [2	3	4	0	0	0	0	0	0	5
1	0	0	3	5	4	0	0	0	0
0	1	0	2	0	0	5	4	0	0
0	0	1	0	0	2	0	3	5	0
1	0	0	0	0	0	0	0	0	0
0	0	1	0	0	0	0	0	0	0
0	1	0	0	0	0	0	0	0	0
0	0	0	0	0	1	0	0	0	0
0	0	0	1	0	0	0	0	0	0
0	0	0	0	0	0	0	1	0	0];

TransitionMatrix_J_2_5_Boltz = Boltzman(h);



% Checking if the transition matrix approaches the stationary state
% The result is transposed to see it as a column vector
first = (initial_state*TransitionMatrix_J_2_5_Boltz)'
second = (initial_state* TransitionMatrix_J_2_5_Boltz^20)'
third = (initial_state* TransitionMatrix_J_2_5_Boltz^22)'
fourth = (initial_state* TransitionMatrix_J_2_5_Boltz^25)'
fifth = (initial_state* TransitionMatrix_J_2_5_Boltz^30)'

[eig_vecs,eig_vals] = eig(TransitionMatrix_J_2_5_Boltz'); %Theoretical stationary state
stationary_dist = eig_vecs(:,1)/sum(eig_vecs(:,1)) %Normalised result from eigen value decomposition
sum(stationary_dist)