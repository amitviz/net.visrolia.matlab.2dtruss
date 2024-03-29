function [Ks,Fs,T] = applyABCg(nodes,elements,Kg,Fg,ABCn)
% Applies boundary conditions in the element coordinate system
% Also returns transform matrix to transform the result back into the global 
%   coordinate system

ndof = size(nodes,2);       % degrees of freedom per node

% Create a null transform matrix (i.e. an Identity matrix)
T = eye(length(Fg));

% loop through rows of ABCn to construct transform matrix
for i = 1:size(ABCn,1)
    element = ABCn(i,1);        % element number
    lnode = ABCn(i,2);          % local node number
    gnode = elements(element,lnode); % global node number
    theta = elementtheta(nodes,elements,element);   % angle of the element
    t = transform(theta);       % transform matrix for the element angle
    gdof = ndof*(gnode-1) + [1:ndof]; % global degrees of freedom
    T(gdof,gdof) = t;           % put it in the appropriate position
end

% modify global force and stifness matrices to local coordinate system at
%   selected nodes - the `starred' matrices
Fs = T*Fg;
Ks = T*Kg*T';

% loop through rows of ABCn to apply constraints
for i = 1:size(ABCn,1)
    element = ABCn(i,1);        % element number
    lnode = ABCn(i,2);          % local node number
    gnode = elements(element,lnode); % global node number
    gdof0 =  ndof*(gnode-1);
    for d = 1:ndof              % iterate through the dimensions
        if ABCn(i,2+d) == 1
            Ks(gdof0+d,:) = 0;
            Ks(:,gdof0+d) = 0;
            Ks(gdof0+d,gdof0+d) = 1;
            Fs(gdof0+d) = 0;
        end
    end
end

return;