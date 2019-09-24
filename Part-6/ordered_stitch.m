% read images
im1_name = 'im01.jpg';
im2_name = 'im02.jpg';
im3_name = 'im03.jpg';
im4_name = 'im04.jpg';
im5_name = 'im05.jpg';
im1 = imread(im1_name);
im2 = imread(im2_name);
im3 = imread(im3_name);
im4 = imread(im4_name);
im5 = imread(im5_name);


H54 = H_finder(im5,im4);
[im54] = stitch(im5,im4,H54);
H43 = H_finder(im54,im3);
[im543] = stitch(im54,im3,H43);
H12 = H_finder(im1,im2);
[im12] = stitch(im1,im2,H12);
H54312 = H_finder(im543,im12);
[im12543] = stitch(im543,im12,H54312);

% cut the black frame
[row,col] = find(sum(im12543,3)~=0);
im_pan = im12543(min(row):max(row),min(col):max(col),:);
figure();imshow(im_pan)