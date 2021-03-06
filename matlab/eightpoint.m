function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

n = size(pts1,1);

% normalize
p1 = pts1./M;
p2 = pts2./M;

% convert pts to [x y 1] and shape to 3*N
p1 = [p1 ones(n,1)].';
p2 = [p2 ones(n,1)].';

% normalize matrix
T = [1/M 0 0; 
     0 1/M 0;
     0 0 1];

% build A matrix [x*x', x*y', x, y*x', y*y', y, x', y', 1]
A = [];
for i = 1:n
    %A = [A ;p1(1,i)*p2(1,i) p1(1,i)*p2(2,i) p1(1,i) p1(2,i)*p2(1,i) p1(2,i)*p2(2,i) p1(2,i) p2(1,i) p2(2,i) 1];
    A = [A ;p2(1,i)*p1(1,i) p2(1,i)*p1(2,i) p2(1,i) p2(2,i)*p1(1,i) p2(2,i)*p1(2,i) p2(2,i) p1(1,i) p1(2,i) 1];

end

% svd of A
[~,~,V] = svd(A);
F = [V(1, 9) V(2, 9) V(3, 9);
     V(4, 9) V(5, 9) V(6, 9); 
     V(7, 9) V(8, 9) V(9, 9)];
% enforce rank 2 constraint on F
[u,s,v] = svd(F);
s(3,3) = 0;
F = u*s*v';
% call refineF before unscaling F
%F = refineF(F,pts1,pts2);
% de-normalize
F = T'*F*T;
end

