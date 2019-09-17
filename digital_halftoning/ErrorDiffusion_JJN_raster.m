%EE 569 Homework Assignment#2
%Date: 02/11/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Gray-Scale Half toning
%Implementation: Error diffusion using JJN matrix (Raster parsing)
%M-file name: ErrorDiffusion_JJN_raster.m
%Output image: output_error_diffused_JJN_raster
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


gray_scale_bridge=readraw('bridge.raw');
added_error_gray_scale_bridge=gray_scale_bridge;
threshold=127;  %setting the threshold
diffusion_matrix=(1/48)*[0 0 0 0 0;0 0 0 0 0;0 0 0 7 5;3 5 7 5 3;1 3 5 3 1];
[N M]=size(diffusion_matrix);

added_error_gray_scale_bridge_extended=zeros(400+N-1,600+N-1);

for i=1:400          %data centered
    for j=1:600
        added_error_gray_scale_bridge_extended(i+(N-1)/2,j+(N-1)/2)=added_error_gray_scale_bridge(i,j);
    end
end

%boundary extension
for i=0:((N-1)/2)-1
    added_error_gray_scale_bridge_extended(:,((N-1)/2)-i)=added_error_gray_scale_bridge_extended(:,((N-1)/2)+i+1);
    added_error_gray_scale_bridge_extended(:,600+((N-1)/2)+i+1)=added_error_gray_scale_bridge_extended(:,600+((N-1)/2)-i);
    added_error_gray_scale_bridge_extended(((N-1)/2)-i,:)=added_error_gray_scale_bridge_extended(((N-1)/2)+i+1,:);
    added_error_gray_scale_bridge_extended((400+(N-1)/2)+i+1,:)=added_error_gray_scale_bridge_extended((400+(N-1)/2)-i,:);
end

temporary=added_error_gray_scale_bridge_extended;

for i=1+(N-1)/2:400+(N-1)/2
    for j=1+(N-1)/2:600+(N-1)/2
        
        if (added_error_gray_scale_bridge_extended(i,j)>threshold)
            output_error_diffused_JJN_raster(i-(N-1)/2,j-(N-1)/2)=255;
            else
            output_error_diffused_JJN_raster(i-(N-1)/2,j-(N-1)/2)=0; 
        end
        error=added_error_gray_scale_bridge_extended(i,j)-output_error_diffused_JJN_raster(i-(N-1)/2,j-(N-1)/2);
            
        if(j<602)
                for k=i-(N-1)/2:i+(N-1)/2
                    for l=j-(N-1)/2:j+(N-1)/2
                    added_error_gray_scale_bridge_extended(k,l)=added_error_gray_scale_bridge_extended(k,l)+error*diffusion_matrix(mod(k-i+(N-1)/2,N)+1,mod(l-j+(N-1)/2,N)+1);
                    end
                end
            else
            added_error_gray_scale_bridge_extended(i,j)=error+added_error_gray_scale_bridge_extended(i,j);   
            end
    end
end

figure(2)
imshow(uint8(output_error_diffused_JJN_raster));
title('Image obtained by JJN error diffusion using raster parsing');                    