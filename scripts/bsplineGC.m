function GC = bsplineGC(directrix, eN, eB , eT, Curve)
% -----------------------------------------------------------------------
% This function caclucates bspline cross-sections of the GC
%
% Inputs:
%   directrix: (xn, yn, zn) the GC spine
%   eT, eN, eB: the TNB coordinate frames
%   Curve: the outer radius of the circle
%
% Output:
%   GC: generalized cylinder calculated with each closed spline as GC(:,:,i)
%
% -----------------------------------------------------------------------
% Code: Reza Ahmadzadeh (IRIM2016) (reza.ahmadzadeh@gatech.edu)
% -----------------------------------------------------------------------

xn = directrix(:,1);
yn = directrix(:,2);
zn = directrix(:,3);

numPoints = length(xn)-1;         % numbe of points on directrix (not counting the last one because it can be zero) it was length(xn)-1,  why?
numArcs = size(Curve(1).curve.points,2);
stepc = fix(0.01*numPoints);    % 10% of the data is used
L = length(1:stepc:numPoints);  % number of cross-sections to calculate
GC = zeros(3,numArcs,L);
k = 1;

stepc = 1;
for ii = 1:stepc:numPoints
    x = Curve(ii).curve.points(1,:);
    y = Curve(ii).curve.points(2,:);
    x = x(:); y = y(:);
    
    C = repmat(directrix(ii,:), numArcs, 1) + ([eN(ii,:);eB(ii,:);[0 0 0]].' * [x y zeros(numArcs,1)].').';
    GC(:,:,k) = C.';
    k = k + 1;
end
clear stepc k C numPoints numArcs tc L a b alpha_val x y
end