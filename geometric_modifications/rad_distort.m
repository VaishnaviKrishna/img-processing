%EE 569 Homework Assignment#3
%Date: 02/25/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Geometric modification
%Implementation: Radial distortion correction
%M-file name: rad_distort.m
%Output image: undistorted_image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



distorted_image=readraw('classroom.raw');
[N M]=size(distorted_image);


%Radial distortion coeff
k1=-0.3536;
k2=0.1730;
k3=0;

fx=600;
fy=600;

u_c=(N+1)/2;
v_c=(M+1)/2;

for u=1:N     %image coordinates for undistorted image
    for v=1:M
        x(u,v)=(u-u_c)./fx;   %Finding the image coordinates from the camera coordinates for the undistorted image
        y(u,v)=(v-v_c)./fy;
        r(u,v)=sqrt(x(u,v).^2+y(u,v).^2);
        x_d(u,v)=x(u,v)*(1+k1*r(u,v).^2+k2*r(u,v).^4+k3*r(u,v).^6);  %distorted image in camera coordinates
        y_d(u,v)=y(u,v)*(1+k1*r(u,v).^2+k2*r(u,v).^4+k3*r(u,v).^6);
        
        u_d(u,v)=fx*x_d(u,v)+u_c;   %Finding the image coordinates from camera coordinates for the distorted image
        v_d(u,v)=fy*y_d(u,v)+v_c;
        
        if((u_d(u,v)>1 && u_d(u,v)<N) && (v_d(u,v)>1 && v_d(u,v)<M))  %do bilinear interpolation
        %interpolation in x and y direction
            if(ceil(u_d(u,v))-floor(u_d(u,v))==0 && ceil(v_d(u,v))-floor(v_d(u,v))==0) %when both are integers
            temp=distorted_image(u_d(u,v),PQ_mapped(2));
            elseif(ceil(u_d(u,v))-floor(u_d(u,v))==0 && ceil(v_d(u,v))-floor(v_d(u,v))~=0)   %x is an integer but y is a fractional value
            temp=(distorted_image(u_d(u,v),floor(v_d(u,v)))+distorted_image(u_d(u,v),ceil(v_d(u,v))))./2;
            elseif(ceil(u_d(u,v))-floor(u_d(u,v))~=0 && ceil(v_d(u,v))-floor(v_d(u,v))==0)   %x is an fractional value but y is a integer value
            temp=(distorted_image(floor(u_d(u,v)),v_d(u,v))+distorted_image(ceil(u_d(u,v)),v_d(u,v)))./2;
            else
            temp=(distorted_image(floor(u_d(u,v)),floor(v_d(u,v)))+distorted_image(ceil(u_d(u,v)),floor(v_d(u,v)))+distorted_image(floor(u_d(u,v)),ceil(v_d(u,v)))+distorted_image(ceil(u_d(u,v)),ceil(v_d(u,v))))./4;
            end
            
            else
            temp=255;
            end
            undistorted_image(u,v)=temp;
        
        
        
    end
end


figure(1);
imshow(uint8(distorted_image));
title('Distorted image');
figure(2);
imshow(uint8(undistorted_image));
title('Image obtained after radial distortion correction');

