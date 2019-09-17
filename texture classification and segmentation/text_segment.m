%EE 569 Homework Assignment#4
%Date: 03/19/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Texture Analysis
%Implementation: Texture Segmentation
%M-file name: text_segment.m
%Input  : M
%Output : segmented,segmented_reduced
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


combined_texture=readraw('comb.raw');
N=5; %Laws filter size
texture_filtered=Laws_filter_combined(5,combined_texture);
M=21; %energy window size
energy_filtered=energy_per_pixel(M,texture_filtered);

count=1;
data=zeros(510*510,25);
for i=1:510
    for j=1:510
        E=[energy_filtered(i,j,1) energy_filtered(i,j,2) energy_filtered(i,j,3) energy_filtered(i,j,4) energy_filtered(i,j,5) energy_filtered(i,j,6) energy_filtered(i,j,7) energy_filtered(i,j,8) energy_filtered(i,j,9) energy_filtered(i,j,10) energy_filtered(i,j,11) energy_filtered(i,j,12) energy_filtered(i,j,13) energy_filtered(i,j,14) energy_filtered(i,j,15) energy_filtered(i,j,16) energy_filtered(i,j,17) energy_filtered(i,j,18) energy_filtered(i,j,19) energy_filtered(i,j,20) energy_filtered(i,j,21) energy_filtered(i,j,22) energy_filtered(i,j,23) energy_filtered(i,j,24) energy_filtered(i,j,25)];
        E_normalized=E./energy_filtered(i,j,1);          %E_normalized=(E-mean(E))./std(E,1);
        data(count,:)=E_normalized;
        count=count+1;
    end
end

[idx]=kmeans(data,7);
i=1;
j=1;
label=zeros(510,510);
for k=1:(510*510)
    
    label(i,j)=idx(k,1);
    j=j+1;
    
    if(mod(k,510)==0)
        i=i+1;
        j=1;
    end
        
end

for i=1:510
    for j=1:510
        if(label(i,j)==1)
            segmented(i,j)=0;
        elseif(label(i,j)==2)
            segemented(i,j)=42;
        elseif(label(i,j)==3)
            segmented(i,j)=84;
        elseif(label(i,j)==4)
            segmented(i,j)=126;
        elseif(label(i,j)==5)
            segmented(i,j)=168;
        elseif(label(i,j)==6)
            segmented(i,j)=210;
        elseif(label(i,j)==7)
            segmented(i,j)=255;
        end
    end
end

figure(1)
imshow(uint8(segmented));
title('Segmented image with window size = 21');

%Computing PCA

[coeff score]=pca(data,'NumComponents',5);
data_reduced=score*coeff';
[idx_PCA]=kmeans(data_reduced,5);

i=1;
j=1;
label_reduced=zeros(510,510);
for k=1:(510*510)
    
    label_reduced(i,j)=idx(k,1);
    j=j+1;
    
    if(mod(k,510)==0)
        i=i+1;
        j=1;
    end
        
end

for i=1:510
    for j=1:510
        if(label_reduced(i,j)==1)
            segmented_reduced(i,j)=0;
        elseif(label_reduced(i,j)==2)
            segmented_reduced(i,j)=42;
        elseif(label_reduced(i,j)==3)
            segmented_reduced(i,j)=84;
        elseif(label_reduced(i,j)==4)
            segmented_reduced(i,j)=126;
        elseif(label_reduced(i,j)==5)
            segmented_reduced(i,j)=168;
        elseif(label_reduced(i,j)==6)
            segmented_reduced(i,j)=210;
        elseif(label_reduced(i,j)==7)
            segmented_reduced(i,j)=255;
        end
    end
end

figure(2)
imshow(uint8(segmented_reduced));
title('Segmented image with window size = 21 after PCA with number of principal components = 5');
