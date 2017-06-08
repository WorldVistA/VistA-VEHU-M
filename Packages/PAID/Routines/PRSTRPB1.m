PRSTRPB1 ; HISC/REL/WAA - Un-TRANSMITTED Employees List  ;8/6/93  08:58
 ;;3.5;PAID;;Jan 26, 1995
L0 W ! K IOP,%ZIS S %ZIS("A")="Select DEVICE: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S ZTDESC="DISPLAY UNTRANSMITTED EMPLOYEES",ZTRTN="Q1^PRSTRPB1" D ^%ZTLOAD W !!,"Request Queued ..." G EX
 U IO D Q1 D ^%ZISC S IOP="" D ^%ZIS K %ZIS,IOP G EX
Q1 S YN="",PG=0 D HEAD S PP=$P(^PRST(455,0),"^",3) G:PP<1 EX
 S TL="" F LL=0:0 S TL=$O(^PRST(455,"ATL",TL)) Q:TL=""  D TLC^PRSTRPB I 'POP S NN="" F KK=0:0 S NN=$O(^PRST(455,"ATL",TL,NN)) Q:NN=""  F DFN=0:0 S DFN=$O(^PRST(455,"ATL",TL,NN,DFN)) Q:DFN<1  D CHK G:YN["^" EX
 G EX
CHK I '$D(^PRST(455,PP,1,DFN,0)) Q
 S X=$P(^PRST(455,PP,1,DFN,0),"^",2)
 I X="X" Q
 S NAM=$S($D(^PRSPC(DFN,0)):$P(^(0),"^",1),1:"")
 I $Y>(IOSL-4) R:IOST?1"C".E !!,"Press RETURN to Continue. ",YN:DTIME Q:YN["^"  D HEAD
 W !,NAM,?35,TL,?46,$S(X="":"No Timekeeper Data",X="H":"On Hold",X="T":"No Payroll Review",X="P":"Untransmitted Payroll reviewed",1:"") Q
HEAD W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !!,?28,"Un-Transmitted Employees"
 W !,"NAME",?35,"T&L",?50,"STATUS"
 W !,"--------------------------------------------------------------------------------" Q
EX K D,DISYS,I,Y,Y(0),Z,%ZIS,DFN,IOP,KK,LL,NAM,NN,POP,PG,PP,TL,X,YN,ZTRTN Q
