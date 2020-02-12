%AMBTC
%Ref:Lema, M., and O. Mitchell. 
%"Absolute moment block truncation coding and its application to color images."
% IEEE Transactions on communications 32.10 (1984): 1148-1157.

%Programmed By: Sankarasrinivasan S
%Multimedia Signal Processing Lab, Dept. of Elec Engg. NTUST
%Oct 2016

function [H]=ambtc(in,bs)

%in--> input image; bs--> blocksize

[s1 s2]=size(in);

 n=bs*bs;
  
for i=1:bs:s1
    for j=1:bs:s2
        bl=in(i:i+(bs-1),j:j+(bs-1));
        mn=mean(mean(bl))   ;            %Computing Mean
        fm=mean(mean(abs(bl-mn)))   ;        %Abs moment
        g=(n*fm)/2;
        c=bl>mn;
        q=nnz(c);
        if(q==n)
            b=mn;
            a=0;
        else
            b=mn+(g/q);
            a=mn-(g/(n-q));
        end
        out=round(c.*b+(~c).*a);
        H(i:i+(bs-1),j:j+(bs-1))=out;
    end
end
imshow(H,[]);

%To Validate Paper Results
% test=[121 114 56 47; 37 200 247 255; 16 0 12 169; 43 5 7 251;];
% mn =
% 
%    98.7500
% 
% 
% fm =
% 
%    83.2188
% 
% 
% g =
% 
%   665.7500
% 
% 
% b =
% 
%   193.8571
% H =
% 
%    194   194    25    25
%     25   194   194   194
%     25    25    25   194
%     25    25    25   194
