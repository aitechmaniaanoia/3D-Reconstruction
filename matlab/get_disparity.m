function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.
dispM = zeros(size(im1));
w = (windowSize - 1)/2;
[y_max, x_max] = size(im1);

% add padding on image
im1 = padarray(im1, [round(w),round(w)]);
im2 = padarray(im2, [round(maxDisp/2),round(maxDisp/2)]);

%window = ones(windowSize, windowSize);
%min_dist = 100000;

for y = 1+w : y_max-w
    for x = 1+w : x_max-w

        y_block = y-w+maxDisp/2;
        x_block = x-w+maxDisp/2;

        im1_patch = im1(y-w:y+w, x-w:x+w);
        window = im2(y_block-maxDisp/2:y_block+maxDisp/2-1, x_block-maxDisp/2:x_block+maxDisp/2-1);

        min_dist = 10000;

        for k = 1:maxDisp-windowSize
            for s = 1:maxDisp-windowSize
                im2_patch = window(k:k+windowSize-1, s:s+windowSize-1);
                dist = sum(sum((im1_patch - im2_patch).^2));
        
                if dist < min_dist
                    min_dist = dist;
                    %max_1 = k;
                    %max_2 = s;
                end
            end
        end
        
        dispM(y-w,x-w) = min_dist;
    end
end

end
