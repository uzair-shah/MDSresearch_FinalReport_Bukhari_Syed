H= 2;             % height = maximum throw height
initial_state = [1 1 ];       % starting state
cap = H;
states = initial_state;        % master list of discovered states (one per row)
queue  = initial_state;        % worklist: states still waiting to be processed
edges  = [];          % records [fromIndex, toIndex, height] as we go

while ~isempty(queue)
    v = queue(1,:);              % take the next state off the worklist | [1 1 0]
    queue(1,:) = [];            % and remove it | queue -> []
    [a, iFrom] = ismember(v, states, 'rows');   % v's row number | iFrom = row number 

    base = [v(2:end), 0];        % shift left

    succs = [];                  % each row will be [successor..., height]
    if v(1) == 0
        succs = [base, 0];       % no ball in hand: only move is the shift (height 0) | new vector eg [0 1 1]
        if sum(v) < cap
            for p = 1:H
                w = v;                  % a fresh state (no shift)
                w(p) = w(p) + 1;        % modify it
                succs = [succs; w, 0];  % APPEND it to the list
            end
        end

    else   
        for t = 0:H   
            w = base;
            w(1) = w(1) + (v(1)-1); %remaining trucks on hold
            if t >= 1
                w(t) = w(t) + 1;        % place the thrown ball  | [1 1 0] -> [1 0 0] -> [1 1 0] or [1 0 1]
            end
            succs = [succs; w, t]; %adding new row to list of successor and corresponding height to reach there
        
        end
    end

    for s = 1:size(succs,1)                  % register each successor | go through each row 
        w = succs(s, 1:H);                   % gives you the vector 
        t = succs(s, H+1);                   % gives you height 
        [tf, loc] = ismember(w, states, 'rows'); %tf is true false
        if ~tf                               % brand-new state | if the state does not exist in states matrix
            states(end+1,:) = w;             % append to matrix
            queue(end+1,:)  = w;             % queue it for processing
            loc = size(states,1);
        end
        edges(end+1,:) = [iFrom, loc, t];    % from -> to via this height
    end
end

n = size(states,1);
M = -ones(n,n);                              % -1 = no transition 
for e = 1:size(edges,1)
    M(edges(e,1), edges(e,2)) = edges(e,3);
end
disp('These are the edges below')
disp(states)
disp(M)

