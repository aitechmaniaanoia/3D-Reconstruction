function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.
P = P/P(3,4);

u = dot(P(1,1:3),P(3,1:3)')./(norm(P(3,1:3))^2);
v = dot(P(3,1:3),P(2,1:3)')./(norm(P(3,1:3))^2);

alpha_u = norm(cross(P(1,1:3)',P(3,1:3)'))./(norm(P(3,1:3))^2);
alpha_v = norm(cross(P(3,1:3)',P(2,1:3)'))./(norm(P(3,1:3))^2);

tz = 1./norm(P(3,1:3));

% define the calibration matrix
K = [alpha_u 0 u;
     0 alpha_v v;
     0 0 1];
 
% define extrinsic matrix
%RT=inv(K)*P*tz;
Rt = K\P*tz;
t = Rt(:,4);
R = Rt(:,1:3);



% 
% [~,~,V] = svd(P);
% c = V(:,end);
% %c = c/c(4); % 4*1
% 
% K = zeros(size(P));
% R = zeros(size(P,2),size(P,2));
% 
% % QR decomposition
% for i = 1:size(P,1)
%     K(i,1) = P(i,1)/norm(P(:,1));
% end
% 
% for j = 2:size(P,2)
%    sum = zeros(size(P,1),1); 
%    for k = 1:j-1
%        sum = sum + (P(:,j)'*K(:,k))*K(:,k);
%    end
%    z = P(:,i)-sum;
%    
%    for s = 1:size(P,1)
%        K(s,j) = z(s)/norm(z);
%    end
% end
% 
% % calculate R
% for i = 1:size(P,1)
%     for j = i:size(P,2)
%         R(i,j) = K(:,i)'*P(:,j);
%     end
% end
% 
% % calculate t
% t = -R*c;
end
