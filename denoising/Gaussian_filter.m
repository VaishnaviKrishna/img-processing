%Image denoising using gaussian low pass filter

noise_free_image=readraw('pepper.raw');
Max=255;    %Max for 8 bit is 255
[N M]=size(noise_free_image);

for sigma=1:5:16
pepper_noise=readraw('pepper_uni.raw');
for filter_size=3:2:9  %any odd number except 1
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

% denoising using uniform mean filter

    for i=1+(filter_size-1)/2:256+(filter_size-1)/2
    for j=1+(filter_size-1)/2:256+(filter_size-1)/2
        total_neighbour_intensity=0;
        neighbour_intensity_weighted=0;
        gaussian_kernel_total=0;
        intensity_window=pepper_noise_extended((i-(filter_size-1)/2:i+(filter_size-1)/2),(j-(filter_size-1)/2:j+(filter_size-1)/2));
        intensity_value(i-(filter_size-1)/2:i+(filter_size-1)/2,j-(filter_size-1)/2:j+(filter_size-1)/2)=intensity_window;
        
        for k=i-(filter_size-1)/2:i+(filter_size-1)/2
            for l=j-(filter_size-1)/2:j+(filter_size-1)/2
                neighbour_intensity=intensity_value(k,l);
                gaussian_kernel=(1/sqrt(2*pi*sigma))*exp(-1*((k-i)^2+(l-j)^2)/(2*sigma^2));
                gaussian_kernel_total=gaussian_kernel_total+gaussian_kernel;
                neighbour_intensity_weighted=neighbour_intensity*gaussian_kernel;
                total_neighbour_intensity=total_neighbour_intensity+neighbour_intensity_weighted;
            end
        end
       
        pepper_denoised_gaussian(i-(filter_size-1)/2,j-(filter_size-1)/2)=total_neighbour_intensity/gaussian_kernel_total;  
        MSE_particular=(pepper_denoised_gaussian(i-(filter_size-1)/2,j-(filter_size-1)/2)-noise_free_image(i-(filter_size-1)/2,j-(filter_size-1)/2))^2;
        MSE_total=MSE_total+MSE_particular;
     
    end
    end
    
    %disp(MSE_total);
    MSE=(1/(N*M))*MSE_total;       
    PSNR_gaussian((filter_size-1)/2,1)=filter_size;
    PSNR_gaussian((filter_size-1)/2,2)=10*log10(Max^2/MSE); 
    
end
    figure(10)
    plot(PSNR_gaussian(:,1),PSNR_gaussian(:,2),'-*');
    xlabel('Size of the N*N window');
    ylabel('PSNR in dB');
    title('Plot of PSNR (dB) against window size');
    
    hold on
    
end

figure(1)
plot(PSNR_gaussian(:,1),PSNR_gaussian(:,2),'-*');
xlabel('Size of the N*N window');
ylabel('PSNR in dB');
title('Plot of PSNR (dB) against window size');

%figure(1)
%subplot(1,2,1)
%figure(2)
%imshow(uint8(pepper_denoised_uniform));
%title('Denoised Pepper image using Gaussian filter');
%subplot(1,2,2)
%imshow(mat2gray(pepper_noise));


% subplot(1,2,1)
% plot(PSNR_gaussian(:,1),PSNR_gaussian(:,2),'-*');
% xlabel('Window size (N)');
% ylabel('PSNR in dB');
% title('Plot of PSNR (dB) against window size N for standard deviation = 1');

%subplot(1,2,2)
figure(3)
imshow(uint8(pepper_denoised_gaussian));
title('Denoised Pepper image using 9*9 Gaussian filter');

