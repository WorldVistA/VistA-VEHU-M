RJPTFDRG ;RJ WILM DE -CALC DRG'S FOR ALL DX#'S IN PTF FILE; 12-12-85
 ;;4.0
 D DT^DICRW S DT=+Y,DRG1="",U="^" S:'$D(DTIME) DTIME=300
R1 R !,"Do you want a BATCH process: N// ",X:DTIME S:'$T X=U G:X["^" Q G:X["?" H1 G:X["Y"!(X["y") T
R2 R !,"Do you want to run the patients that have been checked but",!,?10,"not released: Y// ",X:DTIME S:'$T X=U G:X["^" Q G:X["?" H2 G:X'["N"&(X'["n") LL
 D S G:A=""!(X=U) Q D IO G:POP Q S RJFLAG1=1 W !,"Wait a second..." F RJPTFA=1:1 G:$P(A,",",RJPTFA)="" Q S PTF=$P(A,",",RJPTFA) I $D(^DGPT(PTF,0)) S DFN=$P(^(0),U,1) D PL K AGE,ORG
LL D IO G:POP Q W !,"Hold on, this will take a while..." S (PTF,RJFLAG)=0 F I=1:1 S PTF=$O(^DGP(45.84,PTF)) G:PTF=""!(PTF'?.N) Q I $P(^DGP(45.84,PTF,0),U,2)="",$D(^DGPT(PTF,0)) S DFN=$P(^(0),U,1) D PL K AGE,ORG
S S A="",DIC="^DGPT(" F I=1:1 W ! S DIC(0)="QEALM" D ^DIC Q:Y=-1  S DA=+Y W !,?18,"*** Patient Number = ",DA,?47,"***" S A=$S(A="":DA,1:A_","_DA)
 Q
T R !,"Run DRG beggining with PATIENT number: ",ZZ:DTIME Q:ZZ[U!(ZZ="")  I ZZ>$P(^DGPT(0),U,4)!(ZZ<1) W !,"There are ",$P(^DGPT(0),U,4)," PATIENTS to choose from. Enter PATIENT number!" G L
 R !,?11,"ending with PATIENT number: ",R:DTIME Q:R[U!(R="")  I R>$P(^DGPT(0),U,4)!(R<X) W !,"There are ",$P(^DGPT(0),U,4)," PATIENTS to choose from. Enter PATIENT number!" G L
 G:ZZ>R Q S RJFLAG=1 D IO G:POP Q W !,"Please hold for a second..." F PTF=ZZ:1:R I $D(^DGPT(PTF,0)) S DFN=$P(^(0),U,1) D PL K AGE,ORG
Q K %PTF,B,DA,DAM,DFN,DOB,DRG,TAC,TRS,DRG1,DRGCAL,DXLS,EXP,ICDCAL,L1,L2,MDC,NO,OR,PD,PTF,SD,SD1,SEX,NDR,NOR,NSD,RG D:$D(RJIO) ^RJPTFOU2 K RJFLAG,RJFLAG1,RJPTFUN Q
PL Q:'$D(^DGPT(PTF,"M",0))  S Z(1)=$P(^(0),U,4),SEX=$P(^DPT(DFN,0),U,2) D ^DGPTFD I $D(DRG) S ^DGPT(PTF,"RJ",0)=DRG S:'$D(^DGPT(PTF,"RJ","DXLS")) ^DGPT(PTF,"RJ","DXLS")=$P(^DGPT(PTF,70),"^",10) D R
 F Z(2)=1:1:Z(1) Q:'$D(^DGPT(PTF,"M",Z(2),0))  S ^DGPT(PTF,"RJ",Z(2))="" D I S ^DGPT(PTF,"RJ",Z(2))=$P(^DGPT(PTF,"RJ",Z(2)),U,2,11)
 Q
I F Z(3)=5:1:9,11:1:15 S B(70,1)=^DGPT(PTF,"M",Z(2),0) Q:$P(B(70,1),U,Z(3))=""  D EN1 S DRG="",ICDCAL="",%PTF=1,B(70)=$P(B(70),U,1,9)_U_$P(B(70,1),U,Z(3)) D CD^DGPTFD S ^DGPT(PTF,"RJ",Z(2))=^DGPT(PTF,"RJ",Z(2))_U_DRG
 Q
L R !,"Do you need a PATIENT number LIST (Y/N): N// ",X:DTIME S:'$T X=U Q:X=U  D:X="Y" ^RJPTFLIS G T
R Q:'$D(^DGP(45.84,PTF,0))  S:$P(^(0),U,2)="" ^(0)=^(0)_U_DT_U_DUZ S ^DGP(45.84,"AC",PTF,PTF)="" S:$P(^DGPT(PTF,0),"^",6)<2 $P(^DGPT(PTF,0),"^",6)=2 Q
EN1 S B(70)=$S($D(^DGPT(PTF,70)):^(70),1:""),DOB=$P(^DPT(DFN,0),"^",3),AGE=$S(+B(70):+B(70),1:DT)-DOB\10000,SEX=$P(^DPT(DFN,0),"^",2)
 S DAM=$S($P(B(70),U,3)=4:1,1:0),TAC=$P(B(70),U,13),TAC=$S($L(TAC):1,1:0),TRS=$S($P(B(70),U,3)=5:1,1:0),EXP=$S($P(B(70),U,3)>5:1,1:0)
 Q
H1 W !!,"A BATCH Process will allow you to run the DRG Calculator on a series of",!,"records.  You will be prompted to enter the starting and ending PTF number for",!,"the calculator.",!! G R1
H2 W !!,"This option will allow all the patients that have been coded and run through",!,"the checker to be run through the DRG Calculator.",!! G R2
IO S %ZIS("A")="DRG Funding Output Device: " D ^%ZIS K %ZIS I POP W !,"Try Later." Q
IO1 S:'$D(^DIZ(45.00046,1,0)) ^DIZ(45.00046,1,0)="" I $P(^DIZ(45.00046,1,0),"^",6)="" W !,"I need to have the FUNDING PER WWU entered before I can continue." D ^RJPTFVAR G IO1
 S RJPTFUN=$P(^DIZ(45.00046,1,0),"^",6),RJIO=IO Q
