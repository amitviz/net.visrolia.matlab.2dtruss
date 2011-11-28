function [Kg,Fg] = applyBCg(nodes,Kg,Fg,BCn)
% Applies boundary conditions in the global coordinate system

% use the same function as the force to scatter the nodal values into a vector
BCg = globalF(nodes,BCn);

ndf = size(Fg,1);       % total number of degrees of freedom

% iterate throough all the degrees of freedom
for n = 1:ndf
    if BCg(n) == 1      % if this dof is constrained
        Kg(n,:) = 0;        % zero the row
        Kg(:,n) = 0;        % zero the column
        Kg(n,n) = 1;        % identity on the diagonal
        Fg(n) = 0;          % zero the force
    end
end

return;