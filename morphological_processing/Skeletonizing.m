%EE 569 Homework Assignment#2
%Date: 02/25/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Morphological Processing
%Implementation: Skeletonizing
%M-file name: Skeletonizing.m
%Output image: G_skeletonize_pattern_bridged
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

pattern=readraw('pattern4.raw');
figure(1);
imshow(uint8(pattern));
pattern_normalized=pattern./255; %normalizing betweem 0 and 1

N=3;   %filter size

pattern_extended=zeros(375+N-1,375+N-1); %normalized values are extended

for i=1:375          %data centered
    for j=1:375
        pattern_extended(i+(N-1)/2,j+(N-1)/2)=pattern_normalized(i,j);
    end
end

%boundary extension
for i=0:((N-1)/2)-1
    pattern_extended(:,((N-1)/2)-i)=pattern_extended(:,((N-1)/2)+i+1);
    pattern_extended(:,375+((N-1)/2)+i+1)=pattern_extended(:,375+((N-1)/2)-i);
    pattern_extended(((N-1)/2)-i,:)=pattern_extended(((N-1)/2)+i+1,:);
    pattern_extended((375+(N-1)/2)+i+1,:)=pattern_extended((375+(N-1)/2)-i,:);
end

Shrink_1_NE=[0 1 0 0 0 0 0 0];
Shrink_1_NW=[0 0 0 1 0 0 0 0];
Shrink_1_SW=[0 0 0 0 0 1 0 0];
Shrink_1_SE=[0 0 0 0 0 0 0 1];

Shrink_2_E=[1 0 0 0 0 0 0 0];
Shrink_2_N=[0 0 1 0 0 0 0 0];
Shrink_2_W=[0 0 0 0 1 0 0 0];
Shrink_2_S=[0 0 0 0 0 0 1 0];

Shrink_3_E_NE=[1 1 0 0 0 0 0 0];
Shrink_3_NE_N=[0 1 1 0 0 0 0 0];
Shrink_3_N_NW=[0 0 1 1 0 0 0 0];
Shrink_3_NW_W=[0 0 0 1 1 0 0 0];
Shrink_3_W_SW=[0 0 0 0 1 1 0 0];
Shrink_3_SW_S=[0 0 0 0 0 1 1 0];
Shrink_3_S_SE=[0 0 0 0 0 0 1 1];
Shrink_3_SE_E=[1 0 0 0 0 0 0 1];

Thin_Skeletonize_4_E_N=[1 0 1 0 0 0 0 0];
Thin_Skeletonize_4_N_W=[0 0 1 0 1 0 0 0];
Thin_Skeletonize_4_W_S=[0 0 0 0 1 0 1 0];
Thin_Skeletonize_4_S_E=[1 0 0 0 0 0 1 0];

Shrink_Thin_Skeletonize_4_E_NE_SE=[1 1 0 0 0 0 0 1];
Shrink_Thin_Skeletonize_4_NE_N_NW=[0 1 1 1 0 0 0 0];  
Shrink_Thin_Skeletonize_4_NW_W_SW=[0 0 0 1 1 1 0 0];
Shrink_Thin_Skeletonize_4_SW_S_SE=[0 0 0 0 0 1 1 1];

Shrink_Thin_5_E_N_NW=[1 0 1 1 0 0 0 0];
Shrink_Thin_5_E_N_SE=[1 0 1 0 0 0 0 1];
Shrink_Thin_5_NE_N_W=[0 1 1 0 1 0 0 0];
Shrink_Thin_5_E_NE_S=[1 1 0 0 0 0 1 0];

Shrink_Thin_5_E_NE_N=[1 1 1 0 0 0 0 0];
Shrink_Thin_5_N_NW_W=[0 0 1 1 1 0 0 0];
Shrink_Thin_5_W_SW_S=[0 0 0 0 1 1 1 0];
Shrink_Thin_5_S_SE_E=[1 0 0 0 0 0 1 1];  

Shrink_Thin_6_E_N_NW_SE=[1 0 1 1 0 0 0 1];
Shrink_Thin_6_NE_N_W_SW=[0 1 1 0 1 1 0 0];

Shrink_Thin_Skeletonize_6_E_NE_N_NW=[1 1 1 1 0 0 0 0];
Shrink_Thin_Skeletonize_6_E_NE_N_SW=[1 1 1 0 0 0 0 1];
Shrink_Thin_Skeletonize_6_NE_N_NW_W=[0 1 1 1 1 0 0 0];
Shrink_Thin_Skeletonize_6_N_NW_W_SW=[0 0 1 1 1 1 0 0];
Shrink_Thin_Skeletonize_6_NW_W_SW_S=[0 0 0 1 1 1 1 0];
Shrink_Thin_Skeletonize_6_W_SW_S_SE=[0 0 0 0 1 1 1 1];
Shrink_Thin_Skeletonize_6_SW_S_SE_E=[1 0 0 0 0 1 1 1];
Shrink_Thin_Skeletonize_6_S_SE_E_NE=[1 1 0 0 0 0 1 1];

Shrink_Thin_Skeletonize_7_E_NE_N_NW_SE=[1 1 1 1 0 0 0 1];
Shrink_Thin_Skeletonize_7_NE_N_NW_W_SW=[0 1 1 1 1 1 0 0];
Shrink_Thin_Skeletonize_7_NW_W_SW_S_SE=[0 0 0 1 1 1 1 1];
Shrink_Thin_Skeletonize_7_SW_S_SE_E_NE=[1 1 0 0 0 1 1 1];

Shrink_Thin_Skeletonize_8_E_NE_N_S_SE=[1 1 1 0 0 0 1 1];
Shrink_Thin_Skeletonize_8_E_NE_N_NW_W=[1 1 1 1 1 0 0 0];
Shrink_Thin_Skeletonize_8_N_NW_W_SW_S=[0 0 1 1 1 1 1 0];
Shrink_Thin_Skeletonize_8_W_SW_S_SE_E=[1 0 0 0 1 1 1 1];

Shrink_Thin_Skeletonize_9_E_NE_N_NW_S_SE=[1 1 1 1 0 0 1 1];
Shrink_Thin_Skeletonize_9_E_NE_N_SW_S_SE=[1 1 1 0 0 1 1 1];
Shrink_Thin_Skeletonize_9_E_NE_N_NW_W_SW=[1 1 1 1 1 1 0 0];
Shrink_Thin_Skeletonize_9_E_NE_N_NW_W_SE=[1 1 1 1 1 0 0 1];
Shrink_Thin_Skeletonize_9_NE_N_NW_W_SW_S=[0 1 1 1 1 1 1 0];
Shrink_Thin_Skeletonize_9_N_NW_W_SW_S_SE=[0 0 1 1 1 1 1 1];
Shrink_Thin_Skeletonize_9_NW_W_SW_S_SE_E=[1 0 0 1 1 1 1 1];
Shrink_Thin_Skeletonize_9_W_SW_S_SE_E_NE=[1 1 0 0 1 1 1 1];

Shrink_Thin_Skeletonize_10_not_W=[1 1 1 1 0 1 1 1];
Shrink_Thin_Skeletonize_10_not_S=[1 1 1 1 1 1 0 1];
Shrink_Thin_Skeletonize_10_not_E=[0 1 1 1 1 1 1 1];
Shrink_Thin_Skeletonize_10_not_N=[1 1 0 1 1 1 1 1];

Skeletonize_11_not_SW=[1 1 1 1 1 0 1 1];
Skeletonize_11_not_SE=[1 1 1 1 1 1 1 0];
Skeletonize_11_not_NE=[1 0 1 1 1 1 1 1];
Skeletonize_11_not_NW=[1 1 1 0 1 1 1 1];

flag=1;
temp = pattern_normalized;
G_skeletonize_pattern=zeros(375,375);

while(flag==1)
    
temp_extended=zeros(375+N-1,375+N-1); %normalized values are extended

for i=1:375          %data centered
    for j=1:375
        temp_extended(i+(N-1)/2,j+(N-1)/2)=temp(i,j);
    end
end

%boundary extension
for i=0:((N-1)/2)-1
    temp_extended(:,((N-1)/2)-i)=temp_extended(:,((N-1)/2)+i+1);
    temp_extended(:,375+((N-1)/2)+i+1)=temp_extended(:,375+((N-1)/2)-i);
    temp_extended(((N-1)/2)-i,:)=temp_extended(((N-1)/2)+i+1,:);
    temp_extended((375+(N-1)/2)+i+1,:)=temp_extended((375+(N-1)/2)-i,:);
end
M=zeros(375,375);
P=zeros(375,375);

%computing and storing the pixel bond values
for i=1+(N-1)/2:375+(N-1)/2
    for j=1+(N-1)/2:375+(N-1)/2
          count_4_connected=(temp_extended(i,j-1)+temp_extended(i,j+1)+temp_extended(i-1,j)+temp_extended(i+1,j)); 
          count_8_connected=(temp_extended(i-1,j-1)+temp_extended(i-1,j+1)+temp_extended(i+1,j-1)+temp_extended(i+1,j+1)); 
          pixel_bond=2*count_4_connected+count_8_connected;
          neighbourhood=temp_extended(i-(N-1)/2:i+(N-1)/2,j-(N-1)/2:j+(N-1)/2);
          neighbourhood_1D=[neighbourhood(2,3) neighbourhood(1,3) neighbourhood(1,2) neighbourhood(1,1) neighbourhood(2,1) neighbourhood(3,1) neighbourhood(3,2) neighbourhood(3,3)];
        
if (temp_extended(i,j)==1)
            
 switch pixel_bond
            
                case 4
                
                if(isequal(Shrink_Thin_Skeletonize_4_E_NE_SE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_4_NE_N_NW,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_4_NW_W_SW,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_4_SW_S_SE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                
                elseif(isequal(Thin_Skeletonize_4_E_N,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Thin_Skeletonize_4_N_W,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Thin_Skeletonize_4_W_S,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Thin_Skeletonize_4_S_E,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                
                end
                
                
                case 6
                    
                
                if(isequal(Shrink_Thin_Skeletonize_6_E_NE_N_NW,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_6_E_NE_N_SW,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_6_NE_N_NW_W,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_6_N_NW_W_SW,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_6_NW_W_SW_S,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_6_W_SW_S_SE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_6_SW_S_SE_E,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_6_S_SE_E_NE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                end
                
                case 7
                    
                if(isequal(Shrink_Thin_Skeletonize_7_E_NE_N_NW_SE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_7_NE_N_NW_W_SW,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_7_NW_W_SW_S_SE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_7_SW_S_SE_E_NE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                end
                
                case 8
                    
                if(isequal(Shrink_Thin_Skeletonize_8_E_NE_N_S_SE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_8_E_NE_N_NW_W,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_8_N_NW_W_SW_S,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_8_W_SW_S_SE_E,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                end
                
                case 9
                    
                if(isequal(Shrink_Thin_Skeletonize_9_E_NE_N_NW_S_SE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_9_E_NE_N_SW_S_SE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_9_E_NE_N_NW_W_SW,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_9_E_NE_N_NW_W_SE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_9_NE_N_NW_W_SW_S,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_9_N_NW_W_SW_S_SE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_9_NW_W_SW_S_SE_E,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_9_W_SW_S_SE_E_NE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                end
                
                case 10
                    
                if(isequal(Shrink_Thin_Skeletonize_10_not_W,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_10_not_S,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_10_not_E,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Shrink_Thin_Skeletonize_10_not_N,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                end
  
               case 11
                   
                if(isequal(Skeletonize_11_not_SW,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Skeletonize_11_not_SE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Skeletonize_11_not_NE,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                elseif(isequal(Skeletonize_11_not_NW,neighbourhood_1D))
                M(i-(N-1)/2,j-(N-1)/2)=1;
                end
end
end
end
end

%Unconditional masks for skeletonizing

M_shrinking_extended=zeros(375+N-1,375+N-1); %normalized values are extended

for i=1:375          %data centered
    for j=1:375
        M_shrinking_extended(i+(N-1)/2,j+(N-1)/2)=M(i,j);
    end
end

%boundary extension
for i=0:((N-1)/2)-1
    M_shrinking_extended(:,((N-1)/2)-i)=M_shrinking_extended(:,((N-1)/2)+i+1);
    M_shrinking_extended(:,375+((N-1)/2)+i+1)=M_shrinking_extended(:,375+((N-1)/2)-i);
    M_shrinking_extended(((N-1)/2)-i,:)=M_shrinking_extended(((N-1)/2)+i+1,:);
    M_shrinking_extended((375+(N-1)/2)+i+1,:)=M_shrinking_extended((375+(N-1)/2)-i,:);
end

for i=1+(N-1)/2:375+(N-1)/2
    for j=1+(N-1)/2:375+(N-1)/2
        neighbourhood_M=M_shrinking_extended(i-(N-1)/2:i+(N-1)/2,j-(N-1)/2:j+(N-1)/2);

        %Spur
        if(neighbourhood_M(2,2)==neighbourhood_M(3,3) && neighbourhood_M(1,1)==0 && neighbourhood_M(1,2)==0 && neighbourhood_M(1,3)==0 && neighbourhood_M(2,1)==0 && neighbourhood_M(2,3)==0 && neighbourhood_M(3,1)==0 && neighbourhood_M(3,2)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,2)==neighbourhood_M(3,1) && neighbourhood_M(1,1)==0 && neighbourhood_M(1,2)==0 && neighbourhood_M(1,3)==0 && neighbourhood_M(2,1)==0 && neighbourhood_M(2,3)==0 && neighbourhood_M(3,3)==0 && neighbourhood_M(3,2)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,2)==neighbourhood_M(1,3) && neighbourhood_M(1,1)==0 && neighbourhood_M(1,2)==0 && neighbourhood_M(2,1)==0 && neighbourhood_M(2,3)==0 && neighbourhood_M(3,1)==0 && neighbourhood_M(3,2)==0 && neighbourhood_M(3,3)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,2)==neighbourhood_M(1,1) && neighbourhood_M(1,2)==0 && neighbourhood_M(1,3)==0 && neighbourhood_M(2,1)==0 && neighbourhood_M(2,3)==0 && neighbourhood_M(3,1)==0 && neighbourhood_M(3,2)==0 && neighbourhood_M(1,1)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        %Single 4 connection
        
        if(neighbourhood_M(2,2)==neighbourhood_M(3,2) && neighbourhood_M(1,1)==0 && neighbourhood_M(1,2)==0 && neighbourhood_M(1,3)==0 && neighbourhood_M(2,1)==0 && neighbourhood_M(2,3)==0 && neighbourhood_M(3,1)==0 && neighbourhood_M(3,3)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,2)==neighbourhood_M(2,3) && neighbourhood_M(1,1)==0 && neighbourhood_M(1,2)==0 && neighbourhood_M(1,3)==0 && neighbourhood_M(2,1)==0 && neighbourhood_M(3,2)==0 && neighbourhood_M(3,1)==0 && neighbourhood_M(3,3)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,2)==neighbourhood_M(2,1) && neighbourhood_M(1,1)==0 && neighbourhood_M(1,2)==0 && neighbourhood_M(1,3)==0 && neighbourhood_M(3,2)==0 && neighbourhood_M(2,3)==0 && neighbourhood_M(3,1)==0 && neighbourhood_M(3,3)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,2)==neighbourhood_M(1,2) && neighbourhood_M(1,1)==0 && neighbourhood_M(2,1)==0 && neighbourhood_M(1,3)==0 && neighbourhood_M(3,2)==0 && neighbourhood_M(2,3)==0 && neighbourhood_M(3,1)==0 && neighbourhood_M(3,3)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        %L Corner
        
        if(neighbourhood_M(2,2)==neighbourhood_M(1,2) && neighbourhood_M(2,2)==neighbourhood_M(2,3) && neighbourhood_M(1,1)==0 && neighbourhood_M(1,3)==0 && neighbourhood_M(2,1)==0 && neighbourhood_M(3,1)==0 && neighbourhood_M(3,2)==0 && neighbourhood_M(3,3)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,2)==neighbourhood_M(1,2) && neighbourhood_M(2,2)==neighbourhood_M(2,1) && neighbourhood_M(1,1)==0 && neighbourhood_M(1,3)==0 && neighbourhood_M(2,3)==0 && neighbourhood_M(3,1)==0 && neighbourhood_M(3,2)==0 && neighbourhood_M(3,3)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,2)==neighbourhood_M(3,2) && neighbourhood_M(2,2)==neighbourhood_M(2,3) && neighbourhood_M(1,1)==0 && neighbourhood_M(1,3)==0 && neighbourhood_M(2,1)==0 && neighbourhood_M(3,1)==0 && neighbourhood_M(1,2)==0 && neighbourhood_M(3,3)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,2)==neighbourhood_M(3,2) && neighbourhood_M(2,2)==neighbourhood_M(2,1) && neighbourhood_M(1,1)==0 && neighbourhood_M(1,3)==0 && neighbourhood_M(2,3)==0 && neighbourhood_M(3,1)==0 && neighbourhood_M(1,2)==0 && neighbourhood_M(3,3)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        %Corner Cluster
        
        if(neighbourhood_M(1,1)==neighbourhood_M(2,2) && neighbourhood_M(1,2)==neighbourhood_M(2,2) && neighbourhood_M(2,1)==neighbourhood_M(2,2))
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,3)==neighbourhood_M(2,2) && neighbourhood_M(3,2)==neighbourhood_M(2,2) && neighbourhood_M(3,3)==neighbourhood_M(2,2))
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        %Tee Branch
        
        if(neighbourhood_M(2,3)==neighbourhood_M(2,2) && neighbourhood_M(2,1)==neighbourhood_M(2,2) && neighbourhood_M(1,2)==neighbourhood_M(2,2))
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(3,2)==neighbourhood_M(2,2) && neighbourhood_M(2,1)==neighbourhood_M(2,2) && neighbourhood_M(1,2)==neighbourhood_M(2,2))
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,3)==neighbourhood_M(2,2) && neighbourhood_M(2,1)==neighbourhood_M(2,2) && neighbourhood_M(3,2)==neighbourhood_M(2,2))
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(3,2)==neighbourhood_M(2,2) && neighbourhood_M(1,2)==neighbourhood_M(2,2) && neighbourhood_M(2,3)==neighbourhood_M(2,2))
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        %Vee Branch
        
        if(neighbourhood_M(2,2)==neighbourhood_M(1,1) && neighbourhood_M(2,2)==neighbourhood_M(1,3) && (neighbourhood_M(3,1) | neighbourhood_M(3,2) | neighbourhood_M(3,3))==1)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,2)==neighbourhood_M(1,1) && neighbourhood_M(2,2)==neighbourhood_M(3,1) && (neighbourhood_M(1,3) | neighbourhood_M(2,3) | neighbourhood_M(3,3))==1)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,2)==neighbourhood_M(3,3) && neighbourhood_M(2,2)==neighbourhood_M(3,1) && (neighbourhood_M(1,1) | neighbourhood_M(1,2) | neighbourhood_M(1,3))==1)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        if(neighbourhood_M(2,2)==neighbourhood_M(3,3) && neighbourhood_M(2,2)==neighbourhood_M(1,3) && (neighbourhood_M(1,1) | neighbourhood_M(2,1) | neighbourhood_M(3,1))==1)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
        
        %Diagonal Branch
        
        if(neighbourhood_M(1,2)==neighbourhood_M(2,2) && neighbourhood_M(2,2)==neighbourhood_M(2,3) && neighbourhood_M(2,2)==neighbourhood_M(3,1) && neighbourhood_M(1,3)==0 && neighbourhood_M(2,1)==0 && neighbourhood_M(3,2)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
      
        if(neighbourhood_M(1,2)==neighbourhood_M(2,2) && neighbourhood_M(2,2)==neighbourhood_M(2,1) && neighbourhood_M(2,2)==neighbourhood_M(3,3) && neighbourhood_M(1,1)==0 && neighbourhood_M(2,3)==0 && neighbourhood_M(3,2)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
      
        if(neighbourhood_M(1,3)==neighbourhood_M(2,2) && neighbourhood_M(2,2)==neighbourhood_M(2,1) && neighbourhood_M(2,2)==neighbourhood_M(3,2) && neighbourhood_M(1,2)==0 && neighbourhood_M(2,3)==0 && neighbourhood_M(3,1)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
      
        if(neighbourhood_M(1,1)==neighbourhood_M(2,2) && neighbourhood_M(2,2)==neighbourhood_M(2,3) && neighbourhood_M(2,2)==neighbourhood_M(3,2) && neighbourhood_M(1,2)==0 && neighbourhood_M(2,1)==0 && neighbourhood_M(3,3)==0)
        P(i-(N-1)/2,j-(N-1)/2)=1;
%         else
%         P(i-(N-1)/2,j-(N-1)/2)=0;
        end
    end
end

for i=1:375
    for j=1:375
        G_skeletonize_pattern(i,j)=temp(i,j) & (~M(i,j) | P(i,j));
    end
end
if(isequal(temp,G_skeletonize_pattern))

    flag=0;
else 
    flag=1;
end

temp=uint8(G_skeletonize_pattern);
% figure(3);
% imshow(uint8(G_skeletonize_pattern.*255));
% figure(4);
% imshow(uint8(M.*255));


end

G_skeletonize_pattern_extended=zeros(375+N-1,375+N-1); %normalized values are extended

for i=1:375          %data centered
    for j=1:375
        G_skeletonize_pattern_extended(i+(N-1)/2,j+(N-1)/2)=G_skeletonize_pattern(i,j);
    end
end

%boundary extension
for i=0:((N-1)/2)-1
    G_skeletonize_pattern_extended(:,((N-1)/2)-i)=G_skeletonize_pattern_extended(:,((N-1)/2)+i+1);
    G_skeletonize_pattern_extended(:,375+((N-1)/2)+i+1)=G_skeletonize_pattern_extended(:,375+((N-1)/2)-i);
    G_skeletonize_pattern_extended(((N-1)/2)-i,:)=G_skeletonize_pattern_extended(((N-1)/2)+i+1,:);
    G_skeletonize_pattern_extended((375+(N-1)/2)+i+1,:)=G_skeletonize_pattern_extended((375+(N-1)/2)-i,:);
end

for i=1+(N-1)/2:375+(N-1)/2
    for j=1+(N-1)/2:375+(N-1)/2
        neighbourhood_G=G_skeletonize_pattern_extended(i-(N-1)/2:i+(N-1)/2,j-(N-1)/2:j+(N-1)/2);
        L1=(~neighbourhood_G(2,2) && ~neighbourhood_G(2,3) && neighbourhood_G(1,3) && ~neighbourhood_G(1,2) && neighbourhood_G(1,1) && ~neighbourhood_G(2,1) && ~neighbourhood_G(3,1) && ~neighbourhood_G(3,2) && ~neighbourhood_G(3,3));
        L2=(~neighbourhood_G(2,2) && ~neighbourhood_G(2,3) && ~neighbourhood_G(1,3) && ~neighbourhood_G(1,2) && neighbourhood_G(1,1) && ~neighbourhood_G(2,1) && neighbourhood_G(3,1) && ~neighbourhood_G(3,2) && ~neighbourhood_G(3,3));
        L3=(~neighbourhood_G(2,2) && ~neighbourhood_G(2,3) && ~neighbourhood_G(1,3) && ~neighbourhood_G(1,2) && ~neighbourhood_G(1,1) && ~neighbourhood_G(2,1) && neighbourhood_G(3,1) && ~neighbourhood_G(3,2) && neighbourhood_G(3,3));
        L4=(~neighbourhood_G(2,2) && ~neighbourhood_G(2,3) && neighbourhood_G(1,3) && ~neighbourhood_G(1,2) && ~neighbourhood_G(1,1) && ~neighbourhood_G(2,1) && ~neighbourhood_G(3,1) && ~neighbourhood_G(3,2) && neighbourhood_G(3,3));
        
       
        Pq=L1 | L2 | L3 | L4;
        P1=(~neighbourhood_G(1,2) && ~neighbourhood_G(3,2) && (neighbourhood_G(1,1) | neighbourhood_G(2,1) | neighbourhood_G(3,1)) && (neighbourhood_G(1,3) |neighbourhood_G(2,3) |neighbourhood_G(3,3)) && ~Pq);
        P2=(~neighbourhood_G(2,3) && ~neighbourhood_G(2,1) && (neighbourhood_G(1,1) | neighbourhood_G(1,2) | neighbourhood_G(1,3)) && (neighbourhood_G(3,1) |neighbourhood_G(3,2) |neighbourhood_G(3,3)) && ~Pq);
        P3=(~neighbourhood_G(2,3) && ~neighbourhood_G(3,2) && neighbourhood_G(3,3) && (neighbourhood_G(1,2) | neighbourhood_G(1,1) | neighbourhood_G(2,1)));
        P4=(~neighbourhood_G(2,3) && ~neighbourhood_G(1,2) && neighbourhood_G(1,3) && (neighbourhood_G(2,1) | neighbourhood_G(3,1) | neighbourhood_G(3,2)));
        P5=(~neighbourhood_G(1,2) && ~neighbourhood_G(2,1) && neighbourhood_G(1,1) && (neighbourhood_G(2,3) | neighbourhood_G(3,2) | neighbourhood_G(3,3)));
        P6=(~neighbourhood_G(2,1) && ~neighbourhood_G(3,2) && neighbourhood_G(3,1) && (neighbourhood_G(2,3) | neighbourhood_G(1,3) | neighbourhood_G(1,2)));
        
        P_or=(P1 | P2 | P3 | P4 | P5 | P6);
        G_skeletonize_pattern_bridged(i,j)=neighbourhood_G(2,2) | P_or;
    end
end

figure(2);
imshow(uint8(G_skeletonize_pattern_bridged.*255));
title('Image obtained after Skeletonizing');

        
