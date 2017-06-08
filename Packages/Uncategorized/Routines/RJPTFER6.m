RJPTFER6 ;RJ WILM DE -CHECK MOVEMENTS; 12-12-85
 ;;4.0
 S (RJPFLAG,RJPFLAG1,RJPFLAG2)=0 I '$D(^DGPT(I,"M",0)) W !,"Patient has no MOVEMENTS.  Unable to Run Data CHECKER." G X
 S RJNEXT=0 F C=1:1 S RJNEXT=$N(^DGPT(I,"M",RJNEXT)) Q:RJNEXT'?.N  D C S RJLAST=RJNEXT
 I C=1 W !,"I cannot find any MOVEMENTS.  Unable to Run CHECKER." G X
 S D=^DGPT(I,"M",0),D=$P(D,"^",1,2)_"^"_RJLAST_"^"_(C-1),^DGPT(I,"M",0)=D
 I RJPFLAG D ^RJPTFEM
 S:RJPFLAG2 RJPFLAG=1
Q K RJMFLAG,RJPFLAG2,DIC,DIE,DA,C,D,E,F,K,N,RJLAST,RJNEXT,X Q
X S RJPFLAG1=1 G Q
C S D=^DGPT(I,"M",RJNEXT,0),RJMFLAG=0 I $P(D,"^",2)="" W !?10,"...No Losing Bedsection." S RJMFLAG=1
 I $P(D,"^",3)="" W !?10,"...No LEAVE DAYS." S RJMFLAG=1
 I $P(D,"^",4)="" W !?10,"...No PASS DAYS." S RJMFLAG=1
 I $P(D,"^",10)="" W !?10,"...No MOVEMENT DATE." S RJMFLAG=1
 S F=0 F E=5:1:9,11:1:15 I $P(D,"^",E)'="" S F=1 Q
 I 'F W !?10,"...No DIAGNOSIS." S RJMFLAG=1
 S F="" F E=5:1:9,11:1:15 S N=$P(D,"^",E),F=$S(E=5:N,1:F_"^"_N)
 S N=1 F K=1:1 S X=$P(F,"^",N) Q:'X  S F=$P(F,"^",2,10)
 F K=1:1:10 I $P(F,"^",K) W !?10,"...The DIAGNOSIS need to be Sequential Starting with ICD1." S RJMFLAG=1
 S:'$D(^DGPT(I,"M",RJNEXT,460000)) ^(460000)="" S K=$P(^(460000),"^",1) I K'?1N!(K<1)!(K>4)!(K="") W !?10,"...No Bed Occupancy Status." S RJMFLAG=1
P2 I RJMFLAG=1 W *7,!,"MOVEMENT NUMBER ",RJNEXT," Does not have all its data.  Unable to Run Data CHECKER.",! S RJPFLAG=1
 Q
