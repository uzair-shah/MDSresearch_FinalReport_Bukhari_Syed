TransitionMatrix_Jm_2_3 = [1/3, 1/3, 0,   1/3, 0;
                           1/3, 0,   1/3, 0,   1/3;
                           1,   0,   0,   0,   0;
                           1/3, 1/3, 0,   1/3, 0;
                           0,   0,   0,   1,   0];
X = TransitionMatrix_Jm_2_3;
X_name = " J_m(2,3)";


% Creating theoretical stationary vector corresponding to eigen value 1
[eig_vecs,eig_vals] = eig(X'); 
stationary_vec = (eig_vecs(:,1)/sum(eig_vecs(:,1)))'; %Theoretical stationary state

% Initializing Variables
rng(1947793);
num_states = 5; %Total number of states [0 0 0 0 0]
s_vec = zeros(1,num_states); %State Vector for simulation
n = 10^6; %no. of iterations
diff_vec = zeros(1,n); %difference vector to calc norm diff btw sim-vec and st-vec
pos = 1; %starting state position 
cost = 0; %starting cost
profit = 0; %starting profit
tic %Calculating the time it takes to run the loop

for i = 1:n % Loop over n times
    pos_indxs = find(X(pos,:)); %Index position of non-zero probs | position vectors of +ve prob: [1 2 4]
    probs = X(pos, pos_indxs); %(row = 1, columns = 1,2,4)
    x = rand; %Random number between 0 and 1
    
    cum_probs = cumsum(probs,2); %cumsum(A,2) returns the cumulative sum along the rows of A.

    for j = 1:length(cum_probs)
        if x <= cum_probs(j) %if the rand value is less than the value in cumulative probabilities
            pos = pos_indxs(j); %value of associated pos_indexes index is an index in original vector
            s_vec(pos) = s_vec(pos) + 1; %increase value of original vector
            
            if pos > 3
                cost = cost + 10;
            else
                profit = profit + 10;
            end

            break;
        end
    end
    sim_st_vec = s_vec/sum(s_vec);
    diff_vec(i) = (norm(sim_st_vec - stationary_vec))^2;
end
disp(['cost: ',num2str(cost), ' | profit: ', num2str(profit), ' | net: ', num2str(profit-cost)])

elapsedTime = toc;
disp(['The loop took ' num2str(elapsedTime) ' seconds.']);

% Difference between the theoretical stationary distribution 
% and the simulated stationary distribution for comparison
disp(stationary_vec)
disp(s_vec);
sim_st_vec = s_vec/sum(s_vec) %stationary vector from simulation
rssq = (norm(stationary_vec - sim_st_vec))^2 %residual sum of squares

% Plot the simulation stationary state vector
figure('Name','SimStState');
states = ["110"	"101"	"011"	"[11]00"	"0[11]0"];
bar(states,s_vec);
xlabel("States");
ylabel("Count");
title("Simulated Stationary State Distribution of"+X_name);
grid on;

% Plot the simulation stationary state vector
figure('Name','StState');
states = ["110"	"101"	"011"	"[11]00"	"0[11]0"];
bar(states,stationary_vec);
xlabel("States");
ylabel("Probabilities");
title("Stationary State Distribution of"+X_name);
grid on;

% Plot the residual sum of squares over iterations
figure('Name','Convergence');
t = 1:n;
loglog(t,diff_vec)
% plot(t,diff_vec);
% ylim([0,0.01])
% yline(10^-7,'-','Threshold');
xlabel('Iterations (Log Scale)');
ylabel('Residual Sum of Squares (Log Scale)');
title('Convergence of Simulated Stationary Distribution of' + X_name);
grid on;