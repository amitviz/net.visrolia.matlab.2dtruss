function [strn,strs,loads] = postprocess(nodes,elements,Ee,Ae,u)
% Determine postprocessed quantities (strain, stress, load) and element reaction
%   forces from the solution vector

strn = strain(nodes,elements,u);
strs = stress(strn,Ee);
loads = strs .* Ae;

disp(' e  ex        Sx        Rx1       Ry1       Rx2       Ry2      ');
for e = 1:size(elements,1)
    element_nodes = elements(e,:);
    ui = zeros(4,1);
    ui(1:2,1) = u(2*(element_nodes(1,1)-1)+[1 2]'); % nodal solution
    ui(3:4,1) = u(2*(element_nodes(1,2)-1)+[1 2]'); % nodal solution
    
    T = elementTransform(nodes,elements,e);
    uie = T*ui; % in element coordinate system
    
    L = elementL(nodes,elements,e);
    Ke = elementK(Ae(e),Ee(e),L);
    
    Re = Ke*uie;
    
    fprintf('%2i %9.2e %9.2e %9.2e %9.2e %9.2e %9.2e\n',e,strs(e),strn(e),Re(1),Re(2),Re(3),Re(4));
end

return;