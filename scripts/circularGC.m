function GC = circularGC(directrix, eN, eB, Rc)
% -----------------------------------------------------------------------
% This function caclucates circular cross-sections of the GC
%
% Inputs:
%   directrix: (xn, yn, zn) the GC spine
%   eN, eB: part of the TNB coordinate frames
%   Rc: the outer radius of the circle
%
% Output:
%   GC: generalized cylinder calculated with each circle as GC(:,:,i)
%
% -----------------------------------------------------------------------
% Code: Reza Ahmadzadeh (IRIM2016) (reza.ahmadzadeh@gatech.edu)
% -----------------------------------------------------------------------
% last updated - 6/4/2018

tc = (0:0.01:1).';              % arc-length on the circle
numPoints = size(directrix,1);  % numbe of points on directrix
numArcs = length(tc);           % number of points on each circle
stepc = fix(0.01*numPoints);    % 10% of the data is used
L = length(1:stepc:numPoints);  % number of cross-sections to calculate
GC = zeros(3,numArcs,L);        % Generalized Cylinder
k = 1;

for ii = 1:stepc:numPoints
    C = repmat(directrix(ii,:), numArcs, 1) + Rc(ii) * ([eN(ii,:);eB(ii,:);[0 0 0]].' * [cos(2*pi*tc) sin(2*pi*tc) zeros(numArcs,1)].').';
    GC(:,:,k) = C.';
    k = k + 1;
end

clear stepc k C tc numPoints numArcs stepc L
end