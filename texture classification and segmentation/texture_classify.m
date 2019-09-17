%EE 569 Homework Assignment#4
%Date: 03/19/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Texture Analysis
%Implementation: Texture Classification
%M-file name: texture_classify.m
%Output : idx
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

N=5; %filter size

texture=readraw('texture1.raw');
feature_vector(1,:)=mean_removal(5,texture);

texture=readraw('texture2.raw');
feature_vector(2,:)=mean_removal(5,texture);

texture=readraw('texture3.raw');
feature_vector(3,:)=mean_removal(5,texture);

texture=readraw('texture4.raw');
feature_vector(4,:)=mean_removal(5,texture);

texture=readraw('texture5.raw');
feature_vector(5,:)=mean_removal(5,texture);

texture=readraw('texture6.raw');
feature_vector(6,:)=mean_removal(5,texture);

texture=readraw('texture7.raw');
feature_vector(7,:)=mean_removal(5,texture);

texture=readraw('texture8.raw');
feature_vector(8,:)=mean_removal(5,texture);

texture=readraw('texture9.raw');
feature_vector(9,:)=mean_removal(5,texture);

texture=readraw('texture10.raw');
feature_vector(10,:)=mean_removal(5,texture);

texture=readraw('texture11.raw');
feature_vector(11,:)=mean_removal(5,texture);

texture=readraw('texture12.raw');
feature_vector(12,:)=mean_removal(5,texture);

%standardization across every data point

for i=1:12
    feature_vector_std(i,:)=(feature_vector(i,:)-mean(feature_vector(i,:)))./std(feature_vector(i,:),1);
end

%Performing k-means clustering without PCA
X=feature_vector_std';  %25x12
idx=kmeans_clustering(feature_vector_std,4);  %For the written kmeans algorithm, 'k' data points are taken as initial centroids

%uncomment the following lines for performing PCA

% for i=1:25
% m(i,:)=mean(X(i,:));
% Z(i,:)=X(i,:)-m(i,:);
% end
% 
% [U S V]=svd(Z);
% 
% A=U(:,(1:3))*S((1:3),:)*V';
% 
% UR=U(:,(1:3));
% RX=UR'*A;
% 
% idx=kmeans_clustering(RX,4);
% idx_builtin=kmeans(RX',4);

% figure(1);
% for i=1:12
% plot3(RX(1,i),RX(2,i),RX(3,i),'*');
% xlabel('1st Principal Component');
% ylabel('2nd Principal Component');
% zlabel('3rd Principal Component');
% hold on;
% grid on;
% num=num2str(i);
% text(RX(1,i),RX(2,i),RX(3,i),num);
% end
