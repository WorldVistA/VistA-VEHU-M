DGMT1 ;ALB/JDS - MEANS TEST ;01 JAN 1986
 ;;MAS VERSION 5.1;
EN S DGS="N"
EN2 W ! Q:'$D(^DG(41.3,DFN,0))  S DGMT=$P(^(0),U,2),DGMTL=$N(^DG(41.3,DFN,2,0)),DGMTLL=$S($D(^(DGMTL,0)):^(0),1:"") G Q:DGMT']"",Q:DGMT="N",Q:"ABCPR"'[DGMT,@(DGMT)
A W !,"Patient is Category A based on means test",!,"Veteran is eligible and provision of hospital care is mandatory",! G Q
B W !,"Patient is Category B based on means test",!,"Veteran is eligible on a space available basis",! G Q
C S A=$O(^DG(41.3,DFN,2,0)),A=$S(A:$P(^(A,0),U,11),1:"") W !,"Patient is Category C based on means test",!,$S(A']"":"",A:"Has agreed to pay deductible",1:"Has not agreed to pay deductible"),! G Q
P W !,"Patients Means Test is Pending Adjudication",! G Q
R W !,"Patient Requires Means Test",! G Q
Q I $D(DGMT) W:DGMT="N" !,"Means Test Not Required",! I $D(DGMTL),DGMTL>0 S Y=9999999-DGMTL X ^DD("DD") S DGMTLA=Y,X=$S($P(DGMTLL,U,2)="R":1,1:0),Y=$P(DGMTLL,U,7) I Y]"" X ^DD("DD") S Y="  (COMPLETED: "_Y_")"
 I $D(DGMTLA),DGMTLA]"" W "Means Test ",$S(X:"Required from",1:"Last Applied")," '",DGMTLA,"'.",$S(X!(DGMT="N"):"",1:Y)
QUIT K %,%DT,J,DA,DGADJ1,DGP,DIE,DGMTLA,DGS,DR,DGNC,DGT,DGX,DGV,DGMS,DGN,DGA,DGLY,DGN,DGB,DGC,A,B,I,DG0,DIC,DIV,X,DGCD,DGMT,DGMTL,Y,Z,DG Q
Q1 K IO("Q") G Q^DGMT
MT K DGIO,DGJUMP S DIC(0)="MEQA",DIC="^DG(41.3,",DIC("S")="I $P(^(0),U,2)=""R""" D ^DIC G Q1^DGMT:Y'>0 S DFN=+Y,DGCD=$O(^DG(41.3,DFN,2,0)) I 'DGCD W !,"NO Means Test Registration on record",! G Q
 K DIC S DA=$O(^DPT(DFN,"DIS",0)) I DA S Y=9999999-DA X ^DD("DD") W !,"Editing Registration of ",Y,! S DIE="^DPT(",DFN1=DA,DA=DFN,DR="[DGMT]" D ^DIE D EN^DGMT0 G MT:'DGMT
 S DGCD=9999999-DGCD,DGJUMP=3 G EN1^DGMT
 Q
ADJ S DIC="^DG(41.3,",DIC(0)="MAEQZ",DIC("S")="I $P(^(0),U,2)=""P""" D ^DIC G Q:Y'>0 K DIC("S") S DFN=+Y,DGCD=$O(^DG(41.3,DFN,2,0)) I DGCD'>0 W !,"No Means Test Registration",! G ADJ
 I $P(^DG(41.3,DFN,2,DGCD,0),U,2)'="P" G ADJ
 S DGADJ1=0,DIE="^DG(41.3,"_DFN_",2,",DA(1)=DFN,DA=DGCD,DR="2;S:X=""P"" Y=0;S DGADJ1=1;10///T;50",DGADJ=1 D ^DIE K DGADJ G ADJ:'DGADJ1
 I DGADJ1 S DIE="^DG(41.3,",DA=DFN,DR="50///+Adjudicated by "_$P(^VA(200,DUZ,0),U,1)_" on "_$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3) D ^DIE G ADJ
 Q
AD S DGC=^DG(41.3,DA(1),2,DA,0) G AD1:$D(DGADJ(1)) I $P(DGC,U,4)>$P(DGC,U,12) S DGC="^B^C^" Q
 S DGC="^A^B^C^" Q
AD1 I $P(DGC,U,4)>$P(DGC,U,13)&($P(DGC,U,5)) S DGC="^A^B^C^P^" Q
 S A=9999999-DA,A=$S($D(^DG(43,1,"MT",$E(A,1,3)_"0000",0)):^(0),1:0),A=$P(A,U,8) I $P(DGC,U,4)+$P(DGC,U,5)>A S DGC="^A^B^C^P^" Q
 I $P(DGC,U,4)>$P(DGC,U,13) S DGC="^A^B^C^" Q
 I $P(DGC,U,4)>$P(DGC,U,12) S DGC="^A^B^" Q
 S DGC="^A^" Q
CHK S DIC="^DG(41.3,",DIC(0)="MAEQZ",DIC("S")="I ""^N^R^""'[$P(^(0),U,2)" D ^DIC G QUIT:Y'>0 S DFN=+Y,DGCD=$O(^DG(41.3,DFN,2,0)) I DGCD'>0 W !,"No Means Test Registration",! G CHK
 S DIE="^DG(41.3,"_DFN_",2,",DA(1)=DFN,DA=DGCD,DR="2;8////"_DUZ_";9///N;50",DGADJ(1)=1 D ^DIE K DGADJ S DIE="^DG(41.3,",DA=DFN,DR="50///+Category change by "_$P(^VA(200,DUZ,0),U,1)_" on "_$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3) D ^DIE G CHK
COM S A=1 I DGW=0,("^A^B"[(U_DGC)) S A=0 F J=12:1:16 I $P(X(1),U,J)]"" S A=1 Q
 I 'A W !,"Patients in Category A&B require Property information",! H 4 G EN2^DGMT
 W !,"Do you wish to complete means test" S %=1 D YN^DICN G Q:%<0!(%=2) I '% W !!,"Enter YES if the means test information is complete",!! G COM
END S L=^DG(41.3,DFN,2,9999999-DGCD,0) I $P(L,U,6) D EDIT^DGMT2 K DR,DIE
 S DIE="^DG(41.3,"_DFN_",2,",DA(1)=DFN,DA=9999999-DGCD,DR="2////"_DGC_";4////"_DGT_";5////"_DGW_";6////"_DUZ_$S($P(L,U,7):"",$N(^DG(41.3,DFN,2,0))'=DA:";7///"_DGCD,1:";7///N")_$S(DGC="C":";11",1:"")_";12////"_DGA_";13////"_DGB
 D ^DIE I DGCD<DT S DR=7 D ^DIE
 G PRINT^DGMT2:DGC="C"!((DGW+DGT)'>$P(DGMT,U,8))
ADJJ W !,"Since assets exceed the threshold",!,"Do you wish to send this case to adjudication" S %=1 D YN^DICN I %=1 S DR="2////P" D ^DIE G PRINT^DGMT2
 I %'>0 W !,"Patient will be placed in Category C unless Means test is Adjudicated",!,"Answer Yes or No",! G ADJJ
 S DR="2///C;11" D ^DIE G PRINT^DGMT2
