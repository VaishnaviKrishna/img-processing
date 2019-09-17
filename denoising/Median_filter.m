%Removing impulse noise using median filter
rose_red=readraw_red('rose_color_noise.raw');
rose_green=readraw_green('rose_color_noise.raw');
rose_blue=readraw_blue('rose_color_noise.raw');

filter_size=7;

%denoising impulse noise from red channel

rose_impulse_noise_red=zeros(256+filter_size-1,256+filter_size-1);

for i=1:256          %data centered
    for j=1:256
        rose_impulse_noise_red(i+(filter_size-1)/2,j+(filter_size-1)/2)=rose_red(i,j);
    end
end

%boundary extension
for i=0:((filter_size-1)/2)-1
    rose_impulse_noise_red(:,((filter_size-1)/2)-i)=rose_impulse_noise_red(:,((filter_size-1)/2)+i+1);
    rose_impulse_noise_red(:,256+((filter_size-1)/2)+i+1)=rose_impulse_noise_red(:,256+((filter_size-1)/2)-i);
    rose_impulse_noise_red(((filter_size-1)/2)-i,:)=rose_impulse_noise_red(((filter_size-1)/2)+i+1,:);
    rose_impulse_noise_red((256+(filter_size-1)/2)+i+1,:)=rose_impulse_noise_red((256+(filter_size-1)/2)-i,:);
end


for i=1+(filter_size-1)/2:256+(filter_size-1)/2
    for j=1+(filter_size-1)/2:256+(filter_size-1)/2
         count=1;
        for k=i-(filter_size-1)/2:i+(filter_size-1)/2
            for l=j-(filter_size-1)/2:j+(filter_size-1)/2
               temp(count)=rose_impulse_noise_red(k,l);
               count=count+1;
            end
        end
      for range=1:filter_size*filter_size
          for k=range:filter_size*filter_size
          if (temp(k)<=temp(range))
              temp_1=temp(k);
              temp(k)=temp(range);
              temp(range)=temp_1;
          end
          end
      end
      values_sorted=temp;
      rose_impulse_denoised_red(i-(filter_size-1)/2,j-(filter_size-1)/2)=values_sorted(((filter_size*filter_size)-1)/2);
      
    end
end

%denoising impulse noise from green channel

rose_impulse_noise_green=zeros(256+filter_size-1,256+filter_size-1);

for i=1:256          %data centered
    for j=1:256
        rose_impulse_noise_green(i+(filter_size-1)/2,j+(filter_size-1)/2)=rose_green(i,j);
    end
end

%boundary extension
for i=0:((filter_size-1)/2)-1
    rose_impulse_noise_green(:,((filter_size-1)/2)-i)=rose_impulse_noise_green(:,((filter_size-1)/2)+i+1);
    rose_impulse_noise_green(:,256+((filter_size-1)/2)+i+1)=rose_impulse_noise_green(:,256+((filter_size-1)/2)-i);
    rose_impulse_noise_green(((filter_size-1)/2)-i,:)=rose_impulse_noise_green(((filter_size-1)/2)+i+1,:);
    rose_impulse_noise_green((256+(filter_size-1)/2)+i+1,:)=rose_impulse_noise_green((256+(filter_size-1)/2)-i,:);
end


for i=1+(filter_size-1)/2:256+(filter_size-1)/2
    for j=1+(filter_size-1)/2:256+(filter_size-1)/2
         count=1;
        for k=i-(filter_size-1)/2:i+(filter_size-1)/2
            for l=j-(filter_size-1)/2:j+(filter_size-1)/2
               temp(count)=rose_impulse_noise_green(k,l);
               count=count+1;
            end
        end
      for range=1:filter_size*filter_size
          for k=range:filter_size*filter_size
          if (temp(k)<=temp(range))
              temp_1=temp(k);
              temp(k)=temp(range);
              temp(range)=temp_1;
          end
          end
      end
      values_sorted=temp;
      rose_impulse_denoised_green(i-(filter_size-1)/2,j-(filter_size-1)/2)=values_sorted(((filter_size*filter_size)-1)/2);
      
    end
end



%denoising impulse noise from green channel

rose_impulse_noise_blue=zeros(256+filter_size-1,256+filter_size-1);

for i=1:256          %data centered
    for j=1:256
        rose_impulse_noise_blue(i+(filter_size-1)/2,j+(filter_size-1)/2)=rose_blue(i,j);
    end
end

%boundary extension
for i=0:((filter_size-1)/2)-1
    rose_impulse_noise_blue(:,((filter_size-1)/2)-i)=rose_impulse_noise_blue(:,((filter_size-1)/2)+i+1);
    rose_impulse_noise_blue(:,256+((filter_size-1)/2)+i+1)=rose_impulse_noise_blue(:,256+((filter_size-1)/2)-i);
    rose_impulse_noise_blue(((filter_size-1)/2)-i,:)=rose_impulse_noise_blue(((filter_size-1)/2)+i+1,:);
    rose_impulse_noise_blue((256+(filter_size-1)/2)+i+1,:)=rose_impulse_noise_blue((256+(filter_size-1)/2)-i,:);
end


for i=1+(filter_size-1)/2:256+(filter_size-1)/2
    for j=1+(filter_size-1)/2:256+(filter_size-1)/2
         count=1;
        for k=i-(filter_size-1)/2:i+(filter_size-1)/2
            for l=j-(filter_size-1)/2:j+(filter_size-1)/2
               temp(count)=rose_impulse_noise_blue(k,l);
               count=count+1;
            end
        end
      for range=1:filter_size*filter_size
          for k=range:filter_size*filter_size
          if (temp(k)<=temp(range))
              temp_1=temp(k);
              temp(k)=temp(range);
              temp(range)=temp_1;
          end
          end
      end
      values_sorted=temp;
      rose_impulse_denoised_blue(i-(filter_size-1)/2,j-(filter_size-1)/2)=values_sorted(((filter_size*filter_size)-1)/2);
      
    end
end

rose_impulse_denoised(:,:,1)=rose_impulse_denoised_red;
rose_impulse_denoised(:,:,2)=rose_impulse_denoised_green;
rose_impulse_denoised(:,:,3)=rose_impulse_denoised_blue;

imshow(mat2gray(rose_impulse_denoised));
title('Denoised rose image using median filter');