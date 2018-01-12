PRMQWA ;Chicago ISC/DDA- TEMPLATE CALLS ;4/29/90  10:12
 ;;1.2;Utilization Review;**2**;
EN1 ; ENTRY FROM PRMQW
 S PRMQOUT=0,PRMQDATE="^" D REDIS
 Q
REDIS ; REDISPLAY AND SELECT
 Q:PRMQOUT="^"  S PRMQOUT=0
 D DISPLAY,SELECT
 G:PRMQOUT=1 REDIS
 Q
DISPLAY ; DISPLAY MOST RECIENT ADMISSION DATA ON SCREEN
 W !!,"** PATIENT MOVEMENT DATA **        (""*"" identifies dates already in UR)",!!,"   ADMISSIONS                TRANSFERS                 DISCHARGES"
 W !,"   ==========                =========                 =========="
 S PRMQ("A")=0 W ! F PRMQA=0:0 S PRMQ("A")=$O(PRMQ("A",PRMQ("A"))) Q:PRMQ("A")'>0  S X=PRMQ("A",PRMQ("A")) W !,$P(X,"^"),?26,$P(X,"^",2),?54,$P(X,"^",3)
 Q
SELECT ; ALLOW SELECTION OF DATE
 W !!,"Enter a Date or Select 1" W:PRMQ("CNT")>1 "-"_PRMQ("CNT") W ": "
 R PRMQX:DTIME S:'$T PRMQX="^" G:(PRMQX="^")!(PRMQX="") EXIT^PRMQW G:PRMQX["?" SELHLP G SELDT
 Q
SELHLP ; PROVIDE HELP
 W !,"You may select one of the numbers provided, or type in a date.",!!,"Do you want to see a list of existing Utilization Review episode dates",!,"to choose from"
 S %=2 D YN^DICN S:(%=-1)!(%=2) PRMQOUT=1 G:%=1 SHEPI I %=0 W !!,"PLEASE ENTER (Y)ES OR (N)O.",*7 G SELHLP
 Q
SHEPI ;
 S D="C",DIC="^PRMQ(513.8,",DIC(0)="EZ",DIC("S")="I Y=PRMQD0" D DQ^DICQ K D,DIC
 S PRMQOUT=1
 Q
SELDT ;
 I ((PRMQX>0)&(PRMQX<(PRMQ("CNT")+1)))&($L(PRMQX)<($L(PRMQ("CNT"))+1)) S PRMQDATE=PRMQ("B",PRMQX) W "  ",$P(PRMQDATE,"^") Q
 S X=PRMQX,%DT="ET" D ^%DT I Y=-1 W "??",*7 G SELHLP
 K PRMQ("C405") S PRMQ("C405")=0,(PRMQ("I"),PRMQ("J"))=(Y-.000001),PRMQ("Y")=Y
 F PRMQI=0:0 S PRMQ("I")=$O(^DGPM("APTT1",PRMQDFN,PRMQ("I"))) Q:PRMQ("I")'>0!(PRMQ("I")>(PRMQ("Y")+1))  S PRMQE=0,PRMQE=$O(^(PRMQ("I"),PRMQE)),PRMQ("C405")=PRMQ("C405")+1,Y=PRMQ("I") D DD^%DT S PRMQ("C405",PRMQ("C405"))=Y_"^(ADMISSION)^"_PRMQE
 F PRMQJ=0:0 S PRMQ("J")=$O(^DGPM("APTT2",PRMQDFN,PRMQ("J"))) Q:PRMQ("J")'>0!(PRMQ("J")>(PRMQ("Y")+1))  S PRMQE=0,PRMQE=$O(^(PRMQ("J"),PRMQE)),PRMQ("C405")=PRMQ("C405")+1,Y=PRMQ("J") D DD^%DT S PRMQ("C405",PRMQ("C405"))=Y_"^(TRANSFER)^"_PRMQE
 I '$D(PRMQ("C405",1))#2 W !,"NOT A VALID MAS PATIENT MOVEMENT",*7 S PRMQOUT=1 Q
SELCF W !!,"CHOOSE FROM:" S PRMQ("I")=0 F PRMQI=0:0 S PRMQ("I")=$O(PRMQ("C405",PRMQ("I"))) Q:PRMQ("I")'>0  W !,"   ",PRMQ("I")," ",$P(PRMQ("C405",PRMQ("I")),"^"),"   ",$P(PRMQ("C405",PRMQ("I")),"^",2)
 W !!,"Select 1" W:PRMQ("C405")>1 "-"_PRMQ("C405") W ": "
 R PRMQX:DTIME S:'$T PRMQX="^" I PRMQX="^"!(PRMQX="") S PRMQOUT=1 Q
SELCFH I $E(PRMQX,1)="?" W !,"Please select a Patient Movement Date/Time. (""^"" TO EXIT)" G SELCF
 I PRMQX>0&(PRMQX<(PRMQ("C405")+1)) S PRMQDATE=$P(PRMQ("C405",PRMQX),"^")_"^^"_$E($P(PRMQ("C405",PRMQX),"^",2),2)_"^^^"_$P(PRMQ("C405",PRMQX),"^",3) W "   ",$P(PRMQDATE,"^") Q
 W *7 S PRMQX="?" G SELCFH
 Q
