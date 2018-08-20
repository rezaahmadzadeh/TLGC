function [initPoint, Ratio] = randomInitialPoints(encodedModel, numRepro, crossSectionType)

switch crossSectionType
    case 'circle'
        strt = 1; % points on the first cross-section
        Rc = encodedModel.Rc(strt);
        eN = encodedModel.eN(strt,:);
        eB = encodedModel.eB(strt,:);
        C = encodedModel.directrix(strt,:);
        [initPoint, Ratio] = randomPointsInSpatialCircle(numRepro, Rc, C, eN, eB);
        
    case 'spline'
        strt = 1;
        curve = encodedModel.Curve(strt).curve;
        C = encodedModel.directrix(strt,:);
        eN = encodedModel.eN(strt,:);
        eB = encodedModel.eB(strt,:);
        eT = encodedModel.eT(strt,:);
        [initPoint, Ratio] = randomPointsInSpatialBSpline(numRepro, curve, C, eT, eN, eB);
    otherwise
        error('cross-section type unknown!');
end
end