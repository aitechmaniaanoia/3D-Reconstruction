function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
w = 3;
n = size(pts1,1);
pts2 = [];
% convert pts to [x y 1] and shape to 3*N
pts1 = [pts1 ones(n,1)].';

for i = 1:n
    pt1 = pts1(:,i);
    line2 = pt1.'*F;

    % generate a set of candidate points
    pt2 = [];

    % choose the best matched points
    %pt2 = ...;
    
    %pts2 = [pts2; pt2];
    
end
%pts2 = pts1.'*F;
pts2(:,3) = []; % N*3







