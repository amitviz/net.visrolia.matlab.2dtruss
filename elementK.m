function Ke = elementK(Ae,Ee,Le)
% Direct construction of an element stiffness matrix (in its own coordinate
%   system)

k = Ae * Ee / Le;

Ke = [ k  0 -k  0;
        0  0  0  0;
       -k  0  k  0
        0  0  0  0];

return;