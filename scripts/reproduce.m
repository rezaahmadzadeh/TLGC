function newTrajectories = reproduce(model, numRepro, starting, initPoint, Ratio, crossSection)

if numel(starting) ~= numRepro
    error('The number of starting points should be equal to the number of reproductions');
end
if size(initPoint,1) ~= numRepro
    error('The number of initial points should be equal to the number of reproductions');
end

directrix = model.directrix;
eT = model.eT;
eN = model.eN;
eB = model.eB;
szd = size(directrix,1);

newTrajectories = cell(1,numRepro);

switch crossSection
    case 'circle'
        Rc = model.Rc;
        
        for jj = 1:numRepro
            strt = starting(1,jj);
            ratio = Ratio(jj,1);
            newTraj = zeros(szd-strt+1,3);
            newTraj(1,:) = initPoint(jj,:);
            
            PcurrL = initPoint(jj,:);
            DCMl2g = [eN(1,:);eB(1,:);eT(1,:)];                     % Local2Global DCM using current TNB
            % DCMg2l = DCMl2g.';
            
            for ii = strt+1:szd
                PcurrG = DCMl2g * (PcurrL - directrix(ii-1,:)).';   % PcurrL, PcurrG: current point in Local and Global res.
                
                DCMl2g = [eN(ii,:);eB(ii,:);eT(ii,:)];              % Local2Global DCM using current TNB
                DCMg2l = DCMl2g.';
                
                PnextL0 = DCMg2l * PcurrG;                          % PnextL: next point in Local
                
                PnextL = ratio*Rc(ii)*PnextL0/(norm(PnextL0)) + directrix(ii,:).';
                
                newTraj(ii,:) = PnextL.';
                PcurrL = PnextL.';
            end
            newTrajectories{1,jj} = newTraj;
        end
        
    case 'spline'
        curves = model.Curve;
        
        for jj = 1:numRepro
            
            strt = starting(1,jj);
            ratio = Ratio(jj,1);
            
            newTraj = zeros(szd-strt,3);                            % sometimes the last points are zerod and that makes an error so +1-1
            newTraj(1,:) = initPoint(jj,:);
            
            PcurrL = initPoint(jj,:);
            DCMl2g = [eN(1,:);eB(1,:);eT(1,:)];                     % Local2Global DCM using current TNB
            % DCMg2l = DCMl2g.';
            
            for ii = strt+1:szd-1 %*
                
                PcurrG = DCMl2g * (PcurrL - directrix(ii-1,:)).';   % PcurrL, PcurrG: current point in Local and Global res.
                
                DCMl2g = [eN(ii,:);eB(ii,:);eT(ii,:)];              % Local2Global DCM using current TNB
                DCMg2l = DCMl2g.';
                
                PP = curves(ii).curve;                              % get the second curve

                centerPP = [0 0]; 
                
                [Sx,Sy] = intersectPointCSpline(PcurrG(1:2,1).',centerPP,PP);   % find the intersection
                if numel(Sx)==2
                    [q, d] = nearestIntersection([Sx Sy],PcurrG(1:2,1).');
                elseif numel(Sx)==1  % impossible to happen
                    q = [Sx Sy];
                    warning('only one solution found');
                else
                    warning('no intersection found');
                end
                
                PnextL0 = DCMg2l * PcurrG;                          % PnextL: next point in Local                
                PnextL = ratio * d * PnextL0/norm(PnextL0) + directrix(ii,:).';
                
                newTraj(ii,:) = PnextL.';
                PcurrL = PnextL.';
                
            end
            
            newTrajectories{1,jj} = newTraj;
            
        end
end
end