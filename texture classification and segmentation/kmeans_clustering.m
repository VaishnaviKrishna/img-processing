%EE 569 Homework Assignment#4
%Date: 03/19/2019
%Name: Vaishnavi Krishnamurthy
%ID: 3959621752
%email: vaishnak@usc.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Problem :  Texture Analysis
%Implementation: Texture Classification
%M-file name: kmeans_clustering.m
%Input  : RX,k
%Output : idx
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [idx]=kmeans_clustering(RX,k)

Rx_t=RX';
[N M]=size(Rx_t);

centroid_init=datasample(Rx_t,k,'Replace',false);
flag=true;
temp=centroid_init;       %temp=centroid_init;

while(flag)   %repeating until convergence
    
    for i=1:N
        for j=1:k
        value(i,j)=sum((Rx_t(i,:)-temp(j,:)).^2);
        end
        
        [Y(i) I(i)]=min(value(i,:));
    end
  
        for j=1:k
        temp_sum=zeros(1,M);
        count=0;
        for i=1:N
       
        if(I(i)==j)
            temp_sum=temp_sum+Rx_t(i,:);
            count=count+1;
        else
            continue;
        
        
        end
        temp_updated(j,:)=temp_sum./count;
        end
        
        if(isequal(temp,temp_updated))
            flag=false;
        else
            flag=true;
            
        temp=temp_updated;    
    
        end

end
idx=I';
end        
    