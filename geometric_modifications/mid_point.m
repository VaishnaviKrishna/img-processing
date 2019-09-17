%EE 569 Homework Assignment#2
%Date: 02/25/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Spatial Warping 
%Implementation: Mid point calculation
%M-file name: mid_point.m
%Input arguments:Takes in two pairs of points [x1,y1] and [x2,y2]
%Output: Returs [x,y] coordinates i.e., mid points of the  
%        respective coordinates of two input arguments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x,y]=mid_point(A,B)
x=(A(1)+B(1))./2;
y=(A(2)+B(2))./2;
end

