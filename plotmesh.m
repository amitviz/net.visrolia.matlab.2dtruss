function plotmesh(nodes,elements,varargin)
% Plots the mesh, including displacements and contours of postprocessed
%   quantities

nn  = size(nodes,1);        % number of nodes
dpn = size(nodes,2);        % degrees of freedom per node
nel = size(elements,1);     % number of elements
npe = size(elements,2);     % number of nodes per element

ndf = nn*dpn;

figure; hold on;

optargin = size(varargin,2);
switch optargin
    case 0
        u = zeros(ndf,1);
        c = zeros(nel,3); c(:,3) = 1;
    case 1
        u = varargin{1};
        c = zeros(nel,3); c(:,3) = 1;
        
        if (max(varargin{1}) - min(varargin{1})) ~= 0
            scalefactor = 0.5*min(max(nodes) - min(nodes))/(10^ceil(log10(max(abs(u)))));
            disp(strcat('Scale factor: ',sprintf('%8u',uint16(scalefactor))));
            u = u * scalefactor;
        end
    case 2
        u = varargin{1};
        if (max(varargin{1}) - min(varargin{1})) ~= 0
            scalefactor = 0.5*min(max(nodes) - min(nodes))/(10^ceil(log10(max(abs(u)))));
            disp(strcat('Scale factor: ',sprintf('%8u',uint16(scalefactor))));
            u = u * scalefactor;
        end
        c = zeros(nel,3);
        if (max(varargin{2}) - min(varargin{2})) ~= 0
            c2 = (varargin{2} - min(varargin{2}))/(max(varargin{2}) - min(varargin{2}));
            c(:,1) = c2;
            c(:,3) = 1-c2;
        else
            c(:,3) = 1;
        end
end

switch dpn
    case 1  % 1D models
        % plot elements
        for e = 1:nel
            line(nodes(elements(e,:),1)+u(elements(e,:)),zeros(1,npe),'LineWidth',2,'Color',c(e,:));
        end

        % plot nodes
        plot(nodes(:,1)+u,zeros(1,nn),'ko','MarkerSize',8,'MarkerFaceColor','k');
    case 2  % 2D models
        % plot elements
        for e = 1:nel
            line(nodes(elements(e,:),1)+u((elements(e,:)-1)*dpn+1),nodes(elements(e,:),2)+u((elements(e,:)-1)*dpn+2),'LineWidth',2,'Color',c(e,:));
        end

        % plot nodes
        plot(nodes(:,1)+u(1:dpn:ndf),nodes(:,2)+u(2:dpn:ndf),'ko','MarkerSize',8,'MarkerFaceColor','k');
    case 3
end

daspect([1 1 1]);

return;