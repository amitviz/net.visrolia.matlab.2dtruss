function strain = strain(nodes,elements,u)

nn  = size(nodes,1);        % number of nodes
dpn = size(nodes,2);        % degrees of freedom per node
nel = size(elements,1);     % number of elements
npe = size(elements,2);     % number of nodes per element

strain = zeros(nel,1);

%{
% method as described in the lecture - ONLY VALID FOR SMALL DISPLACEMENTS
% iterate through elements
for e = 1:nel
    % element dof
    DOFe = kron((dpn*(elements(e,:)-1)),ones(1,dpn)) + kron(ones(1,npe),1:dpn);
    
    % element global displacements
    uge = u(DOFe);
    
    % element transform
    T = elementTransform(nodes,elements,e);
    
    % element local displacements
    ule = T*uge;
    
    % element length
    Le = elementL(nodes,elements,e);
    
    % strain  = (delta u') / L
    strain(e) = (ule(3) - ule(1)) / Le;
end
%}

% method valid for large displacements
displaced_nodes = nodes + [u(1:2:length(u)) u(2:2:length(u))];

original_length = elementL(nodes,elements,1:nel);
displaced_length = elementL(displaced_nodes,elements,1:nel);
strain = (displaced_length-original_length) ./ original_length;
return;