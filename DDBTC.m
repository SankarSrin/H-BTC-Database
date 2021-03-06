%DDBTC
%Combination of Block Truncation Coding with Dot Diffusion
%met = 1-Messe 16, 2- Mese 8 ; 3- Knuth 8
%Programmed By: Sankarasrinivasan S
%Multimedia Signal Processing Lab, Dept. of Elec Engg. NTUST
%Oct 2016

function [H1]=DDBTC(in,met)

[ri,ci]=size(in);
in=im2double(in);
in=padarray(in,[1 1],'both');

if(met==1)
     CM= [207	0	13	17	28	55	18	102	81	97	74	144	149	169	170	172;
3	6	23	36	56	50	65	87	145	130	137	158	182	184	195	221;
7	14	24	37	67	69	86	5	106	152	150	165	183	192	224	1;
15	26	43	53	51	101	115	131	139	136	166	119	208	223	226	4;
22	39	52	71	84	103	164	135	157	173	113	190	222	225	227	16;
40	85	72	83	104	117	167	133	168	180	200	219	231	228	12	21;
47	120	54	105	123	132	146	176	179	202	220	230	245	2	20	41;
76	73	127	109	138	134	178	181	206	196	229	244	246	19	42	49;
80	99	112	147	142	171	177	203	218	232	243	248	247	33	48	68;
108	107	140	143	185	163	204	217	233	242	249	255	44	45	70	79;
110	141	88	75	175	205	214	234	241	250	254	38	46	77	116	100;
111	148	160	174	201	215	235	240	251	252	253	61	62	93	94	125;
151	159	189	199	197	216	236	239	25	31	60	82	92	95	124	114;
156	188	191	209	213	237	238	29	32	59	64	91	118	78	128	155;
187	194	198	212	9	10	30	35	58	63	90	96	122	129	154	161;
193	210	211	8	11	27	34	57	66	89	98	121	126	153	162	186;];
 bs=16;
 
elseif(met==2)

    
              CM = [47 31	51	24	27	45	5	21;
                    37	63	53	11	22	4	1	33;
                    61	0	57	16	26	29	46	8;
                    20	14	9	62	18	41	38	6;
                    17	13	25	15	55	48	52	58;
                    3	7	2	32	30	34	56	60;
                    28	40	36	39	49	43	35	10;
                    54	23	50	12	42	59	44	19;];  %Mese
                bs=8;
else 

               CM=  [34 48 40 32 29 15 23 31;    
				     42 58 56 53 21 5 7 10;
				     50 62 61 45 13 1 2 18;
				     38 46 54 37 25 17 9 26;
				     28 14 22 30 35 49 41 33;
				     20 4 6 11 43 59 57 52;
				     12 0 3 19 51 63 60 42;
				     24 16 8 27 39 47 55 36;]; 
                 bs=8;
                 
end                                                         %Knuth
                DM=[1 2 1;
                    2 0 2;
                    1 2 1;]/12;
                
                
   CM=repmat(CM,floor(ri/bs),floor(ci/bs));
   CM1=zeros(ri+2,ci+2)-1;   
   CM1(2:ri+1,2:ci+1)=CM;
   CM=CM1; 


b1=bs; b2=bs;

%Finding MEan, MAx and Minimum in Block wise 
for i1=1:b1:ri
    for j1=1:b2:ci
        bl=in(i1:i1+(b1-1),j1:j1+(b2-1));
        men(i1:i1+(b1-1),j1:j1+(b2-1))=mean(mean(bl));
        mx(i1:i1+(b1-1),j1:j1+(b2-1))=max(max(bl));
        mnn(i1:i1+(b1-1),j1:j1+(b2-1))=min(min(bl));
        med(i1:i1+(b1-1),j1:j1+(b2-1))=median(median(bl));
    end
end
size(men)
H=zeros(ri+2,ci+2);
men=padarray(men,[1 1],'both');
mx=padarray(mx,[1 1],'both');
mnn=padarray(mnn,[1 1],'both');
size(men)

% Error Diffusion Block 
for ii=0:1:max(max(CM))
      [p1 p2]=(find(CM==ii))    ;
      
          i1=1;
          j1=1;
      
      for m1=1:1:size(p1,1)   
      
            while(i1<=size(p1,1));
            while(j1<=size(p2,1));
            
              if(in(p1(i1),p2(j1))>men(p1(i1),p2(j1)))
                  H(p1(i1),p2(j1))=mx(p1(i1),p2(j1));
                               else
                  H(p1(i1),p2(j1))=mnn(p1(i1),p2(j1));
              end
           
              qerr=in(p1(i1),p2(j1))-H(p1(i1),p2(j1))  ;  
              cl=CM1((p1(i1)-1):(p1(i1)+1),(p2(j1)-1):(p2(j1)+1));
              k=cl>ii;
              DM1=(DM.*k);
              DM1=DM1/sum(DM(:));
              err=DM1*qerr;
              in((p1(i1)-1):(p1(i1)+1),(p2(j1)-1):(p2(j1)+1))= in((p1(i1)-1):(p1(i1)+1),(p2(j1)-1):(p2(j1)+1))+err;
               
                    i1=i1+1;
                    j1=j1+1;
            end
            end      
      end
end
size(H)
H1=H(2:ri+1,2:ci+1);
H1=uint8(255 * mat2gray(H1));
end

