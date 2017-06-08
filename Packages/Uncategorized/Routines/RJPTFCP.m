RJPTFCP ;RJ WILM DE -CHECK PTF DATA DRIVER FOR CENSUS PATIENTS; 12-12-85
 ;;4.0
 D DT^DICRW S U="^",RJERL="",AA=0,A="",DIC="^DGPT(",RJER1="Patient not discharged.Col 28-50 left blank, Patient record STATUS not updated." S:'$D(DTIME) DTIME=300
 F I=1:1 W ! S DIC(0)="QEALM" D ^DIC Q:Y=-1  D CC I Y'=-1 S DA=+Y W !,?18,"***  PATIENT NUMBER = ",DA,?47,"***" S A=$S(A="":DA,1:A_","_DA),AA=AA+1 I AA>29!($L(A)>220) W *7 Q
 F RJPTFA=1:1 G:$P(A,",",RJPTFA)="" Q S (PTF,I,DA)=$P(A,",",RJPTFA) D I G:R=U X
 Q
I W !!,"Enter ""^"" to exit checker,",!,?6,"""-"" to skip next PATIENT number (" W PTF,"  ",$P(^DPT($P(^DGPT(PTF,0),"^",1),0),"^",1) R "),",!,?10,"or <RET> to continue: ",R:DTIME S:'$T R=U Q:R=U
R I R="-" S A=$S(RJPTFA=1:$P(A,",",2,30),1:$P(A,",",0,RJPTFA-1)_","_$P(A,",",RJPTFA+1,30)),RJPTFA=RJPTFA-1 Q
 W !!,PTF," PATIENT= ",$P(^DPT($P(^DGPT(PTF,0),U,1),0),U,1) D E
 Q
E W ?50,"Running Checker." D ^RJPTFER6 G:RJPFLAG E1 I RJPFLAG1 S R="-" D R Q
 W "." S RJPFLAG=0 D ^RJPTFER1 S RJDR="" F J=1:1 S V=$P(DR,";",J) Q:V=""  I V'=70,V'=71,V'=72,V'=73,V'=74,V'=75,V'=76,V'=77 S RJDR=RJDR_V_";"
 S DR=RJDR I DR'="" S DA=I,(DIC,DIE)="^DGPT(",DIC(0)="QEALM",RJPFLAG=1 D ^DIE S I=DA
 W "." D ^RJPTFER2 I DR'="" S DA=$P(^DGPT(I,0),"^",1),(DIC,DIE)="^DPT(",DIC(0)="QEALM",RJPFLAG=1 D ^DIE G E1
 I 'RJPFLAG W ?73,"Done." Q
E1 K DIC,DIE W !!,"Unable to process until all data is entered...",!,"Type <RET> to loop same PATIENT, or ""^"" to process a new PATIENT: " R X:DTIME
 S:'$T X=U I X=U S RJERL=RJERL_U_PTF,R="-" D R Q
 S RJPTFA=RJPTFA-1 Q
CC S Y=$S('$D(^DGPT(+Y,460)):-1,$P(^DGPT(+Y,460),U,2)'="Y":-1,1:Y) I Y=-1 W !,*7,"PATIENT IS NOT A CENSUS PATIENT.  YOU MUST MARK IT BEFORE PROCEEDING." Q
 I '$D(^DGPT(+Y,70)) W !,RJER1 Q
 I '$P(^(70),"^",1) W !,RJER1 Q
 S X=$P(^(70),U,1),X=$E(X,4,5)_"-"_$E(X,6,7)_"-"_$E(X,2,3) W !,?18,"*** Discharged: ",X,?47,"***" Q
Q I RJPTFA>1,$D(RJSTORE) D ^RJPTFCPP
X K A,AA,DA,DIC,DIE,DR,I,J,PTF,R,RJERL,RJPFLAG,RJPFLAG1,RJSTORE,RJDR,RJER1,V,X,Y Q
