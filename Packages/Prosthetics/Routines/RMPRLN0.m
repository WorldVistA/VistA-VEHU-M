RMPRLN0 ;PHX/RFM-CREATE LOAN CARD ;10/19/1993
 ;;2.0;PROSTHETICS;;10/19/1993
 D HOME^%ZIS,DIV4^RMPRSIT G:$D(X) EXIT S RMPRLN0=1
ASK S %=2 W !,"Is this an Auto Adaptive Loan" D YN^DICN G:%<0 EXIT I %=0 W !,"Answer `YES` or `NO`" G ASK
 I %=1 G ^RMPRLNAU
 K DIR S DIR(0)="P^665:AEQMZ",DIR("A")="Select PATIENT" D ^DIR G:$D(DIRUT) EXIT S DFN=+Y
 D WAIT^DICD S RP=0 F I=1:1 S RP=$O(^RMPR(660,"C",DFN,RP)) Q:RP=""  D
 .Q:'$D(^RMPR(660,RP,0))  Q:$P(^(0),U,6)=""!($P(^(0),U,4)="X")
 .S RP(1)="" I $D(^RMPR(660.1,"AC",RP)) S RP(1)=0 F  S RP(1)=$O(^RMPR(660.1,"AC",RP,RP(1))) Q:'RP(1)  I $P(^RMPR(660.1,RP(1),0),U,14)=2!($P(^(0),U,14)=4)!($P(^(0),U,14)=5)!($P(^(0),U,10)]""&($P(^(0),U,11)="")) K RP(1) Q
 .Q:'$D(RP(1))
 .I $D(^RMPR(660.2,"AP",RP)) S ZDA=$O(^RMPR(660.2,"AP",RP,0)) I $P(^RMPR(660.2,ZDA,0),U,19)["N",$P(^(0),U,2)=DFN S FLGG=1 Q
 .S ^TMP($J,RP)=$P(^PRC(441,$P(^RMPR(661,$P(^RMPR(660,RP,0),U,6),0),U),0),U,2)
 I '$D(^TMP($J)) W !,"Item must first be issued to the patient before it can be loaned!" W:$D(FLGG) !,"Patient does have at least one item on loan." G EXIT^RMPRLN0
 W @IOF W !!?10,"ITEM(S) AVAILABLE FOR LOAN FROM PATIENT 10-2319",!!?15,"ITEM",?30,"DATE ISSUED",?43,"SERIAL NUMBER"
 S RO=0 F I=1:1 S RO=$O(^TMP($J,RO)) Q:RO=""!($D(RMPRKILL))  S RZ(I)=RO D WRI I $D(RMPRIEN)!($D(DUOUT))!($D(DTOUT)) Q
 G:$D(RMPRKILL)!('$D(RMPRIEN))!($D(DTOUT)) EXIT G CATEG
WRI I $D(RMPRHELP) K RMPRHELP G WRI
 W !,I_".",?7,$P(^RMPR(660,RO,0),U,15),$E($P(^TMP($J,RO),U),1,20) S Y=$P(^RMPR(660,RO,0),U,3) X ^DD("DD") W ?30,Y W ?43,$P(^RMPR(660,RO,0),U,11)
SEL I I#15=0!($O(^TMP($J,RO))="") D  Q:(X="^")!(X="")
 .W !! K DIR S DIR(0)="NO^1:"_I,DIR("A")="Please enter a number" D ^DIR  Q:($D(DIRUT))!($D(DTOUT))
 .I +X S (ZRMP,RMPRIEN)=RZ(X),RMPRSER=$P(^RMPR(660,RMPRIEN,0),U,11),RMPRITEM=$P(^(0),U,6)
 Q
CATEG K DIR S DIR(0)="S^1:BED;2:DIALYSIS;3:INVALID LIFT;4:RESPIRATIORS;5:WHEELCHAIR;6:ALL OTHER;",DIR("A")="Select Loan Category or `^` to Exit" D ^DIR G:$D(DIRUT) EXIT
 S RMPRTYPE=$S(X=1:1,X=2:3,X=3:4,X=4:5,X=5:6,X=6:7,1:7)
 S RMPRITNA=$P(^PRC(441,$P(^RMPR(661,$P(^RMPR(660,RMPRIEN,0),U,6),0),U),0),U,2)
 S X=$S(X=1:"a BED",X=2:"a DIAYSIS ITEM",X=3:"a LIFT",X=4:"a RESPIRATIOR",X=5:"a WHEELCHAIR",X=6:"an ALL OTHER",1:"")
ASKA I RMPRITNA'[$E($P(X," ",2),1,5) S %=2 W $C(7),$C(7),!,"Are you sure ",X," is the correct loan category for a ",!,RMPRITNA D YN^DICN G:%=2 CATEG G:%=-1 EXIT I %=0 W !,"Answer `YES` or `NO`" G ASKA
 S S660=^RMPR(660,RMPRIEN,0)
DAT S %DT="AEX",%DT("A")="DATE OF LOAN: " D ^%DT G:Y<0!($D(DTOUT)) EXIT I Y<$P(S660,U,3) W !,$C(7),"Date of loan must be equal to or later than 10-2319 date!" G DAT
 S RMPRDATE=Y
FOUP S %DT="AEX",%DT("A")="DATE OF FIRST FOLLOW-UP: " S X1=RMPRDATE,X2=180 D C^%DTC S Y=X X ^DD("DD") S %DT("B")=Y D ^%DT G:Y<0!($D(DTOUT)) EXIT D:Y<RMPRDATE  G:Y<RMPRDATE FOUP S RMPRDAT1=Y
 .W !,$C(7),"Follow-up date must be greater than or equal to the date of loan" Q
 S X1=RMPRDAT1,X2=180 D C^%DTC S RMPRDAT2=X,X1=RMPRDAT1,X2=540 D C^%DTC S RMPRDAT3=X
CONT K DIR S DIR(0)="660.1,3",DIR("A")="QTY",DIR("B")=1 D ^DIR
 G:$D(DIRUT) EXIT I X>$P(^RMPR(660,RMPRIEN,0),U,7) W $C(7)," ??",!,"Loan Quantity cannot exceed "_$P(^(0),U,7) G CONT
 S PRCP("QTY")=-X,RMPRQTY1=X
COST S RMPRCOST=$P(^RMPR(660,RMPRIEN,0),U,16) I RMPRCOST K DIR S DIR(0)="660.1,4",DIR("A")="UNIT COST" S DIR("B")=RMPRCOST D ^DIR G:$D(DTOUT)!($D(DUOUT)) EXIT I X>RMPRCOST W $C(7),!,"Cost can not exceed $"_RMPRCOST G COST
 I RMPRCOST S RMPRCOST=X
SER K DIR S DIR(0)="660.1,5" I $P(^RMPR(660,RMPRIEN,0),U,11)]"" S DIR("B")=$P(^(0),U,11)
 D ^DIR
 G:$D(DTOUT)!($D(DUOUT)) EXIT I (X="")!(X="@") W $C(7),!,"Serial Number is Required" G SER
 I $E(X)?1" " W !,"Serial Number cannot begin with a space!" G SER
SERA I $L(X)<5 S %=2 W !,"Are you sure this serial number is correct" D YN^DICN G:%<0 EXIT G:%=2 SER I %=0 W !,"It appears the serial number is to short, enter `NO` to edit the serial number" G SERA
 I X["^" W !,"Serial Number cannot contain an `^`" G SER
 S RMPRSER1=X
DATE S Y=$P(S660,U,3) X ^DD("DD") S %DT("B")=Y,%DT="AEX",%DT("A")="DATE ITEM PURCHASED: " D ^%DT I X="" W !,$C(7),"Enter the date the item was purchased or `^` to exit" G DATE
 G:Y<0!($D(DTOUT)) EXIT I Y>$P(S660,U,3) W $C(7),"  ??",!,"Purchase date must be equal to or earlier than 10-2319 date!",! G DATE
 G ^RMPRLN0A
EXIT ;EXIT AND KILL VARIABLES
 I $D(RMPRLN0),'$D(IEN) W !!,"Loan Card was not created"
 N RMPR,RMPRSITE K ^TMP($J) D ^%ZISC,KILL^XUSCLEAN
 Q
