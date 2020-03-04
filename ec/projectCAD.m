clear all;

pnp = load('../data/PnP.mat');

P = estimate_pose(pnp.x, pnp.X);
[K, R, t] = estimate_params(P);

n = size(pnp.X, 2); % 3*N
% Use P to project the X onto the image
X = [pnp.X ; ones(1,n)];  %4*N
p_proj = P*X;
p_proj(1,:) = p_proj(1,:)./p_proj(3,:);
p_proj(2,:) = p_proj(2,:)./p_proj(3,:);
p_proj = p_proj(1:2, :);

% Plot x and the projected 3D points on screen (plot)

% x = [pnp.x ; ones(1,n)]';
% imshow(pnp.image,[]); hold on;
% xlabel({'Plot given x and projected 3D points'});
% plot(pnp.x(1,:),pnp.x(2,:), 'b.');
% plot(p_proj(1,:), p_proj(2,:), 'yo');

% Draw the CAD model rotated by your estimated rotation R on screen (trimesh)

% face = pnp.cad.faces;
% vertices = R*pnp.cad.vertices';
% trimesh(face,vertices(1,:),vertices(2,:),vertices(3,:));

% Project the CADs all vertices onto the image and draw the projected CAD model 
% overlapping with the 2D image (patch)

N = size(pnp.cad.vertices,1);
%P = P/P(end,end);
vertices_proj = P*[pnp.cad.vertices ones(N,1)]';
%vertices_proj = vertices_proj./vertices_proj(3,:);
vertices_proj(1,:) = vertices_proj(1,:)./vertices_proj(3,:);
vertices_proj(2,:) = vertices_proj(2,:)./vertices_proj(3,:);
vertices_proj = vertices_proj(1:2, :);

imshow(pnp.image, []); hold on;
patch('XData', vertices_proj(1,:), 'YData', vertices_proj(2,:));



