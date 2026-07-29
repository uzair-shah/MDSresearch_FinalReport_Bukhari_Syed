% J(2,3): 2 balls, height 3 — bare bones, no multiplex, no add/drop
% States are DISCOVERED from a seed, not listed up front.

H    = 3;             % height = state length
seed = [1 1 0];       % any valid starting state

states = seed;        % master list of discovered states (one per row)
queue  = seed;        % worklist: states still waiting to be processed
edges  = [];          % records [fromIndex, toIndex, height] as we go

while ~isempty(queue)
    v = queue(1,:);              % take the next state off the worklist | [1 1 0]
    queue(1,:) = [];            % and remove it | queue -> []
    [a, iFrom] = ismember(v, states, 'rows');   % v's row number | iFrom = row number 

    base = [v(2:end), 0];        % shift left

    succs = [];                  % each row will be [successor..., height]
    if v(1) == 0
        succs = [base, 0];       % no ball in hand: only move is the shift (height 0) | new vector eg [0 1 1]
    else
        for t = 1:H
            if base(t) == 0      % empty slot -> ball may land (this line forbids multiplex)
                w = base;
                w(t) = 1;        % place the thrown ball  | [1 1 0] -> [1 0 0] -> [1 1 0] or [1 0 1]
                succs = [succs; w, t]; %adding new row to list of successor and corresponding height to reach there
            end
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
M = -ones(n,n);                              % -1 = no transition (like your sheet)
for e = 1:size(edges,1)
    M(edges(e,1), edges(e,2)) = edges(e,3);
end
disp('This here')
disp(states)
disp(M)

