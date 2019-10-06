# [Panoramic-Image-Stitching](https://github.com/haofengsiji/Panoramic-Image-Stitching)
This is the implement of my visual computing class CA1.I sincerely hope we can learn from the open source. : )

My teacher's class link: [here](https://tanrobby.github.io/teaching/ece_visual/index.html) (I hope you can enjoy the class like me.)

## Part-1: 2D Convolution

Change the size of **the sobel kernel** by setting `s_size = value`

Change the size of **the gaussian kernel** by setting `g_size = value`

Change the size of **the 5 haar-like kernel** by setting `h_size = value`

Run the file `kernal.m` to see the result.

## Part-2: SIFT Features and Descriptors

My code references from **[Demo Software: SIFT Keypoint Detector](https://www.cs.ubc.ca/~lowe/keypoints/)**. What's more , I also used `sift.m` and `siftWin32.exe` as the core part of SIFT Features and Descriptors.  **Please use Demo carefully, the author has the patent of Demo Software.**

My work is only to show descriptors  on the image by using SIFT Demo. 

Run the file `sift_application.m` to see  the result.

## Part-3: Homography

Run the file `Homography_GUI.m`  to activate GUI.

In the GUI:

​	**Transform image1 to image2 -README**

​	1. Fill in the 1st image name in the left text box of 'show image1'

​	2. Click 'show image1'

​	3. Fill in the 2nd image name in the left text box of 'show image1'

​	4. Click 'show image2' 

​	5. Click 'choose points 1' to choose 4 reference points in image1

​	6. Click 'choose points 2' to choose 4 reference points in image2

	7. Click 'Transform 1 to 2' to see the result.

## Part-4 Manual Homography + Sticthing

Run the file `M_H.m` to manually choose transform pairs to get images cache firstly.

Then run the file `sticthing.m` to see the stitching image

## Part-5 Homography + RANSAC

Run the file `match_xzf.m` to automatically choose best homography matrix, show the match lines and get images cache firstly.

Then run the file `sticthing.m` to see the stitching image

## Part-6 Basic Panoramic Image

Run the file `ordered_stitch.m` to see the result.

