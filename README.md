# Hu-s-Invariant-Moments-in-MATLAB
An improved and tested code to produce Hu's Invariant moments for any Image/ Audio signals. One of the Best Feature Extraction Techniques. 

In order to understand the program first look through the basic concept of Hu's moments.
https://en.wikipedia.org/wiki/Image_moment

First download all three matlab files into your directory, 
open hu_moments.m file 
In the 1st command change the imagename/ audioname etc which u want to give as input
Just run the code and relax. You will be displayed with the features once the execution is done.


The skeleton of the code was initially taken from Mathworks.inc. However, there were some serious errors in the code including errors in the formula itself.
Those errors were then modified and later code was optimised for my purpose and to further reduce the features as much as possible to reduce computational cost.

These features obtained at the end of the program can be used efficiently for facerecognition/ CMFD etc. Since the number of features per image are extremely low, the process of searching a similar face from millions of faces in the database would considerably be much faster than its fellow feature extraction based algorithms such as DCT, SVD, SWT, DWT, DyWT, SIFT, SURF, BRISK, FREAK etc.

For further doubts contact me at tejastk.reddy@gmail.com
