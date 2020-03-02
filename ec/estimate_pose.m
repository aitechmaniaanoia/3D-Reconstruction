function P = estimate_pose(x, X)
% x : 2*N (x,y) points in image
% X: 3*N (x,y,z) 3d points

n = size(x,2);
A = [];
b = [];

for i = 1:n
    pt_3d = X(:,i);
    pt_2d = x(:,i);
    
    a1 = [pt_3d(1) pt_3d(2) pt_3d(3) 1 0 0 0 0 -pt_2d(1)*pt_3d(1) -pt_2d(1)*pt_3d(2) -pt_2d(1)*pt_3d(3)]; 
    a2 = [0 0 0 0 pt_3d(1) pt_3d(2) pt_3d(3) 1 -pt_2d(2)*pt_3d(1) -pt_2d(2)*pt_3d(2) -pt_2d(2)*pt_3d(3)];
    
    A = [A; a1; a2];
    
    b = [b; pt_2d(1); pt_2d(1)];
end

P = A\b;
P = [P;1];
P = reshape(P,[],3)';

end