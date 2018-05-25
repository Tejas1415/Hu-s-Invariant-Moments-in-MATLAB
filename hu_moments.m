% The skeleton of the code was taken from Mathworks.inc but there are several mistakes in that code, including mistakes in formula itself.
% The errors were corrected and code was further improved (made more efficient and robust for further analysis).
% Tejas K
% Jan 2018




%function  hu_moments_vector  = hu_moments( image )     % Use it as a function if need it that way.
clc
clear all                                               % Clean MATLAB environment for further execution.
close all


# Input an Image/ Audio signal or a matrix of any dimension to extract Hu's Moments from it.
i=imread('tamp7.jpg');               


%i= [ 1 2 3 4 5 6 7 8; 8 7 6 5 4 3 2 1; 1 3 2 4 5 7 6 8; 2 1 4 3 6 5 7 8; 143 234 32 23 45 43 233 144; 100 200 250 210 220 150 1 2; 1 2 3 4 5 6 7 7; 10 101 10 18 18 10 87 89]
%image = rgb2gray(i);
%image = [232.3750  -84.8231   -7.2605   14.6632  -15.6250    4.2057    0.4367   -1.4261
  -97.6312   -0.7064   19.0930    2.5346    3.0491    1.9681    2.4835   -3.3131
   16.1167   21.5494    5.8096  -11.5730    8.1380   -5.3363   -2.7652    2.3217
   -1.1350  -13.9768   -0.3398   -0.3787   -1.3860    3.5817    2.1123   -1.2197
    0.8750    5.6352    0.3547    0.6664    1.8750   -2.2608    0.5296   -1.1732
    0.0670   -1.7677    1.2096    1.5817    0.7018   -1.7249   -0.0810    0.9604
   -5.1874    3.4917    2.2348   -4.1844    2.9882   -0.5341   -3.5596    4.2674
    4.3504   -1.3131   -1.1406    0.5947    1.2656    2.0220   -0.5623   -0.6900 ];
%image=imresize(image,5);
%image=imrotate(image,150);
%A=[1 2 3;4 5 6;7 8 9];
%A=A+5;
%B=imrotate(A,110);
%C=[1 2 3 4 5;1 2 3 6 7; 1 1 5 9 9; 0 4 7 8 9; 0 3 7 9 7];
%image=A;
image=im2double(image);           % Convert from uint8/ logical form to double form

[height, width] = size(image);  

% To Understand why i am doing the below stuff, go through the theorotical concepts of Hu's invariant moments
%  https://en.wikipedia.org/wiki/Image_moment

% define a co-ordinate system for image 
xgrid = repmat((-floor(height/2):1:ceil(height/2)-1)',1,width);
ygrid = repmat(-floor(width/2):1:ceil(width/2)-1,height,1);

[x_bar, y_bar] = centerOfMass(image,xgrid,ygrid);

% normalize coordinate system by subtracting mean
xnorm = x_bar - xgrid;
ynorm = y_bar - ygrid;

% central moments
mu_11 = central_moments( image ,xnorm,ynorm,1,1);                
mu_20 = central_moments( image ,xnorm,ynorm,2,0);
mu_02 = central_moments( image ,xnorm,ynorm,0,2);
mu_21 = central_moments( image ,xnorm,ynorm,2,1);
mu_12 = central_moments( image ,xnorm,ynorm,1,2);
mu_03 = central_moments( image ,xnorm,ynorm,0,3);
mu_30 = central_moments( image ,xnorm,ynorm,3,0);

%central_moment = [mu_11, mu_20, mu_02, mu_21, mu_12, mu_03, mu_30];
%calculate first 8 hu moments of order 3
I_one   = mu_20 + mu_02;
I_two   = (mu_20 - mu_02)^2 + 4*(mu_11)^2;
I_three = (mu_30 - 3*mu_12)^2 + (mu_03 - 3*mu_21)^2;
I_four  = (mu_30 + mu_12)^2 + (mu_03 + mu_21)^2;
I_five  = (mu_30 - 3*mu_12)*(mu_30 + mu_12)*((mu_30 + mu_12)^2 - 3*(mu_21 + mu_03)^2) + (3*mu_21 - mu_03)*(mu_21 + mu_03)*(3*(mu_30 + mu_12)^2 - (mu_03 + mu_21)^2);
I_six   = (mu_20 - mu_02)*((mu_30 + mu_12)^2 - (mu_21 + mu_03)^2) + 4*mu_11*(mu_30 + mu_12)*(mu_21 + mu_03);
I_seven = (3*mu_21 - mu_03)*(mu_30 + mu_12)*((mu_30 + mu_12)^2 - 3*(mu_21 + mu_03)^2) + (mu_30 - 3*mu_12)*(mu_21 + mu_03)*(3*(mu_30 + mu_12)^2 - (mu_03 + mu_21)^2);
I_eight = mu_11*(mu_30 + mu_12)^2 - (mu_03 + mu_21)^2 - (mu_20 - mu_02)*(mu_30 + mu_12)*(mu_21 + mu_03);

hu_moments_vector = [I_one, I_two, I_three,I_four,I_five,I_six,I_seven,I_eight];
hu_moments_vector_norm= -sign(hu_moments_vector).*(log10(abs(hu_moments_vector)));
hu_moments_vector
hu_moments_vector_norm
% calculate scale invariant central moments


% calculate center of mass

% the eight I_ values are the final Hu's moments obtained. These are the features of the image/ Audio that was given as input.
% These features can be used to recognise this image during facerecognition/ copy move forgerydetection etc etc. 
% The advantage is that, the entire matrix of elements are now reduced to 8 features which reduces computational cost.

% Also we can apply log transform to all 8 moments and then add them to get one feature for the entire image/ audio signal.

