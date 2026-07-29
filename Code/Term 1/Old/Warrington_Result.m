%Comparing the result from Warrington for J(3,4)
%Transition matrix for J(2,5)
P = [
0.5,0.5,0,0;
0.5,0,0.5,0;
0.5,0,0,0.5;
1,0,0,0
]

[eig_vecs,eig_vals] = eig(P')
eig_vals(:,1)
stationary_dist = eig_vecs(:,1)/sum(eig_vecs(:,1)) %Normalised result from eigen value decomposition

warrington_result = 1/15*[8,4,2,1] %Warrington Result
sum(warrington_result) %Sum equals to 1