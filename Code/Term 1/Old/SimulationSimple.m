% TransitionMatrix_J_2_5 = [
%     0.25,0.25,0.25,0,0,0,0,0,0,0.25;
%     0.25,0,0,0.25,0.25,0.25,0,0,0,0;
%     0,0.25,0,0.25,0,0,0.25,0.25,0,0;
%     0,0,0.25,0,0,0.25,0,0.25,0.25,0;
%     1,0,0,0,0,0,0,0,0,0;
%     0,0,1,0,0,0,0,0,0,0;
%     0,1,0,0,0,0,0,0,0,0;
%     0,0,0,0,0,1,0,0,0,0;
%     0,0,0,1,0,0,0,0,0,0;
%     0,0,0,0,0,0,0,1,0,0
% ];
TransitionMatrix_J_2_5 = [0.25	0.25	0.25	0.25	0	0	0	0	0	0
0.25	0	0	0	0.25	0.25	0.25	0	0	0
0	0.25	0	0	0.25	0	0	0.25	0.25	0
0	0	0.25	0	0	0	0.25	0	0.25	0.25
1	0	0	0	0	0	0	0	0	0
0	0	1	0	0	0	0	0	0	0
0	1	0	0	0	0	0	0	0	0
0	0	0	0	0	0	1	0	0	0
0	0	0	0	1	0	0	0	0	0
0	0	0	0	0	0	0	0	1	0];


%Starting Simulation
%%Initialising variables
rng(1947793) %Setting seed for reproducibility
h=5; b = 2; %h: height of throw, b: number of balls
num_states = nchoosek(h,b); %Total number of states
s_vec = zeros(1,num_states); %State Vector
[eig_vecs,eig_vals] = eig(TransitionMatrix_J_2_5'); %Theoretical stationary state
stationary_vec = (eig_vecs(:,1)/sum(eig_vecs(:,1)))'; %Normalised result from eigen value decomposition
n = 3; %Number of iterations for the loop
diff_vec = zeros(1,n);
pos = 1;

for i = 1:n % Loop over n times
    
    lst_indx = find(TransitionMatrix_J_2_5(pos,:)); %Index position of non-zero elements
    
    x = rand %Random number between 0 and 1
    if length(lst_indx) > 1  %If theres more than 1 option for the next state
        
        if (x >=0) && (x <= 0.25)
            pos = lst_indx(1);
            s_vec(pos) = s_vec(pos) + 1 ; % Increase the s_vec in the specified position by 1
        elseif (x > 0.25) && (x <= 0.5)
            pos = lst_indx(2);
            s_vec(lst_indx(2)) = s_vec(lst_indx(2)) + 1; 
        elseif (x > 0.5) && (x <= 0.75)
            pos = lst_indx(3);
            s_vec(pos) = s_vec(pos) + 1 ; 
        else
            pos = lst_indx(4);
            s_vec(pos) = s_vec(pos) + 1 ; 
        end
    else %If theres only 1 option for the state
        pos = lst_indx(1);
        s_vec(pos) = s_vec(pos) + 1; % Assign the only index available
    
    end %end if statement
    sim_st_vec = s_vec/sum(s_vec);
    difference = (norm(sim_st_vec - stationary_vec))^2;
    
    diff_vec(i) = difference;
end
disp(s_vec/sum(s_vec));
disp(s_vec);
% Plot the resulting simulation vector
figure;
states = ["11000" "10100"	"10010"	"10001"	"01100"	"01001"	"01010"	"00101"	"00110"	"00011"];
bar(states,s_vec)
xlabel("Juggling States");
ylabel("Frequency of Occurrence");
title("Simulation for J(2,5)");
grid on;

% Calculate the difference between the theoretical stationary distribution 
% and the simulated stationary distribution for comparison
disp(stationary_vec);
sim_st_vec = s_vec/sum(s_vec) %stationary vector from simulatio`n
rssq = (norm(stationary_vec - sim_st_vec))^2 %residual sum of squares


% Plot the residual sum of squares over iterations
figure;
t = 1:n;
plot(t,diff_vec)
% yline(0.00001,'-','Threshold')
xlabel('Iteration (t) (Log Scale)');
ylabel('Residual Sum of Squares (Log Scale)');
title('Simple Convergence of Simulated Stationary Distribution J(2,5)');
grid on;
