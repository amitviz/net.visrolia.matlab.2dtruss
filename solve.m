function [u,R] = solve(nodes,elements,Ee,Ae,Fn,BCn,ABCn)
% Solves a truss finite element system

% Calculate the global stiffness matrix
Kg = globalK(nodes,elements,Ee,Ae);

% Calculate the global force vector
Fg = globalF(nodes,Fn);

% Apply the globally aligned boundary conditions
[Kb,Fb] = applyBCg(nodes,Kg,Fg,BCn);

% Apply the locally aligned boundary conditions
[Ks,Fs,T] = applyABCg(nodes,elements,Kb,Fb,ABCn);

% Solve using backslash operator
us = Ks\Fs;

% Return all components to global coordinate system (for when we've solved
%   certain nodes in an element coordinate system)
u = T'*us;
R = Kg*u;

return;