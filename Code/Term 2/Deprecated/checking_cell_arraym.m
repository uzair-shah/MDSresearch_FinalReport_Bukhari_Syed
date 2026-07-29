succs = {}
succs = {[1,0,0],0}
% succs = [succs; new_s, 0];
% succs = {succs;[2,0,0],0}
succs(end+1,:) = {[2,0,0], 0}
succs(end+1,:) = {[3,0,0], [1,0]}
succs
h = succs(3, 2)
size(succs,1)

edges = {}
edges{end+1} = {1,2,3};
edges

ones(1,0)