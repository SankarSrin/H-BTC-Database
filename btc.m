%Block Truncation Coding
% Ref:Delp, Edward, and O. Mitchell. 
 %"Image compression using block truncation coding." 
 %IEEE transactions on Communications 27.9 (1979): 1335-1342.

%Programmed By: Sankarasrinivasan S
%Multimedia Signal Processing Lab, Dept. of Elec Engg. NTUST
%Oct 2016

function [H]=btc(in,bs)

%in--> input image, bs-block size(2,4,..)
[s1 s2]=size(in);

n=bs*bs;
  
for i=1:bs:s1    
    for j=1:bs:s2
        bl=in(i:i+(bs-1),j:j+(bs-1));
        mn=mean(bl(:))  ;         %Computing Mean
        sd=std(double(bl(:)),1); %Standard Deviation
        c=bl>mn;
        q=nnz(c);
        a=mn-(sd*sqrt((q)/(n-q)));
        b=mn+(sd*sqrt((n-q)/(q)));
        out=round((c).*b+((~c)).*a);
        H(i:i+(bs-1),j:j+(bs-1))=out;
    end
end
end

