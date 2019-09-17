%EE 569 Homework Assignment#2
%Date: 02/25/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Geometric modification 
%Implementation: Translation, Rotation and Scaling
%M-file name: sub_image.m
%Input arguments: light_house_sub_image(image to be modified)
%                 varargin(for rotation)
%Output image: light_house_sub_image_translated_rotated_scaled
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [light_house_sub_image_translated_rotated_scaled]=sub_image(light_house_sub_image,varargin)

i=10;
% if(varargin{1}==0)

[N M]=size(light_house_sub_image);

pointer_north=1;
pointer_east=1;
pointer_west=1;
pointer_south=1;

for i=1:N
    for j=1:M
        
        if(light_house_sub_image(i,j)~=255 && isequal(light_house_sub_image(i-1,:),255.*ones(1,M))) %to get the north co-ordinate of the rhombus
        potential_corners_north_x(pointer_north)=i;
        potential_corners_north_y(pointer_north)=j;
        neighbourhood=light_house_sub_image(i-1:i+1,j-1:j+1);
        count=0;
        for k=1:3
            for l=1:3
                if(neighbourhood(k,l)==255)
                    count=count+1;
                end
            end
        end
        potential_corners_north_count(pointer_north)=count;
        pointer_north=pointer_north+1;    
        end
        
        if(light_house_sub_image(i,j)~=255 && isequal(light_house_sub_image(:,j+1),255.*ones(N,1)))  %to get the east co-ordinate of the rhombus
        potential_corners_east_x(pointer_east)=i;
        potential_corners_east_y(pointer_east)=j;
        neighbourhood=light_house_sub_image(i-1:i+1,j-1:j+1);
        count=0;
        for k=1:3
            for l=1:3
                if(neighbourhood(k,l)==255)
                    count=count+1;
                end
            end
        end
        potential_corners_east_count(pointer_east)=count;
        pointer_east=pointer_east+1;
        end

       
        if(light_house_sub_image(i,j)~=255 && isequal(light_house_sub_image(:,j-1),255.*ones(N,1)))  %to get the west coordinates of the rhombus
        potential_corners_west_x(pointer_west)=i;
        potential_corners_west_y(pointer_west)=j;
        neighbourhood=light_house_sub_image(i-1:i+1,j-1:j+1);
        count=0;
        for k=1:3
            for l=1:3
                if(neighbourhood(k,l)==255)
                    count=count+1;
                end
            end
        end
        potential_corners_west_count(pointer_west)=count;
        pointer_west=pointer_west+1; 
        end
        
        if(light_house_sub_image(i,j)~=255 && light_house_sub_image(i-1,j)~=255 && isequal(light_house_sub_image(i+1,:),255.*ones(1,M)))  %to find the south co-ordinates of the rhombus
        potential_corners_south_x(pointer_south)=i;
        potential_corners_south_y(pointer_south)=j;
        neighbourhood=light_house_sub_image(i-1:i+1,j-1:j+1);
        count=0;
        for k=1:3
            for l=1:3
                if(neighbourhood(k,l)==255)
                    count=count+1;
                end
            end
        end
        potential_corners_south_count(pointer_south)=count;
        pointer_south=pointer_south+1; 
        end
        
    end
end

%Deciding north corner pixel coordinates

[N M]=size(potential_corners_north_count);

for z=1:M
if(max(potential_corners_north_count)==potential_corners_north_count(z))
north_corner_x=potential_corners_north_x(z);
north_corner_y=potential_corners_north_y(z);
end
end

%Deciding east corner pixel coordinates

[N M]=size(potential_corners_east_count);

for z=1:M
if(max(potential_corners_east_count)==potential_corners_east_count(z))
east_corner_x=potential_corners_east_x(z);
east_corner_y=potential_corners_east_y(z);
end
end

%Deciding west corner pixel coordinates

[N M]=size(potential_corners_west_count);

for z=1:M
if(max(potential_corners_west_count)==potential_corners_west_count(z))
west_corner_x=potential_corners_west_x(z);
west_corner_y=potential_corners_west_y(z);
end
end

%Deciding south corner pixel coordinates

[N M]=size(potential_corners_south_count);

for z=1:M
if(max(potential_corners_south_count)==potential_corners_south_count(z))
south_corner_x=potential_corners_south_x(z);
south_corner_y=potential_corners_south_y(z);
end
end

%Calculating width,height,angle and centre point

width=sqrt((north_corner_x-west_corner_x).^2+(north_corner_y-west_corner_y).^2);
height=sqrt((north_corner_x-east_corner_x).^2+(north_corner_y-east_corner_y).^2);
angle=atan((south_corner_y-west_corner_y)/(south_corner_x-west_corner_x));
angle=angle+varargin{1};                                                                               
centre_point_x=(west_corner_x+east_corner_x)/2;
centre_point_y=(west_corner_y+east_corner_y)/2;

%Image translation

[N M]=size(light_house_sub_image);
for j=1:N
    for k=1:M   %this is starting from the output image
    x=k-0.5;   %check these once (this is for the output image)
    y=-j+N+0.5;
    conversion_matrix=[0 1 -0.5;-1 0 N+0.5;0 0 1];
    %translation
    tx=-centre_point_x+(N+1)/2;
    ty=-centre_point_y+(N+1)/2;
    
    PQ_translation_x=j-tx;                                 
    PQ_translation_y=k-ty;                                 
    PQ_mapped=[PQ_translation_x;PQ_translation_y];
       
    if((PQ_mapped(1)>1 && PQ_mapped(1)<N) && (PQ_mapped(2)>1 && PQ_mapped(2)<N)) %do bilinear interpolation
            %interpolation in x and y direction
            if(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0) %when both are integers
            temp=light_house_sub_image(PQ_mapped(1),PQ_mapped(2));
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))~=0)   %x is an integer but y is a fractional value
            temp=(light_house_sub_image(PQ_mapped(1),floor(PQ_mapped(2)))+light_house_sub_image(PQ_mapped(1),ceil(PQ_mapped(2))))./2;
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))~=0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0)   %x is an fractional value but y is a integer value
            temp=(light_house_sub_image(floor(PQ_mapped(1)),PQ_mapped(2))+light_house_sub_image(ceil(PQ_mapped(1)),PQ_mapped(2)))./2;
            else
            temp=(light_house_sub_image(floor(PQ_mapped(1)),floor(PQ_mapped(2)))+light_house_sub_image(ceil(PQ_mapped(1)),floor(PQ_mapped(2)))+light_house_sub_image(floor(PQ_mapped(1)),ceil(PQ_mapped(2)))+light_house_sub_image(ceil(PQ_mapped(1)),ceil(PQ_mapped(2))))./4;
            end
            
            else
            temp=255;
            end
            light_house_sub_image_translated(j,k)=temp;
    end
end

figure(i);
imshow(uint8(light_house_sub_image_translated));
title('Sub image translated to the origin');
i=i+1;

%Rotating

for j=1:N
    for k=1:M
        
    x=k-0.5;   
    y=-j+N+0.5;
    
    rotation_matrix=[1 0 (N+1)/2;0 1 (N+1)/2;0 0 1]*[cos(angle) sin(angle) 0;-sin(angle) cos(angle) 0;0 0 1]*[1 0 -(N+1)/2;0 1 -(N+1)/2;0 0 1];
    UV = pinv(rotation_matrix)*[x y 1]';
    %For reverse conversion
    
    PQ_rotation = (pinv(conversion_matrix))*UV;
    PQ_mapped=[PQ_rotation(1);PQ_rotation(2)];
    
    if((PQ_mapped(1)>1 && PQ_mapped(1)<N) && (PQ_mapped(2)>1 && PQ_mapped(2)<N)) %do bilinear interpolation
            %interpolation in x and y direction
            if(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0) %when both are integers
            temp=light_house_sub_image_translated(PQ_mapped(1),PQ_mapped(2));
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))~=0)   %x is an integer but y is a fractional value
            temp=(light_house_sub_image_translated(PQ_mapped(1),floor(PQ_mapped(2)))+light_house_sub_image_translated(PQ_mapped(1),ceil(PQ_mapped(2))))./2;
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))~=0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0)   %x is an fractional value but y is a integer value
            temp=(light_house_sub_image_translated(floor(PQ_mapped(1)),PQ_mapped(2))+light_house_sub_image_translated(ceil(PQ_mapped(1)),PQ_mapped(2)))./2;
            else
            temp=(light_house_sub_image_translated(floor(PQ_mapped(1)),floor(PQ_mapped(2)))+light_house_sub_image_translated(ceil(PQ_mapped(1)),floor(PQ_mapped(2)))+light_house_sub_image_translated(floor(PQ_mapped(1)),ceil(PQ_mapped(2)))+light_house_sub_image_translated(ceil(PQ_mapped(1)),ceil(PQ_mapped(2))))./4;
            end
            
            else
            temp=255;
            end
            light_house_sub_image_translated_rotated(j,k)=temp;
 
    end
end    

figure(i);
imshow(uint8(light_house_sub_image_translated_rotated));
title('Sub image rotated about the origin');
i=i+1;

% P=256;
J=N;
K=N;

%Scaling to make the sub image a square one
for j=1:J     %For 160x160 use J and K
    for k=1:K
   
    x=k-0.5;   
    y=-j+J+0.5;
    sx= 168./height;    %Scaling to 164x164          
    sy= 168./width;               
    %scaling_matrix=[sx 0 0;0 sy 0;0 0 1];
   
    centre_pixel=conversion_matrix*[(N+1)/2; (N+1)/2; 1];
    
    
    
    scaling_matrix=[1 0 centre_pixel(1);0 1 centre_pixel(2);0 0 1]*[sx 0 0;0 sy 0;0 0 1]*[1 0 -centre_pixel(1);0 1 -centre_pixel(2);0 0 1];
    UV_scaling=(pinv(scaling_matrix))*[x;y;1];
    PQ_scaling = (pinv(conversion_matrix))*UV_scaling;
    
    PQ_mapped=[PQ_scaling(1);PQ_scaling(2)];
    
%     PQ_scaling_x=((1/sy).*(j-J+0.5))+P+0.5;
%     PQ_scaling_y=((1/sx).*(K-0.5))+0.5;
    
            if((PQ_mapped(1)>1 && PQ_mapped(1)<N) && (PQ_mapped(2)>1 && PQ_mapped(2)<N)) %do bilinear interpolation
            %interpolation in x and y direction
            if(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0) %when both are integers
            temp=light_house_sub_image_translated_rotated(PQ_mapped(1),PQ_mapped(2));
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))~=0)   %x is an integer but y is a fractional value
            temp=(light_house_sub_image_translated_rotated(PQ_mapped(1),floor(PQ_mapped(2)))+light_house_sub_image_translated_rotated(PQ_mapped(1),ceil(PQ_mapped(2))))./2;
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))~=0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0)   %x is an fractional value but y is a integer value
            temp=(light_house_sub_image_translated_rotated(floor(PQ_mapped(1)),PQ_mapped(2))+light_house_sub_image_translated_rotated(ceil(PQ_mapped(1)),PQ_mapped(2)))./2;
            else
            temp=(light_house_sub_image_translated_rotated(floor(PQ_mapped(1)),floor(PQ_mapped(2)))+light_house_sub_image_translated_rotated(ceil(PQ_mapped(1)),floor(PQ_mapped(2)))+light_house_sub_image_translated_rotated(floor(PQ_mapped(1)),ceil(PQ_mapped(2)))+light_house_sub_image_translated_rotated(ceil(PQ_mapped(1)),ceil(PQ_mapped(2))))./4;
            end
            
            else
            temp=255;
            end
            light_house_sub_image_translated_rotated_scaled(j,k)=temp;
 
    end
end 
% figure(i);
% imshow(uint8(light_house_sub_image_translated)):
% title('Sub image translated to the origin');
% i=i+1;

   
end  
%end
  
