function [m,d] = getLine(p1,p2)
% This function calculats m and d of a line (y = mx + d) from a couple of points
%
% Inputs;
%       p1,p2: two points (1x2)
% 
% outputs:
%       m: line slope
%       d: line translation value: y = mx + d
%
%
% -----------------------------------------------------------------------
% Code: Reza Ahmadzadeh (IRIM 2016) (reza.ahmadzadeh@gatech.edu)
% -----------------------------------------------------------------------

if (p2(1,1)-p1(1,1)) == 0 % case of vertical lines (x=d)
    m = Inf;
    d = p2(1,1);
else % case of general and horizontal lines
    m = (p2(1,2)-p1(1,2))/(p2(1,1)-p1(1,1));
    d = p2(1,2) - m*p2(1,1);
end
end