function [sx, sy] = intersectLinenDPolynomialInInterval(m,d,P)
% -----------------------------------------------------------------
% This function finds the intersection between a line and a polynomial
% the line is given by y=mx+d
% and the polynomial coefficients are given as P
% To find the intersection between a line y=mx+d
% and a polynomial P we have to first make a new equation
% by    P - [m d] = 0
% to do this we use our function addPolynomials but instead for
% doing subtraction we do   P + [-m -d] = 0
% then we use roots function to find the roots of the new equation
% then we check for real roots and use them to get the y values
%
% Inputs:
%           m: slope of the line
%           d: line shift
%           P: polynomial in pp-form
%
% Outputs:
%           qc: roots of the equation (on x)
%           yc: solutions (on y) - empty if qc is not real number
%
% Example:
%           [q, yc] = intersectLinePolynomial(-1,3,[1 0 -2 3])
%
%   q =
%
%      0
%     -1
%      1
%
%
%   yc =
%
%      3
%      4
%      2
%
% -----------------------------------------------------------------
% Reza Ahmadzadeh - IRIM 2016 (reza.ahmadzadeh@gatech.edu)
% -----------------------------------------------------------------
if P.pieces > 1
    error('the polynomial should be only one piece.');
end

B = P.breaks;
Co = P.coefs;
k = P.order;
% dim = P.dim;

Px = Co(1,:);
Py = Co(2,:);

D = zeros(1,k);
D(1,k) = d;
ss = round(roots(Py - (m*Px+ D)),4);
sx = [];
sy = [];

Idx = zeros(size(ss));
for ii = 1:length(ss)
    Idx(ii) = isreal(ss(ii));
end
ssc = ss(Idx==1);
if ~isempty(ssc)
    for ii=1:length(ssc)
        if ssc(ii)<= B(2)-B(1) && ssc(ii)>= 0
            sx = polyval(Px,ssc(ii));
            sy = polyval(Py,ssc(ii));
        end
    end
else
end
end