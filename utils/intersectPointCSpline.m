function [Sx,Sy] = intersectPointCSpline(P,C,PP)
[m,d] = getLine(C,P);
[Sx,Sy] = intersectLineCSpline(m,d,PP);
end
