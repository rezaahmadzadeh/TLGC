function [Curve] = extractBoundariesBSpline(directrix, X1s, X2s, X3s, eT, eN, eB)
% -----------------------------------------------------------------------
% This function finds the radius of a closed-spline cross-section covering a
% set of effective points on trajectories using a plane approximation
%
% Inputs:
%   directrix: the spine of the GC
%   X1s, X2s, X3s: the x, y, and z components of all trajectories
%   eT, eN, eB: TNB frame components
%
% Output:
%   Curve: the estimated closed-Bspline (a natural smooth piecewise cubic spline curve)
%   threshold: the threshold added to the Rc
%
%
% -----------------------------------------------------------------------
% Code: Reza Ahmadzadeh and Roshni Kaushik (IRIM2016)
% Last updated 6/30/2018
% -----------------------------------------------------------------------
% last updated - 6/30/2018

%Get dimensions
numPoints = size(directrix, 1);
numTraj = size(X1s, 2);

neighborhood = floor(numPoints/3); % 300; % to search only around the point. this is efficient
% for cases in which the movement is not a function (e.g. cricular movement).

Curve = struct([]);

% build all the idx outside the loop
tt = 1:numPoints;
Idx1 = max(tt-neighborhood, 1);
Idx2 = min(tt+neighborhood, length(tt));

for ii = 1:numPoints-1        %For each point (-1 because sometimes the last points are all zeroed)
    
    idx1 = Idx1(ii);
    idx2 = Idx2(ii);
    
    %Current Point
    point1 = directrix(ii,:);
    
    distances = zeros(numTraj, 1);
    max_point = zeros(numTraj, 3);
    
    for jj = 1:numTraj          %For each trajectory
        
        %Closest point to plane
        min_func = eT(ii,1)*(X1s(idx1:idx2,jj) - point1(1)) + ...
            eT(ii,2)*(X2s(idx1:idx2,jj) - point1(2)) + ...
            eT(ii,3)*(X3s(idx1:idx2,jj) - point1(3));
        
        [~, idx3] = min(abs(min_func));
        
        point2 = [X1s(idx1-1+idx3, jj), X2s(idx1-1+idx3, jj), X3s(idx1-1+idx3, jj)];
        
        %Store values
        max_point(jj, :) = point2;
        distances(jj) = norm(point1-point2);
    end
    
    new_points = zeros(numTraj,2);
    for k = 1:numTraj
        new_points(k,:) = [dot(eN(ii,:), max_point(k,:)-point1), dot(eB(ii,:), max_point(k,:)-point1)];
    end
    
    curve = estimateBSpline(new_points.');
    Curve(ii).curve = curve;
end
Curve = unifyCurves(Curve); % make the point sizes equal in all splines

% adding threshold to the boundaries
threshold_percentage = 0.05; % each cross-section is going to be scaled by 1+threshold_percentage

% scaling the curves
for ii=1:size(Curve,2)
    X = Curve(ii).curve.points(1,:);
    Y = Curve(ii).curve.points(2,:);
    Cx = sum(X)/size(X,2);
    Cy = sum(Y)/size(Y,2);
    XX = (threshold_percentage + 1)*(X - Cx) + Cx;
    YY = (threshold_percentage + 1)*(Y - Cy) + Cy;
    Curve(ii).curve.points = [XX;YY];
end

end
