%Histogram equalization using transfer function method (Method A)

data=readraw('rose_bright.raw');
freq_data(:,1)=0:255;
output_data(:,1)=0:255;
freq_data(:,2)=zeros(256,1);
output_data(:,2)=zeros(256,1);

for i=1:400
    for j=1:400
     freq_data(data(i,j)+1,2)=freq_data(data(i,j)+1,2)+1;  %counting the occurence of each pixel
     end
end

freq_data(:,2)=freq_data(:,2)./160000;  %normalizing by the total number of pixels

for i=1:256
    sum=0;
    for j=1:i
       sum=sum+freq_data(j,2); %calculating the cumulative sum
    end
    freq_data(i,3)=sum;
end

data_new=zeros(400,400);    %to find the new set of pixel values 
for i=1:400
    for j=1:400
        data_new(i,j)=freq_data(data(i,j)+1,3)*255;
    end
end


for i=1:400
    for j=1:400
     output_data((round(data_new(i,j))+1),2)=output_data((round(data_new(i,j))+1),2)+1;
     end
end

output_data(:,2)=output_data(:,2)./160000;  %normalizing

for i=1:256
   sum=0;
    for j=1:i
       sum=sum+output_data(j,2);    %calculating the cumulative sum
    end
    output_data(i,3)=sum;
        
end



figure(1)
subplot(2,2,1);
stem(freq_data(:,1),freq_data(:,2)*160000,'-');
xlabel('Intensity');
ylabel('Number of pixels');
title('Original histogram');

subplot(2,2,2);
plot(freq_data(:,1),freq_data(:,3),'-');
xlabel('Intensity');
ylabel('Input CDF');

subplot(2,2,3);
stem(freq_data(:,1),output_data(:,2)*160000,'-');
xlabel('Intensity');
ylabel('Number of pixels');
title('Enhanced histogram (Method A)');


subplot(2,2,4);
plot(freq_data(:,1),output_data(:,3),'-');
xlabel('Intensity');
ylabel('Output CDF');
   
figure(2)
subplot(1,2,1)
imshow(uint8(data));
subplot(1,2,2)
imshow(uint8(data_new));

figure(3)
plot(freq_data(:,1),freq_data(:,3)*255,'-');
title('Transfer function');

figure(4)
stem(freq_data(:,1),output_data(:,2)*160000,'-');
xlabel('Intensity');
ylabel('Number of pixels');
title('Enhanced histogram of the rose bright image using transfer function method'); 
