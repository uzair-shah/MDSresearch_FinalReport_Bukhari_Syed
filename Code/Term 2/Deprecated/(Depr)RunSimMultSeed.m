%Making this code state independent
TransitionMatrix_J_3_3 = [ 0.25	0.25	0.25	0.25	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0.25	0.25	0.25	0.25	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
0.25	0	0	0	0.25	0.25	0.25	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0.25	0	0	0	0.25	0.25	0.25	0	0	0	0	0	0	0	0	0	0	0
0.25	0	0	0	0.25	0	0	0.25	0	0.25	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0.25	0.25	0.25	0.25	0	0	0	0	0	0	0
0	0	0	0	0.25	0	0	0	0	0	0	0	0.25	0.25	0.25	0	0	0	0	0
0	0	0.25	0	0.25	0.25	0.25	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0.25	0	0	0	0	0	0	0	0	0.25	0.25	0.25	0	0	0
0.25	0	0	0	0.25	0	0	0.25	0	0.25	0	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0.25	0	0	0	0	0	0	0	0.25	0.25	0.25
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0
0	0	0	0	0.25	0	0	0	0	0	0.25	0	0	0.25	0	0	0	0	0.25	0
0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0
0	0	0	0	0	0.25	0	0	0	0	0.25	0.25	0.25	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0	0.25	0	0	0	0	0	0	0	0.25	0.25	0.25
0	0	0	0	0	0	0	0	0	0.25	0	0	0	0	0	0	0	0.25	0.25	0.25
0	0	0	0	0.25	0	0	0	0	0	0.25	0	0	0.25	0	0	0	0	0.25	0];
X = TransitionMatrix_J_3_3;
X_name = " J_n(>=3,3)";


% Creating theoretical stationary vector corresponding to eigen value 1
[eig_vecs,eig_vals] = eig(X'); 
stationary_vec = (eig_vecs(:,1)/sum(eig_vecs(:,1)))'; %Theoretical stationary state

% Initializing Variables
num_states = 20; %Total number of states
seeds = 30;
n = 10^5; %no. of iterations
diff_mat = zeros(num_states,n,seeds); %difference vector to calc norm diff btw sim-vec and st-vec
sim_st_vec_matrix = zeros(num_states,num_states,seeds); %Storing vectors from different starting states
cost = 0;
profit = 0;
for seed = 1:seeds
    rng(1947793+seed);
    
    for k = 1:num_states
        s_vec = zeros(1,num_states); %State Vector for simulation
        
        pos = k; %starting state position
        
        tic %Calculating the time it takes to run the loop
        
        for i = 1:n % Loop over n times
            pos_indxs = find(X(pos,:)); %Index position of non-zero probs
            probs = X(pos, pos_indxs);
            x = rand; %Random number between 0 and 1
            
            cum_probs = cumsum(probs,2);
        
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
            diff_mat(k,i,seed) = (norm(sim_st_vec - stationary_vec))^2;
        end
        sim_st_vec_matrix(k,:,seed) = sim_st_vec;
    end
end
elapsedTime = toc;
disp(['The loop took ' num2str(elapsedTime) ' seconds.']);

% disp('The matrix across different starting states is:' )
% disp(sim_st_vec_matrix)
mean_sim_st_vec_matrix = mean(sim_st_vec_matrix,[1,3]);
mean_diff_vec = mean(diff_mat,[1,3]); %averages difference across all states
% Difference between the theoretical stationary distribution 
% and the simulated stationary distribution for comparison
disp(stationary_vec)
disp(s_vec);
sim_st_vec = s_vec/sum(s_vec) %stationary vector from simulation
rssq = (norm(stationary_vec - sim_st_vec))^2 %residual sum of squares


% Plot the residual sum of squares over iterations
figure('Name','Convergence');
t = 1:n;
% loglog(t,mean_diff_vec)
plot(t,mean_diff_vec);
ylim([0,0.001])
% yline(10^-7,'-','Threshold');
xlabel('Iterations');
ylabel('Residual Sum of Squares');
title('Convergence of Simulated Stationary Distribution of' + X_name);
grid on;

% Plot the residual sum of squares over iterations - Log Graph
figure('Name','Convergence_Log');
t = 1:n;
loglog(t,mean_diff_vec)
% plot(t,diff_vec);
% ylim([0,0.01])
% yline(10^-7,'-','Threshold');
xlabel('Iterations (Log Scale)');
ylabel('Residual Sum of Squares (Log Scale)');
title('Convergence of Simulated Stationary Distribution of' + X_name);
grid on;

% Plot simulated vs theoretical stationary distribution on the same graph
figure('Name','SimVsStState');
states =["1 0 0"	"0 0 0"	"0 1 0"	"0 0 1"	"1 1 0"	"0 2 0"	"0 1 1"	"1 0 1"	"0 0 2"	"2 0 0"	"1 2 0"	"0 3 0"	"0 2 1"	"1 1 1"	"0 1 2"	"1 0 2"	"0 0 3"	"3 0 0"	"2 1 0"	"2 0 1"];

sim_st_vec = s_vec / n;          % normalize counts by number of iterations


combined = [sim_st_vec(:), stationary_vec(:)];   % 6 x 2 matrix | Combine both vectors as columns so bar() draws grouped bars

b = bar(states, combined);
b(1).FaceColor = [0.20 0.45 0.75];   % simulated  (blue)
b(2).FaceColor = [0.85 0.40 0.20];   % theoretical (orange)

xlabel("States");
ylabel("Probabilities");
title("Simulated vs Theoretical Stationary State Distribution of" + X_name);
legend("Simulated","Theoretical","Location","best");
grid on;