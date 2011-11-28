function Kg = globalK(nodes,elements,Ee,Ae)
% Assembles a global stiffness matrix

nn  = size(nodes,1);        % number of nodes
dpn = size(nodes,2);        % degrees of freedom per node
nel = size(elements,1);     % number of elements
npe = size(elements,2);     % number of nodes per element

ndf = nn*dpn;               % number of degrees of freedom

% create blank global stiffness matrix
Kg = zeros(ndf,ndf);

% iterate through elements
for e = 1:nel
    % Calculate element length
    L = elementL(nodes,elements,e);
    % Calculate the element stiffness matrix
    Kel = elementK(Ae(e),Ee(e),L);
    
    % Calculate the element transform matrix
    T = elementTransform(nodes,elements,e);
    % Transform the element stiffness matrix to the global coordinates
    Ke = T'*Kel*T;
    
    % Work out which global degrees of freedom are relevant for this element
    DOFe = kron((dpn*(elements(e,:)-1)),ones(1,dpn)) + kron(ones(1,npe),1:dpn);
    
    % Insert the element stiffness matrix into global stiffness matrix
    Kg(DOFe,DOFe) = Kg(DOFe,DOFe) + Ke;
end

return;