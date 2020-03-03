clear all;

pnp = load('../data/PnP.mat');

P = estimate_pose(pnp.x, pnp.X);
[K, R, t] = estimate_params(P);

n = size(pnp.X, 2); % 3*N
% Use P to project the X onto the image
X = [pnp.X ; zeros(1,n)];  %4*N
p_proj = P*X;
%p_proj = p_proj./p_proj(3,:);

% Plot x and the projected 3D points on screen (plot)
%x = [pnp.x ; ones(1,n)]';
imshow(pnp.image,[]); hold on;
plot(pnp.x(1,:),pnp.x(2,:), 'r.');
plot(p_proj(2,:), p_proj(1,:), 'b*');
xlabel({'Plot given x and projected 3D points'})

% Draw the CAD model rotated by your estimated rotation R on screen (trimesh)
%face = R*pnp.cad.faces';
face = R*pnp.cad.vertices';
%[x_,y_] = meshgrid(X(1,:),X(2,:));
tri = delaunay(face(1,:),face(2,:));
%z = face(:,3);
trimesh(tri,face(1,:),face(2,:),face(3,:));

% Project the CAD’s all vertices onto the image and draw the projected CAD model 
% overlapping with the 2D image (patch)




