% A test script using templeCoords.mat
% Write your code here
close all;
clear all;

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
[coordsIM1, coordsIM2] = epipolarMatchGUI(I1, I2, F);



% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
