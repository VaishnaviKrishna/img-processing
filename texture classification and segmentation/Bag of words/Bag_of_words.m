%EE 569 Homework Assignment#4
%Date: 03/19/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Image Matching and Classification
%Implementation: Bag of Visual Words
%M-file name: Bag_of_words.m
%Input  : n (scaling value)
%Output : Y (total count in each of the bin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;
n=3;  %resizing scale

image1=readraw('zero_1.raw');
image1_resized=imresize(image1,n);
[F1 D1]=vl_sift(single(image1_resized));

image2=readraw('zero_2.raw');
image2_resized=imresize(image2,n);
[F2 D2]=vl_sift(single(image2_resized));

image3=readraw('zero_3.raw');
image3_resized=imresize(image3,n);
[F3 D3]=vl_sift(single(image3_resized));

image4=readraw('zero_4.raw');
image4_resized=imresize(image4,n);
[F4 D4]=vl_sift(single(image4_resized));

image5=readraw('zero_5.raw');
image5_resized=imresize(image5,n);
[F5 D5]=vl_sift(single(image5_resized));

image6=readraw('one_1.raw');
image6_resized=imresize(image6,n);
[F6 D6]=vl_sift(single(image6_resized));

image7=readraw('one_2.raw');
image7_resized=imresize(image7,n);
[F7 D7]=vl_sift(single(image7_resized));

image8=readraw('one_3.raw');
image8_resized=imresize(image8,n);
[F8 D8]=vl_sift(single(image8_resized));

image9=readraw('one_4.raw');
image9_resized=imresize(image9,n);
[F9 D9]=vl_sift(single(image9_resized));

image10=readraw('one_5.raw');
image10_resized=imresize(image10,n);
[F10 D10]=vl_sift(single(image10_resized));

feature_vector=[D1';D2';D3';D4';D5';D6';D7';D8';D9';D10'];
k=2;
[idx,C]=kmeans(double(feature_vector),k);
centroid_location=C';

%Histograms for ones and zeros- training data

X=[D1';D2';D3';D4';D5'];

count_1=0;
count_2=0;
[A,B]=size(X);

for i=1:A
    if (idx(i)==1)
        count_1=count_1+1;
    else
        count_2=count_2+1;
    end
end

X=[0 1];
Y=[count_1 count_2];
figure(1);
bar(X,Y,0.05);
title('Histogram for Bag of visual words for training image zero');
xlabel('Number of centroids (classes) in the training codebook');
ylabel('Total count for each class');

Y=[D6';D7';D8';D9';D10'];

count_1=0;
count_2=0;
[J,K]=size(Y);

for i=A+1:A+J
    if (idx(i)==2)
        count_2=count_2+1;
    else
        count_1=count_1+1;
    end
end

X=[0 1];
Y=[count_1 count_2];
figure(2);
bar(X,Y,0.05);
title('Histogram for Bag of visual words for training image one');
xlabel('Number of centroids (classes) in the training codebook');
ylabel('Total count for each class');

%Test data

test_image=readraw('eight.raw');
test_image_resized=imresize(test_image,n);
[F_test,D_test]=vl_sift(single(test_image_resized));

[N M]=size(D_test);
count_1=0;
count_2=0;

for i=1:M
    
        dist1=sqrt(sum((double(D_test(:,i))-centroid_location(:,1)).^2));
        dist2=sqrt(sum((double(D_test(:,i))-centroid_location(:,2)).^2));
        if (dist1<dist2)
           count_1=count_1+1;     
        else
           count_2=count_2+1;     
end

X=[0 1];
Y=[count_1 count_2];
figure(10);
bar(X,Y,0.05);
title('Histogram for Bag of visual words on Test image');
xlabel('Number of centroids (classes) in the training codebook');
ylabel('Total count for each class');



