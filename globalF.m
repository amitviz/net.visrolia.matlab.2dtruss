function Fg = globalF(nodes,Fn)
% Scatters a nodal force matrix into a force vector

nn  = size(nodes,1);        % number of nodes
dpn = size(nodes,2);        % degrees of freedom per node

ndf = nn*dpn;               % total number of degrees of freedom

Fg = zeros(ndf,1);          % A blank force vector

% iterate through all the specified forces
for Fi = 1:size(Fn,1)
    n = Fn(Fi,1);           % global node number
    d0 = (n-1)*dpn;         % the zero-th global dof number
    Fg(d0 + [1:dpn]) = Fn(Fi,2:dpn+1);  % set the global dof in the force vector
end

return;