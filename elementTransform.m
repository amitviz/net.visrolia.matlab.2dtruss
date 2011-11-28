function T = elementTransform(nodes,elements,e)
% Assembles a transform matrix for a two-node element
%   for {u(theta)} = [T(theta)]{u}

theta = elementtheta(nodes,elements,e);
t = transform(theta);
T = kron(eye(2),t);

return;