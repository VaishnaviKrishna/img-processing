%EE 569 Homework Assignment#2
%Date: 02/11/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Gray-Scale Half toning
%Implementation: Error diffusion using Floyd-Steinberg matrix (Serpentine parsing)
%M-file name: ErrorDiffusion_FS_Serpentine.m
%Output image: output_error_diffused_FS_serpentine
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


gray_scale_bridge=readraw('bridge.raw');
added_error_gray_scale_bridge=gray_scale_bridge;
threshold=127;  %setting the threshold
diffusion_matrix=(1/16)*[0 0 0;0 0 7;3 5 1];
diffusion_matrix_mirrored=(1/16)*[0 0 0;7 0 0;1 5 3];
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
    if(mod(i,2)==0)
    for j=1+(N-1)/2:600+(N-1)/2
        if (added_error_gray_scale_bridge_extended(i,j)>threshold)
            output_error_diffused_FS_serpentine(i-(N-1)/2,j-(N-1)/2)=255;
            else
            output_error_diffused_FS_serpentine(i-(N-1)/2,j-(N-1)/2)=0; 
        end
        
        
        error=added_error_gray_scale_bridge_extended(i,j)-output_error_diffused_FS_serpentine(i-(N-1)/2,j-(N-1)/2);
            

                for k=i-(N-1)/2:i+(N-1)/2
                    for l=j-(N-1)/2:j+(N-1)/2
                    added_error_gray_scale_bridge_extended(k,l)=added_error_gray_scale_bridge_extended(k,l)+error*diffusion_matrix(mod(k-i+(N-1)/2,N)+1,mod(l-j+(N-1)/2,N)+1);
                    end
                end
    end
    elseif(mod(i,2)==1)
        for j=600+(N-1)/2:-1:1+(N-1)/2
            if (added_error_gray_scale_bridge_extended(i,j)>threshold)
            output_error_diffused_FS_serpentine(i-(N-1)/2,j-(N-1)/2)=255;
            else
            output_error_diffused_FS_serpentine(i-(N-1)/2,j-(N-1)/2)=0; 
        end
        error=added_error_gray_scale_bridge_extended(i,j)-output_error_diffused_FS_serpentine(i-(N-1)/2,j-(N-1)/2);
        for k=i-(N-1)/2:i+(N-1)/2
            for l=j-(N-1)/2:j+(N-1)/2
                added_error_gray_scale_bridge_extended(k,l)=added_error_gray_scale_bridge_extended(k,l)+error*diffusion_matrix_mirrored(mod(k-i+(N-1)/2,N)+1,mod(l-j+(N-1)/2,N)+1);
            end
        end
        end
    end
    end



figure(2)
imshow(uint8(output_error_diffused_FS_serpentine));
title('Image obtained by Floyd-Steinberg error diffusion using Serpentine parsing');     

MSE_temp=0;
Max=255;
[N M]=size(gray_scale_bridge);
for i=1:N
    for j=1:M
        MSE_temp=MSE_temp+((output_error_diffused_FS_serpentine(i,j)-gray_scale_bridge(i,j)).^2);
    end
end
MSE=(1/(N*M))*MSE_temp;
PSNR_FS_serpentine=10*log10(Max^2/MSE);
