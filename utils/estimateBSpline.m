function [curve] = estimateBSpline(P)
% this function encloses the given points inside the smallest feasible
% closed B-Spline
%
% input:
%       P: a set of points in a plane size = (2,N)
%
% output:
%       curve: cubic spline in ppform
%       points: added the points on the bspline to the curve structure
%       bpoints: added breakpoints to the curve structure
%
%
% -----------------------------------------------------------------------
% Code: Reza Ahmadzadeh (IRIM 2016) (reza.ahmadzadeh@gatech.edu)
% -----------------------------------------------------------------------

if size(P, 1) ~= 2
    P = P.';
end

P = [P P(:,1)];                     % closing the curve
k = convhull(P(1,:),P(2,:));        % get the convexhull to find the bounding points
bpoints = P(:,k);                   % only use the bounding points
curve = cscvn(bpoints);             % calculate the closed-curve
[points, tinterval] = fnplt(curve); % getting the points
curve.points = points;
curve.bpoints = bpoints;
curve.tinterval = tinterval;        % maybe can use this in unifyingCurve function

end