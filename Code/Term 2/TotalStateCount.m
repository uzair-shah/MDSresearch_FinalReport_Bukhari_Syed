total = 0;
h=6;
b_end = 3;
for b = 0:b_end
    states_count = nchoosek(h+b-1,b);
    disp(['Number of states with ', num2str(b), ' balls is ', num2str(states_count)])
    total = total + states_count;
end
total