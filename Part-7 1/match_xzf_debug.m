im1 = 'test.jpg';
im1 = imread(im1);
[~, des1, loc1] = sift(im1);
im2 = 'test1.jpg';
im2 = imread(im2);
[~, des2, loc2] = sift(im2);
% im1 = im543;
% im2 = im12;
% [~, des1, loc1] = sift(im1);
% [~, des2, loc2] = sift(im2);


rows1 = size(im1,1);
rows2 = size(im2,1);

if (rows1 < rows2)
     im1(rows2,1) = 0;
else
     im2(rows1,1) = 0;
end
% appending two images
im3 = [im1 im2]; 

% using cosine similarity to measure the match descriptors
% this is very smart to save the time for calculting the distance
 
match = zeros(size(des1,1),1);
for i=1:size(des1,1)
    dists = des1(i,:)*des2.';
    [vals, idx] = sort(dists,'descend');
    % I used similarity threshold to drop match
    % I think my method is more clear
    
%     % 1. vals > 0.972 to match 
%     %   this threshold is chosen manually by leaving about 100 candidate
%     % 2. 0.95*vals(1)>vals(2) to avoid disturbance
%     %   this threshold is chosen manually by leaving about 25 candidate
%     % hahaha, I still can get good pairs by using these without RANSAC
%     if vals(1) > 0.972 && 0.95*vals(1)>vals(2)
%         match(i) = idx(1);
%     end
    
    % TO STUDY RANSAC
    %   I think SIFT didnt do good cornor detection!!!!
    %   It causes that I have keypoints of objects like small dots  in my descriptors
    %   These dots is realy disgusting !!!!
    %   These dots fails my RANSAC!!!!
    %   && loc1(i,3)>2 && loc2(i,3) > 2 to avoid keypoints of objects like small dots 
    if 0.95*vals(1)>vals(2)
        match(i) = idx(1);
    end
end

% Show a figure with lines joining the accepted matches.
figure('Position', [100 100 size(im3,2) size(im3,1)]);
imagesc(im3);
hold on;
cols1 = size(im1,2);
for i = 1: size(des1,1)
  if (match(i) > 0)
    line([loc1(i,2) loc2(match(i),2)+cols1], ...
         [loc1(i,1) loc2(match(i),1)], 'Color', 'c');
  end
end
hold off;
num = sum(match > 0);
fprintf('Found %d matches.\n', num);

% RANSAC
best_H = 0;
best_count = 0;
match_idx = find(match>0);
% iteration
for iter=1:10000
    idx = randsample(match_idx,5)
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
        scale = 1/v1(3);
        v1 = v1(1:2)/v1(3);
        if norm(v1-v2, 2) < 0.03 && size(find(match==match(i)),1)==1
            inliers_count = inliers_count + 1;
        end
    end
    if best_count < inliers_count
       best_count = inliers_count;
       best_H = H;
    end
end

% inliers match
best_match = match;
inliers_count = 0;
for i = match_idx.'
        v1 = loc1(i,2:-1:1);
        v2 = loc2(match(i),2:-1:1);
        v1 = [v1 1]*best_H;
        v1 = v1(1:2)/v1(3);
        % tolerance can not be really small, or you only get dots
        if norm(v1-v2, 2) > 1
            best_match(i) = 0;
        end
end 

% Show a figure with lines joining inlier matches.
figure('Position', [100 100 size(im3,2) size(im3,1)]);
imagesc(im3);
hold on;
cols1 = size(im1,2);
for i = 1: size(des1,1)
  if (best_match(i) > 0)
    line([loc1(i,2) loc2(best_match(i),2)+cols1], ...
         [loc1(i,1) loc2(best_match(i),1)], 'Color', 'c');
  end
end
hold off;
inlier_num = sum(best_match > 0);
fprintf('Found %d inliner matches.\n', inlier_num);

% Homography
tform1 = projective2d(best_H);
J = imwarp(im1,tform1);
