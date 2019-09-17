%EE 569 Homework Assignment#2
%Date: 02/11/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Gray-Scale Half toning
%Implementation: Fixed Thresholding
%M-file name: Fixed_thresholding.m
%Output image: output_fixed_thresholding
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gray_scale_bridge=readraw('bridge.raw');
threshold=127; %fixed threshold
output_fixed_thresholding=zeros(400,600);
for i=1:400
    for j=1:600
        if (gray_scale_bridge(i,j)<threshold)
        output_fixed_thresholding(i,j)=0;
        elseif (gray_scale_bridge(i,j)>= threshold)
        output_fixed_thresholding(i,j)=255;
        end
    end
end
figure;
imshow(uint8(output_fixed_thresholding));
title('Half-toned image obtained through Fixed thresholding');