%EE 569 Homework Assignment#2
%Date: 02/11/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Gray-Scale Half toning
%Implementation: Random Thresholding
%M-file name: RandomThresholding.m
%Output image: output_random_thresholding
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


gray_scale_bridge=readraw('bridge.raw');
random_number=randi([0,255],400,600);
output_random_thresholding=zeros(400,600);
for i=1:400
    for j=1:600
        if (gray_scale_bridge(i,j)<random_number(i,j) && gray_scale_bridge(i,j)>=0)
        output_random_thresholding(i,j)=0;
        elseif (gray_scale_bridge(i,j)>=random_number(i,j) && gray_scale_bridge(i,j)<256)
        output_random_thresholding(i,j)=255;
        end
    end
end
figure;
imshow(uint8(output_random_thresholding));
title('Half-toned image obtained through Random thresholding');