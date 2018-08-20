function [Pout, Ratio] = randomPointsInSpatialCircle(n, r, C, eN, eB)
% This function generates random points inside a circle
% Inputs:
%       n: number of points required
%       r: the radius of the circle
%       C: center of the circle [cx cy]
% Output:
%       P: points inside circle
% -----------------------------------------------------------------------
% Code: Reza Ahmadzadeh (IRIM 2018) (reza.ahmadzadeh@gatech.edu)
% -----------------------------------------------------------------------
% A more efficient version: 6/5/2018

rr = -r + 2*r*rand(n,1);        % get a random point on diameter 
tr = rand(n,1)*2*pi;            % get a random angle 
P0 = dot(rr, cos(tr),2)*eN + dot(rr, sin(tr),2)*eB; 
Ratio = sqrt(sum(P0.^2,2)) / r; % calculate the ratio
Pout = P0 + repmat(C, n , 1);   % translate to the directrix
end
