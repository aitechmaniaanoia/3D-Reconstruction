function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).
c1 = -(K1*R1)^(-1)*K1*t1;
c2 = -(K2*R2)^(-1)*K2*t2;

%b = norm(c1,c2);
b = norm(sqrt((c1-c2).^2));
f = K1(1,1);
depthM = zeros(size(dispM));

for y = 1:size(dispM,1)
    for x = 1:size(dispM,2)
        if dispM(y,x) == 0
            depthM(y,x) = 0;
        else
            depthM(y,x) = b*f/dispM(y,x);
        end
    end
end
end
