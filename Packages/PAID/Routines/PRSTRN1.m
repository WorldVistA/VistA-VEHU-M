PRSTRN1 ; HISC/REL/WAA - List Transmission Cases ;8/6/93  08:13
 ;;3.5;PAID;;Jan 26, 1995
 W !!,"8B Records to be Transmitted ..."
 S PP=$P(^PRST(455,0),"^",3) G:PP<1 KIL
 I $P(^PRST(455,PP,0),"^",3)'="X" W !!,"Pay Period ",+$E(PP,4,5)," has NOT been transmitted yet." G KIL
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S ZTIO=ION,ZTDESC="8B Re-Transmission List",ZTRTN="Q1^PRSTRN1",ZTSAVE("PP")="" K IO("Q") D ^%ZTLOAD K ZTSK W !!,"Request Queued" G KIL
 U IO D Q1 D ^%ZISC S IOP="" D ^%ZIS K %ZIS,IOP G KIL
Q1 S X="T",%DT="X" D ^%DT S DT=+Y,PG=0 D HDR
 S RR="" F DFN=0:0 S DFN=$O(^PRST(455,"AR",PP,DFN)) Q:DFN<1  D L1 Q:RR="^"
 W ! Q
L1 S Y0=^PRST(455,PP,1,DFN,0),SSN=$P(Y0,"^",5) D:$Y>(IOSL-4) HDR Q:RR="^"
 S NAM=$P($G(^PRSPC(DFN,0)),"^",1)
 W !?8,$E(SSN,1,3),"-",$E(SSN,4,5),"-",$E(SSN,6,9),?23,NAM,?60,$P(Y0,"^",4),?67,$P(Y0,"^",7) Q
HDR I PG'=0&(IOST?1"C".E) R !!,"Press <Return> to continue...",RR:DTIME S:'$T RR="^" Q:RR="^"
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1 W !!,$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3),?17,"8 B     T R A N S M I S S I O N     L I S T",?72,"Page ",PG
 W !!?30,"Pay Period ",+$E(PP,4,5),", ",1700+$E(PP,1,3)
 W !!?8,"SSN",?23,"Name",?58,"Station","  T&L",! Q
KIL K %DT,%ZIS,DFN,IOP,NAM,PG,PP,POP,RR,SSN,X,Y,Y0,ZTDESC,ZTSAVE,ZTIO,ZTRTN,ZTSK Q
