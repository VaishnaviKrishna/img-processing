data=readraw('cat.raw');
%data_original=readraw('cat_ori.raw');
[N M]=size(data);
filter_size=3;

%Separating the image into 3 channels
for i=1:300
    for j=1:390
if (mod(i,2)==0 & mod(j+1,2)==0)   %condition for blue pixel location in the Bayer pattern
    data_blue(i,j)=data(i,j);
    data_green(i,j)=0;
    data_red(i,j)=0;
    
elseif (mod(i+1,2)==0 & mod(j,2)==0) %condition for red pixel location in the Bayer pattern
    data_red(i,j)=data(i,j);
    data_green(i,j)=0;
    data_blue(i,j)=0;
else
    data_green(i,j)=data(i,j); %otherwise green
    data_blue(i,j)=0;
    data_red(i,j)=0;
end
    end
end
%end

%extending the boundaries for interpolation at the edges

data_extended=zeros(N+filter_size-1,M+filter_size-1);


for i=1:N          %data centered
    for j=1:M
        data_extended(i+(filter_size-1)/2,j+(filter_size-1)/2)=data(i,j);
    end
end

%boundary extension about the pixels at the edge
for i=1:((filter_size-1)/2)
    data_extended(:,((filter_size-1)/2))=data_extended(:,((filter_size-1)/2)+i+1);
    data_extended(:,M+((filter_size-1)/2)+1)=data_extended(:,M+((filter_size-1)/2)-i);
    data_extended(((filter_size-1)/2),:)=data_extended(((filter_size-1)/2)+i+1,:);
    data_extended((N+(filter_size-1)/2)+1,:)=data_extended((N+(filter_size-1)/2)-i,:);
end

%interpolating red color at each pixel


for i=2:301
    for j=2:391
        if (mod(i+1,2)==0 & mod(j,2)==0)  %condition for blue sensor in CFA
            data_red(i-1,j-1)=1/4*(data_extended(i-1,j-1)+data_extended(i-1,j+1)+data_extended(i+1,j-1)+data_extended(i+1,j+1));
        elseif (mod(i,2)==0 & mod(j+1,2)==0)   %condition for red sensor in CFA
            data_red(i-1,j-1)=data_extended(i,j);
        else
            if (mod(i,2)==0 & mod(j,2)==0)
            data_red(i-1,j-1)=1/2*(data_extended(i,j-1)+data_extended(i,j+1)); %otherwise green
            elseif (mod(i+1,2)==0 & mod(j+1,2)==0)
            data_red(i-1,j-1)=1/2*(data_extended(i-1,j)+data_extended(i+1,j));
            end
                
        end
    end
end

%interpolating blue color at each pixel

for i=2:301
    for j=2:391
        if (mod(i,2)==0 & mod(j+1,2)==0)  %condition for red sensor in CFA
            data_blue(i-1,j-1)=1/4*(data_extended(i-1,j-1)+data_extended(i-1,j+1)+data_extended(i+1,j-1)+data_extended(i+1,j+1));
        elseif (mod(i+1,2)==0 & mod(j,2)==0)  % condition for blue sensor in CFA
            data_blue(i-1,j-1)=data_extended(i,j);
        else                         %otherwise green
             
            if (mod(i,2)==0 & mod(j,2)==0)
            data_blue(i-1,j-1)=1/2*(data_extended(i-1,j)+data_extended(i+1,j)); %otherwise green
            elseif (mod(i+1,2)==0 & mod(j+1,2)==0)
            data_blue(i-1,j-1)=1/2*(data_extended(i,j-1)+data_extended(i,j+1));
            end
        end
    end
end

%interpolating green color at each pixel

for i=2:301
    for j=2:391
        if (mod(i,2)==0 & mod(j+1,2)==0)  %condition for red sensor in CFA
            data_green(i-1,j-1)=1/4*(data_extended(i-1,j)+data_extended(i+1,j)+data_extended(i,j-1)+data_extended(i,j+1));
        elseif (mod(i+1,2)==0 & mod(j,2)==0)   % condition for blue sensor in CFA
            data_green(i-1,j-1)=1/4*(data_extended(i-1,j)+data_extended(i+1,j)+data_extended(i,j-1)+data_extended(i,j+1));
        else
            data_green(i-1,j-1)=data_extended(i,j);
        end
    end
end

demosaiced_bilinear_interpolation(1:300,1:390,1)=data_red(1:300,1:390);
demosaiced_bilinear_interpolation(1:300,1:390,2)=data_green(1:300,1:390);
demosaiced_bilinear_interpolation(1:300,1:390,3)=data_blue(1:300,1:390);

figure(7)
imshow(uint8(demosaiced_bilinear_interpolation));
title('Image obtained after bilinear demosaicing');

% figure(2)
% subplot(2,1,1)
% plot((25:50),data_red(57,25:50),'-*');
% title('Interpolated red plane using bilinear demosaicing');
% subplot(2,1,2)
% plot((25:50),data_red_MHC(57,25:50),'-*');
% title('Interpolated red plane using MHC demosaicing'); 
% 
% figure(3)
% subplot(2,1,1)
% plot((25:50),data_green(57,25:50),'-*');
% title('Interpolated green plane using bilinear demosaicing');
% subplot(2,1,2)
% plot((25:50),data_green_MHC(57,25:50),'-*');
% title('Interpolated green plane using MHC demosaicing'); 
% 
% figure(4)
% subplot(2,1,1)
% plot((25:50),data_blue(57,25:50),'-*');
% title('Interpolated blue plane using bilinear demosaicing');
% subplot(2,1,2)
% plot((25:50),data_blue_MHC(57,25:50),'-*');
% title('Interpolated blue plane using MHC demosaicing'); 