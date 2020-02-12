%Improved block truncation coding using
%modified error diffusion  - Prof. J M Guo

%Programmed By: Sankarasrinivasan S
%Multimedia Signal Processing Lab, Dept. of Elec Engg. NTUST
%Oct 2016


function [Y1, qerr]=EDBTC_new(in,bs)

 fc=[0    0    7;  3   5    1] ;   %Floyd Method
 fc=double(fc);
in=double(in);  
[ri,ci]=size(in);
[rm,cm]=size(fc);
rm=rm-1;
cm=cm-1;
b1=bs; b2=bs;
in=padarray(in,[1 1],'both');


% Error Diffusion Block 
for yi=2:bs:ci+1
  for xi=2:bs:ri+1
      bl=in(yi:yi+(bs-1),xi:xi+(bs-1));
      men=mean(bl(:));
      mx=max(bl(:));
      mnn=min(bl(:));
   
    for y=yi:yi+(bs-1)
        for x=xi:xi+(bs-1)
    if(in(y,x)>men)
        Y1(y,x)=(mx);
    else
        Y1(y,x)=(mnn);
    end 
   qerr=(in(y,x)-Y1(y,x)).*fc;
     
    in((y):(y)+rm,(x-1):(x-1)+cm)=(in((y):(y)+rm,(x-1):(x-1)+cm))+ qerr./16;
        end
    end
    
     end
end

% Y1=int8(255 * mat2gray(Y1));
Y1=Y1(2:ri+1,2:ci+1);
% imshow(Y1)
end




