%EE 569 Homework Assignment#4
%Date: 03/19/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Texture Analysis
%Implementation: Texture Segmentation
%M-file name: Laws_filter_combined.m
%Input  : N,combined_texture
%Output : texture_filtered
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [texture_filtered] = Laws_filter_combined(N,combined_texture)

combined_texture_mean_removed=combined_texture-(1/(510*510))*sum(sum(combined_texture));

combined_texture_extended=zeros(510+(N-1),510+(N-1));

for i=1:510          %data centered
    for j=1:510
        combined_texture_extended(i+(N-1)/2,j+(N-1)/2)=combined_texture_mean_removed(i,j);
    end
end

%boundary extension
for i=0:((N-1)/2)-1
    combined_texture_extended(:,((N-1)/2)-i)=combined_texture_extended(:,((N-1)/2)+i+2);
    combined_texture_extended(:,510+((N-1)/2)+i+1)=combined_texture_extended(:,510+((N-1)/2)-i-1);
    combined_texture_extended(((N-1)/2)-i,:)=combined_texture_extended(((N-1)/2)+i+2,:);
    combined_texture_extended((510+(N-1)/2)+i+1,:)=combined_texture_extended((510+(N-1)/2)-i-1,:);
end



Level_filter=[1 4 6 4 1];
Edge_filter=[-1 -2 0 2 1];
Spot_filter=[-1 0 2 0 -1];
Wave_filter=[-1 2 0 -2 1];
Ripple_filter=[1 -4 6 -4 1];


Filter1=Level_filter'*Level_filter;
Filter2=Level_filter'*Edge_filter;
Filter3=Level_filter'*Spot_filter;
Filter4=Level_filter'*Wave_filter;
Filter5=Level_filter'*Ripple_filter;

Filter6=Edge_filter'*Level_filter;
Filter7=Edge_filter'*Edge_filter;
Filter8=Edge_filter'*Spot_filter;
Filter9=Edge_filter'*Wave_filter;
Filter10=Edge_filter'*Ripple_filter;

Filter11=Spot_filter'*Level_filter;
Filter12=Spot_filter'*Edge_filter;
Filter13=Spot_filter'*Spot_filter;
Filter14=Spot_filter'*Wave_filter;
Filter15=Spot_filter'*Ripple_filter;

Filter16=Wave_filter'*Level_filter;
Filter17=Wave_filter'*Edge_filter;
Filter18=Wave_filter'*Spot_filter;
Filter19=Wave_filter'*Wave_filter;
Filter20=Wave_filter'*Ripple_filter;

Filter21=Ripple_filter'*Level_filter;
Filter22=Ripple_filter'*Edge_filter;
Filter23=Ripple_filter'*Spot_filter;
Filter24=Ripple_filter'*Wave_filter;
Filter25=Ripple_filter'*Ripple_filter;

for i=1+(N-1)/2:510+(N-1)/2
    for j=1+(N-1)/2:510+(N-1)/2
        neighbour_window_mean_removed=combined_texture_extended((i-(N-1)/2:i+(N-1)/2),(j-(N-1)/2:j+(N-1)/2));
        
                texture_filtered(i-(N-1)/2,j-(N-1)/2,1)=sum(sum(neighbour_window_mean_removed.*Filter1));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,2)=sum(sum(neighbour_window_mean_removed.*Filter2));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,3)=sum(sum(neighbour_window_mean_removed.*Filter3));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,4)=sum(sum(neighbour_window_mean_removed.*Filter4));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,5)=sum(sum(neighbour_window_mean_removed.*Filter5));
                
                texture_filtered(i-(N-1)/2,j-(N-1)/2,6)=sum(sum(neighbour_window_mean_removed.*Filter6));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,7)=sum(sum(neighbour_window_mean_removed.*Filter7));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,8)=sum(sum(neighbour_window_mean_removed.*Filter8));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,9)=sum(sum(neighbour_window_mean_removed.*Filter9));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,10)=sum(sum(neighbour_window_mean_removed.*Filter10));
                
                texture_filtered(i-(N-1)/2,j-(N-1)/2,11)=sum(sum(neighbour_window_mean_removed.*Filter11));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,12)=sum(sum(neighbour_window_mean_removed.*Filter12));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,13)=sum(sum(neighbour_window_mean_removed.*Filter13));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,14)=sum(sum(neighbour_window_mean_removed.*Filter14));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,15)=sum(sum(neighbour_window_mean_removed.*Filter15));
                
                texture_filtered(i-(N-1)/2,j-(N-1)/2,16)=sum(sum(neighbour_window_mean_removed.*Filter16));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,17)=sum(sum(neighbour_window_mean_removed.*Filter17));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,18)=sum(sum(neighbour_window_mean_removed.*Filter18));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,19)=sum(sum(neighbour_window_mean_removed.*Filter19));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,20)=sum(sum(neighbour_window_mean_removed.*Filter20));
                
                texture_filtered(i-(N-1)/2,j-(N-1)/2,21)=sum(sum(neighbour_window_mean_removed.*Filter21));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,22)=sum(sum(neighbour_window_mean_removed.*Filter22));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,23)=sum(sum(neighbour_window_mean_removed.*Filter23));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,24)=sum(sum(neighbour_window_mean_removed.*Filter24));
                texture_filtered(i-(N-1)/2,j-(N-1)/2,25)=sum(sum(neighbour_window_mean_removed.*Filter25));
                
  end
end

end

