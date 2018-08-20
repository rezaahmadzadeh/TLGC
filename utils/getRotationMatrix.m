function R = getRotationMatrix(UVW1,UVW2)
DCM = getDirectionalCosine(UVW1,UVW2,true);
q = dcm2quat(DCM);
R = quat2rotm(q);
end