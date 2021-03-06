function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script q4rectify.m

% compute optical center c1 c2
c1 = -(K1*R1)^(-1)*K1*t1;
c2 = -(K2*R2)^(-1)*K2*t2;

% compute new rotation matrix R [r1 r2 r3].'
%r1 = (c1-c2)/det(c1-c2);
%r1 = (c1-c2)/abs(c1-c2);
%r1 = r1(:,1);
r1 = (c1-c2)/norm(c1-c2);
r2 = cross(R1(3,:), r1)';
r3 = cross(r2,r1);

R = [r1 r2 r3]';

R1n = R;
R2n = R;

% compute new intrinsic parameter K
K = K2;

K1n = K1;
K2n = K2;

% new translation t
t1n = -R*c1;
t2n = -R*c2;

% rectification matrix 
M1 = (K*R)*(K1*R1)^(-1);
M2 = (K*R)*(K2*R2)^(-1);

end
