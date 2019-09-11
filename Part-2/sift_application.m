image_file = 'im01.jpg';
[image, descriptors, locs] = sift(image_file);
cimage = imread(image_file);
[rows, cols] = size(image);
myshowkeys(image, cimage, locs, descriptors)

% myshowkeys(image, locs)
%
% This is the function read an image ,keypoint locatlization, and its
% descriptors. Then returns the image with descriptor boxes and arrows of HoG on it.
%   Input parameters:
%     image: the filename for the image
%     locs: matrix where each row gives the keypoint location (row, column,
%     scale, rotation) info.
%     descrpitor: matrix where each row gives the keyoint 
function myshowkeys(image,cimage, locs, descriptors)

disp('Drawing SIFT keypoints ...');

% Draw image with keypoints
figure('Position', [50 50 size(image,2) size(image,1)]);
imagesc(cimage);
hold on;
scale_num = 20; % reduce the descriptor's num for comfortable view
for i = 1: size(locs,1)/scale_num
    % Draw the descriptor's boundary.
    myTransformLine(locs(i*scale_num,:), 0.0-2, 0.0-2, 4.0-2, 0.0-2,0);
    myTransformLine(locs(i*scale_num,:), 0.0-2, 0.0-2, 0.0-2, 4.0-2,0);
    myTransformLine(locs(i*scale_num,:), 4.0-2, 0.0-2, 4.0-2, 4.0-2,0);
    myTransformLine(locs(i*scale_num,:), 0.0-2, 4.0-2, 4.0-2, 4.0-2,0);
    % Draw the descriptor's grid
    %   row
    for r = 1:3
    myTransformLine(locs(i*scale_num,:), 0.0-2, 0.0-2+r, 4.0-2, 0.0-2+r,0);
    end
    %   column
    for c = 1:3
    myTransformLine(locs(i*scale_num,:), 0.0-2+c, 0.0-2, 0.0-2+c, 4.0-2,0);
    end
    des = reshape(descriptors(i*scale_num,:),4,4,8);
    for ii = 1:4
        for jj = 1:4
            for d = 1:8
                deg = (d-1)*pi/4;
                % offset + scale*[roatation]X[x, y]
                a1 = [-1.5+ii-1;1.5-jj+1]+des(ii,jj,d)*[cos(deg) -sin(deg); sin(deg) cos(deg)]*[0.0 ; 0.0];
                a2 = [-1.5+ii-1;1.5-jj+1]+des(ii,jj,d)*[cos(deg) -sin(deg); sin(deg) cos(deg)]*[1.0 ; 0.0];
                a3 = [-1.5+ii-1;1.5-jj+1]+des(ii,jj,d)*[cos(deg) -sin(deg); sin(deg) cos(deg)]*[0.85 ; 0.1];
                a4 = [-1.5+ii-1;1.5-jj+1]+des(ii,jj,d)*[cos(deg) -sin(deg); sin(deg) cos(deg)]*[0.85 ; -0.1];
                myTransformLine(locs(i*scale_num,:), a1(1,1), a1(2,1), a2(1,1), a2(2,1),1);
                myTransformLine(locs(i*scale_num,:), a3(1,1), a3(2,1), a2(1,1), a2(2,1),1);
                myTransformLine(locs(i*scale_num,:), a4(1,1), a4(2,1), a2(1,1), a2(2,1),1);
            end
        end
    end
end
hold off;
end

function myTransformLine(keypoint, x1, y1, x2, y2,is_arrow)

% The scaling of the unit length arrow is set to approximately the radius
%   of the region used to compute the keypoint descriptor.
len = 3*keypoint(3);

% Rotate the keypoints by 'ori' = keypoint(4)
s = sin(keypoint(4));
c = cos(keypoint(4));

% Apply transform
r1 = keypoint(1) + len * (c * y1 + s * x1);
c1 = keypoint(2) + len * (- s * y1 + c * x1);
r2 = keypoint(1) + len * (c * y2 + s * x2);
c2 = keypoint(2) + len * (- s * y2 + c * x2);
if is_arrow
    line([c1 c2], [r1 r2], 'Color', 'c');
elseif len > 20
    line([c1 c2], [r1 r2], 'Color', 'r');
elseif len > 1
    line([c1 c2], [r1 r2], 'Color', 'y');
else
    line([c1 c2], [r1 r2], 'Color', 'b');
end
end


