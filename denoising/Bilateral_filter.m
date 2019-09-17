%Image denoising using bilateral filter

noise_free_image=readraw('pepper.raw');
Max=255;    %Max for 8 bit is 255
[N M]=size(noise_free_image);
for sigma_c=20:20:100
%sigma_s=40;
%filter_size=7;
pepper_noise=readraw('pepper_uni.raw');
for filter_size=3:2:9    %any odd number except 1
    sigma_s=sigma_c;
    MSE_particular=0;
    MSE_total=0;
    pepper_noise_extended=zeros(256+filter_size-1,256+filter_size-1);

for i=1:256          %data centered
    for j=1:256
        pepper_noise_extended(i+(filter_size-1)/2,j+(filter_size-1)/2)=pepper_noise(i,j);
    end
end

%boundary extension
for i=0:((filter_size-1)/2)-1
    pepper_noise_extended(:,((filter_size-1)/2)-i)=pepper_noise_extended(:,((filter_size-1)/2)+i+1);
    pepper_noise_extended(:,256+((filter_size-1)/2)+i+1)=pepper_noise_extended(:,256+((filter_size-1)/2)-i);
    pepper_noise_extended(((filter_size-1)/2)-i,:)=pepper_noise_extended(((filter_size-1)/2)+i+1,:);
    pepper_noise_extended((256+(filter_size-1)/2)+i+1,:)=pepper_noise_extended((256+(filter_size-1)/2)-i,:);
end

% denoising using bilateral filter

    for i=1+(filter_size-1)/2:256+(filter_size-1)/2
    for j=1+(filter_size-1)/2:256+(filter_size-1)/2
        total_neighbour_intensity=0;
        neighbour_intensity_weighted=0;
        bilateral_kernel_total=0;
        %intensity_window=pepper_noise_extended((i-(filter_size-1)/2:i+(filter_size-1)/2),(j-(filter_size-1)/2:j+(filter_size-1)/2));
        
        
        for k=i-(filter_size-1)/2:i+(filter_size-1)/2
            for l=j-(filter_size-1)/2:j+(filter_size-1)/2
                neighbour_intensity=pepper_noise_extended(k,l);
                bilateral_kernel=exp(-((i-k)^2+(j-l)^2)/(2*sigma_c^2)-((pepper_noise_extended(i,j)-pepper_noise_extended(k,l)).^2/(2*sigma_s^2)));
                bilateral_kernel_total=bilateral_kernel_total+bilateral_kernel;
                neighbour_intensity_weighted=neighbour_intensity*bilateral_kernel;
                total_neighbour_intensity=total_neighbour_intensity+neighbour_intensity_weighted;
            end
        end
       
        pepper_denoised_bilateral(i-(filter_size-1)/2,j-(filter_size-1)/2)=total_neighbour_intensity/bilateral_kernel_total; 
        MSE_particular=(pepper_denoised_bilateral(i-(filter_size-1)/2,j-(filter_size-1)/2)-noise_free_image(i-(filter_size-1)/2,j-(filter_size-1)/2))^2;
        MSE_total=MSE_total+MSE_particular;
     
    end
    end
    
    MSE_bilateral=(1/(N*M))*MSE_total;       
    PSNR_bilateral((filter_size-1)/2,1)=filter_size;
    PSNR_bilateral((filter_size-1)/2,2)=10*log10(Max^2/MSE_bilateral);
    %disp(PSNR_bilateral(:,2));
%end
end
    figure(10)
    plot(PSNR_bilateral(:,1),PSNR_bilateral(:,2),'-*');
    xlabel('Size of the N*N window');
    ylabel('PSNR in dB');
    title('Plot of PSNR (dB) against window size');
    
   hold on


end

% PSNR of the noisy input image



figure(1)
plot(PSNR_bilateral(:,1),PSNR_bilateral(:,2),'-*');
%hold on
%plot(PSNR_noisy(:,1),PSNR_noisy(:,2),'-*');
figure(2)
subplot(1,2,1)
imshow(uint8(pepper_denoised_bilateral));
%writeraw(pepper_denoised_bilateral,'Pepper_Denoised_Gaussian.raw');
subplot(1,2,2)
imshow(uint8(pepper_noise));

figure(3)
% subplot(1,2,1)
% plot(PSNR_bilateral(:,1),PSNR_bilateral(:,2),'-*');
% xlabel('Window size (N)');
% ylabel('PSNR in dB');
% title('Plot of PSNR (dB) against window size N with spread parameters = 40');
% 
% subplot(1,2,2)
imshow(uint8(pepper_denoised_bilateral));
title('Denoised Pepper image using Bilateral filter');