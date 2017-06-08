PRSTSTA ; HISC/REL - T&L Employee Status ;8/6/93  08:24
 ;;3.5;PAID;;Jan 26, 1995
 S PP=$P(^PRST(455,0),"^",3) G:PP<1 KIL
 W !!,"Report of employee RECORD status within a T&L ..."
 D PICK^PRSTUTL G:TLIEN<1 KIL S TL=$P(^PRST(455.5,TLIEN,0),"^",1)
 W ! K IOP,%ZIS S %ZIS("A")="Select REPORT Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S ZTIO=ION,ZTDESC="New Employee List",ZTRTN="Q1^PRSTSTA",ZTSAVE("PP")="",ZTSAVE("TL")="" K IO("Q") D ^%ZTLOAD K ZTSK W !!,"Request Queued" G KIL
 U IO D Q1 D ^%ZISC S IOP="" D ^%ZIS K %ZIS,IOP G KIL
Q1 D NOW^%DTC S Y=% X ^DD("DD") S DTE=Y,PG=0 D HDR
 S (NX,RT)="" F K=0:0 S NX=$O(^PRST(455,"ATL",TL,NX)) Q:NX=""  F DFN=0:0 S DFN=$O(^PRST(455,"ATL",TL,NX,DFN)) Q:DFN<1  D A1 G:RT="^" Q2
Q2 W ! Q
A1 S X=$G(^PRST(455,PP,1,DFN,0)) Q:X=""  I $Y>(IOSL-8) D HDR Q:RT="^"
 S Y=$P(X,"^",5) W !,$E(Y,1,3)_"-"_$E(Y,4,5)_"-"_$E(Y,6,9)
 S Y=$P(X,"^",1) S Y=$S(Y="":Y,$D(^PRSPC(Y,0))#2:$P(^(0),"^",1),1:Y) W ?13,Y
 S Y=$P(X,"^",2) W:Y]"" ?42,$S(Y="":"NO TIMEKEEPER RELEASE",Y="T":"TIMEKEEPER RELEASED",Y="P":"REVIEWED BY PAYROLL",Y="X":"TRANSMITTED",Y="H":"RECORD ON HOLD",1:"") Q
HDR I PG'=0&(IOST?1"C".E) R !!,"Press <Return> to continue...",RT:DTIME S:'$T RT="^" Q:RT="^"
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1 W !!,"EMPLOYEE STATUS LIST FOR T&L "_TL,?48,DTE,?70,"PAGE ",PG
 W !,"SSN",?13,"NAME",?42,"STATUS FLAG"
 W !,"--------------------------------------------------------------------------------",! Q
KIL K DISYS,I,Y,Z,%,%ZIS,DTE,DFN,IOP,K,NX,OTL,PG,POP,PP,RT,TL,TLIEN,TLMETH,X,Y,ZTDESC,ZTSAVE,ZTIO,ZTRTN,ZTSK Q
