%EE 569 Homework Assignment#2
%Date: 02/11/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Gray-Scale Half toning
%Implementation: Dithering
%M-file name: Dithering.m
%Output image: dither_output_2; dither_output_8; dither_output_32; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


gray_scale_bridge=readraw('bridge.raw');

%creating the index matrices
I_2=[1 2;3 0];
I_4=[4.*I_2+ones(2,2) 4.*I_2+2*ones(2,2);4.*I_2+3*ones(2,2) 4.*I_2];
I_8=[4.*I_4+ones(4,4) 4.*I_4+2*ones(4,4);4.*I_4+3*ones(4,4) 4.*I_4];
I_16=[4.*I_8+ones(8,8) 4.*I_8+2*ones(8,8);4.*I_8+3*ones(8,8) 4.*I_8];
I_32=[4.*I_16+ones(16,16) 4.*I_16+2*ones(16,16);4.*I_16+3*ones(16,16) 4.*I_16];
%end

%creating the threshold matrices for I_2,I_8 and I_32
[N M]=size(I_2);
for i=1:N
    for j=1:M
    T_2(i,j)=(I_2(i,j)+0.5)*255./(N*M);
    end
end

[N M]=size(I_8);
for i=1:N
    for j=1:M
    T_8(i,j)=(I_8(i,j)+0.5)*255./(N*M);
    end
end

[N M]=size(I_32);
for i=1:N
    for j=1:M
    T_32(i,j)=(I_32(i,j)+0.5)*255./(N*M);
    end
end

%Applying the threshold materror=added_error_gray_scale_bridge_extended(i,j)-binarized(i,j);rices to the halftone
[N M]=size(I_2);
for i=1:400
    for j=1:600
        if (gray_scale_bridge(i,j)>=0 && gray_scale_bridge(i,j)<=T_2(mod(i,N)+1,mod(j,M)+1))
        dither_output_2(i,j)=0;
        elseif(gray_scale_bridge(i,j)<256 && gray_scale_bridge(i,j)>T_2(mod(i,N)+1,mod(j,M)+1))
        dither_output_2(i,j)=255;
        end
    end
end

[N M]=size(I_8);
for i=1:400
    for j=1:600
        if (gray_scale_bridge(i,j)>=0 && gray_scale_bridge(i,j)<=T_8(mod(i,N)+1,mod(j,M)+1))
        dither_output_8(i,j)=0;
        elseif(gray_scale_bridge(i,j)<256 && gray_scale_bridge(i,j)>T_8(mod(i,N)+1,mod(j,M)+1))
        dither_output_8(i,j)=255;
        end
    end
end

[N M]=size(I_32);
for i=1:400
    for j=1:600
        if (gray_scale_bridge(i,j)>=0 && gray_scale_bridge(i,j)<=T_32(mod(i,N)+1,mod(j,M)+1))
        dither_output_32(i,j)=0;
        elseif(gray_scale_bridge(i,j)<256 && gray_scale_bridge(i,j)>T_32(mod(i,N)+1,mod(j,M)+1))
        dither_output_32(i,j)=255;
        end
    end
end

figure(1);
imshow(uint8(dither_output_2));
title('Output image obtained through dithering using I(2) thresholding matrix');
figure(2);
imshow(uint8(dither_output_8));
title('Output image obtained through dithering using I(8) thresholding matrix');
figure(3);
imshow(uint8(dither_output_32));
title('Output image obtained through dithering using I(32) thresholding matrix');
