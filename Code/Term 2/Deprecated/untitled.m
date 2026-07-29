% Plot simulated vs theoretical stationary distribution on the same graph
figure('Name','SimVsStState');
states =["1 0 0"	"0 0 0"	"0 1 0"	"0 0 1"	"1 1 0"	"0 2 0"	"0 1 1"	"1 0 1"	"0 0 2"	"1 2 0"	"0 3 0"	"0 2 1"	"1 1 1"	"0 1 2"	"1 0 2"	"0 0 3"	"3 0 0"	"2 1 0"	"2 0 1"	"2 0 0"];


combined = [mean_sim_st_vec_matrix, stationary_vec];   % 6 x 2 matrix | Combine both vectors as columns so bar() draws grouped bars

b = bar(states, combined);
b(1).FaceColor = [0.20 0.45 0.75];   % simulated  (blue)
b(2).FaceColor = [0.85 0.40 0.20];   % theoretical (orange)

xlabel("States");
ylabel("Probabilities");
title("Simulated vs Theoretical Stationary State Distribution of" + X_name);
legend("Simulated","Theoretical","Location","best");
grid on;