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
n = size(pts1,1);
% convert pts to [x y 1] and shape to 3*N
pts1 = [pts1 ones(n,1)].';

line2 = pts1.'*F;

% choose best matched points




