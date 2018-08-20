function Curve = unifyCurves(Curve)
% This function makes the number of points in each curve equal to all
% others
%
% Input:
%       Curve: all curves calculated over the directrix using cscvn
%
% Output:
%       Curve: all now have the same number of points
%
%
% TODO: other ways!?
%
%
numCurves = size(Curve,2);
sizes = zeros(numCurves,2);
for ii=1:numCurves
    sizes(ii,1) = size(Curve(ii).curve.points ,2);
    sizes(ii,2) = ii;
end

if all(sizes(:,1) == sizes(1,1))
    % all curves have the same number of points
    % do nothing
else
    % add points to the curves with less number of points
    max_size = max(sizes(:,1));
    % min_size = min(sizes(:,1));
    
    for ii=1:numCurves
        cur_size = size(Curve(ii).curve.points ,2);
        if cur_size < max_size
            n = max_size - cur_size;
            tmp_points = [Curve(ii).curve.points repmat(Curve(ii).curve.points(:,end),1,n)];
            Curve(ii).curve.points = tmp_points;
        end
    end
end
end


