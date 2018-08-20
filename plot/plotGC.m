function plotGC(model, demos, numSet, numDemos, gcPlotType, crossSectionType, fhandle)
% -----------------------------------------------------------------------
% This function plots the Generalized Cylinder
%
% Inputs:
%   model: encoded generalized cylinder
%   demos: the set of demonstrations
%   numSet: dataset number
%   numDemos: number of demos in the dataset
%   gcPlotType: GC plot type ('line' or 'surface')
%   crossSectionType: GC cross section type ('circle' or 'spline')
%   fhandle: if a figure already exists
%
% -----------------------------------------------------------------------
% Code: Reza Ahmadzadeh and Roshni Kaushik (IRIM2016)
% -----------------------------------------------------------------------
% last updated - 6/4/2018

directrix = model.directrix;
GC = model.GC;

if nargin < 7
    fhandle = figure;
end
figure(fhandle);hold on;
stepc = 1;
if strcmp(crossSectionType ,'spline')
    stepc = fix(0.01*length(directrix(:,1)));    % 10% of the data is used
end
switch gcPlotType
    case 'line'
        for kk = 1:stepc:size(GC,3)
            C = GC(:,:,kk);
            plot3(C(1,:),C(2,:),C(3,:),'color','k');%[0.5 0.5 0.5]); %[0.5 0.5 0.5]);
        end
        
    case 'surface'
        surf(squeeze(GC(1,:,1:stepc:end)), squeeze(GC(2,:,1:stepc:end)), squeeze(GC(3,:,1:stepc:end)));
        shading interp;alpha 0.5;colormap winter;
        
    otherwise
        error('Unknown plot type!');
end

plot3(directrix(:,1), directrix(:,2), directrix(:,3), 'b','linewidth',2);

for ii=1:numDemos
    plot3(demos{ii}(:,1), demos{ii}(:,2), demos{ii}(:,3),'r','linewidth',1);
end

title(sprintf('Set %i',numSet));
xlabel('x_1'); ylabel('x_2'); zlabel('x_3');
view([19.6,-6.8]);
box on; grid on;
h = get(gcf,'children');
n = numel(h);
for ii=1:n
    axisType = h(ii).Type;
    switch axisType
        case 'axes'
            h(ii).FontName = 'Times';
            h(ii).FontSize = 12;
    end
end
hold off;
axis equal
end