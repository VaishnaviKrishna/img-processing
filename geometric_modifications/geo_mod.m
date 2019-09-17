%EE 569 Homework Assignment#3
%Date: 02/25/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Geometric modification 
%Implementation: Translation, Rotation and Scaling
%M-file name: geo_mod.m
%Output image: light_house
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

light_house=readraw('lighthouse.raw');

[N M]=size(light_house);
sub_image_x_coordinate=zeros();
sub_image_y_coordinate=zeros();
count=1;

for i=1:N
    for j=1:M
        
        if(light_house(i,j)==255 && light_house(i,j-1)~=255 && light_house(i-1,j)~=255 && light_house(i-1,j-1)~=255 && light_house(i,j+1)==255 && light_house(i+1,j)==255 && light_house(i+1,j+1)==255)  %Searching for top left coordinates
        sub_image_x_coordinate(count)=i;
        sub_image_y_coordinate(count)=j;
        count=count+1;
        end
        
        if(light_house(i,j)==255 && light_house(i,j+1)~=255 && light_house(i-1,j)~=255 && light_house(i-1,j+1)~=255 && light_house(i,j-1)==255 && light_house(i+1,j-1)==255 && light_house(i+1,j)==255) %Searching for top right coordinates
        sub_image_x_coordinate(count)=i;
        sub_image_y_coordinate(count)=j;
        count=count+1;
        end
        
        if(light_house(i,j)==255 && light_house(i,j-1)~=255 && light_house(i+1,j)~=255 && light_house(i+1,j-1)~=255 && light_house(i-1,j)==255 && light_house(i-1,j+1)==255 && light_house(i,j+1)==255)  %Searching for bottom left coordinates
        sub_image_x_coordinate(count)=i;
        sub_image_y_coordinate(count)=j;
        count=count+1;
        end
        
        if(light_house(i,j)==255 && light_house(i,j+1)~=255 && light_house(i+1,j)~=255 && light_house(i+1,j+1)~=255 && light_house(i-1,j-1)==255 && light_house(i-1,j)==255 && light_house(i,j-1)==255)  %Searching for bottom right coordinates
        sub_image_x_coordinate(count)=i;
        sub_image_y_coordinate(count)=j;
        count=count+1;
        end
        
    end
end

for count=1:12   %To locate the top left co-ordinates
    if (count==1)
        sub_image_b_coordinates=[sub_image_x_coordinate(count) sub_image_y_coordinate(count)];
    end
    
    if (count==3)
        sub_image_a_coordinates=[sub_image_x_coordinate(count) sub_image_y_coordinate(count)];
    end
    
    if (count==9)
        sub_image_c_coordinates=[sub_image_x_coordinate(count) sub_image_y_coordinate(count)];
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

light_house_sub_image=readraw_subimage('lighthouse1.raw');
final_modified_subimage1=sub_image(light_house_sub_image,0);
figure(1);
imshow(uint8(final_modified_subimage1));
title('modified');
[N M]=size(final_modified_subimage1);

light_house_sub_image=readraw_subimage('lighthouse2.raw');
final_modified_subimage2=sub_image(light_house_sub_image,pi/2);
title('Geometrically modified sub image');
figure(2);
imshow(uint8(final_modified_subimage2));

light_house_sub_image=readraw_subimage('lighthouse3.raw');
final_modified_subimage3=sub_image(light_house_sub_image,3*pi/2);
figure(3);
imshow(uint8(final_modified_subimage3));
title('Geometrically modified sub image');

sub_image_a=final_modified_subimage1(48:207,48:207);
sub_image_b=final_modified_subimage2(48:207,48:207);
sub_image_c=final_modified_subimage3(48:207,48:207);

figure(4);
imshow(uint8(sub_image_a));
figure(5);
imshow(uint8(sub_image_b));
figure(6);
imshow(uint8(sub_image_c));

%Filling the white patches with respective geometrically modified images

light_house(sub_image_b_coordinates(1):160+sub_image_b_coordinates(1,1)-1,sub_image_b_coordinates(2):160+sub_image_b_coordinates(1,2)-1)=sub_image_b;
light_house(sub_image_a_coordinates(1):160+sub_image_a_coordinates(1,1)-1,sub_image_a_coordinates(2):160+sub_image_a_coordinates(1,2)-1)=sub_image_a;
light_house(sub_image_c_coordinates(1):160+sub_image_c_coordinates(1,1)-1,sub_image_c_coordinates(2):160+sub_image_c_coordinates(1,2)-1)=sub_image_c;
figure(10);
imshow(uint8(light_house));
title('Final image obtained by fitting the sub images to their respective holes');


