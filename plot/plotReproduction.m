function plotReproduction(initPoints,  newTrajectories, hMainPlot)
% -----------------------------------------------------------------------
% This function plots the reproductions
%
% Inputs:
%   initPoints: a set of initial points (n x 3)
%   newTrajectories: a cell including reproductions (1xn)
%   hMainPlot: handle of the figure to plot into
%
% -----------------------------------------------------------------------
% Code: Reza Ahmadzadeh (IRIM2018)
% -----------------------------------------------------------------------
% last updated - 6/5/2018

figure(hMainPlot);hold on
plot3(initPoints(:,1),initPoints(:,2),initPoints(:,3),'or','linewidth',2);
for jj = 1:size(newTrajectories,2)
    plot3(initPoints(jj,1),initPoints(jj,2),initPoints(jj,3),'or','linewidth',2);
    plot3(newTrajectories{jj}(:,1),newTrajectories{jj}(:,2),newTrajectories{jj}(:,3),'.-','linewidth',1,'color','m');
end
end