%EE 569 Homework Assignment#4
%Date: 03/19/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Texture Analysis
%Implementation: Texture Classification
%M-file name: Laws_filter.m
%Input  : N, texture_mean_removed
%Output : E
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [E] = Laws_filter(N,texture_mean_removed)

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

for i=1+(N-1)/2:128+(N-1)/2
    for j=1+(N-1)/2:128+(N-1)/2
        neighbour_window=texture_mean_removed((i-(N-1)/2:i+(N-1)/2),(j-(N-1)/2:j+(N-1)/2));
       
                
                texture_filtered1(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter1));
                texture_filtered2(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter2));
                texture_filtered3(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter3));
                texture_filtered4(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter4));
                texture_filtered5(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter5));
                
                texture_filtered6(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter6));
                texture_filtered7(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter7));
                texture_filtered8(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter8));
                texture_filtered9(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter9));
                texture_filtered10(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter10));
                
                texture_filtered11(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter11));
                texture_filtered12(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter12));
                texture_filtered13(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter13));
                texture_filtered14(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter14));
                texture_filtered15(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter15));
                
                texture_filtered16(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter16));
                texture_filtered17(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter17));
                texture_filtered18(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter18));
                texture_filtered19(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter19));
                texture_filtered20(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter20));
                
                texture_filtered21(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter21));
                texture_filtered22(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter22));
                texture_filtered23(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter23));
                texture_filtered24(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter24));
                texture_filtered25(i-(N-1)/2,j-(N-1)/2)=sum(sum(neighbour_window.*Filter25));
                
            end
        end
   
E1=avg_energy(texture_filtered1);
E2=avg_energy(texture_filtered2);
E3=avg_energy(texture_filtered3);
E4=avg_energy(texture_filtered4);
E5=avg_energy(texture_filtered5);

E6=avg_energy(texture_filtered6);
E7=avg_energy(texture_filtered7);
E8=avg_energy(texture_filtered8);
E9=avg_energy(texture_filtered9);
E10=avg_energy(texture_filtered10);

E11=avg_energy(texture_filtered11);
E12=avg_energy(texture_filtered12);
E13=avg_energy(texture_filtered13);
E14=avg_energy(texture_filtered14);
E15=avg_energy(texture_filtered15);

E16=avg_energy(texture_filtered16);
E17=avg_energy(texture_filtered17);
E18=avg_energy(texture_filtered18);
E19=avg_energy(texture_filtered19);
E20=avg_energy(texture_filtered20);

E21=avg_energy(texture_filtered21);
E22=avg_energy(texture_filtered22);
E23=avg_energy(texture_filtered23);
E24=avg_energy(texture_filtered24);
E25=avg_energy(texture_filtered25);

E=[E1 E2 E3 E4 E5 E6 E7 E8 E9 E10 E11 E12 E13 E14 E15 E16 E17 E18 E19 E20 E21 E22 E23 E24 E25];

end       

        
