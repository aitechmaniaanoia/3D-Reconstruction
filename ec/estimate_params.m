function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.
[~,~,V] = svd(P);
c = V(:,end);
%c = c/c(4); % 4*1

K = zeros(size(P));
R = zeros(size(P,2),size(P,2));

% QR decomposition
for i = 1:size(P,1)
    K(i,1) = P(i,1)/norm(P(:,1));
end

for j = 2:size(P,2)
   sum = zeros(size(P,1),1); 
   for k = 1:j-1
       sum = sum + (P(:,j)'*K(:,k))*K(:,k);
   end
   z = P(:,i)-sum;
   
   for s = 1:size(P,1)
       K(s,j) = z(s)/norm(z);
   end
end

% calculate R
for i = 1:size(P,1)
    for j = i:size(P,2)
        R(i,j) = K(:,i)'*P(:,j);
    end
end

% calculate t
t = -R*c;
end
