DGMT2 ;ALB/JDS - MEANS TEST ;01 JAN 86
 ;;MAS VERSION 5.1;
MOV S %=1 Q:'$D(^DG(41.3,DFN,1,DGLY-10000,1,0))  W !,"No current income data",!,"Want to move data from previous year" S %=1 D YN^DICN Q:%=-1!(%=2)  I %=0 W !!,?10,"Enter 'Y' for YES or 'N' for NO or '^' to EXIT",! G MOV
 F I=1:1:5 I $D(^DG(41.3,DFN,1,DGLY-10000,1,I,0)) S ^DG(41.3,DFN,1,DGLY,1,I,0)=^(0)
 S $P(^DG(41.3,DFN,1,DGLY,0),U,2,3)=$P(^DG(41.3,DFN,1,DGLY-10000,0),U,2,3)
 Q
REF S A=9999999-DGCD,DIE="^DG(41.3,"_DFN_",2,",DA(1)=DFN,DA=A,DR="14;S:X']"""" Y=0;50" D ^DIE I '$P(^DG(41.3,DFN,2,A,0),U,14) G EN2^DGMT
 S DGC="C",DGT=$S($D(DGT):DGT,1:+$P(^DG(41.3,DFN,2,A,0),U,4)),DGW=$S($D(DGW):DGW,1:+$P(^(0),U,5)),DGA=$S($D(DGA):DGA,1:+$P(^(0),U,12)),DGB=$S($D(DGB):DGB,1:$P(^(0),U,13)),DGMT=$S($D(DGMT):DGMT,1:0) G END^DGMT1
 Q
ADD S DIC="^DPT(",DIC(0)="AEMQ" D ^DIC G Q1^DGMT:Y'>0 S DFN=+Y D EN^DGMT0 I 'DGMT W !,"Means Test Not Required",! G ADD
 S:'$D(^DG(41.3,DFN,2,0)) ^(0)="^41.33DA^^" S DIC(0)="ELMZAQ",DIC="^DG(41.3,"_DFN_",2,",DA(1)=DFN D ^DIC G Q1^DGMT:Y'>0 S DGCD=+Y(0) I '$P(Y,U,3) W !,"Use Edit option if not adding new Means Test",! G ADD
 S A=$N(^DG(41.3,DFN,2,0)) I A'=+Y,$N(^(A))=+Y,$P(^(A,0),U,2)="R" S DIK="^DG(41.3,"_DFN_",2,",DA(1)=DFN,DA=A D ^DIK K DIK
 S DGJUMP=2 G EN1^DGMT
Q G Q^DGMT1
FOR S:X']"" X=$J("-",12) I X'[" -" S:X'<1000 X=X\1000_","_$E(X,$L(X\1)-2,99) S $P(X,".",2)=$E($P(X,".",2)_"00",1,2),X=$J($S(X["-":"-$",1:"$")_$S(X["-":$P(X,"-",2),1:X),12)
 W X Q
H W !!,"Enter # to edit field",!?6,"#,#... to edit group of fields",!?6,"#-# to edit range",!?6,"ALL to edit all fields",!?6,"Type 'V','S','C' in front of entry for only VET,SPOUSE,CHILDREN",!
 W:'(DGW+DGT) ?6,"'R' if refuses to give income information",! R !,"Press Return to Continue:",X:DTIME G EN2^DGMT
SE S X=$S(L=1:2,L<6:L,"^66^103^104^"[(U_L_U):L,1:0) G @X:X S B=2,A=5 S:L>66 A=6 I L>84&(L<97) S B=$S(L<91:3,1:1)
 G FR
2 S X=$P(^DPT(DFN,0),U,$S(L=2:9,1:1)) W X Q
3 S X=$P($P($P(^DD(41.31,2,0),U,3),+$P(DG0,U,2)_":",2),";",1) W X Q
4 S X=+$P(DG0,U,3) W X Q
5 S Y=DGLY X ^DD("DD") S X=Y W X Q
66 S DGFR=2,DGTO=11 D SUM S DGW=X G FOR:DGR S X=DGR W X Q
103 S X=DGW+$S($P(X(6),U,17)>0:$P(X(6),U,17),1:0) G FOR:DGR S X=DGR W DGR Q
104 S X=$P($S($D(^DG(41.3,DFN,2,9999999-DGT,0)):^(0),1:0),U,2),X=$S(X="P":"C",1:X),DGL=$S(X'="C":I+5,1:0) W X Q
 Q
SUM S X=0 F D=DGFR:1:DGTO S X=X+$P(X(6),U,D)
 Q
FR S X=$P(X($S(L-A#6:L-A#6,1:6)),U,(L-A-1\6+B)) G FOR
EDIT S DR="50///+MEANS TEST OF "_$E(+L,4,5)_"-"_$E(+L,6,7)_"-"_$E(+L,2,3)_" formerly completed by "_$P(^VA(200,$P(L,U,6),0),U,1)_" completed by "_$P(^VA(200,DUZ,0),U,1)_" on "_$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3),DA=DFN,DIE="^DG(41.3,"
 G ^DIE
PRINT W !,"PRINT 10-10F" S %=1 D YN^DICN G Q1^DGMT1:%=2,Q1^DGMT:%=-1 I '% W !!,?10,"Enter 'Y' for YES or 'N' for NO or '^' to EXIT",! G PRINT
DEV I '$D(DGIO(10)) W ! S %IS="QM",%IS("B")="",IOP="Q" D ^%ZIS G:POP Q1^DGMT1 I IO=IO(0) W *7,!,"CANNOT QUEUE TO HOME DEVICE",! G DEV
 K:$D(IO("Q")) IO("Q") S ZTRTN="PRINT1^DGMT0",ZTDTH=$H,ZTSAVE("DFN")=DFN,ZTSAVE("DGT")=DGCD S ZTIO=$S($D(DGIO(10)):DGIO(10),1:ION) D ^%ZTLOAD W !,$S($D(ZTSK):"REQUEST QUEUED!",1:"REQUEST CANCELLED") K ZTSK
 X ^%ZIS("C") G Q1^DGMT1
