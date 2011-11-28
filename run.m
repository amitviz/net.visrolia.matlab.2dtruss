tic;
% Bridge model

% Set up nodal coordinates matrix:
% Format: [x1, y1; x2, y2; ...];
nodes = [0 0; 1800 3118; 3600 0; 5400 3118; 7200 0; 9000 3118; 10800 0];

% Set up element connectivity matrix:
% Format: [e1_n1, e1_n2; e2_n1, e2_n2; ...];
elements = [1 2; 1 3; 2 3; 2 4; 3 4; 3 5; 4 5; 4 6; 5 6; 5 7; 6 7];

% Define element modulus:
% Format: column vector, one row per element
Ee = ones(size(elements,1),1)*200e9/1e6;

% Define element cross sectional areas:
% Format: column vector, one row per element
Ae = ones(size(elements,1),1)*3250;

% Define globally aligned boundary conditions
% Format: [node, constrain x (0|1), constrain y (0|1)];
BCn = [1 1 1;
       7 0 1];

% Define globally aligned boundary conditions
% Format: [element, node (1|2), constrain x' (0|1), constrain y' (0|1)];
ABCn = [];

% Define applied forces in global coordinate system
% Format: [node, Fx, Fy];
Fn = [1 0 -280e3;
      3 0 -210e3;
      5 0 -280e3;
      7 0 -360e3];

% Solve the system for displacements and reactions
[u,R] = solve(nodes,elements,Ee,Ae,Fn,BCn,ABCn);

% Postprocess the solution vector to determine derived quantities
[strn,strs,loads] = postprocess(nodes,elements,Ee,Ae,u);

% Plot the mesh, with displacements and strain contours
plotmesh(nodes,elements,u,strn)
toc;