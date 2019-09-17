%EE 569 Homework Assignment#2
%Date: 02/11/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Color Half toning
%Implementation: Color halftoning with error diffusion using MBVQ based method
%M-file name: Halftoning_MBVQ.m
%Output image: output_MBVQ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


bird_red=readraw_red('bird.raw');
bird_green=readraw_green('bird.raw');
bird_blue=readraw_blue('bird.raw');

output_MBVQ_FS_serpentine_red=zeros(375,500);
output_MBVQ_FS_serpentine_green=zeros(375,500);
output_MBVQ_FS_serpentine_blue=zeros(375,500);
% bird_red=bird_red./255;
% bird_green=bird_green./255;
% bird_blue=bird_blue./255;

%threshold=127;  %setting the threshold
diffusion_matrix=(1/16)*[0 0 0;0 0 7;3 5 1];
diffusion_matrix_mirrored=(1/16)*[0 0 0;7 0 0;1 5 3];
[N M]=size(diffusion_matrix);

%Applying error diffusion for the red channel
added_error_bird_red_extended=zeros(375+N-1,500+N-1); %RED
added_error_bird_green_extended=zeros(375+N-1,500+N-1); %GREEN
added_error_bird_blue_extended=zeros(375+N-1,500+N-1);  %BLUE

for i=1:375          %data centered
    for j=1:500
        added_error_bird_red_extended(i+(N-1)/2,j+(N-1)/2)=bird_red(i,j);
        added_error_bird_green_extended(i+(N-1)/2,j+(N-1)/2)=bird_green(i,j);
        added_error_bird_blue_extended(i+(N-1)/2,j+(N-1)/2)=bird_blue(i,j);
    end
end

%boundary extension
for i=0:((N-1)/2)-1
    added_error_bird_red_extended(:,((N-1)/2)-i)=added_error_bird_red_extended(:,((N-1)/2)+i+1);
    added_error_bird_red_extended(:,500+((N-1)/2)+i+1)=added_error_bird_red_extended(:,500+((N-1)/2)-i);
    added_error_bird_red_extended(((N-1)/2)-i,:)=added_error_bird_red_extended(((N-1)/2)+i+1,:);
    added_error_bird_red_extended((375+(N-1)/2)+i+1,:)=added_error_bird_red_extended((375+(N-1)/2)-i,:);
    
    added_error_bird_green_extended(:,((N-1)/2)-i)=added_error_bird_green_extended(:,((N-1)/2)+i+1);
    added_error_bird_green_extended(:,500+((N-1)/2)+i+1)=added_error_bird_green_extended(:,500+((N-1)/2)-i);
    added_error_bird_green_extended(((N-1)/2)-i,:)=added_error_bird_green_extended(((N-1)/2)+i+1,:);
    added_error_bird_green_extended((375+(N-1)/2)+i+1,:)=added_error_bird_green_extended((375+(N-1)/2)-i,:);
    
    added_error_bird_blue_extended(:,((N-1)/2)-i)=added_error_bird_blue_extended(:,((N-1)/2)+i+1);
    added_error_bird_blue_extended(:,500+((N-1)/2)+i+1)=added_error_bird_blue_extended(:,500+((N-1)/2)-i);
    added_error_bird_blue_extended(((N-1)/2)-i,:)=added_error_bird_blue_extended(((N-1)/2)+i+1,:);
    added_error_bird_blue_extended((375+(N-1)/2)+i+1,:)=added_error_bird_blue_extended((375+(N-1)/2)-i,:);
end


for i=1+(N-1)/2:375+(N-1)/2
    if(mod(i,2)==0)
    for j=1+(N-1)/2:500+(N-1)/2
%         if (added_error_bird_red_extended(i,j)>threshold)
%             output_MBVQ_FS_serpentine_red(i-(N-1)/2,j-(N-1)/2)=255;
%             else
%             output_MBVQ_FS_serpentine_red(i-(N-1)/2,j-(N-1)/2)=0; 
%         end
%        
%         
%         if (added_error_bird_green_extended(i,j)>threshold)
%             output_MBVQ_FS_serpentine_green(i-(N-1)/2,j-(N-1)/2)=255;
%             else
%             output_MBVQ_FS_serpentine_green(i-(N-1)/2,j-(N-1)/2)=0; 
%         end
%         
%         
%         
%         if (added_error_bird_blue_extended(i,j)>threshold)
%             output_MBVQ_FS_serpentine_blue(i-(N-1)/2,j-(N-1)/2)=255;
%             else
%             output_MBVQ_FS_serpentine_blue(i-(N-1)/2,j-(N-1)/2)=0; 
%         end
        
        mbvq=mbvq_return(bird_red(i-(N-1)/2,j-(N-1)/2),bird_green(i-(N-1)/2,j-(N-1)/2),bird_blue(i-(N-1)/2,j-(N-1)/2));
        vertex=getNearestVertex(mbvq,added_error_bird_red_extended(i,j)./255,added_error_bird_green_extended(i,j)./255,added_error_bird_blue_extended(i,j)./255);
    
    if (isequal('yellow',vertex))
        yellow_vertex=[255,255,0];
        quant_error_red=yellow_vertex(1,1);
        quant_error_green=yellow_vertex(1,2);
        quant_error_blue=yellow_vertex(1,3);
    
    elseif (isequal('white',vertex))
        white_vertex=[255,255,255];
        quant_error_red=white_vertex(1,1);
        quant_error_green=white_vertex(1,2);
        quant_error_blue=white_vertex(1,3);
    
    elseif (isequal('cyan',vertex))
        cyan_vertex=[0,255,255];
        quant_error_red=cyan_vertex(1,1);
        quant_error_green=cyan_vertex(1,2);
        quant_error_blue=cyan_vertex(1,3);
    
    elseif (isequal('magenta',vertex))
        magenta_vertex=[255,0,255];
        quant_error_red=magenta_vertex(1,1);
        quant_error_green=magenta_vertex(1,2);
        quant_error_blue=magenta_vertex(1,3);
    
    elseif (isequal('green',vertex))
        green_vertex=[0,255,0];
        quant_error_red=green_vertex(1,1);
        quant_error_green=green_vertex(1,2);
        quant_error_blue=green_vertex(1,3);
    
    elseif (isequal('red',vertex))
        red_vertex=[255,0,0];
        quant_error_red=red_vertex(1,1);
        quant_error_green=red_vertex(1,2);
        quant_error_blue=red_vertex(1,3);
    
    elseif (isequal('blue',vertex))
        blue_vertex=[0,0,255];
        quant_error_red=blue_vertex(1,1);
        quant_error_green=blue_vertex(1,2);
        quant_error_blue=blue_vertex(1,3);
    
    elseif (isequal('black',vertex))
        black_vertex=[0,0,0];
        quant_error_red=black_vertex(1,1);
        quant_error_green=black_vertex(1,2);
        quant_error_blue=black_vertex(1,3);
    end
    
%     error_red=added_error_bird_red_extended(i,j)-output_MBVQ_FS_serpentine_red(i-(N-1)/2,j-(N-1)/2)-quant_error_red(i-(N-1)/2,j-(N-1)/2);
%     error_green=added_error_bird_green_extended(i,j)-output_MBVQ_FS_serpentine_green(i-(N-1)/2,j-(N-1)/2)-quant_error_green(i-(N-1)/2,j-(N-1)/2);
%     error_blue=added_error_bird_blue_extended(i,j)-output_MBVQ_FS_serpentine_blue(i-(N-1)/2,j-(N-1)/2)-quant_error_blue(i-(N-1)/2,j-(N-1)/2);
      
    error_red=added_error_bird_red_extended(i,j)-quant_error_red;
    error_green=added_error_bird_green_extended(i,j)-quant_error_green;
    error_blue=added_error_bird_blue_extended(i,j)-quant_error_blue;

    output_MBVQ_FS_serpentine_red(i-(N-1)/2,j-(N-1)/2)=quant_error_red;
    output_MBVQ_FS_serpentine_green(i-(N-1)/2,j-(N-1)/2)=quant_error_green;
    output_MBVQ_FS_serpentine_blue(i-(N-1)/2,j-(N-1)/2)=quant_error_blue;


    for k=i-(N-1)/2:i+(N-1)/2
        for l=j-(N-1)/2:j+(N-1)/2
            added_error_bird_red_extended(k,l)=added_error_bird_red_extended(k,l)+error_red*diffusion_matrix(k-i+N-1,l-j+N-1);
        end
    end
                
    for k=i-(N-1)/2:i+(N-1)/2
       for l=j-(N-1)/2:j+(N-1)/2
           added_error_bird_green_extended(k,l)=added_error_bird_green_extended(k,l)+error_green*diffusion_matrix(k-i+N-1,l-j+N-1);
       end
    end            
                
                for k=i-(N-1)/2:i+(N-1)/2
                    for l=j-(N-1)/2:j+(N-1)/2
                    added_error_bird_blue_extended(k,l)=added_error_bird_blue_extended(k,l)+error_blue*diffusion_matrix(k-i+N-1,l-j+N-1);
                    end
                end
                

                
    end
    elseif(mod(i,2)==1)
        for j=500+(N-1)/2:-1:1+(N-1)/2
%             if (added_error_bird_red_extended(i,j)>threshold)
%             output_MBVQ_FS_serpentine_red(i-(N-1)/2,j-(N-1)/2)=255;
%             else
%             output_MBVQ_FS_serpentine_red(i-(N-1)/2,j-(N-1)/2)=0; 
%         end
%        
%         if (added_error_bird_green_extended(i,j)>threshold)
%             output_MBVQ_FS_serpentine_green(i-(N-1)/2,j-(N-1)/2)=255;
%             else
%             output_MBVQ_FS_serpentine_green(i-(N-1)/2,j-(N-1)/2)=0; 
%         end
%         
%         if (added_error_bird_blue_extended(i,j)>threshold)
%             output_MBVQ_FS_serpentine_blue(i-(N-1)/2,j-(N-1)/2)=255;
%             else %mbvq=mbvq_return(bird_red(i-(N-1)/2,j-(N-1)/2),bird_green(i-(N-1)/2,j-(N-1)/2),bird_blue(i-(N-1)/2,j-(N-1)/2));
%             output_MBVQ_FS_serpentine_blue(i-(N-1)/2,j-(N-1)/2)=0; 
%         end
        
   mbvq=mbvq_return(bird_red(i-(N-1)/2,j-(N-1)/2),bird_green(i-(N-1)/2,j-(N-1)/2),bird_blue(i-(N-1)/2,j-(N-1)/2));
   vertex=getNearestVertex(mbvq,added_error_bird_red_extended(i,j)./255,added_error_bird_green_extended(i,j)./255,added_error_bird_blue_extended(i,j)./255);
    
    if (isequal('yellow',vertex))
        yellow_vertex=[255,255,0];
        quant_error_red=yellow_vertex(1,1);
        quant_error_green=yellow_vertex(1,2);
        quant_error_blue=yellow_vertex(1,3);
    
    elseif (isequal('white',vertex))
        white_vertex=[255,255,255];
        quant_error_red=white_vertex(1,1);
        quant_error_green=white_vertex(1,2);
        quant_error_blue=white_vertex(1,3);
    
    elseif (isequal('cyan',vertex))
        cyan_vertex=[0,255,255];
        quant_error_red=cyan_vertex(1,1);
        quant_error_green=cyan_vertex(1,2);
        quant_error_blue=cyan_vertex(1,3);
    
    elseif (isequal('magenta',vertex))
        magenta_vertex=[255,0,255];
        quant_error_red=magenta_vertex(1,1);
        quant_error_green=magenta_vertex(1,2);
        quant_error_blue=magenta_vertex(1,3);
    
    elseif (isequal('green',vertex))
        green_vertex=[0,255,0];
        quant_error_red=green_vertex(1,1);
        quant_error_green=green_vertex(1,2);
        quant_error_blue=green_vertex(1,3);
    
    elseif (isequal('red',vertex))
        red_vertex=[255,0,0];
        quant_error_red=red_vertex(1,1);
        quant_error_green=red_vertex(1,2);
        quant_error_blue=red_vertex(1,3);
    
    elseif (isequal('blue',vertex))
        blue_vertex=[0,0,255];
        quant_error_red=blue_vertex(1,1);
        quant_error_green=blue_vertex(1,2);
        quant_error_blue=blue_vertex(1,3);
    
    elseif (isequal('black',vertex))
        black_vertex=[0,0,0];
        quant_error_red=black_vertex(1,1);
        quant_error_green=black_vertex(1,2);
        quant_error_blue=black_vertex(1,3);
    end
    
    error_red=added_error_bird_red_extended(i,j)-quant_error_red;
    error_green=added_error_bird_green_extended(i,j)-quant_error_green;
    error_blue=added_error_bird_blue_extended(i,j)-quant_error_blue; 
    
    output_MBVQ_FS_serpentine_red(i-(N-1)/2,j-(N-1)/2)=quant_error_red;
    output_MBVQ_FS_serpentine_green(i-(N-1)/2,j-(N-1)/2)=quant_error_green;
    output_MBVQ_FS_serpentine_blue(i-(N-1)/2,j-(N-1)/2)=quant_error_blue;


%     error_red=added_error_bird_red_extended(i,j)-output_MBVQ_FS_serpentine_red(i-(N-1)/2,j-(N-1)/2)-quant_error_red(i-(N-1)/2,j-(N-1)/2);
%     error_green=added_error_bird_green_extended(i,j)-output_MBVQ_FS_serpentine_green(i-(N-1)/2,j-(N-1)/2)-quant_error_green(i-(N-1)/2,j-(N-1)/2);
%     error_blue=added_error_bird_blue_extended(i,j)-output_MBVQ_FS_serpentine_blue(i-(N-1)/2,j-(N-1)/2)-quant_error_blue(i-(N-1)/2,j-(N-1)/2); 
%         
%         
        
        for k=i-(N-1)/2:i+(N-1)/2
            for l=j-(N-1)/2:j+(N-1)/2
                added_error_bird_red_extended(k,l)=added_error_bird_red_extended(k,l)+error_red*diffusion_matrix_mirrored(k-i+N-1,l-j+N-1);
            end
        end
        for k=i-(N-1)/2:i+(N-1)/2
            for l=j-(N-1)/2:j+(N-1)/2
                added_error_bird_green_extended(k,l)=added_error_bird_green_extended(k,l)+error_green*diffusion_matrix_mirrored(k-i+N-1,l-j+N-1);
            end
        end
        
        for k=i-(N-1)/2:i+(N-1)/2
            for l=j-(N-1)/2:j+(N-1)/2
                added_error_bird_blue_extended(k,l)=added_error_bird_blue_extended(k,l)+error_blue*diffusion_matrix_mirrored(k-i+N-1,l-j+N-1);
            end
        end
        
        
    

        
        
        end
        
        
        
    end
end


output_MBVQ(:,:,1)=output_MBVQ_FS_serpentine_red;
output_MBVQ(:,:,2)=output_MBVQ_FS_serpentine_green;
output_MBVQ(:,:,3)=output_MBVQ_FS_serpentine_blue;

figure(10);
imshow(uint8(output_MBVQ));
title('Color error diffusion using MBVQ based algorithm');








% bird_red=bird_red./255;
% bird_green=bird_green./255;
% bird_blue=bird_blue./255;
