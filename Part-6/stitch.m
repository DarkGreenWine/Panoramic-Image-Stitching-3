%[J] = stitch(im1,im2,H)
%
% This is function to sticthing two images
%   Input parameters:
%     im1: the matrix of image1.
%     im2: the matrix of image2.
%     H: the Homography matrix transforming image1 to image2
%     
%   Returned:
%     sti_im: the stitching image

function [sti_im] = stitch(im1,im2,H)
% construct the canvas
[h,w,~] = size(im1);
im_x1 = [0; w; w; 0];
im_y1 = [[0; 0; h; h]];
temp = [im_x1,im_y1,[1;1;1;1]]*H;
temp = temp./repmat(temp(:,3),1,3);
im_x2 = temp(:,1);
im_y2 = temp(:,2);
x_min = int32(min([im_x1,im_x2],[],'all'));
y_min = int32(min([im_y1,im_y2],[],'all'));
x_max = int32(max([im_x1,im_x2],[],'all'));
y_max = int32(max([im_y1,im_y2],[],'all'));
sti_im = zeros(y_max-y_min+1,x_max-x_min+1,3,'uint8'); % plus 1 to round up 

% painting image2 on the canvas
[h1,w1,~]=size(im2);
for h=1:h1
    for w=1:w1
        sti_im(h-y_min,w-x_min,:) = im2(h,w,:);
    end
end


% Homography
tform1 = projective2d(H);
J = imwarp(im1,tform1);
% painting J on the canvas
x2_min = int32(min(im_x2,[],'all'));
y2_min = int32(min(im_y2,[],'all'));
[h2,w2,~]=size(J);

for h=1:h2
    for w=1:w2
        
        if sum(J(h,w,:)) ~= 0
            % overlapping
            if sum(sti_im(h+y2_min-y_min,w+x2_min-x_min,:),'all') ~= 0 && sum(J(h,w,:),'all') ~= 0
                sti_im(h+y2_min-y_min,w+x2_min-x_min,:) = sti_im(h+y2_min-y_min,w+x2_min-x_min,:)./2+J(h,w,:)./2;
            % nonoverlapping
            else
                sti_im(h+y2_min-y_min,w+x2_min-x_min,:) = J(h,w,:);
            end
        end
        
    end
end





