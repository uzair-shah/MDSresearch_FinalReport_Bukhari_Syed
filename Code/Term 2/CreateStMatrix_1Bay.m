%Initialising variables
max_H = 3;
max_b = max_H; %maximum number of balls that can be added
initial_state = [1 0 0];
states_mat = initial_state; %all discovered states intialized to first valid state
queue = initial_state; % states to be processed - determines if loop should run 
edges = {}; %contains rows of the form: [loc_from, loc_to, h] - Juggler decides to go from state i(loc_from) to state j(loc_to) by throwing height h

while ~isempty(queue)
    
    s = queue(1,:); %processing state in queue
    queue(1,:) = []; %empty the queue
    [li_a, loc_from] = ismember(s, states_mat, "rows"); %Checking which row (loc_from) of the states matrix contains current state
    shifted_s = [s(2:end), 0]; %state after removing ball at t=0 but before determining new state with thrown ball
    succs = {}; %  will contain the next state and the throw height needed to reach it (successor)
    if s(1) == 0
        succs = {shifted_s, 0}; %next state is the same as the shifted state above, 0 represents height to reach this state |
        if sum(s) < max_b %if balls in system are less than maximum balls allowed
            for i = 1:max_H
                new_s = s; % addition is instantaneous
                new_s(i) = new_s(i) + 1; %add new ball to the system
                succs(end+1,:) = {new_s, 0}; %new state added along with throw height (0 in this case as ball is added at any point in the state)
            end
        end
    elseif s(1) == 1
        for h = 0:max_H
            new_s = shifted_s;
            new_s(1) = new_s(1) + (s(1) - 1); %[[11] 1 0] -> [ [11] 0 1] case where remaining balls are shifted one step ahead while one ball is thrown
            if h >= 1 %if t=0, then ball is just dropped
                new_s(h) = new_s(h) + 1; %ball thrown to required position from max_H positions
            end
            succs(end+1,:) = {new_s, h}; %adding successor along with height thrown to reach position (t in this case)
        end
    
    elseif s(1)==2 
        for h = 0:max_H
            new_s = shifted_s;
            new_s(1) = new_s(1) + (s(1) - 1); %[[11] 1 0] -> [ [11] 0 1] case where remaining balls are shifted one step ahead while one ball is thrown
            if h >= 1 %if t=0, then ball is just dropped
                new_s(h) = new_s(h) + 1; %ball thrown to required position from max_H positions
            end
            succs(end+1,:)= {new_s, [h,1]}; %adding successor along with height thrown to reach position (t in this case)
        end
    else
        for h = 0:max_H
            new_s = shifted_s;
            new_s(1) = new_s(1) + (s(1) - 1); %[[11] 1 0] -> [ [11] 0 1] case where remaining balls are shifted one step ahead while one ball is thrown
            if h >= 1 %if t=0, then ball is just dropped
                new_s(h) = new_s(h) + 1; %ball thrown to required position from max_H positions
            end
            succs(end+1,:)= {new_s, [h,1,1]}; %adding successor along with height thrown to reach position (t in this case)
        end
    end
    
    for j = 1:size(succs, 1) %going through rows of succs matrix that contains successor state and throw height (at end)
        new_s = succs{j, 1}; %successor extracted
        h = succs{j, 2}; %throw height extracted
        [ex_states, loc_to] = ismember(new_s, states_mat, "rows"); %ex_states(T/F): which states exist in states matrix, loc_to: which row the vector corresponds to in states matrix
        if ~ex_states %if state does not exist in state matrix
            states_mat(end+1,:) = new_s; %new state is appended to states matrix
            queue(end+1,:) = new_s; %add state to queue for next processing
            loc_to = size(states_mat, 1); %this is the new row to which the matrix is appended
        end
        edges(end+1,:) = {loc_from, loc_to, h}; %height(h) corresponding to throw height required to move between the states
    end
end

state_count = size(states_mat, 1); %Total number of states
transition_values = cell(state_count); %Cell array representing throw heights associated with moving from state i to state j
for e = 1:size(edges,1) %iterating over rows of the edges
    transition_values{edges{e,1}, edges{e,2}} = edges{e,3}; %tells you the transition height value from current state to another and adds to transition matrix (index values for current state(edges(e,1)) to new state(edges(e,2))
end
disp("Each row is a juggling state in the following matrix")

disp(states_mat)

disp("Each row entry denotes the throw height associated with transitioning from state i to j")
disp(transition_values)
