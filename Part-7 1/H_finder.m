%[best_H] = H_finder(image_file1,image_file2)
%
% This is function to find best homography matrix from image1 to image2
%   Input parameters:
%     im1: the matrix of image1.
%     im2: the matrix of image2.
%   Returned:
%     best_H: the best homography matrix from image1 to image2

function [best_H,best_count] = H_finder(im1,im2)
[~, des1, loc1] = sift(im1);
[~, des2, loc2] = sift(im2);
% using cosine similarity to measure the match descriptors
% this is very smart to save the time for calculting the distance

match = zeros(size(des1,1),1);
for i=1:size(des1,1)
    dists = des1(i,:)*des2.';
    [vals, idx] = sort(dists,'descend');
    
    % I used similarity threshold to drop match
    % I think my method is more clear
    if 0.95*vals(1) > vals(2)
        match(i) = idx(1);
    end
end
num = sum(match > 0);
fprintf('Found %d matches.\n', num);

% RANSAC
best_H = 0;
best_count = 0;
match_idx = find(match>0);
% iteration
for iter=1:10000
    idx = randsample(match_idx,5);
    y1 = loc1(idx,1);
    x1 = loc1(idx,2);
    y2 = loc2(match(idx),1);
    x2 = loc2(match(idx),2);
    % Construct A 
    A = zeros(8,9);
    for i = 1:5
        A(2*i-1:2*i,:) = [x1(i) y1(i) 1 0 0 0 -x1(i)*x2(i) -x2(i)*y1(i) -x2(i);
                        0 0 0 x1(i) y1(i) 1 -y2(i)*x1(i) -y2(i)*y1(i) -y2(i)];
    end
    [~,~,V] = svd(A);
    p = V(:,9);
    H = reshape(p,3,3)/p(9);
    inliers_count = 0;
    for i = match_idx.'
        v1 = loc1(i,2:-1:1);
        v2 = loc2(match(i),2:-1:1);
        v1 = [v1 1]*H;
        v1 = v1(1:2)/v1(3);
        % This time I use `size(find(match==match(i)),1)==1` to avoid
        % project into a point
        if norm(v1-v2, 2) < 1 && size(find(match==match(i)),1)==1
            inliers_count = inliers_count + 1;
        end
    end
    if best_count < inliers_count
       best_count = inliers_count;
       best_H = H;
    end
end
fprintf('Found %d inliner matches.\n', best_count);


