clear
clc
% Get the manual keypoints.
image1 = imread('im02.jpg');
f1 = figure();imshow(image1);
image2 = imread('im01.jpg');
f2 = figure();imshow(image2);
figure(f1)
axis on
[x1,y1] = ginput(4);

figure(f2)
axis on
[x2,y2] = ginput(4);

% Construct A 
A = zeros(8,9);
for i = 1:4
    A(2*i-1:2*i,:) = [x1(i) y1(i) 1 0 0 0 -x1(i)*x2(i) -x2(i)*y1(i) -x2(i);
                    0 0 0 x1(i) y1(i) 1 -y2(i)*x1(i) -y2(i)*y1(i) -y2(i)];
end
[~,~,V] = svd(A);
p = V(:,9);
H = reshape(p,3,3)/p(9);
% 'projective'
%   Use this transformation when the scene appears tilted. Straight lines remain straight,
%   but parallel lines converge toward a vanishing point.
% comparing with offical funcation for degbug
tform = fitgeotrans([x1,y1],[x2,y2],'projective');

% h(1:2,3)=0; % it will become affine2d if you decomment this line

% MY BLOOD LESSEON:
%   DONT USE affine2d
%   dont make h[1:2.3]=0, it will become affine2d.!!!!!
%   That will lose information that makes projective vianish into a
%   point!!!

tform1 = projective2d(H);
% imwarp also additionally shift your image central align 
% so orignal shift coordinate needs to be calculated by ourself.
J = imwarp(image1,tform1); % I used my h not the offical one.
figure();imshow(J);
axis on

% STICTHING


