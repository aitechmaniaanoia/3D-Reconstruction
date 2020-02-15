% A test script using templeCoords.mat
% Write your code here
close all;
clear all;

%load('../data/someCorresp.mat'); ????
I1 = imread('../data/im1.png');
I2 = imread('../data/im2.png');

M = size(I1);

F = eightpoint(I1, I2, M);

displayEpipolarF(I1, I2, F);


% save extrinsic parameters for dense reconstruction
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
