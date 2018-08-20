function [Rc, threshold] = extractBoundariesCircle(directrix, X1s, X2s, X3s)
% -----------------------------------------------------------------------
% This function finds the radius of a circular cross-section covering a
% set of effective points on trajectories using a plane approximation
%
% Inputs:
%   directrix: the spine of the GC
%   X1s, X2s, X3s: the x, y, and z components of all trajectories
%
% Output:
%   Rc: the outer radius of the circular cross section for each arclength
%   value 's'
%   threshold: the threshold added to the Rc
%
%
% -----------------------------------------------------------------------
% Code: Reza Ahmadzadeh and Roshni Kaushik (IRIM2016)
% Last updated 6/30/2018
% -----------------------------------------------------------------------
% validated version - 6/6/2017
% last updated - 8/5/2018 (works correctly)

%Get dimensions
numPoints = size(directrix, 1);
numTraj = size(X1s, 2);

neighborhood = floor(numPoints/3); % to search only around the point. this is efficient
% for cases in which the movement is not a function (e.g. cricular movement).

%Calculate slopes
G = gradient(directrix.');              % dx,dy,dz at each point (dm/dx,dm/dy,dm/dz)
Gnorm = bsxfun(@rdivide, G, norm(G));     % normalization: calculate the norms and divide
%*/ instead of recalculating the eT we can directly use eT in the equations
% this has been tested in the extractBoundariesBSpline.m

Rc = zeros(numPoints, 1);

% build all the idx outside the loop
tt = 1:numPoints;
Idx1 = max(tt-neighborhood, 1);
Idx2 = min(tt+neighborhood, length(tt));

for ii = 1:numPoints
    dx = Gnorm(1,ii);
    dy = Gnorm(2,ii);
    dz = Gnorm(3,ii);
    
    idx1 = Idx1(ii);
    idx2 = Idx2(ii);
    
    %Current Point on the directrix
    point1 = directrix(ii,:);
    distances = zeros(numTraj, 1);
    
    for jj = 1:numTraj                  %For each trajectory
        %Closest point to plane
        min_func = dx*(X1s(idx1:idx2,jj) - point1(1)) + ...
            dy*(X2s(idx1:idx2,jj) - point1(2)) + ...
            dz*(X3s(idx1:idx2,jj) - point1(3));
        
        [~, idx3] = min(abs(min_func));
        
        point2 = [X1s(idx1-1+idx3, jj), X2s(idx1-1+idx3, jj), X3s(idx1-1+idx3, jj)];
        distances(jj) = norm(point1 - point2);  % equivalent sqrt(sum((point1 - point2).^2));
    end
    
    %Get the point with the max distance
    [maxVal, ~] = max(distances);
    Rc(ii) = maxVal;
    % xyzDistanceVec(ii, :) = xyzDistance(maxIdx, :);
end

% ===--=== Smoothing Rc ===--===

ttt = (1:10:numPoints).';   % pick 10% of the data

% ===-=== method 1 (does not require a separate MATLAB toolbox
Rc = spline(ttt, Rc(1:10:numPoints), (1:numPoints)).';

% adding threshold to the boundaries
threshold_percentage = 0.05;%5;

% use a small percentage of the average of the biggest and smallest radii
% distances in the data
threshold = threshold_percentage * mean([max(max(repmat(Rc,1,3))), min(min(repmat(Rc,1,3)))]);
Rc = Rc + threshold;

end