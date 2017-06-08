RJPTFXXX ;RJ WILM DE -CHECK PTF DATA DRIVER; 12-12-85
 ;;4.0
 D DT^DICRW S U="^",RJERL="",AA=0,A="",DIC="^DGPT(",RJER1="*** Patient has not been DISCHARGED Yet.  Cannot run Checker. ***" S:'$D(DTIME) DTIME=300
 F I=1:1 W ! S DIC(0)="QEALM" D ^DIC Q:Y=-1  S DA=+Y W !,?18,"***  PATIENT NUMBER = ",DA,?47,"***" D D I X'=1 S A=$S(A="":DA,1:A_","_DA),AA=AA+1 I AA>29!($L(A)>220) W *7 Q
 F RJPTFA=1:1 G:$P(A,",",RJPTFA)="" Q S (PTF,I,DA)=$P(A,",",RJPTFA) D I G:R=U X
 Q
I W !!,"Enter ""^"" to exit checker,",!,?6,"""-"" to skip next PATIENT number (" W PTF,"  ",$P(^DPT($P(^DGPT(PTF,0),"^",1),0),"^",1) R "),",!,?10,"or <RET> to continue: ",R:DTIME S:'$T R=U Q:R=U
R I R="-" S A=$S(RJPTFA=1:$P(A,",",2,30),1:$P(A,",",0,RJPTFA-1)_","_$P(A,",",RJPTFA+1,30)),RJPTFA=RJPTFA-1 Q
 W !!,PTF," PATIENT= ",$P(^DPT($P(^DGPT(PTF,0),U,1),0),U,1) D E
 Q
E W ?50,"Running Checker."
 D ^RJPTFER6 G:RJPFLAG E1 I RJPFLAG1 S R="-" D R Q
 W "." S RJPFLAG=0 D ^RJPTFER3 I RJPFLAG G E1
 W "." S RJPFLAG=0 D ^RJPTFER1 I DR'="" S DA=I,(DIC,DIE)="^DGPT(",DIC(0)="QEALM",RJPFLAG=1 D ^DIE S I=DA
 W "." D ^RJPTFER2 I DR'="" S DA=$P(^DGPT(I,0),"^",1),(DIC,DIE)="^DPT(",DIC(0)="QEALM",RJPFLAG=1 D ^DIE G E1
 I 'RJPFLAG W ?73,"Done." S:'$D(^DGP(45.84,I,0)) ^DGP(45.84,I,0)=I,^DGP(45.84,"B",I,I)="",D=^DGP(45.84,0),D=$P(D,"^",1,3)_"^"_($P(D,"^",4)+1),^DGP(45.84,0)=D S:$P(^DGPT(I,0),"^",6)'>1 $P(^DGPT(I,0),"^",6)=1 Q
E1 K DIC,DIE W !!,"Unable to process until all data is entered...",!,"Type <RET> to loop same PATIENT, or ""^"" to process a new PATIENT: " R X:DTIME
 S:'$T X=U I X=U S RJERL=RJERL_U_PTF,R="-" D R Q
 S RJPTFA=RJPTFA-1 Q
D I '$D(^DGPT(DA,70)) W !!,*7,?7,RJER1 S X=1 Q
 I $P(^(70),U,1)="" W !!,*7,?7,RJER1 S X=1 Q
 I $D(^(460)) I $P(^(460),"^",2)="Y" W !,*7,"PATIENT IS A CENSUS PATIENT.  YOU SHOULD NOT USE THIS OPTION TO PUNCH IT." S X=1 Q
 S X=$P(^(70),U,1),X=$E(X,4,5)_"-"_$E(X,6,7)_"-"_$E(X,2,3) W !,?18,"*** Discharged: ",X,?47,"***" Q
Q I RJPTFA>1,$D(RJSTORE) D ^RJPTFVA1
X K K,L,A,AA,D,DA,DIC,DIE,DR,I,PTF,R,RJPFLAG,RJPTFI,RJSTORE,RJER1,RJERL,RJPTFA,RJPFLAG1,X,Y Q
