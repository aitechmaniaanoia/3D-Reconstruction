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
w = 8;
n = size(pts1,1);
pts2 = [];
%[sy,sx]= size(im2);

% convert pts to [x y 1] and shape to 3*N
pts1 = [pts1 ones(n,1)].';

for i = 1:n
pt1 = pts1(:,i);
eline = F*pt1;
s = norm(eline(1:2));
%s = sqrt(pt1(1)^2+pt1(2)^2);
eline = eline/s;  % 3*1
% generate a set of points
test = [-eline(2) eline(1) eline(2)*pt1(1)-eline(1)*pt1(2)]';
pt_proj = round(cross(eline, test));

im1_kernel = double(im1((pt1(1)-w):(pt1(1)+w), (pt1(2)-w):(pt1(2)+w)));
best_e = 10000;

kernel_size = 2*w + 1;
gaussian_kernel = fspecial('gaussian', [kernel_size kernel_size], 5);

for k = pt_proj(1)-20:pt_proj(1)+20
    for j = pt_proj(2)-20:pt_proj(2)+20 
        im2_kernel = double(im2(k-w:k+w,j-w:j+w));
        e = norm(gaussian_kernel .*(im1_kernel - im2_kernel));
        if e < best_e
            best_e = e;
            %pts2 = [pts2; k, j];
            pt2_x = k;
            pt2_y = j;
        end
    end
end
pts2 = [pts2; pt2_x pt2_y];
end
end
% 
% for i = 1:n
%     pt1 = pts1(:,i);
%     %p = pt1.'*F;
%     p = F*pt1;
%     dist = sqrt(p(1)^2+p(2)^2);
%     p = p/dist;
% 
%     % line([xs xe],[ys ye]);
%     if p(1) ~= 0
%         ye = sy;
%         ys = 1;
%         xe = -(p(2) * ye + p(3))/p(1);
%         xs = -(p(2) * ys + p(3))/p(1);
%     else
%         xe = sx;
%         xs = 1;
%         ye = -(p(1) * xe + p(3))/p(2);
%         ys = -(p(1) * xs + p(3))/p(2);
%     end
% 
%     % line y = ax+b;
%     a = (xe-ye)/();
%     b = ;
%     eline =  line([xs xe],[ys ye]);
% 
%     % generate a set of candidate points
%     pt2 = [];
% 
%     % choose the best matched points
%     %pt2 = ...;
%     
%     %pts2 = [pts2; pt2];
%     
% end
% pts2(:,3) = []; % N*3







