% Checking result from J(2,5) 
TransitionMatrix_J_2_5 = [
    0.25,0.25,0.25,0,0,0,0,0,0,0.25;
    0.25,0,0,0.25,0.25,0.25,0,0,0,0;
    0,0.25,0,0.25,0,0,0.25,0.25,0,0;
    1,0,0,0,0,0,0,0,0,0;
    0,0,1,0,0,0,0,0,0,0;
    0,1,0,0,0,0,0,0,0,0;
    0,0,0,0,0,1,0,0,0,0;
    0,0,0,1,0,0,0,0,0,0;
    0,0,0,0,0,0,0,1,0,0;
    0,0,0.25,0,0,0.25,0,0.25,0.25,0
];

vrow = [1,0,0,0,0,0,0,0,0,0]; %Represents state 01100

%State 01100 should transition to 11000 (which it does) after
%multiplication with the transition matrix
vrow*TransitionMatrix_J_2_5
vrow*TransitionMatrix_J_2_5^10
vrow*TransitionMatrix_J_2_5^15
vrow*TransitionMatrix_J_2_5^20
vrow*TransitionMatrix_J_2_5^21
final = vrow*TransitionMatrix_J_2_5^25

[eig_vecs,eig_vals] = eig(TransitionMatrix_J_2_5'); %Theoretical stationary state
stationary_vec = eig_vecs(:,1)/sum(eig_vecs(:,1)) %Normalised result from eigen value decomposition

