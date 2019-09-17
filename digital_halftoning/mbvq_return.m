%EE 569 Homework Assignment#2
%Date: 02/11/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Color Half toning
%Implementation: Color halftoning with error diffusion using MBVQ based method
%M-file name: mbvq_return.m
%Input parameters: R,G,B channel 8 bit values each
%Return output: character (for eg, 'MYGC')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mbvq= mbvq_return(R,G,B)

if ((R+G)>255)
   if ((G+B)>255)
       if((R+G+B)>510)
           mbvq = 'CMYW';
       else
       mbvq = 'MYGC';
       end
   else
mbvq = 'RGMY';
   end       
elseif (~((G+B)>255))
if (~((R+G+B)>255))
 mbvq = 'KRGB';
else
 mbvq = 'RGBM';
end
else
 mbvq = 'CMGB';           
end
end
