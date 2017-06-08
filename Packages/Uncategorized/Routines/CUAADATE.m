CUAADATE ;RJ WILMINGTON DE & LM COLUMBIA SC-LIST MICOM DATE & TIME; 6-9-85
 ;Version 3.6
 D 1^CUAAVR I X=U W !,"No connection made." K IO,IOP,W,X,Y Q
 U IO(0) W !,"Listing Micom Time and Date..." F I=1:1:4 U IO W *10 R X:1
 S CUDT="",R="DMP 969F 3" D T,R U IO(0) S:$P(CUDT,U,2)'=10 CUDT=$P(CUDT,U,1)_U_U_U_$P(CUDT,U,3,50) S (CUT,CUTIM)=""
 F CUT=$P(CUDT,U,25,26),$P(CUDT,U,28,29),$P(CUDT,U,31,32) D X S I=H+L S:$L(I)=1 I=0_I S CUTIM=CUTIM_I
 W !!,"Time (HH:MM:SS) ->> ",$E(CUTIM,1,2),":",$E(CUTIM,3,4),":",$E(CUTIM,5,6)
 S CUDT="",R="DMP 969D 2" D T,R U IO(0) D CP^CUAADIS X ^%ZIS("C")
 S CUT=$P(CUDT,U,24,25) D X S R=$C($P(CUDT,U,28))*16*16+H+L
 S CUMON="Jan^Feb^Mar^Apr^May^Jun^Jul^Aug^Sep^Oct^Nov^Dec",CUDAY="31^59^90^120^151^181^212^243^273^304^334^365"
 S %DT=$P($H,",",1) D %CDS^%H S Y=$P(%DAT1,"-",3)
 I Y#4=0 F I=2:1:12 S CUDAY=$P(CUDAY,U,1,I-1)_U_$P(CUDAY,U,I)+1_U_$P(CUDAY,U,I+1,12)
 D M S CUDAT=R-$P(CUDAY,U,I-1)_"-"_$P(CUMON,U,I)_"-"_Y W !!,"Date ->> ",CUDAT K CUDAY,CUMON,CUDT,CUDAT,CUTIM,CUT,I,IO,H,L,R,%DAT,%DAT1,P,Y Q
T U IO(0) F J=1:1 D P S X=$E(R,J) Q:X=""  U IO W X
 U IO W *13 Q
R F J=0:0 U IO R *X:1 Q:X=-1  S:X'=0 CUDT=CUDT_U_X
 Q
P F I=1:1:50
 Q
M F I=1:1:12 Q:$P(CUDAY,U,I)>(R-1)
 Q
X S H=$C($P(CUT,U,1)),H=$S(H="A":10,H="B":11,H="C":12,H="D":13,H="E":14,H="F":15,1:H)*16,L=$C($P(CUT,U,2)),L=$S(L="A":10,L="B":11,L="C":12,L="D":13,L="E":14,L="F":15,1:L) Q
