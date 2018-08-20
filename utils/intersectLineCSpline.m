function [Sx,Sy] = intersectLineCSpline(m,d,PP)

Sx=[];
Sy=[];
for ii=1:PP.pieces
    P = fnbrk(PP,ii);
    [sx, sy] = intersectLinenDPolynomialInInterval(m,d,P);
    Sx=[Sx;sx];
    Sy=[Sy;sy];
end

