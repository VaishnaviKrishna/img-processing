%EE 569 Homework Assignment#2
%Date: 02/11/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem : Edge detection
%Implementation: Canny edge detector
%M-file name: Canny_edge_detector_tiger.m
%Output image: tiger_edge_final;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


tiger_red=readraw_red('Tiger.raw');
tiger_green=readraw_green('Tiger.raw');
tiger_blue=readraw_blue('Tiger.raw');
tiger_gray_scale=0.2989.*tiger_red+0.5870.*tiger_green+0.1140.*tiger_blue;
tiger_gray_scale_normalized=tiger_gray_scale./255;
%tiger_gray_scale_normalized=double(tiger_gray_scale_normalized);

%Value for Thresholding
T_Low = 0.1;
T_High = 0.4;

% T_Low = 0.075;
% T_High = 0.175;
%Gaussian Filter Coefficient
B = (1/159).*[2, 4, 5, 4, 2; 4, 9, 12, 9, 4;5, 12, 15, 12, 5;4, 9, 12, 9, 4;2, 4, 5, 4, 2 ];
%Convolution of image by Gaussian Coefficient
A=conv2(tiger_gray_scale_normalized, B, 'same');
%Filter for horizontal and vertical direction
KGx =(1/4)* [-1, 0, 1; -2, 0, 2; -1, 0, 1];
KGy =(1/4)* [1, 2, 1; 0, 0, 0; -1, -2, -1];
%Convolution by image by horizontal and vertical filter
Filtered_X = conv2(A, KGx, 'same');
Filtered_Y = conv2(A, KGy, 'same');
%Calculate directions/orientations
arah = atan2 (Filtered_Y, Filtered_X);
arah = arah.*180/pi;  %conversion to degrees
N=size(A,1);
M=size(A,2);
%Adjustment for negative directions, making all directions positive
for i=1:N
    for j=1:M
        if (arah(i,j)<0) 
            arah(i,j)=360+arah(i,j);
        end
    end
end
arah2=zeros(N, M);
%Adjusting directions to nearest 0, 45, 90, or 135 degree
for i = 1  : N
    for j = 1 : M
        if ((arah(i, j) >= 0 ) && (arah(i, j) < 22.5) || (arah(i, j) >= 157.5) && (arah(i, j) < 202.5) || (arah(i, j) >= 337.5) && (arah(i, j) <= 360))
            arah2(i, j) = 0;
        elseif ((arah(i, j) >= 22.5) && (arah(i, j) < 67.5) || (arah(i, j) >= 202.5) && (arah(i, j) < 247.5))
            arah2(i, j) = 45;
        elseif ((arah(i, j) >= 67.5 && arah(i, j) < 112.5) || (arah(i, j) >= 247.5 && arah(i, j) < 292.5))
            arah2(i, j) = 90;
        elseif ((arah(i, j) >= 112.5 && arah(i, j) < 157.5) || (arah(i, j) >= 292.5 && arah(i, j) < 337.5))
            arah2(i, j) = 135;
        end
    end
end
%figure, imagesc(arah2); colorbar;
%Calculate magnitude
magnitude = (Filtered_X.^2) + (Filtered_Y.^2);
magnitude2 = sqrt(magnitude);
BW = zeros (N, M);
%Non-Maximum Supression
for i=2:N-1
    for j=2:M-1
        if (arah2(i,j)==0)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i,j+1), magnitude2(i,j-1)]));
        elseif (arah2(i,j)==45)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j-1), magnitude2(i-1,j+1)]));
        elseif (arah2(i,j)==90)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j), magnitude2(i-1,j)]));
        elseif (arah2(i,j)==135)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j+1), magnitude2(i-1,j-1)]));
        end
    end
end
BW = BW.*magnitude2;
% figure;
% imshow((BW));
%Hysteresis Thresholding
T_Low = T_Low * max(max(BW));
T_High = T_High * max(max(BW));
T_res = zeros (N, M);
for i = 1  : N
    for j = 1 : M
        if (BW(i, j) < T_Low)
            T_res(i, j) = 0;
        elseif (BW(i, j) > T_High)
            T_res(i, j) = 1;
        %Using 8-connected components
        elseif ( BW(i+1,j)>T_High || BW(i-1,j)>T_High || BW(i,j+1)>T_High || BW(i,j-1)>T_High || BW(i-1, j-1)>T_High || BW(i-1, j+1)>T_High || BW(i+1, j+1)>T_High || BW(i+1, j-1)>T_High)
            T_res(i,j) = 1;
        end
    end
end
tiger_edge_final = T_res.*255;
%Show final edge detection result
figure(1);
imshow(uint8(tiger_edge_final));
title('Edge map');
