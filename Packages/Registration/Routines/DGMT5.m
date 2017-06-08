DGMT5 ;ALB/JDS - MEANS TEST CALCULATION ; 01 JAN 86
 ;;MAS VERSION 5.1;
 S DGEND=DT,DGSTART=0
 F I=0:0 S I=$N(^DG(41.3,DFN,2,I)) Q:I'>0  S J=^(I,0),K=$P(J,U,2) S:"^C^P^"[(U_K_U) DGSTART=$P(J,U,7),DGEND=DT S:'DGSTART DGEND=J
 I 'DGSTART S $P(^DG(41.3,DFN,0),U,3)="",X=1 F DGI=0:0 S DGI=$N(^DD(41.3,3,1,DGI)) Q:DGI'>0  S DA=DFN X ^(DGI,2)
 Q:'DGSTART  S I=$S($D(^DG(41.3,DFN,0)):^(0),1:0) Q:'I  I $P(I,U,4) S X1=DT,X2=-30 D C^%DTC S X1=DGSTART,DGSTART=$E(X,1,5)_"01" S DGSTART=$S('$P(I,U,5):DGSTART,DGSTART<$P(I,U,5):DGSTART,1:$P(I,U,5)) S:DGSTART>X1 DGSTART=X1 Q:DGEND'>DGSTART
 F DGI=$E(DGSTART,1,5):1:$E(DGEND,1,5) S:$E(DGI,4,5)=13 DGI=$E(DGI,1,3)+1_"01" S DGSD=DGI_"00",DGOF=$N(^DG(43,1,"MT1",9999999-DGSD)),DGOF=$S($D(^(DGOF,0)):$P(^(0),U,2),1:16) D SET
 S DIE="^DG(41.3,",DA=DFN,DR="4///N"_$S($P(^DG(41.3,DFN,0),U,5):";5///@",1:"") G ^DIE
SET S:'$D(^DG(41.3,DFN,4,0)) ^(0)="^41.36D^^" I $D(^(DGSD,0)) Q:$P(^(0),U,11)
 E  S X=DGSD,DIC="^DG(41.3,"_DFN_",4,",DA(1)=DFN,X=DGSD,DIC(0)="LM" D ^DIC
 S DGX=$S($D(^DG(43,1,"MT1","AB",DGI)):99-$E($N(^(DGI,0)),6,7),1:0)
 S I=$N(^DD("FUNC","B","DGDAYSINMONTH",0)) S X=32 I I>0 S X=DGSD X ^DD("FUNC",I,1)
 K DGFB S DGED=(DGI_X)+.9,DGFB="",DGII=^DG(41.3,DFN,4,DGSD,0) D DGSD^DGMT3,^SDMEAN
 S DGF="" I DGFB'?31"0" F I=0:0 S I=$N(DGFB(I)) Q:I'>0  S $P(DGF,U,I)=DGFB(I)
 S DIE="^DG(41.3,"_DFN_",4,",DA(1)=DFN,DA=DGSD,DR="" F I=8:1:9 S J=@($P("DGIN^SD^DGFB",U,I-7)) S:J?31"0" J="" S DR=DR_I_"///"_$S($L($P(DGII,U,I))&('$L(J)):"@",1:"/"_J)_";"
 S DR=DR_"12///NOW;"_$S(DGF]"":"50///"_DGF,1:"") D ^DIE
 Q
EN F DFN=0:0 S DFN=$N(^DG(41.3,"AC",1,DFN)) Q:DFN'>0  D DGMT5
 K D,D1,DA,DFN,DG1,DG2,DGA1,DGCA,DGDA,DGDO,DGED,DGEND,DGF,DGFB,DGI,DGID,DGII,DGIN,DGIS,DGNO,DGOF,DGS,DGSD,DGSTART,DGT,DGX,DIC,DIE,DR,I,J,K,P,POP,S,SD,SDSC,X,X1 Q
EN1 K ^UTILITY($J)
EN2 S DIC="^DG(41.3,",D="B",DIC(0)="AZMEQ",DIC("S")="I $P(^(0),U,3)",DIC("W")="W !,$P(^DPT(+^(0),0),U,1),?25,$P(^(0),U,9)" D IX^DIC
 G Q1:Y'>0 I '$P(Y(0),U,4) W !,"Means Test information never recompiled",! S ^UTILITY($J,+Y)="" G EN2
ASK S ^UTILITY($J,+Y)="" W !,"Want to recompile from earliest date patient was Cat C" S %=1 D YN^DICN G Q:%<0
 I '% W !!?4,"YES - To recompile from date patient was first identified as Category 'C'.",!?4,"NO  - To recompile from last date recompilation was run for this patient.",! G ASK
 S DIE=DIC,DR=$S(%=1:"4///@",1:5),DA=+Y D ^DIE W !,"Will recompile when Means Test compilation runs",! G EN2
 Q
Q1 Q:'$D(^UTILITY($J))  W !,"Want to Queue Means Test Compilation for now" S %=2 D YN^DICN G Q1:'%,Q:%=2
Q2 S ZTRTN="DQ1^DGMT5",ZTDTH=$H S ZTIO=$S($D(DGIO(10)):DGIO(10),1:"")
 S ZTSAVE("^UTILITY($J,")="" D ^%ZTLOAD W !,$S($D(ZTSK):"REQUEST QUEUED!",1:"REQUEST CANCELLED!") K ZTSK,^UTILITY($J)
Q K D0,DA,DIC,DIE,DR Q
DQ1 F DFN=0:0 S DFN=$N(^UTILITY($J,DFN)) Q:DFN'>0  D DGMT5
