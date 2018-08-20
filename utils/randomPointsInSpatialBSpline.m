function [Pout, Ratio] = randomPointsInSpatialBSpline(n, curve, C, eT, eN, eB)
%
% This function generates random points inside a spatial closed cubic
% spline
%
% Inputs:
%       n: number of points required
%       curve: for the new version we need the whole closed spline
%       % bpoints: break poins on the spline
%       C: center of the ellipse [cx cy]
%       eT: tangent unit vector (perpendicular to the circle)
%       eN: normal unit vector
%       eB: binorma unit vector
%
% Output:
%       Pout: points inside the spatial spline
%
%
% -----------------------------------------------------------------------
% Code: Reza Ahmadzadeh (IRIM 2016) (reza.ahmadzadeh@gatech.edu)
% -----------------------------------------------------------------------
%%%% This code has to be debugged thoroughly %%%% 8/3/2017
% last updated on: 8/5/2018

Pout = zeros(n,3);
[Pxy, Ratio] = randomPointsInBSpline(n,curve);

for ii=1:n
    Pxy0 = Pxy(:,ii);
    Pout(ii,:) = (([eN;eB;eT].')*[Pxy0;0]).' + C;                   % method 2 : simpler
end
end

function [Pout, Ratio] = randomPointsInBSpline(n,curve)
% ---
% This function generates random points inside a bspline
% ---
Pout = zeros(2,n);
Ratio = zeros(n,1);

% centerPP = mean(curve.points,2);                % find the center using all the points making the spline
centerPP = [0;0];
for ii=1:n
    randpi = randi(size(curve.points,2));       % select one of the rays randomely
    ponspline = curve.points(:,randpi);         % get the selected point which is on the edge of the spline
    rayd = norm(ponspline - centerPP);          % find the distance from the center to the point
    Ratio(ii,1) = rand;
    raydr = Ratio(ii,1)*rayd;                   % randomly pick a distance rand([0 1]) * actual_ray_distance
    xrand = (raydr/rayd)*(ponspline(1,1)-centerPP(1,1)) + centerPP(1,1);
    yrand = (raydr/rayd)*(ponspline(2,1)-centerPP(2,1)) + centerPP(2,1);
    Pout(:,ii) = [xrand;yrand];
end
end
