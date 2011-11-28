function T = transform(theta)
% Constructs a point rotation matrix for:
%   u(theta) = [T(theta)]u
    T = [cos(theta) sin(theta); -sin(theta) cos(theta)];
return;