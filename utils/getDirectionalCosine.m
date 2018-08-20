function DCM = getDirectionalCosine(UVW1,UVW2,inout)
%----------------------------------------------------------
% This function calculated the directional cosine matrix between 
% two coordinate systems CS1, CS2
%
% Input:
%       UVW1: the CS of input
%       UVW2: the CS of output
%       inout: true if the given order is UVW1 and UVW2
%
% Output:
%       DCM: directional cosine matrix
%
%----------------------------------------------------------
% Reza Ahmadzadeh - IRIM 2016 (reza.ahmadzadeh@gatech.edu)
%----------------------------------------------------------
if nargin < 3
    inout = true;
end
DCM = [dot(UVW2(1,:),UVW1(1,:)) dot(UVW2(1,:),UVW1(2,:)) dot(UVW2(1,:),UVW1(3,:));
    dot(UVW2(2,:),UVW1(1,:)) dot(UVW2(2,:),UVW1(2,:)) dot(UVW2(2,:),UVW1(3,:));
    dot(UVW2(3,:),UVW1(1,:)) dot(UVW2(3,:),UVW1(2,:)) dot(UVW2(3,:),UVW1(3,:))];
if ~inout
    DCM = DCM.';
end
end