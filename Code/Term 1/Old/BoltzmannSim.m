% Checking result from J(2,5) 
TransitionMatrix_J_2_5 = [
    0.25,0.25,0.25,0,0,0,0,0,0,0.25;
    0.25,0,0,0.25,0.25,0.25,0,0,0,0;
    0,0.25,0,0.25,0,0,0.25,0.25,0,0;
    0,0,0.25,0,0,0.25,0,0.25,0.25,0;
    1,0,0,0,0,0,0,0,0,0;
    0,0,1,0,0,0,0,0,0,0;
    0,1,0,0,0,0,0,0,0,0;
    0,0,0,0,0,1,0,0,0,0;
    0,0,0,1,0,0,0,0,0,0;
    0,0,0,0,0,0,0,1,0,0
];

% TransitionMatrix_J_2_5_Boltz = [
%     0.031245229	0.084933337	0.230872748	0.004228582	0.004228582	0.004228582	0.004228582	0.004228582	0.004228582	0.627577195
% 0.011726076	0.004313782	0.004313782	0.086644634	0.640222062	0.235524534	0.004313782	0.004313782	0.004313782	0.004313782
% 0.004563738	0.012405525	0.004563738	0.033721713	0.004563738	0.004563738	0.677318709	0.249171628	0.004563738	0.004563738
% 0.005416941	0.005416941	0.014724772	0.005416941	0.005416941	0.040026081	0.005416941	0.108802169	0.803945331	0.005416941
% 0.231969317	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743
% 0.085336743	0.085336743	0.231969317	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743
% 0.085336743	0.231969317	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743
% 0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.231969317	0.085336743	0.085336743	0.085336743	0.085336743
% 0.085336743	0.085336743	0.085336743	0.231969317	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743
% 0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.085336743	0.231969317	0.085336743	0.085336743
% ];

h = [2	3	4	-1	-1	-1	-1	-1	-1	5
1	-1	-1	3	5	4	-1	-1	-1	-1
-1	1	-1	2	-1	-1	5	4	-1	-1
-1	0	1	-1	-1	2	-1	3	5	-1
0	-1	-1	-1	-1	-1	-1	-1	-1	-1
-1	-1	0	-1	-1	-1	-1	-1	-1	-1
-1	0	-1	-1	-1	-1	-1	-1	-1	-1
-1	-1	-1	-1	-1	0	-1	-1	-1	-1
-1	-1	-1	0	-1	-1	-1	-1	-1	-1
-1	-1	-1	-1	-1	-1	-1	0	-1	-1];

TransitionMatrix_J_2_5_Boltz = Boltzman(h);
[eig_vecs,eig_vals] = eig(TransitionMatrix_J_2_5_Boltz'); 
stationary_vec = eig_vecs(:,1)/sum(eig_vecs(:,1)); %Theoretical stationary state

h=5; b = 2; %h: height of throw, b: number of balls
num_states = nchoosek(h,b); %Total number of states
s_vec = zeros(1,num_states); %State Vector for simulation
diff_vec = zeros(1,100000); %difference vector to calc norm diff btw sim-vec and st-vec

lst_position = 1;
for i = 1:10000000 % Loop over 100,000 times
    
    curr_row = TransitionMatrix_J_2_5_Boltz(lst_position,:); %probability transition vector of current state
    
    x = rand; %Random number between 0 and 1
    if length(curr_row) > 1  %If theres more than 1 option for the next state
        sum_row = cumsum(curr_row,2);
        if (x >=0) && (x <= sum_row(1))
            lst_position = 1;
            s_vec(lst_position) = s_vec(lst_position) + 1 ; % Increase the s_vec in the specified position by 1
        elseif (x > sum_row(1)) && (x <= sum_row(2))
            lst_position = 2;
            s_vec(lst_position) = s_vec(lst_position) + 1; 
        elseif (x > sum_row(2)) && (x <= sum_row(3))
            lst_position = 3;
            s_vec(lst_position) = s_vec(lst_position) + 1 ; 
        elseif (x > sum_row(3)) && (x <= sum_row(4))
            lst_position = 4;
            s_vec(lst_position) = s_vec(lst_position) + 1 ; 
        elseif (x > sum_row(4)) && (x <= sum_row(5))
            lst_position = 5;
            s_vec(lst_position) = s_vec(lst_position) + 1 ;
        elseif (x > sum_row(5)) && (x <= sum_row(6))
            lst_position = 6;
            s_vec(lst_position) = s_vec(lst_position) + 1 ;
        elseif (x > sum_row(6)) && (x <= sum_row(7))
            lst_position = 7;
            s_vec(lst_position) = s_vec(lst_position) + 1 ;

        elseif (x > sum_row(7)) && (x <= sum_row(8))
            lst_position = 8;
            s_vec(lst_position) = s_vec(lst_position) + 1 ;

        elseif (x > sum_row(8)) && (x <= sum_row(9))    
            lst_position = 9;
            s_vec(lst_position) = s_vec(lst_position) + 1 ;
        else
            lst_position = 10;
            s_vec(lst_position) = s_vec(lst_position) + 1 ;
        end
    else %If theres only 1 option for the state
        lst_position = find(curr_row);
        s_vec(lst_position) = s_vec(lst_position) + 1; % Assign the only index available
    
    end %end if statement
end
% disp(s_vec/sum(s_vec))
disp(s_vec)
states = ["11000" "10100"	"10010"	"01100"	"01001"	"01010"	"00101"	"00110"	"00011"	"10001"];
bar(states,s_vec)
xlabel("States")
ylabel("Frequency")
title("Simulation for J(2,5) with Boltzmann Distribution")

disp(stationary_vec)
sim_st_vec = s_vec/sum(s_vec) %stationary vector from simulation
rssq = (norm(stationary_vec - sim_st_vec))^2 %residual sum of squares

bar(states,stationary_vec)
xlabel("States")
ylabel("Probabilities")
title("Stationary State for J(2,5) with Boltzmann Distribution")
