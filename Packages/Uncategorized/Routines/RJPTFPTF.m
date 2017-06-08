RJPTFPTF ;RJ WILM DE -EDIT PTF FILE; 12-12-85
 ;;4.0
 D DT^DICRW S (DIE,DIC)="^DGPT(",U="^" D X K D0,DA,DQ,DR,DIC,DIE,J,Y,Z0,K,PTF,AD,DFN,DGX,I Q
X F J=1:1 D E W ! I $D(Y) Q:Y=-1
 Q
E S (DIC,DIE)="^DGPT(",DIC(0)="QEALMZ" D ^DIC Q:Y=-1  S DA=+Y,K=$P(^DGPT(DA,0),U,2),K=$E(K,4,5)_"-"_$E(K,6,7)_"-"_$E(K,2,3) W !,?18,"***  PATIENT NUMBER = ",DA,?49,"***",!,?18,"***  ADMISSION DATE = ",K,?49,"***" D D D:X'=1 ^DIE,WHO Q
D S X="*** Patient has not been DISCHARGED Yet. No editing. ***" I '$D(^DGPT(DA,70)) W !!,*7,?7,X S X=1 Q
 I $P(^DGPT(DA,70),U,1)="" W !!,*7,?7,X S X=1 Q
 S X=$P(^DGPT(DA,70),U,1) S X=$E(X,4,5)_"-"_$E(X,6,7)_"-"_$E(X,2,3) W !,?18,"*** Patient Discharged: ",X," ***"
 D STATUS I $P(^DGPT(DA,0),"^",10)="" S PTF=DA,DFN=^DGPT(DA,0),AD=$P(DFN,"^",2),DFN=$P(DFN,"^",1) D ^RJPTF3
 S DR=".01:5;10;20;21.1;21.2;22;23;40:45.05;50;70:75;76.1;76.2;77;78;79;79.16:79.19;79.201:79.24;460003;460004" Q
WHO Q:+DUZ=0  S:'$D(^DGPT(DA,1,0)) ^(0)="^45.03PA^^" S K=+$P(^(0),"^",3)+1,^DGPT(DA,1,K,0)=DUZ,^DGPT(DA,1,0)="^45.03PA^"_K_"^"_($P(^DGPT(DA,1,0),"^",4)+1) Q
STATUS W !,"Wilmington PTF Package Status: " I '$D(^DGP(45.84,DA,0)) S PTF=$S('$D(^DGPT(DA,70)):0,$P(^(70),"^",1)="":0,1:1) W:PTF "DISCHARGED.  ...waiting to be CHECKED." Q
 S PTF=^(0) I $P(PTF,"^",2)="" W "CHECKED.  ...waiting to be CLOSED." Q
 I $P(PTF,"^",4)="" W "CLOSED.  ...waiting to be RELEASED." Q
 W "RELEASED." Q
 Q
