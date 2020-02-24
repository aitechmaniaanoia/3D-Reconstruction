% A test script using templeCoords.mat
% Write your code here
close all;
clear all;

K = load('../data/intrinsics.mat'); 
S = load('../data/someCorresp.mat');

I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');

M = S.M;
pts1 = S.pts1;
pts2 = S.pts2;

F = eightpoint(pts1, pts2, M);
% test 8 point
%displayEpipolarF(I1, I2, F);

% epipolar Correspondence
[pts2] = epipolarCorrespondence(I1, I2, F, pts1); 
%[coordsIM1, coordsIM2] = epipolarMatchGUI(I1, I2, F);

% essential matrix
E = essentialMatrix(F, K.K1, K.K2); % 3*3
%[coordsIM1, coordsIM2] = epipolarMatchGUI(I1, I2, E);

% triangulation 
P1 = [E zeros(3,1)]; % 3*4
P2_group = camera2(E);
err_best = 10000;

for i = 1:size(P2_group,3)
    
    P2 = P2_group(:,:,i);
    p3d = triangulate(P1, pts1, P2, pts2); % N*3
    
    % project the 3D points back to the image
    n = size(p3d,1);
    p3d_ = [p3d zeros(n,1)]';
    p1_proj = P1*p3d_;  % 3*N
    p2_proj = P2*p3d_;  % 3*N
    
    % compute the mean Euclidean error between projected 2D points and pts
    err = norm(sqrt((p1_proj-[pts1 zeros(n,1)].').^2) + sqrt((p2_proj-[pts2 zeros(n,1)].').^2));
    
    % find the best P2
    if err < err_best
        err_best = err;
        P2_best = P2;
        pts3d = p3d;
    end
end

plot3(pts3d(:,1), pts3d(:,2), pts3d(:,3));

% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
