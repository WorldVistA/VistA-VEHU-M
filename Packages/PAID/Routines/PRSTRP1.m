PRSTRP1 ; HISC/WAA -Print out status report;8/6/93  08:19
 ;;3.5;PAID;;Jan 26, 1995
L0 ;DEVICE HAND
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S ZTDESC="PRINT STATUS REPORT",ZTRTN="Q1^PRSTRP1"
 I  D ^%ZTLOAD W !!,"Request Queued ..." G KIL
 U IO D Q1 D ^%ZISC S IOP="" D ^%ZIS K %ZIS,IOP G KIL
 Q
Q1 ;
 S PG=0 D HDR S TL="",OUT=0
Q2 S TL=$O(^PRST(455,"ATL",TL))
 I TL="" W !,"'*'= UNPROCESSED T&L" Q
 S TLIEN=""
 S TLIEN=$O(^PRST(455.5,"B",TL,TLIEN)) G:TLIEN="" Q2
 S STAT=$P(^PRST(455.5,TLIEN,0),"^",3),NAME=$P(^(0),"^",2)
 S STAT=$S(STAT="P":"PAYROLL REVIEWED",STAT="X":"SENT TO AUSTIN",STAT="T":"TIMEKEEPER CLOSED",STAT="":"*",1:"")
 D LINE Q:OUT=1  G Q2
 Q
LINE I $Y'>(IOSL-3) W !,TL,?6,NAME,?28,STAT Q
 W !,"'*'= UNPROCESSED T&L"
 I IOST?1"C".E R !,"Press RETURN to Continue. ",YN:DTIME I YN="^"!('$T) S OUT=1 K YN
 I OUT=1
 D HDR
 Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF W !,"T&L UNITS STATUS REPORT"
 D NOW^%DTC S Y=% X ^DD("DD") S DATE=$P(Y,"@"),TIME=$P($P(Y,"@",2),":",1,2)
 S PG=PG+1 W ?45,DATE," ",TIME,?70,"PG ",PG
 W !,"CODE  NAME",?28,"CURRENT PAY PERIOD STATUS"
 W !,"--------------------------------------------------------------------------------"
 Q
KIL K TL,TLIEN,NAME,STAT,OUT,PG,TIME,%,Y Q
