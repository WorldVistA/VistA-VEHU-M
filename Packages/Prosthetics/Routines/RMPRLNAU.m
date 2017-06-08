RMPRLNAU ;PHX/RFM-AUTO ADAPTIVE LOAN ;10/19/1993
 ;;2.0;PROSTHETICS;;10/19/1993
 D GETPAT^RMPRUTIL G:'$D(RMPRDFN) EXIT^RMPRLN0 S DFN=RMPRDFN
EN1 I '$D(^RMPR(667,"AD",DFN)) W $C(7),!,"This patient does not have a vehicle of record. You cannot loan auto",!,"adaptive equipment without a vehicle of record." G EXIT^RMPRLN0
 D WAIT^DICD F RP=0:0 S RP=$O(^RMPR(667,"C",DFN,RP)) Q:RP'>0  F ZI=0:0 S ZI=$O(^RMPR(667.3,"AD",RP,ZI)) Q:ZI'>0  F ZA=0:0 S ZA=$O(^RMPR(667.3,"AD",RP,ZI,ZA)) Q:ZA'>0  I $P(^RMPR(667.3,ZA,0),U,8)'="X",'$P(^(0),U,12) D
 .I $D(^RMPR(660.2,"AC",ZA)) S ZDA=$O(^RMPR(660.2,"AC",ZA,0)) I $D(^RMPR(660.2,ZDA,0)),$P(^(0),U,19)="N" Q
 .S ^TMP($J,ZA)=$P(^RMPR(667.1,ZI,0),U)
TMP I '$D(^TMP($J)) W $C(7),!,"No items issued to this patient. In order to loan an item, it must first",!,"be issued to the patient." G EXIT^RMPRLN0
TMP1 W !!?15,"RECORDED AUTO-ADAPTIVE EQUIPMENT AVAILABLE FOR LOAN",!!,?15,"ITEM",?30,"DATE ISSUED",?43,"SERIAL NUMBER"
 W ! S RO=0 F I=1:1 S RO=$O(^TMP($J,RO)) Q:RO=""  I '$D(RMPREXF1) S RZ(I)=RO D WRI I $D(RMPRIEN)!($D(DUOUT))!($D(DTOUT)) Q
 G:'$D(RMPRIEN)!($D(DTOUT)) EXIT^RMPRLN0 G CATEG
WRI I $D(RMPRHELP) K RMPRHELP G WRI
 W !,I_".",?7,$E($P(^TMP($J,RO),U),1,20) S Y=$P(^RMPR(667.3,RO,0),U,1) X ^DD("DD") W ?30,Y,?43,$P(^RMPR(667.3,RO,0),U,6)
SEL I I#15=0!($O(^TMP($J,RO))="") D  Q:(X="^")!(X="")
 .W !! K DIR S DIR(0)="NO^1:"_I,DIR("A")="Please enter a number " D ^DIR  Q:($D(DIRUT))!($D(DTOUT))
 .I +X S (ZRMP,RMPRIEN)=RZ(X),RMPRSER=$P(^RMPR(667.3,RMPRIEN,0),U,6),RMPRITEM=$P(^(0),U,3)
 Q
CATEG K DIR S DIR(0)="S^1:INVALID LIFT;2:ALL OTHER;",DIR("A")="Select Loan Category or `^` to Exit" D ^DIR G:$D(DIRUT) EXIT^RMPRLN0 S RMPRTYPE=$S(X=1:2,X=2:7,1:7)
 S RMPRITNA=$P(^RMPR(667.1,$P(^RMPR(667.3,+RMPRIEN,0),U,3),0),U)
ASKA I RMPRITNA'[$E($P(X," ",2),1,5) S %=2 W $C(7),$C(7),!,"Are you sure ",X," is the correct loan category for a ",!,RMPRITNA D YN^DICN G:%=2 CATEG G:%=-1 EXIT^RMPRLN0 I %=0 W !,"Answer `YES` or `NO`" G ASKA
 S S667=^RMPR(667.3,ZRMP,0)
DAT S %DT="AEX",%DT("A")="DATE OF LOAN: " D ^%DT G:Y<1!($D(DTOUT)) EXIT^RMPRLN0 I Y<$P(S667,U) W !,$C(7),"Date of loan must be equal or greater than the date the Auto-Adaptive",!,"transaction was entered",! G DAT
 S RMPRDATE=Y
FOUP S %DT="AEX",%DT("A")="DATE OF FIRST FOLLOW-UP: " S Y=RMPRDATE X ^DD("DD") S %DT("B")="T+180" D ^%DT G:Y<1!($D(DTOUT)) EXIT^RMPRLN0 D:Y<RMPRDATE  G:Y<RMPRDATE FOUP S RMPRDAT1=Y
 .W !,$C(7),"Follow-up date must be greater than or equal to the date of loan",! Q
 S X1=RMPRDAT1,X2=180 D C^%DTC S RMPRDAT2=X,X1=RMPRDAT1,X2=540 D C^%DTC S RMPRDAT3=X
CONT K DIR S DIR(0)="660.1,3",DIR("A")="QTY",DIR("B")=1 D ^DIR I X>$P(^RMPR(667.3,RMPRIEN,0),U,7) W $C(7)," ??",!,"Quantity cannot exceed "_$P(^(0),U,7) G CONT
 G:$D(DIRUT) EXIT^RMPRLN0 S RMPRQTY1=X K DIR S (RMPRCOST,DIR("B"))=$P(^RMPR(667.3,RMPRIEN,0),U,4) I RMPRCOST'>0 G SER
COST S DIR(0)="660.1,4",DIR("A")="UNIT COST" D ^DIR G:$D(DTOUT)!($D(DUOUT)) EXIT^RMPRLN0 I X>$P(^RMPR(667.3,RMPRIEN,0),U,4) W $C(7)," ??",!,"Cost cannot exceed $"_$P(^(0),U,4) G COST
 S RMPRCOST=X G:X'?.N.1".".2N COST
SER K DIR S DIR(0)="660.1,5" I $P(^RMPR(667.3,RMPRIEN,0),U,6)]"" S DIR("B")=$P(^(0),U,6)
 D ^DIR G:$D(DTOUT)!($D(DUOUT)) EXIT^RMPRLN0
SERA I $L(X)<5 S %=2 W !,"Are you sure this serial number is correct" D YN^DICN G:%=-1 EXIT^RMPRLN0 G:%=2 SER I %=0 W !,"It appears the serial number is to short, enter `NO` to edit the serial number" G SERA
 S RMPRSER=X
DATE S Y=$P(S667,U) X ^DD("DD") S %DT("B")=Y,%DT="AEX",%DT("A")="DATE ITEM PURCHASED: " D ^%DT I X="" W !,$C(7),"Enter the date the item was purchased or `^` to exit" G DATE
 G:Y=-1!($D(DTOUT)) EXIT^RMPRLN0 I $P(S667,U)<Y W $C(7),$C(7),!!,"Purchase date must be eariler than the transaction date!",! G DATE
 G ^RMPRLN0B
