%EE 569 Homework Assignment#4
%Date: 03/19/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Texture Analysis
%Implementation: Texture Classification
%M-file name: avg_energy.m
%Input  : texture_filtered
%Output : E
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [E]=avg_energy(texture_filtered)

texture_filtered_sum=0;
for i=1:128
    for j=1:128
        %texture_filtered_sum=texture_filtered_sum+(texture_filtered(i,j).^2);
        texture_filtered_sum=texture_filtered_sum+abs(texture_filtered(i,j));  %taking absolute value
    end
end
E=(1/((128)*(128))).*texture_filtered_sum;
