function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%
n = size(pts1, 1);

% convert p to [x y 1] and shape to 3*N
pts1 = [pts1 ones(n,1)].';
pts2 = [pts2 ones(n,1)].';

pts3d = zeros(4,n);

for i = 1:n
    pt1 = pts1(:,i);
    pt2 = pts2(:,i);
    pt1_m = [0      1       -pt1(2); 
             -1     0       pt1(1); 
             pt1(2) -pt1(1) 0];
    pt2_m = [0      1       -pt2(2);
             -1     0       pt2(1);
             pt2(2) -pt2(1) 0];
 
    A = [pt1_m*P1; pt2_m*P2];

%     A = zeros(4,4);
%     A(1,:) = pt1(2)*P1(3,:) - P1(2,:);
%     A(2,:) = P1(1,:) - pt1(1)*P1(3,:);
%     A(3,:) = pt2(2)*P2(3,:) - P2(2,:);
%     A(4,:) = P2(1,:) - pt2(1)*P2(3,:);

%      A = [P1(3,:) * pt1(1) - P1(1,:);
%           P1(3,:) * pt1(2) - P1(2,:);
%           P2(3,:) * pt2(1) - P2(1,:);
%           P2(3,:) * pt2(2) - P2(2,:)];

    [~,~,V] = svd(A);
    z = V(:,end);
    pts3d(:,i) = z/z(4); % 4*N
end

pts3d(4,:) = [];
pts3d = pts3d'; % N*3
end



