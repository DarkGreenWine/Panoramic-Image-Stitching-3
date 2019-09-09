clear
clc
% Implement of classical kernals
% Author: Xin Zhengfang

% DATA PREPROCESSING
%   Image read
I = imread('Notre Dame de Paris.jpg');  %Assassin's Creed@ Unity's image from my game screenshot
%   use grey image for quick and easy study
%   nomalize image
I = double(rgb2gray(I))/255;
[height, width] = size(I);


% SOBEL KERNAL
%   the vaule of s_size must be 1,2,3,4,5,...,n 
%   if s_size = 1 which means sobel kernal size is 3X3
s_size = 1;     %########################################################## Please edit size here
                %##########################################################
% Construct the sobel kernal x and y
s_kernel_size = 2*s_size+1;
left = ones(2*s_size+1,1);
right = zeros(1,2*s_size+1);
left(s_size + 1) =  2;
for i = 1:(2*s_size+1)
    right(1,i) = i-(s_size+1);
end
sobel_kernal_y = left*right;
sobel_kernal_x = right.'*left.';
% Convlution implement
%   stride is xzfixed to 1 for simple and easy study
output_height = (height-(2*s_size+1))/1 + 1;
output_width = (width-(2*s_size+1))/1 + 1;
output_x = zeros(output_height,output_width);
output_y = zeros(output_height,output_width);
%for each pixzf of output_image
for i = 1:output_height
    for j = 1:output_width
        output_y(i,j) = sum(double(I(i:i+2*s_size,j:j+2*s_size)).*sobel_kernal_y,'all');
        output_x(i,j) = sum(double(I(i:i+2*s_size,j:j+2*s_size)).*sobel_kernal_x,'all');
    end
end
figure;imshow(I)
figure;imshow(output_y)
figure;imshow(output_x)
figure;imshow(output_y+output_x) % very beautiful! I like this one!


% GAUSSIAN KERNEL
%   the value of g_size is 1,2,3,..,n
%   if g_size = 1 which means the gaussian kernal size is 3x3
g_size = 4;     %########################################################## Please edit size here
                %##########################################################
% Construct the gaussian kernal
%   explanation:[http://songho.ca/dsp/convolution/convolution.htmltion]
g_kernal_size = 2*g_size+1;
left = zeros(g_kernal_size,1);
for i = 1:g_size+1
    left(i) = i;
end
for i = g_kernal_size:-1:g_size+1
    left(i) = g_kernal_size+1-i;
end
gaussian_kernel = left*left.';
gaussian_kernel = gaussian_kernel/max(gaussian_kernel,[],'all');
% Convlution implement
%   same as before
output_height = (height-(2*g_size+1))/1 + 1;
output_width = (width-(2*g_size+1))/1 + 1;
output = zeros(output_height,output_width);
for i = 1:output_height
    for j = 1:output_width
        %   /sum(gaussian_kernel,'all') is because of sum, and this is important to avoid
        %   image to become too bright or too dark
        %   I spend a lot of time figuring this out to avoid extreme.
       output(i,j) = sum(double(I(i:i+2*g_size,j:j+2*g_size)).*gaussian_kernel,'all')/sum(gaussian_kernel,'all');
    end
end
figure;imshow(output)

% THE 5 HAAR-LIIKE MASKS
%   the h_size value is 1,2,3...,n
%   if h_size = 1, which means 1-type-A haar mask size = 2x1, 1-type-B mask
%       szie = 1x2, 2-type-A haar mask size = 3x1, xzf 2-type-B mask size = 1x3
%       ,and 3-type haar mask = 2x2
%   haar like feature explanation[https://www.youtube.com/watch?v=F5rysk51txQ]
h_size = 1;     %########################################################## Please edit size here
                %########################################################## 
% Construct kernal
haar_kernel1 = -ones(2*h_size,1*h_size); % 1-type-A
haar_kernel2 = -ones(1*h_size,2*h_size); % 1-type-B
haar_kernel3 = -ones(3*h_size,1*h_size); % 2-type-A
haar_kernel4 = -ones(1*h_size,3*h_size); % 2-type-B
haar_kernel5 = -ones(2*h_size,2*h_size); % 3-type
%   1-type-A/B haar mask
for i = 1:h_size
    for j = 1:h_size
        haar_kernel1(i,j)=1;
        haar_kernel2(i,j)=1;
    end
end
%   2-type-A haar mask
for i = 1+h_size:2*h_size
    for j = 1:h_size
        haar_kernel3(i,j)=2;
    end
end
%   2-type-B haar mask
for i = 1:h_size
    for j = 1+h_size:2*h_size
        haar_kernel4(i,j)=2; % =2 the trick to avoid all black or all white
    end
end
%   3-type haar mask
for i = 1:h_size
    for j=1:h_size
        haar_kernel5(i,j)=1;
        haar_kernel5(i+h_size,j+h_size)=1;
    end
end
% Convlution implement
output_height1 = (height-(2*h_size))/1 + 1;
output_width1 = (width-(1*h_size))/1 + 1;
output_height2 = (height-(1*h_size))/1 + 1;
output_width2 = (width-(2*h_size))/1 + 1;
output_height3 = (height-(3*h_size))/1 + 1;
output_width3 = (width-(1*h_size))/1 + 1;
output_height4 = (height-(1*h_size))/1 + 1;
output_width4 = (width-(3*h_size))/1 + 1;
output_height5 = (height-(2*h_size))/1 + 1;
output_width5 = (width-(2*h_size))/1 + 1;
output1 = zeros(output_height1,output_width1);
output2 = zeros(output_height2,output_width2);
output3 = zeros(output_height3,output_width3);
output4 = zeros(output_height4,output_width4);
output5 = zeros(output_height2,output_width5);
for i = 1:output_height1
    for j = 1:output_width1
        output1(i,j) = sum(double(I(i:i+2*h_size-1,j:j+1*h_size-1)).*haar_kernel1,'all');
    end
end
for i = 1:output_height2
    for j = 1:output_width2
        output2(i,j) = sum(double(I(i:i+1*h_size-1,j:j+2*h_size-1)).*haar_kernel2,'all');
    end
end
for i = 1:output_height3
    for j = 1:output_width3
        output3(i,j) = sum(double(I(i:i+3*h_size-1,j:j+1*h_size-1)).*haar_kernel3,'all');
    end
end
for i = 1:output_height4
    for j = 1:output_width4
        output4(i,j) = sum(double(I(i:i+1*h_size-1,j:j+3*h_size-1)).*haar_kernel4,'all');
    end
end
for i = 1:output_height5
    for j = 1:output_width5
        output5(i,j) = sum(double(I(i:i+2*h_size-1,j:j+2*h_size-1)).*haar_kernel5,'all');
    end
end
figure;imshow(output1)
figure;imshow(output2)
%min_size = min(output_height1,output_width1);
%figure;imshow(output1(1:min_size,1:min_size)+output2(1:min_size,1:min_size))% the edge is more accurate than sobel
figure;imshow(output3)
figure;imshow(output4)
figure;imshow(output5)



















