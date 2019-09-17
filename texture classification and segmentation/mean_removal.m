%EE 569 Homework Assignment#4
%Date: 03/19/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Texture Analysis
%Implementation: Texture Classification
%M-file name: mean_removal.m
%Input  : N, texture
%Output : feature_vector_row
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function [feature_vector_row]=mean_removal(N, texture)
texture_sum=0;

%texture=double(texture);
for i=1:128
    for j=1:128
        texture_sum=texture_sum+texture(i,j);
    end
end
texture_mean=(1/((128)*(128))).*texture_sum;
texture_mean_removed=texture-texture_mean;

texture_extended=zeros(128+(N-1),128+(N-1));

for i=1:128          %data centered
    for j=1:128
        texture_extended(i+(N-1)/2,j+(N-1)/2)=texture_mean_removed(i,j);
    end
end

%boundary extension
for i=0:((N-1)/2)-1
    texture_extended(:,((N-1)/2)-i)=texture_extended(:,((N-1)/2)+i+2);
    texture_extended(:,128+((N-1)/2)+i+1)=texture_extended(:,128+((N-1)/2)-i-1);
    texture_extended(((N-1)/2)-i,:)=texture_extended(((N-1)/2)+i+2,:);
    texture_extended((128+(N-1)/2)+i+1,:)=texture_extended((128+(N-1)/2)-i-1,:);
end

feature_vector_row=Laws_filter(5,texture_extended);
end