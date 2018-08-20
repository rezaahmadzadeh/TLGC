function [T, N, B] = getTNB(directrix,init)
% Estimate TNB frames for a curve -
%
% Input:
%       directrix: [x y z] the curve as Nx3 where N = num points
%       init: the user-specified initial normal vector (optional)
%
% Output:
%       [T, N, B] = Tangent, Normal, and Binormal Vectors
%
%
% Example
%     t=2*pi*linspace(-1/2,1/2,100).';
%     x=cos(t); y=sin(t); z=t;
%     [T,N,B] = getTNB([x,y,z]);
%
% -------------------------------------------------------
% Reza Ahmadzadeh (reza.ahmadzadeh@gatech.edu) IRIM-2016
% (Modified version of the code by : Mehmet OZTURK )
% -------------------------------------------------------
%% data extraction while dealing with both 2D and 3D
x = directrix(:,1);                     % extract x vector
y = directrix(:,2);                     % extract x vector
x = x(:);                               % make sure they are vectors
y = y(:);
sz = length(x);                         % we can deal with both 2D and 3D data
if size(directrix,2) == 3
    dim = 3;
    z = directrix(:,3);
    z = z(:);
else
    dim = 2;
end

%% fit pp-form of a natural cubic spline to the data using csaps(x,y,p)
% p defines the weight between the regression part (p) and the regularization
% part (1-p). With p=1 the regularization part goes away and we are just
% solving the least-squared problem.
% p in [0 1], p=1 --> natural, default defined by : p = 1/(1 + h^3/6)
v = 1:sz;
X = csaps(v, x, 1);
Y = csaps(v, y, 1);
Z = csaps(v, z, 1);
% --- calculate derrivatives of the curve and evaluate
mx = fnval(fnder(X,1), v).';
my = fnval(fnder(Y,1), v).';
mz = fnval(fnder(Z,1), v).';
%% noise removal
ind = find(sqrt(sum([mx my mz].*[mx my mz], 2))>0); % find points with norms less than zero
data = [mx(ind) my(ind) mz(ind)];                   % discard bad points
%% calculate T and normalize
T = bsxfun(@rdivide, data, sqrt(sum(data.*data, 2)));  % normalize tangents

s = numel(ind);                                     % memory allocation for Normal and Binormal vectors
N = zeros(s+1,3);
B = zeros(s,3);
% if there is no initial tangent given
if nargin < 2                                       % check if user has supplied initial normal vector (init)
    % make initial normal vector perpendicular to first tangent vector
    N(1,:) = [T(1,3)*T(1,1) T(1,3)*T(1,2) -(T(1,1)^2+T(1,2)^2)];
    % check for appropirate initial normal vector (if not exist frenet normal)
    if all(N(1,:) == 0) || all(isnan(N(1,:)))
        N(1,:) = [1 0 0];
    end
else
    N(1,:) = init;
end
N(1,:) = N(1,:)./norm(N(1,:));                      % normalize

%% Build N and B by propagating the normal along the curve
for m = 1:s
    B(m,:) = cross(N(m,:),T(m,:));
    N(m+1,:) = cross(T(m,:),B(m,:));
end

%% data interpolation using table lookup
N(1,:) = [];                                        % discard initial vector
T = interp1(ind,T,1:sz(1),'linear','extrap');      % '*linear'
B = interp1(ind,B,1:sz(1),'linear','extrap');
N = interp1(ind,N,1:sz(1),'linear','extrap');
%% --- TODO
% So according to MATLAB this would end up in producing NaNs outside the
% range while extrapolating, either we should change linear to spline, or
% forget about the extrapolation option
% If you specify the 'pchip' or 'spline' interpolation methods, then the default behavior is 'extrap'.
% All other interpolation methods return NaN by default for query points outside the domain.
% -----
T = bsxfun(@rdivide, T, sqrt(sum(T.*T,2)));           % normalize T vector
B = bsxfun(@rdivide, B, sqrt(sum(B.*B,2)));           % normalize B vector
N = bsxfun(@rdivide, N, sqrt(sum(N.*N,2)));           % normalize N vector

if dim == 2
    T(:,3) = [];
    N(:,3) = [];
    B(:,3) = [];
end
%% plot (for debugging)
if nargout == 0
    figure;
    if dim==3
        plot3(x,y,z,'color','r');hold on;
        quiver3(x,y,z,N(:,1),N(:,2),N(:,3),'color','g'),hold on;
        quiver3(x,y,z,B(:,1),B(:,2),B(:,3),'color','b'),hold on;
        grid,daspect([1 1 1]);axis vis3d;
        legend('Curve','Normal','Binormal');
    else
        plot(x,y);hold on;
        quiver(x,y,B(:,1),B(:,2),'color','r');
        grid,daspect([1 1 1]);axis vis3d;
        legend('Tangent','Normal','Binormal');
    end
end
end