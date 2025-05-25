\\ file name: h7s-AES.gp

\\ AES (128 bit key) encryption/decryption programs using PARI/GP ver.0.900.
\\ copyright by Hideo Suzuki, hideo7suzuki@gmail.com Jan. 2025.

{ AES_RK(KEY) = 
RK=vector(11);
RK[1]=KEY;
for(i=2,11,RK[i]= AESnextRK(RK[i-1],RC[i-1])); 
return; }

{ AES(PT,KEY) = 
CTT=vector(11);
CTT[1]=bitxor(PT,RK[1]);
for(i=2,10,CTT[i]=AES_round(i,CTT[i-1]));
for(i=11,11,CTT[i]=AES_round10(i,CTT[i-1]));
return(CTT[11]); }

{ AESinv(CT,KEY) = 
  my(PT);
CTT=vector(11);
CTT[11]=CT;
for(i=10,10,CTT[10]=AESinv_round10(10,CTT[11]));
for(i=1,9,CTT[10-i]=AESinv_round(10-i,CTT[11-i]));
PT=bitxor(CTT[1],RK[1]);
return(PT); }

{ AESprintRK() = 
printf("   KEY=0x%032X",KEY);print("");
for(i=1,11,printf("RK[%2d]=0x%032X",i,RK[i]);print(""))
}

{ AESprint() = 
print("(dec)");
printf("KEY=%d",KEY);print(""); 
printf(" PT=%d",PT);print(""); 
printf(" CT=%d",CT);print("");
print("(hexdec)");
printf("KEY=0x%032X",KEY);print(""); 
printf(" PT=0x%032X",PT);print(""); 
printf(" CT=0x%032X",CT);print("");
}

{ AESprintrev() = 
print("(dec)");
printf("KEY=%d",KEY);print(""); 
printf(" CT=%d",CT);print("");
printf(" PT=%d",PT);print(""); 
print("(hexdec)");
printf("KEY=0x%032X",KEY);print(""); 
printf(" CT=0x%032X",CT);print("");
printf(" PT=0x%032X",PT);print(""); 
}

{ AESprintKEY() = 
print("(dec)");
printf("KEY=%d",KEY);print(""); 
print("(hexdec)");
printf("KEY=0x%032X",KEY);print(""); 
}

{ AESprintPT() = 
print("(dec)");
printf(" PT=%d",PT);print(""); 
print("(hexdec)");
printf(" PT=0x%032X",PT);print(""); 
}

{ AESprintCT() = 
print("(dec)");
printf(" CT=%d",CT);print("");
print("(hexdec)");
printf(" CT=0x%032X",CT);print("");
}

{ AESprintCTT() = 
printf("     PT=0x%032X",PT);print(""); 
for(i=1,11,printf("CTT[%2d]=0x%032X",i,CTT[i]);print(""));
printf("     CT=0x%032X",CT);print("");
}

{ AESprintCTTrev() = 
printf("     CT=0x%032X",CT);print("");
for(i=0,10,printf("CTT[%2d]=0x%032X",11-i,CTT[11-i]);print(""));
printf("     PT=0x%032X",PT);print(""); 
}


P(x)=x^8+x^4+x^3+x+1;

{ dec2radix(dec,base) =
  my(i,digiii,ans);
if(dec==0,
if(base==10,ans="0",
  if(base==2,ans="0b0",
    if(base==16,ans="0x0",ans=concat(concat("radix(",Str(base)),") 0"))));
        if(base==10,return(eval(ans)),return(ans)));
digiii=digits(dec,base);
if(base==10,ans="",
  if(base==2,ans="0b",
    if(base==16,ans="0x",ans=concat(concat("radix(",Str(base)),") "))));
    for(i=1,length(digiii),ans=concat(ans,hexdecchar(digiii[i])));
  if(base==10,return(eval(ans)),return(ans)) }
\\ for check
\\ for(i=2,16,print(dec2radix(0x43,i)))

{ digits2dec(digi,base) =
  my(dec,i);
dec=0;for(i=1,length(digi),dec*=base;dec+=digi[i]);return(dec) }

{ count1(dec) = 
  my(i,bb,c); 
if(dec<=0,return(0)); 
bb=digits(dec,2); 
c=0; for(i=1,length(bb),if(bb[i]==1,c++));return(c) }
\\ for check
\\ for(i=0,63,print("count1( ",digits(i,2)," ) = ",count1(i)))

{ AESnextRK(RK,RC) = 
my(RKK,RKD=matrix(2,4),GV=vector(4),G);
RKD[1,]=Vecrev(Vecrev(digits(RK,2^32),4));
GV=Vecrev(Vecrev(digits(RKD[1,4],256),4));
GV=concat(vecextract(GV,"2..4"),vecextract(GV,"1"));
GV = [S[GV[1]+1,1],S[GV[2]+1,1],S[GV[3]+1,1],S[GV[4]+1,1]];
GV[1]=bitxor(GV[1],RC);
G=digits2dec(GV,256);
RKD[2,1]=bitxor(RKD[1,1],G);
RKD[2,2]=bitxor(RKD[2,1],RKD[1,2]);
RKD[2,3]=bitxor(RKD[2,2],RKD[1,3]);
RKD[2,4]=bitxor(RKD[2,3],RKD[1,4]);
RKK=digits2dec(RKD[2,],2^32);
return(RKK); }

{ AES_round(r,A) = 
my(C,ADD=vector(16),BDD=vector(16),
BBpos=matrix(4,4),BB=matrix(4,4),BBpol=matrix(4,4),
XX=matrix(4,4),XXpol=matrix(4,4),
CC=matrix(4,4),CCpol=matrix(4,4),
CD=vector(4) );

ADD=Vecrev(Vecrev(digits(A,256),16));

BDD=vector(0);
for(i=1,16,BDD=concat(BDD,S[ADD[i]+1,1]));

BBpos = [
1,5,9,13;
6,10,14,2;
11,15,3,7;
16,4,8,12];
for(i=1,4, for(j=1,4,BB[i,j]=BDD[BBpos[i,j]]));
for(i=1,4, for(j=1,4,BBpol[i,j]=Pol(digits(BB[i,j],2))));

XX = [
0x02,0x03,0x01,0x01;
0x01,0x02,0x03,0x01;
0x01,0x01,0x02,0x03;
0x03,0x01,0x01,0x02];

for(i=1,4, for(j=1,4,XXpol[i,j]=Pol(digits(XX[i,j],2))));

CCpol = lift(lift(Mod(Mod(XXpol * BBpol,P(x)),2)));
for(i=1,4, for(j=1,4,CC[i,j]=digits2dec(Vec(CCpol[i,j]),2)));
for(i=1,4,CD[i]=digits2dec(CC~[i,],256));
C = digits2dec(CD,2^32);
C = bitxor(C,RK[r]);
return(C); }

{ AES_round10(r,A) = 
my(C,ADD=vector(16),BDD=vector(16),
BBpos=matrix(4,4),BB=matrix(4,4),BBpol=matrix(4,4),
XX=matrix(4,4),XXpol=matrix(4,4),
CC=matrix(4,4),CCpol=matrix(4,4),
CD=vector(4) );

ADD=Vecrev(Vecrev(digits(A,256),16));

BDD=vector(0);
for(i=1,16,BDD=concat(BDD,S[ADD[i]+1,1]));

BBpos = [
1,5,9,13;
6,10,14,2;
11,15,3,7;
16,4,8,12];
for(i=1,4, for(j=1,4,CC[i,j]=BDD[BBpos[i,j]]));

for(i=1,4,CD[i]=digits2dec(CC~[i,],256));
C = digits2dec(CD,2^32);
C = bitxor(C,RK[r]);
return(C); }


{ AESinv_round(r,C) = 
my(A,C2,CDD=vector(16),BDD=vector(16),
BD=vector(16),
BBpos=matrix(4,4),BB=matrix(4,4),BBpol=matrix(4,4),
XX=matrix(4,4),XXpol=matrix(4,4),
CC=matrix(4,4),CCpol=matrix(4,4),
CD=vector(4) );

C2 = bitxor(C,RK[r+1]);

CDD=Vecrev(Vecrev(digits(C2,256),16));

for(i=1,4,CC[i,1]=CDD[i]);
for(i=1,4,CC[i,2]=CDD[i+4]);
for(i=1,4,CC[i,3]=CDD[i+8]);
for(i=1,4,CC[i,4]=CDD[i+12]);

for(i=1,4, for(j=1,4,CCpol[i,j]=Pol(digits(CC[i,j],2))));

XXinv = [
0x0E,0x0B,0x0D,0x09;
0x09,0x0E,0x0B,0x0D;
0x0D,0x09,0x0E,0x0B;
0x0B,0x0D,0x09,0x0E];

for(i=1,4, for(j=1,4,XXpol[i,j]=Pol(digits(XXinv[i,j],2))));

BBpol = lift(lift(Mod(Mod(XXpol * CCpol,P(x)),2)));
for(i=1,4, for(j=1,4,BB[i,j]=digits2dec(Vec(BBpol[i,j]),2)));

BBinvpos = [
1,5,9,13;
14,2,6,10;
11,15,3,7;
8,12,16,4];

BD=vector(0);
BD=concat(BD,[BB[1,1],BB[2,4],BB[3,3],BB[4,2]]);
BD=concat(BD,[BB[1,2],BB[2,1],BB[3,4],BB[4,3]]);
BD=concat(BD,[BB[1,3],BB[2,2],BB[3,1],BB[4,4]]);
BD=concat(BD,[BB[1,4],BB[2,3],BB[3,2],BB[4,1]]);

AD=vector(0);
for(i=1,16,AD=concat(AD,S[BD[i]+1,2]));

A = digits2dec(AD,256);
return(A); }


{ AESinv_round10(r,C) = 
my(A,C2,CDD=vector(16),BDD=vector(16),
BD=vector(16),
BBpos=matrix(4,4),BB=matrix(4,4),BBpol=matrix(4,4),
XX=matrix(4,4),XXpol=matrix(4,4),
CC=matrix(4,4),CCpol=matrix(4,4),
CD=vector(4) );

C2 = bitxor(C,RK[r+1]);

CDD=Vecrev(Vecrev(digits(C2,256),16));

for(i=1,4,CC[i,1]=CDD[i]);
for(i=1,4,CC[i,2]=CDD[i+4]);
for(i=1,4,CC[i,3]=CDD[i+8]);
for(i=1,4,CC[i,4]=CDD[i+12]);

BD=vector(0);
BD=concat(BD,[CC[1,1],CC[2,4],CC[3,3],CC[4,2]]);
BD=concat(BD,[CC[1,2],CC[2,1],CC[3,4],CC[4,3]]);
BD=concat(BD,[CC[1,3],CC[2,2],CC[3,1],CC[4,4]]);
BD=concat(BD,[CC[1,4],CC[2,3],CC[3,2],CC[4,1]]);

AD=vector(0);
for(i=1,16,AD=concat(AD,S[BD[i]+1,2]));

A = digits2dec(AD,256);
return(A); }

{ af = [
1,1,1,1,1,0,0,0;
0,1,1,1,1,1,0,0;
0,0,1,1,1,1,1,0;
0,0,0,1,1,1,1,1;
1,0,0,0,1,1,1,1;
1,1,0,0,0,1,1,1;
1,1,1,0,0,0,1,1;
1,1,1,1,0,0,0,1]; }

b3=[0,1,1,0,0,0,1,1]; 

\\ S[1..256,1] is S-box
\\ S[1..256,2] is S^{-1}-box
{ S=matrix(256,2);
for(i=0,255,
if(i==0,b2=vector(8),
b2=Vecrev(Vecrev(lift(lift(Mod(Mod(Pol(digits(i,2)),P(x)),2)^-1)),8)));
b = lift(Mod(af * b2~ + b3~,2))~;
S[i+1,1] = digits2dec(b,2)); 
for(i=0,255,for(j=0,255,if(S[j+1,1] == i, S[i+1,2]=j; break))); }

RC=vector(14);
{ for(i=1,14,
    RC[i] = digits2dec(Vecrev(Vecrev(lift(lift(Mod(Mod(x^(i-1),P(x)),2))),8)),2) ) }

