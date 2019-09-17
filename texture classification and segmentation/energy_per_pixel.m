%EE 569 Homework Assignment#4
%Date: 03/19/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Texture Analysis
%Implementation: Texture Segmentation
%M-file name: energy_per_pixel.m
%Input  : N,texture_filtered
%Output : energy_filtered
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [energy_filtered]=energy_per_pixel(N,texture_filtered)

texture_filtered_extended=zeros(510,510,25);

for k=1:25
for i=1:510          %data centered
    for j=1:510
        texture_filtered_extended(i+(N-1)/2,j+(N-1)/2,k)=texture_filtered(i,j,k);
    end
end
end

%boundary extension
for k=1:25
for i=0:((N-1)/2)-1
    texture_filtered_extended(:,((N-1)/2)-i,k)=texture_filtered_extended(:,((N-1)/2)+i+2,k);
    texture_filtered_extended(:,510+((N-1)/2)+i+1,k)=texture_filtered_extended(:,510+((N-1)/2)-i-1,k);
    texture_filtered_extended(((N-1)/2)-i,:,k)=texture_filtered_extended(((N-1)/2)+i+2,:,k);
    texture_filtered_extended((510+(N-1)/2)+i+1,:,k)=texture_filtered_extended((510+(N-1)/2)-i-1,:,k);
end
end

for k=1:25
    for i=1+(N-1)/2:510+(N-1)/2
        for j=1+(N-1)/2:510+(N-1)/2
            neighbour_window=texture_filtered_extended(i-(N-1)/2:i+(N-1)/2,j-(N-1)/2:j+(N-1)/2,k);
            energy_avg=(1/(N*N))*sum(sum(abs(neighbour_window)));
            %energy_avg=(1/(N*N))*sum(sum(neighbour_window.^2));
            energy_filtered(i-(N-1)/2,j-(N-1)/2,k)=energy_avg;
        end
    end
end

end
            
