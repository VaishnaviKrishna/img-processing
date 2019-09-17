data=readraw('cat.raw');

%Separating the image into 3 channels
for i=1:300
    for j=1:390
if (mod(i,2)==0 & mod(j+1,2)==0)   %condition for blue pixel location in the Bayer pattern
    data_blue_MHC(i,j)=data(i,j);
    data_green_MHC(i,j)=0;
    data_red_MHC(i,j)=0;
    
elseif (mod(i+1,2)==0 & mod(j,2)==0) %condition for red pixel location in the Bayer pattern
    data_red_MHC(i,j)=data(i,j);
    data_green_MHC(i,j)=0;
    data_blue_MHC(i,j)=0;
else
    data_green_MHC(i,j)=data(i,j); %otherwise green
    data_blue_MHC(i,j)=0;
    data_red_MHC(i,j)=0;
end
    end
end
%end

%mirroring the boundaries for interpolation at the edges upto 2 rows and
%columns

for i=1:300
    for j=1:390
        data_append(i+2,j+2)=data(i,j);
    end
end

for i=1:300
data_append(i+2,1)=data(i,2);
data_append(i+2,2)=data(i,1);
end
for i=1:300 
data_append(i+2,393)=data(i,390);
data_append(i+2,394)=data(i,389);
end
for j=1:394
    data_append(1,j)=data_append(4,j);
    data_append(2,j)=data_append(3,j);
end

for j=1:394
    data_append(303,j)=data_append(302,j);
    data_append(304,j)=data_append(301,j);
end
%end

%interpolating red color in each pixel

for i=3:302
    for j=3:392
        if (mod(i,2)==0 && mod(j+1,2)==0)   % condition for blue sensor in Bayer pattern
        data_red_MHC(i-2,j-2)=(1/8)*(6*data_append(i,j)+2*(data_append(i-1,j-1)+data_append(i-1,j+1)+data_append(i+1,j-1)+data_append(i+1,j+1))+(-3/2)*(data_append(i-2,j)+data_append(i+2,j)+data_append(i,j-2)+data_append(i,j+2)));
        elseif (mod(i+1,2)==0 && mod(j,2)==0) %condition for red sensor in Bayer pattern
            data_red_MHC(i-2,j-2)=data_append(i,j);
        else                                     %condition for green
            if (mod(i,2)==0 && mod(j,2)==0)  %condition for B row R col
            data_red_MHC(i-2,j-2)=(1/8)*(5*data_append(i,j)+4*(data_append(i-1,j)+data_append(i+1,j))+(-1)*(data_append(i-2,j)+data_append(i+2,j))+(1/2)*(data_append(i,j-2)+data_append(i,j+2))+(-1)*(data_append(i-1,j-1)+data_append(i-1,j+1)+data_append(i+1,j-1)+data_append(i+1,j+1)));
            elseif (mod(i+1,2)==0 && mod(j+1,2)==0)  %condition for R row B col
            data_red_MHC(i-2,j-2)=(1/8)*(5*data_append(i,j)+4*(data_append(i,j-1)+data_append(i,j+1))+(-1)*(data_append(i,j-2)+data_append(i,j+2))+(1/2)*(data_append(i-2,j)+data_append(i+2,j))+(-1)*(data_append(i-1,j-1)+data_append(i-1,j+1)+data_append(i+1,j-1)+data_append(i+1,j+1)));
            end
        end
    end
end
    
   %interpolating blue color in each pixel
   
   for i=3:302
    for j=3:392
        if (mod(i,2)==0 && mod(j+1,2)==0)   % condition for blue sensor in Bayer pattern
            data_blue_MHC(i-2,j-2)=data_append(i,j);
        elseif (mod(i+1,2)==0 && mod(j,2)==0)  %condition for red sensor in Bayer pattern 
            data_blue_MHC(i-2,j-2)=(1/8)*(6*data_append(i,j)+2*(data_append(i-1,j-1)+data_append(i-1,j+1)+data_append(i+1,j-1)+data_append(i+1,j+1))+(-3/2)*(data_append(i-2,j)+data_append(i+2,j)+data_append(i,j-2)+data_append(i,j+2)));
        else
            if (mod(i,2)==0 && mod(j,2)==0)  %condition for B row R col
              data_blue_MHC(i-2,j-2)=(1/8)*(4*(data_append(i,j-1)+data_append(i,j+1))+5*data_append(i,j)+(-1)*(data_append(i,j-2)+data_append(i,j+2))+(1/2)*(data_append(i-2,j)+data_append(i+2,j))+(-1)*(data_append(i-1,j-1)+data_append(i-1,j+1)+data_append(i+1,j-1)+data_append(i+1,j-1)));
            elseif (mod(i+1,2)==0 && mod(j+1,2)==0)  %condition for R row B col
              data_blue_MHC(i-2,j-2)=(1/8)*(4*(data_append(i-1,j)+data_append(i+1,j))+5*data_append(i,j)+(-1)*(data_append(i-2,j)+data_append(i+2,j))+(1/2)*(data_append(i,j-2)+data_append(i,j+2))+(-1)*(data_append(i-1,j-1)+data_append(i-1,j+1)+data_append(i+1,j-1)+data_append(i+1,j-1)));
            end
        end
    end
   end
   
   
  %interpolating green color in each pixel
   
   for i=3:302
    for j=3:392
        if (mod(i,2)==0 && mod(j+1,2)==0)   % condition for blue sensor in Bayer pattern
            data_green_MHC(i-2,j-2)=(1/8)*(4*(data_append(i,j))+2*(data_append(i-1,j)+data_append(i+1,j)+data_append(i,j-1)+data_append(i,j+1))+(-1)*(data_append(i-2,j)+data_append(i+2,j)+data_append(i,j-2)+data_append(i,j+2)));
        elseif (mod(i+1,2)==0 && mod(j,2)==0) %condition for red sensor in Bayer pattern
            data_green_MHC(i-2,j-2)=(1/8)*(4*(data_append(i,j))+2*(data_append(i-1,j)+data_append(i+1,j)+data_append(i,j-1)+data_append(i,j+1))+(-1)*(data_append(i-2,j)+data_append(i+2,j)+data_append(i,j-2)+data_append(i,j+2)));
        end
    end
   end
   
   
   demosaiced_MHC(:,:,1)=data_red_MHC;
   demosaiced_MHC(:,:,2)=data_green_MHC;
   demosaiced_MHC(:,:,3)=data_blue_MHC;
   
   figure(1)
   imshow(uint8(demosaiced_MHC));
   title('Image obtained after MHC demosaicing');       
            




