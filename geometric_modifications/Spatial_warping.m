%EE 569 Homework Assignment#2
%Date: 02/25/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Geometric modification 
%Implementation: Spatial Warping
%M-file name: Spatial_warping.m
%Output image: image_warped
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


image=readraw('hat.raw');
[N M]=size(image);

%Converting image co-ordinates to cartesian co-ordinates

for j=1:N
    for k=1:M
           
        
%Finding reference points

conversion_matrix=[0 1 -0.5;-1 0 N+0.5;0 0 1];
if (j==1 && k==1)
    XY1=conversion_matrix*[j;k;1];
    UV1=XY1;
end
if (j==1 && k==512)
    XY2=conversion_matrix*[j;k;1];
    UV2=XY2;
end
if (j==512 && k==1)
    XY3=conversion_matrix*[j;k;1];
    UV3=XY3;
end
if (j==512 && k==512)
    XY4=conversion_matrix*[j;k;1];
    UV4=XY4;
end
% if (p==(N)/2 && q==(N)/2)
%     XY5=conversion_matrix*[p;q;1];
%     UV5=XY5;
% end

        
    end
end
XY5=[(N+1)/2 (N+1)/2];
UV5=XY5;


%Finding mid-points

[UV12(1),UV12(2)]=mid_point(UV1,UV2);
XY12=UV12;
XY12(2)=UV12(2)-128;  %to be changed

[UV13(1),UV13(2)]=mid_point(UV1,UV3);
XY13=UV13;   %to be changed
XY13(1)=UV13(1)+128;

[UV15(1),UV15(2)]=mid_point(UV1,UV5);
XY15=UV15;

[UV24(1),UV24(2)]=mid_point(UV4,UV2);
XY24=UV24;   %to be changed
XY24(1)=UV24(1)-128;

[UV25(1),UV25(2)]=mid_point(UV5,UV2);
XY25=UV25;

[UV34(1),UV34(2)]=mid_point(UV3,UV4);
XY34=UV34;  %to be changed
XY34(2)=XY34(2)+128;

[UV35(1),UV35(2)]=mid_point(UV3,UV5);
XY35=UV35;

[UV45(1),UV45(2)]=mid_point(UV4,UV5);
XY45=UV45;

%Finding the co-efficients for mapping in each triangle from the reference
%points
%For upper triangle

UV_matrix=[UV1(1) UV12(1) UV2(1) UV25(1) UV5(1) UV15(1);UV1(2) UV12(2) UV2(2) UV25(2) UV5(2) UV15(2)];
XY_matrix=[1 1 1 1 1 1;XY1(1) XY12(1) XY2(1) XY25(1) XY5(1) XY15(1);XY1(2) XY12(2) XY2(2) XY25(2) XY5(2) XY15(2);XY1(1).^2 XY12(1).^2 XY2(1).^2 XY25(1).^2 XY5(1).^2 XY15(1).^2;XY1(1)*XY1(2) XY12(1)*XY12(2) XY2(1)*XY2(2) XY25(1)*XY25(2) XY5(1)*XY5(2) XY15(1)*XY15(2);XY1(2).^2 XY12(2).^2 XY2(2).^2 XY25(2).^2 XY5(2).^2 XY15(2).^2];
AB_coeff_upper_triangle=UV_matrix*pinv(XY_matrix);

%For lower triangle

UV_matrix=[UV3(1) UV35(1) UV5(1) UV45(1) UV4(1) UV34(1);UV3(2) UV35(2) UV5(2) UV45(2) UV4(2) UV34(2)];
XY_matrix=[1 1 1 1 1 1;XY3(1) XY35(1) XY5(1) XY45(1) XY4(1) XY34(1);XY3(2) XY35(2) XY5(2) XY45(2) XY4(2) XY34(2);XY3(1).^2 XY35(1).^2 XY5(1).^2 XY45(1).^2 XY4(1).^2 XY34(1).^2;XY3(1)*XY3(2) XY35(1)*XY35(2) XY5(1)*XY5(2) XY45(1)*XY45(2) XY4(1)*XY4(2) XY34(1)*XY34(2);XY3(2).^2 XY35(2).^2 XY5(2).^2 XY45(2).^2 XY4(2).^2 XY34(2).^2];
AB_coeff_lower_triangle=UV_matrix*pinv(XY_matrix);

%For left triangle

UV_matrix=[UV1(1) UV15(1) UV5(1) UV35(1) UV3(1) UV13(1);UV1(2) UV15(2) UV5(2) UV35(2) UV3(2) UV13(2)];
XY_matrix=[1 1 1 1 1 1;XY1(1) XY15(1) XY5(1) XY35(1) XY3(1) XY13(1);XY1(2) XY15(2) XY5(2) XY35(2) XY3(2) XY13(2);XY1(1).^2 XY15(1).^2 XY5(1).^2 XY35(1).^2 XY3(1).^2 XY13(1).^2;XY1(1)*XY1(2) XY15(1)*XY15(2) XY5(1)*XY5(2) XY35(1)*XY35(2) XY3(1)*XY3(2) XY13(1)*XY13(2);XY1(2).^2 XY15(2).^2 XY5(2).^2 XY35(2).^2 XY3(2).^2 XY13(2).^2];
AB_coeff_left_triangle=UV_matrix*pinv(XY_matrix);

%For right triangle

UV_matrix=[UV2(1) UV24(1) UV4(1) UV45(1) UV5(1) UV25(1);UV2(2) UV24(2) UV4(2) UV45(2) UV5(2) UV25(2)];
XY_matrix=[1 1 1 1 1 1;XY2(1) XY24(1) XY4(1) XY45(1) XY5(1) XY25(1);XY2(2) XY24(2) XY4(2) XY45(2) XY5(2) XY25(2);XY2(1).^2 XY24(1).^2 XY4(1).^2 XY45(1).^2 XY5(1).^2 XY25(1).^2;XY2(1)*XY2(2) XY24(1)*XY24(2) XY4(1)*XY4(2) XY45(1)*XY45(2) XY5(1)*XY5(2) XY25(1)*XY25(2);XY2(2).^2 XY24(2).^2 XY4(2).^2 XY45(2).^2 XY5(2).^2 XY25(2).^2];
AB_coeff_right_triangle=UV_matrix*pinv(XY_matrix);


%Mapping from one domain to the other

for j=1:N     %For right triangle
    for k=N/2+1:N
        if(j>=N+1-k || k>=j)
            x=k-0.5;   
            y=-j+N+0.5;
            
            XY_vector=[1;x;y;x.^2;x*y;y.^2];
            UV_mapped=AB_coeff_right_triangle*XY_vector;
            
            PQ_mapped = (pinv(conversion_matrix))*[UV_mapped;1];
            
            if((PQ_mapped(1)>1 && PQ_mapped(1)<N) && (PQ_mapped(2)>1 && PQ_mapped(2)<N)) %do bilinear interpolation
            %interpolation in x and y direction
            if(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0) %when both are integers
            temp=image(PQ_mapped(1),PQ_mapped(2));
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))~=0)   %x is an integer but y is a fractional value
            temp=(image(PQ_mapped(1),floor(PQ_mapped(2)))+image(PQ_mapped(1),ceil(PQ_mapped(2))))./2;
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))~=0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0)   %x is an fractional value but y is a integer value
            temp=(image(floor(PQ_mapped(1)),PQ_mapped(2))+image(ceil(PQ_mapped(1)),PQ_mapped(2)))./2;
            else
            temp=(image(floor(PQ_mapped(1)),floor(PQ_mapped(2)))+image(ceil(PQ_mapped(1)),floor(PQ_mapped(2)))+image(floor(PQ_mapped(1)),ceil(PQ_mapped(2)))+image(ceil(PQ_mapped(1)),ceil(PQ_mapped(2))))./4;
            end
            
            else
            temp=0;
            end
            image_warped(j,k)=temp;
        else
            continue;
        end
    end
end



for j=1:N     %For left triangle
    for k=1:N/2
        if(j<=k || j<=N+1-k)
            x=k-0.5;   
            y=-j+N+0.5;
            
            XY_vector=[1;x;y;x.^2;x*y;y.^2];
            UV_mapped=AB_coeff_left_triangle*XY_vector;
            
            PQ_mapped = (pinv(conversion_matrix))*[UV_mapped;1];
            
            if((PQ_mapped(1)>1 && PQ_mapped(1)<N) && (PQ_mapped(2)>1 && PQ_mapped(2)<N)) %do bilinear interpolation
            %interpolation in x and y direction
            if(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0) %when both are integers
            temp=image(PQ_mapped(1),PQ_mapped(2));
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))~=0)   %x is an integer but y is a fractional value
            temp=(image(PQ_mapped(1),floor(PQ_mapped(2)))+image(PQ_mapped(1),ceil(PQ_mapped(2))))./2;
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))~=0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0)   %x is an fractional value but y is a integer value
            temp=(image(floor(PQ_mapped(1)),PQ_mapped(2))+image(ceil(PQ_mapped(1)),PQ_mapped(2)))./2;
            else
            temp=(image(floor(PQ_mapped(1)),floor(PQ_mapped(2)))+image(ceil(PQ_mapped(1)),floor(PQ_mapped(2)))+image(floor(PQ_mapped(1)),ceil(PQ_mapped(2)))+image(ceil(PQ_mapped(1)),ceil(PQ_mapped(2))))./4;
            end
            
            else
            temp=0;
            end
            image_warped(j,k)=temp;
        else
            continue;
        end
    end
end



for j=N/2+1:N         %For lower triangle
    for k=1:N
        if(k>j || j<N+1-k)
            continue;
        else
            x=k-0.5;   
            y=-j+N+0.5;
            
            XY_vector=[1;x;y;x.^2;x*y;y.^2];
            UV_mapped=AB_coeff_lower_triangle*XY_vector;
            
            PQ_mapped = (pinv(conversion_matrix))*[UV_mapped;1];
            
            if((PQ_mapped(1)>1 && PQ_mapped(1)<N) && (PQ_mapped(2)>1 && PQ_mapped(2)<N)) %do bilinear interpolation
            %interpolation in x and y direction
            if(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0) %when both are integers
            temp=image(PQ_mapped(1),PQ_mapped(2));
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))~=0)   %x is an integer but y is a fractional value
            temp=(image(PQ_mapped(1),floor(PQ_mapped(2)))+image(PQ_mapped(1),ceil(PQ_mapped(2))))./2;
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))~=0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0)   %x is an fractional value but y is a integer value
            temp=(image(floor(PQ_mapped(1)),PQ_mapped(2))+image(ceil(PQ_mapped(1)),PQ_mapped(2)))./2;
            else
            temp=(image(floor(PQ_mapped(1)),floor(PQ_mapped(2)))+image(ceil(PQ_mapped(1)),floor(PQ_mapped(2)))+image(floor(PQ_mapped(1)),ceil(PQ_mapped(2)))+image(ceil(PQ_mapped(1)),ceil(PQ_mapped(2))))./4;
            end
            
            else
            temp=0;
            end
            image_warped(j,k)=temp;
        end
    end
end



for j=1:N/2     %For upper triangle
    for k=1:N
        if(j>k || j>N+1-k)
            continue;
        else
            x=k-0.5;   
            y=-j+N+0.5;
            
            XY_vector=[1;x;y;x.^2;x*y;y.^2];
            UV_mapped=AB_coeff_upper_triangle*XY_vector;
            
            PQ_mapped = (pinv(conversion_matrix))*[UV_mapped;1];
            
            if((PQ_mapped(1)>1 && PQ_mapped(1)<N) && (PQ_mapped(2)>1 && PQ_mapped(2)<N)) %do bilinear interpolation
            %interpolation in x and y direction
            if(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0) %when both are integers
            temp=image(PQ_mapped(1),PQ_mapped(2));
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))==0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))~=0)   %x is an integer but y is a fractional value
            temp=(image(PQ_mapped(1),floor(PQ_mapped(2)))+image(PQ_mapped(1),ceil(PQ_mapped(2))))./2;
            elseif(ceil(PQ_mapped(1))-floor(PQ_mapped(1))~=0 && ceil(PQ_mapped(2))-floor(PQ_mapped(2))==0)   %x is an fractional value but y is a integer value
            temp=(image(floor(PQ_mapped(1)),PQ_mapped(2))+image(ceil(PQ_mapped(1)),PQ_mapped(2)))./2;
            else
            temp=(image(floor(PQ_mapped(1)),floor(PQ_mapped(2)))+image(ceil(PQ_mapped(1)),floor(PQ_mapped(2)))+image(floor(PQ_mapped(1)),ceil(PQ_mapped(2)))+image(ceil(PQ_mapped(1)),ceil(PQ_mapped(2))))./4;
            end
            
            else
            temp=0;
            end
            image_warped(j,k)=temp;
        end
    end
end
figure(1);
imshow(uint8(image_warped));

title('Warped image');






            
 
 