function [q, dist_] = nearestIntersection(Q, P)
% Inputs:
%       Q: is the set of solutions (points on the spline)
%       P: is the point that the line passes through towards the center
%
% Outputs:
%       q: closest point to P
%       dist: distance from q to P
%
D = sqrt(sum((Q - repmat(P,size(Q,1),1)).^2,2));
[~,idx] = min(D);   % the first element is the distance from the closest point in Q to P and we do not need it
q = Q(idx,:);       % the closest point in Q to P
dist_ = norm(q);    % distance from the closest point to the center (the whole ray that has to be sclaed using the ratio)
end