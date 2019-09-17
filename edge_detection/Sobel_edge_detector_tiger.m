%EE 569 Homework Assignment#2
%Date: 02/11/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem : Edge detection
%Implementation: Sobel edge detector
%M-file name: Sobel_edge_detector_tiger.m
%Output image: output_tiger_sobel_edge_detected;
               %gradient_map_tiger_gray_scale;
               %row_gradient_tiger_gray_scale_normalized;
               %column_gradient_tiger_gray_scale_normalized;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tiger_red=readraw_red('Tiger.raw');
tiger_green=readraw_green('Tiger.raw');
tiger_blue=readraw_blue('Tiger.raw');
Gx=(1/4)*[-1 0 1;-2 0 2;-1 0 1];
Gy=(1/4)*[1 2 1;0 0 0;-1 -2 -1];
[N M]=size(Gx);
tiger_gray_scale=0.299.*tiger_red+0.5870.*tiger_green+0.1140.*tiger_blue;
tiger_gray_scale_extended=zeros(321+(N-1),481+(N-1));

for i=1:321          %data centered
    for j=1:481
        tiger_gray_scale_extended(i+(N-1)/2,j+(N-1)/2)=tiger_gray_scale(i,j);
    end
end

%boundary extension
for i=0:((N-1)/2)-1
    tiger_gray_scale_extended(:,((N-1)/2)-i)=tiger_gray_scale_extended(:,((N-1)/2)+i+2);
    tiger_gray_scale_extended(:,481+((N-1)/2)+i+1)=tiger_gray_scale_extended(:,481+((N-1)/2)-i-1);
    tiger_gray_scale_extended(((N-1)/2)-i,:)=tiger_gray_scale_extended(((N-1)/2)+i+3,:);
    tiger_gray_scale_extended((321+(N-1)/2)+i+1,:)=tiger_gray_scale_extended((321+(N-1)/2)-i-1,:);
end


for i=1+(N-1)/2:321+(N-1)/2
    for j=1+(N-1)/2:481+(N-1)/2
        sum_of_products_column=0;
        sum_of_products_row=0;
        for k=i-(N-1)/2:i+(N-1)/2
            for l=j-(N-1)/2:j+(N-1)/2
            sum_of_products_row=sum_of_products_row+tiger_gray_scale_extended(k,l)*Gx((k-i+N-1),(l-j+N-1));
            sum_of_products_column=sum_of_products_column+tiger_gray_scale_extended(k,l)*Gy((k-i+N-1),(l-j+N-1));
            end
        end
        row_gradient_tiger_gray_scale(i-(N-1)/2,j-(N-1)/2)=sum_of_products_row;
        column_gradient_tiger_gray_scale(i-(N-1)/2,j-(N-1)/2)=sum_of_products_column;
    end
end

gradient_map_tiger_gray_scale=sqrt((row_gradient_tiger_gray_scale.^2)+(column_gradient_tiger_gray_scale.^2));
gradient_map_tiger_rounded=floor(gradient_map_tiger_gray_scale);
%gradient_map_pig_gray_scale_normalized=gradient_map_pig_gray_scale-min(min(gradient_map_pig_gray_scale))./(max(max(gradient_map_pig_gray_scale))-min(min(gradient_map_pig_gray_scale)));

%Normalizing the X gradient and the Y gradient values
max_row_tiger=max(max(row_gradient_tiger_gray_scale));
min_row_tiger=min(min(row_gradient_tiger_gray_scale));
max_col_tiger=max(max(column_gradient_tiger_gray_scale));
min_col_tiger=min(min(column_gradient_tiger_gray_scale));

row_gradient_tiger_gray_scale_normalized=((row_gradient_tiger_gray_scale-min_row_tiger)./(max_row_tiger-min_row_tiger)).*255;
column_gradient_tiger_gray_scale_normalized=((column_gradient_tiger_gray_scale-min_col_tiger)./(max_col_tiger-min_col_tiger)).*255;

 temp=gradient_map_tiger_rounded;
 value=max(max(gradient_map_tiger_rounded));
 freq_count=zeros(value+1,3);
 freq_count(:,1)=0:value;

 
 for i=1:321
     for j=1:481
         freq_count(temp(i,j)+1,2)=freq_count(temp(i,j)+1,2)+1;
     end
 end
 
freq_count(:,2)=freq_count(:,2)./(321*481);  %normalizing

for i=1:value+1
    sum=0;
    for j=1:i
       sum=sum+freq_count(j,2);
    end
    freq_count(i,3)=sum;
end


% figure(1);
% plot(freq_count(:,1),freq_count(:,3));
% title('Cumulative histogram');
% xlabel('Gradient magnitude values');
% ylabel('Cumulative distribution function');

 for i=1:321
  for j=1:481
      if(gradient_map_tiger_gray_scale(i,j)>40)
          output_tiger_sobel_edge_detected(i,j)=0;
      else
          output_tiger_sobel_edge_detected(i,j)=255;
      end
  end
 end
 
figure(2);
imshow(uint8(output_tiger_sobel_edge_detected));
title('Edge map: Threshold 80% ');
% figure(3)
% imshow(uint8(gradient_map_tiger_gray_scale));
% title('Gradient map');
% figure(4)
% imshow(uint8(row_gradient_tiger_gray_scale_normalized));
% title('Horizontal gradient map (Detecting vertical edges)');
% figure(5)
% imshow(uint8(column_gradient_tiger_gray_scale_normalized));
% title('Vertical gradient map (Detecting horizontal edges)');        
