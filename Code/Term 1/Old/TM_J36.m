% J(3,6)
initial_state = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0] %Initial state for 20x20 matrix for J_3_6
 

% TransitionMatrix_J_3_6 % Transition Matrix for J(3,6)

% Checking if the transition matrix approaches the stationary state
% The result is transposed to see it as a column vector
first = (initial_state*TransitionMatrix_J_3_6)'
second = (initial_state* TransitionMatrix_J_3_6^20)'
third = (initial_state* TransitionMatrix_J_3_6^22)'
fourth = (initial_state* TransitionMatrix_J_3_6^25)'
fifth = (initial_state* TransitionMatrix_J_3_6^30)'

[eig_vecs,eig_vals] = eig(TransitionMatrix_J_3_6'); %Theoretical stationary state
stationary_dist = eig_vecs(:,1)/sum(eig_vecs(:,1)) %Normalised result from eigen value decomposition
sum(stationary_dist)