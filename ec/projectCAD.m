clear all;

pnp = load('../data/PnP.mat');

P = estimate_pose(pnp.x, pnp.X);
[K, R, t] = estimate_params(P);

n = size(pnp.X, 2); % 3*N
% Use P to project the X onto the image
X = [pnp.X ; zeros(1,n)];  %4*N
p_proj = P*X;
p_proj = p_proj/p_proj(3,:);

% Plot x and the projected 3D points on screen (plot)
x = [pnp.x ; ones(1,n)]';
imshow(pnp.image,[]); hold on;
plot(round(x), 'r.');
xlabel({'plot given x and projected 3D points'})

% Draw the CAD model rotated by your estimated rotation R on screen (trimesh)

% Project the CAD’s all vertices onto the image and draw the projected CAD model 
% overlapping with the 2D image (patch)



