data=readraw('rose_bright.raw');

freq_data=zeros(256,3);
freq_data(:,1)=0:255;
location = zeros();
data_new = zeros(400,400);
current_basket = 0;
current_index = 0;
search_pixel_pointer=0;
search_pixel_count=0;

for search_pixel = 0:255
    
for i = 1:400
    for j = 1:400
        if (data(i,j) == search_pixel)
            location(search_pixel_pointer+1,1)=i;
            location(search_pixel_pointer+1,2)=j;
            search_pixel_count = search_pixel_count+1;
            search_pixel_pointer = search_pixel_pointer+1;
        end
    end
end

remainder = mod(search_pixel_count,625);
quotient = (search_pixel_count-remainder)/625;


for basket = current_basket:(current_basket + quotient)-1
    k=1;
    
    while (k <= 625)
        data_new(location(current_index+k,1),location(current_index+k,2))= basket;
        k = k + 1;
    end
    current_index = current_index + 625;
end
current_basket = (current_basket + quotient);
search_pixel_count = remainder;
end

for i=1:400
    for j=1:400
     freq_data(data_new(i,j)+1,2)=freq_data(data_new(i,j)+1,2)+1;
    end
end
freq_data(:,2)=freq_data(:,2)./160000;

for i=1:256
   sum=0;
    for j=1:i
       sum=sum+freq_data(j,2);    %calculating the cumulative sum
    end
    freq_data(i,3)=sum;
        
end

figure(1)
subplot(1,2,1);
plot(freq_data(:,1),freq_data(:,3),'-');
xlabel('Intensity');
ylabel('Normalized occurrences of pixels');
title('CDF of the enhanced rose bright image'); 

subplot(1,2,2)
imshow(uint8(data_new));
title('Enhanced rose bright image using Method B'); 

