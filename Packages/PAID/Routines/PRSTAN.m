PRSTAN ; HISC/REL - List New Employees ;8/6/93  08:06
 ;;3.5;PAID;;Jan 26, 1995
 I '$D(^XUTL("PRST")) W !!,"No New Employees have been created." Q
 W !!,"List of New Employees ..."
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S ZTIO=ION,ZTDESC="New Employee List",ZTRTN="Q1^PRSTAN" K IO("Q") D ^%ZTLOAD K ZTSK W !!,"Request Queued" G KIL
 U IO D Q1 D ^%ZISC S IOP="" D ^%ZIS K %ZIS,IOP G KIL
Q1 S X="T",%DT="X" D ^%DT S DT=+Y,PG=0 D HDR
 S RR="" F SSN=0:0 S SSN=$O(^XUTL("PRST",SSN)) Q:SSN<1  D L1 Q:RR="^"
 W ! Q
L1 S Y0=^XUTL("PRST",SSN) D:$Y>(IOSL-8) HDR Q:RR="^"
 W !?8,$E(SSN,1,3),"-",$E(SSN,4,5),"-",$E(SSN,6,9),?23,$E(Y0,14,16),?60,$E(Y0,2,4),?67,$E(Y0,22,24) Q
HDR I PG'=0&(IOST?1"C".E) R !!,"Press <Return> to continue...",RR:DTIME S:'$T RR="^" Q:RR="^"
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1 W !!,$E(DT,4,5),"/",$E(DT,6,7),"/",$E(DT,2,3),?20,"N E W   E M P L O Y E E   L I S T",?72,"Page ",PG
 W !!?8,"SSN",?23,"Name",?58,"Station","  T&L",! Q
KIL K %DT,%ZIS,DFN,IOP,PG,POP,RR,SSN,X,Y,Y0,ZTDESC,ZTIO,ZTRTN,ZTSK Q
