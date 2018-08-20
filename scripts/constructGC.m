function model = constructGC(demos, numDemos, numPoints, idx, crossSectionType)
% -----------------------------------------------------------------------
% This function constructs a Generalized Cylinder
%
% Inputs:
%   demos: set of demonstrations
%   numDemos: number of demos in the dataset
%   numPoints: number of Points in each demonstration
%   idx: a vector including the initial and final cut indices
%   crossSectionType: type of the cross section for the GC ('circle' or
%   'spline')
%
% Output:
%   model: a structure including the directrix, TNB, and cross-section of
%   the GC
%
% -----------------------------------------------------------------------
% Code: Reza Ahmadzadeh and Roshni Kaushik (IRIM2016)
% -----------------------------------------------------------------------
% last updated - 6/4/2018

% Get the X, Y, Z matrices (size = number of points , number of trajectories)
X1s = zeros(numPoints, numDemos);
X2s = zeros(numPoints, numDemos);
X3s = zeros(numPoints, numDemos);
for ii = 1:numDemos
    X1s(:,ii) = demos{ii}(:,1);
    X2s(:,ii) = demos{ii}(:,2);
    X3s(:,ii) = demos{ii}(:,3);
end

s = linspace(0,1,numPoints).';

% Calculate the mean trajectory
directrix = [mean(X1s, 2), mean(X2s, 2), mean(X3s, 2)];

% Calculate the TNB Frames
[eT, eN, eB] = getTNB(directrix);

switch crossSectionType
    case 'circle'
        [Rc, threshold] = extractBoundariesCircle(directrix, X1s, X2s, X3s);
        
    case 'spline'
        Curve = extractBoundariesBSpline(directrix, X1s, X2s, X3s, eT, eN, eB);
        
    otherwise
        error('No boundary was extracted!');
end

idx1 = idx(1);
idx2 = idx(2);

% Get only subset of values within specified boundary
ss = s(idx1:end-idx2);
eT = eT(idx1:end-idx2, :);
eN = eN(idx1:end-idx2, :);
eB = eB(idx1:end-idx2, :);
directrix = directrix(idx1:end-idx2, :);

% make the model as a structure
model = struct([]);
model(1).s = ss;
model(1).eN = eN;
model(1).eB = eB;
model(1).eT = eT;
model(1).directrix = directrix;

% Construct the GC depending on the cross-section type
switch crossSectionType
    case 'circle'
        RRc = Rc(idx1:end-idx2);
        GC = circularGC(directrix, eN, eB, RRc);
        model(1).Rc = RRc;
        model(1).GC = GC;
        
    case 'spline'
        Curvec = Curve(1,idx1:end-idx2);
        GC = bsplineGC(directrix, eN, eB, eT, Curvec);
        
        model(1).Curve = Curvec;
        model(1).GC = GC;
    otherwise
        error('Error! Cross-section type unknown!');
end

end


