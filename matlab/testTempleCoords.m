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

T = load('../data/templeCoords.mat');

% epipolar Correspondence
[pts2] = epipolarCorrespondence(I1, I2, F, T.pts1); 
%[coordsIM1, coordsIM2] = epipolarMatchGUI(I1, I2, F);

% essential matrix
E = essentialMatrix(F, K.K1, K.K2); % 3*3

% triangulation 
%P1 = [E zeros(3,1)]; % 3*4
P1 = [eye(3) zeros(3,1)];
P2_group = camera2(E);
err_best = 10000;
min_neg_Z = 10000;

for i = 1:size(P2_group,3)
    
    P2 = P2_group(:,:,i);
    p3d = triangulate(K.K1*P1, T.pts1, K.K2*P2, pts2); % N*3
    
    % project the 3D points back to the image
    n = size(p3d,1);
    p3d_ = [p3d zeros(n,1)]'; % 4*N
    p1_proj = P1*p3d_;  % 3*N
    p2_proj = P2*p3d_;  % 3*N
    
    % compute the mean Euclidean error between projected 2D points and pts
    err1 = norm(sqrt((p1_proj-[T.pts1 zeros(n,1)].').^2));
    err2 = norm(sqrt((p2_proj-[pts2 zeros(n,1)].').^2));
    err = err1 + err2;

    neg_Z = length(find(p3d(:,3) < 0));
    % find the best P2
    if neg_Z < min_neg_Z
        min_neg_Z = neg_Z;
        err_best = err;
        P2_best = P2;
        pts3d = p3d;
    end
end

plot3(pts3d(:,1), pts3d(:,2), pts3d(:,3),'.', 'MarkerSize',15);

R1 = P1(:,1:3);
R2 = P2_best(:,1:3);

t1 = P1(:,end);
t2 = P2_best(:,end);

% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
