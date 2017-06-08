PRSTRPB ; HISC/REL/WAA - Un-Reviewed Employees List  ;8/6/93  08:57
 ;;3.5;PAID;;Jan 26, 1995
L0 W ! K IOP,%ZIS S %ZIS("A")="Select DEVICE: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP EX
 I $D(IO("Q")) S ZTDESC="DISPLAY UNREVIEWED EMPLOYEES",ZTRTN="Q1^PRSTRPB" D ^%ZTLOAD W !!,"Request Queued ..." G EX
 U IO D Q1 D ^%ZISC S IOP="" D ^%ZIS K %ZIS,IOP G EX
Q1 S YN="",PG=0 D HEAD S PP=$P(^PRST(455,0),"^",3) G:PP<1 EX
 S TL="" F LL=0:0 S TL=$O(^PRST(455,"ATL",TL)) Q:TL=""  D TLC I 'POP S NN="" F KK=0:0 S NN=$O(^PRST(455,"ATL",TL,NN)) Q:NN=""  F DFN=0:0 S DFN=$O(^PRST(455,"ATL",TL,NN,DFN)) Q:DFN<1  D CHK G:YN["^" EX
 G EX
TLC ; Check if T&L Old or Enhanced
 S POP="",NN=$O(^PRST(455.5,"B",TL,0))
 S:$P($G(^PRST(455.5,+NN,0)),"^",9) POP=1 Q
CHK I '$D(^PRST(455,PP,1,DFN,0)) Q
 S X=$P(^PRST(455,PP,1,DFN,0),"^",2)
 I "TH"'[X Q
 S NAM=$S($D(^PRSPC(DFN,0)):$P(^(0),"^",1),1:"")
 I $Y>(IOSL-4) R:IOST?1"C".E !!,"Press RETURN to Continue. ",YN:DTIME Q:YN["^"  D HEAD
 W !,NAM,?35,TL,?46,$S(X="":"No Timekeeper Data",X="H":"On Hold",1:"No Payroll Review") Q
HEAD W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !!,?25,"Un-Reviewed Employees"
 W !,"NAME",?35,"T&L",?50,"STATUS"
 W !,"--------------------------------------------------------------------------------" Q
EX K D,DISYS,I,Y,Z,%ZIS,DFN,IOP,KK,LL,NAM,NN,POP,PG,PP,TL,X,YN,ZTRTN Q
