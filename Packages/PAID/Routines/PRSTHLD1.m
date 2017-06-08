PRSTHLD1 ; HISC/WAA - List all records on HOLD;8/6/93  08:56
 ;;3.5;PAID;;Jan 26, 1995
L0 W ! K IOP,%ZIS S %ZIS("A")="Select DEVICE Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S ZTDESC="DISPLAY RECORDS ON HOLD",ZTRTN="Q1^PRSTHLD1" D ^%ZTLOAD W !!,"Request Queued ..." G KIL
 U IO D Q1 D ^%ZISC S IOP="" D ^%ZIS K %ZIS,IOP
 Q
Q1 K ^TMP($J) S PP=$P(^PRST(455,0),"^",3),PG=0 G:PP<0 EX
 F DFN=0:0 S DFN=$O(^PRST(455,"AH",PP,DFN)) Q:DFN<1  S:$D(^PRSPC(DFN,0)) NAME=$P(^(0),"^",1),TNL=$P(^PRST(455,PP,1,DFN,0),"^",7) S:TNL'="" ^TMP($J,TNL,NAME)="Hold by Payroll"
 D PRINT G KIL
PRINT ;
 S (NAME,TNL,YN)="" D HEAD
P1 S TNL=$O(^TMP($J,TNL)) Q:TNL=""
P2 S NAME=$O(^TMP($J,TNL,NAME)) G:NAME="" P1 S STA=^(NAME)
 W !,NAME,?40,TNL,?50,STA
 I $Y>(IOSL-4) R:IOST?1"C".E !!,"Press RETURN to Continue. ",YN:DTIME Q:YN="^"  D HEAD
 G P2
 Q
HEAD ;
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 D NOW^%DTC S Y=%,PG=PG+1 X ^DD("DD") W !,Y,?30,"Hold Status Report"
 W !,"Name",?40,"T&L"
 W !,"--------------------------------------------------------------------------------"
EX Q
KIL K ^TMP($J),%,DFN,NAME,POP,PG,PP,TNL,Y,D,DISYS,I,POP,X,Y,Z,YN,ZTRTN Q
