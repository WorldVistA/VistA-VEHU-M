DJDEFS ;FDJW JA/WASH; Shift entries ; 05 JUN 86  11:54 AM ;
 ;VERSION 1.36
 S DJDF=1 X DJCP
E S DY=17,DX=0 X XY W "Shift which entry numbers? " R DJDE:DTIME G Q:DJDE=""!(DJDE=U) I DJDE["?" D A1 G E
 F DJT=1:1 S DJK=$P(DJDE,",",DJT) Q:DJK=""  D E1:DJK["-" Q:'$D(DJDE)  D A1:'$D(^DJR(DJDN,1,"A",DJK)) Q:'$D(DJDE)
 G E:'$D(DJDE)
 X DJCP
B S DY=17,DX=0 X XY R "L(abels), F(ields), or B(oth)?: B// ",DJDB:DTIME G Q:DJDB=U,A2:DJDB["?" S:DJDB="" DJDB="B" S DJDB=$E(DJDB,1) G A2:"LlFfBb"'[DJDB S DJDB=$S("Bb"[DJDB:3,"Ff"[DJDB:2,1:1)
 X DJCP
UDRL S DY=17,DX=0 X XY W "Shift U(p), D(own), R(ight) or L(eft): " R DJD:DTIME G Q:DJD=""!(DJD=U) G A3:DJD["?" S DJD=$E(DJD,1) G A3:"UuDdRrLl"'[DJD S DJDY=$S("Uu"[DJD:-1,"Dd"[DJD:1,1:0),DJDX=$S("Rr"[DJD:1,"Ll"[DJD:-1,1:0)
 X DJCP
P S DY=17,DX=0 X XY W "How many positions? " R DJDP:DTIME G Q:DJDP=""!(DJDP=U) G A4:DJDP["?",A4:+DJDP<1,A4:DJDP>79,A4:DJDY&(DJDP>14),A4:DJDP["."
 X DJCP S DJX(2)=$S(DJD="R"&(DJDB>1):1,1:0)
REP S DJD1=$P(DJDE,",",1),DJDE=$P(DJDE,",",2,255) I DJD1_DJDE="" D Q S DJD=1 Q
 S DJD2=+DJD1 S:DJD1["-" DJD2=$P(DJD1,"-",2) S DJD1=+DJD1,DJV=DJD1-.01
NXT S DJV=$N(^DJR(DJN,1,"A",DJV)) G REP:DJV'>0,REP:DJV>DJD2 S DJDZ=^DJR(DJN,1,$N(^DJR(DJN,1,"A",DJV,0)),0),DJX=$P($P(DJDZ,U,2),"DX=",2),DJX(1)=+$P($P(DJDZ,U,2),"DY=",2),DJFL=1 D S:DJDB#2,S1:DJDB>1,S2:DJFL
 G NXT
Q S DJD="" K DJ3,DJ4,DJ8,DJ9,DJ10,DJ11,DJDA,DJD1,DJD2,DJDB,DJDE,DJDP,DJDX,DJDY,DJDZ,DJFL,DJK,DJI,DJT,DJV,DJX Q
S G:DJX=""!(DJX(1)="") D1 S DJ9=DJDP*DJDY+DJX(1),DJ8=DJDP*DJDX+DJX G D:DJ9<0,D:DJ9>15,D:DJ8<0,D:DJ8>79 Q
S1 I DJFL S DJX=$P($P(DJDZ,U,4),"DX=",2),DJX(1)=+$P($P(DJDZ,U,4),"DY=",2) G:DJX=""!(DJX(1)="") D1 S DJ11=DJDP*DJDY+DJX(1),DJ10=DJDP*DJDX+DJX G D:DJ11<0,D:DJ11>15,D:DJ10<0,D:(DJ10+$S(DJX(2):(+$P(DJDZ,"^",3)-1),1:0))>79 Q
 Q
S2 I DJDB#2 S DJDA=$N(^DJR(DJDN,1,"A",DJV,0)),$P(^DJR(DJDN,1,DJDA,0),U,2)="DY="_DJ9_",DX="_DJ8
 I DJDB>1 S DJDA=$N(^DJR(DJDN,1,"A",DJV,0)),$P(^DJR(DJDN,1,DJDA,0),U,4)="DY="_DJ11_",DX="_DJ10
 Q
A1 X DJCP S DY=22,DX=0 X XY W @DJEOP,"Enter a legal number (nn), a range of numbers separated by a hyphen (n0-n1),",!,"a combination of the two separated by comma's, or press return to exit." W:DJDE'["?" *7 K DJDE Q
A2 X DJCP S DY=22,DX=0 X XY W @DJEOP,"Enter an 'L' if you want to move just the label (and the entry number),",!,"an 'F' to move just the data field (the dots), or a 'B' to move both." W:DJDB'["?" *7 G B
A3 X DJCP X DJCL W "Enter a 'U','D','R', or 'L' for the direction of movement." W:DJD'["?" *7 G UDRL
A4 X DJCP S DY=22,DX=0 X XY W @DJEOP,"Enter the number of "_$S(DJDY:"rows (1-14)",1:"columns (1-79)")_" you wish to shift the entries",!,"you have selected.  Only whole numbers are allowed." W:DJDP'["?" *7 G P
D X DJCP X DJCL W @DJHIN,"Sorry, you are trying to move entry number ",DJV," too far "_$S(DJD="U":"up.",DJD="D":"down.",DJD="L":"left.",1:"right."),@DJLIN,*7 H 2 S DJFL=0 Q
 S DX=35,DY=17 X XY W "                            " G B
D1 X DJCP X DJCL W @DJHIN,"PLEASE CHECK THE COORDINATES FOR THIS FIELD","**",DJV,"**",@DJLIN H 2 S DJFL=0 Q
E1 S DJI=$P(DJK,"-",1) G A1:'$D(^DJR(DJDN,1,"A",DJI)) S DJK=$P(DJK,"-",2) G A1:'$D(^DJR(DJDN,1,"A",DJK)) Q
