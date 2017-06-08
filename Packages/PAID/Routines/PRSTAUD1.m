PRSTAUD1 ; HISC/REL/WAA - Display Audit Record ;8/15/91  15:24
 ;;3.5;PAID;;Jan 26, 1995
 D CODES^PRSTUTL
A1 R !!,"Enter YEAR: ",YR:DTIME S:'$T YR="^" G:"^"[YR KIL I YR'?2N,YR'?4N W *7,!,"Enter year that data is in (ex. 1988 or 88)" G A1
A2 R !!,"Enter Pay Period: ",PP:DTIME S:'$T PP="^" G:"^"[PP KIL I PP'?1.2N W !,*7,"  Enter a Pay Period Number 1 through 27" G A2
 I PP<1!(PP>27) W !,*7," Enter a Pay Period Number 1 through 27" G A2
 S PP=$S(YR<100:200+YR,1:YR-1700)_$S(PP<10:"0"_PP,1:PP)
A3 I '$D(^PRST(455,PP,1,0)) W !,*7,"No data available for this pay period!" G KIL
A4 R !!,"Select T&L UNIT CODE (or ALL): ",X:DTIME G:"^"[X!('$T) KIL I X="ALL" S TLIEN=0
 E  K DIC S DIC="^PRST(455.5,",DIC(0)="QEM" D ^DIC G:Y<1 A4 S TLIEN=+Y
L0 ;DEVICE HAND
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S ZTDESC="DISPLAY AUDIT RECORD",ZTRTN="Q1^PRSTAUD1" F K="TLIEN","PP","N1","N2","T0","T1" S ZTSAVE(K)=""
 I  D ^%ZTLOAD W !!,"Request Queued ..." G KIL
 U IO D Q1 D ^%ZISC S IOP="" D ^%ZIS K %ZIS,IOP G KIL
 Q
Q1 ;
TNL S OUT=0 I TLIEN'=0 S TL=$P(^PRST(455.5,TLIEN,0),"^") G EMP,KIL
 S TL=""
TLOOP S TL=$O(^PRST(455,"ATL",TL)) Q:TL=""
 S TLIEN="",TLIEN=$O(^PRST(455.5,"B",TL,TLIEN))
 D EMP Q:OUT=1  G TLOOP
 Q
EMP S NN=""
EMP1 S NN=$O(^PRST(455,"ATL",TL,NN)) Q:NN=""
 S DFN=""
EMP2 S DFN=$O(^PRST(455,"ATL",TL,NN,DFN)) G:DFN<1 EMP1
 I '$D(^PRST(455,PP,1,DFN,0)) G EMP2
 S CDIS=3,PRSTLV=8 D DISP^PRSTDIS,LINE
 Q:OUT=1  G EMP2
 Q
LINE I IOST?1"C".E R !!,"Press RETURN to Continue. ",YN:DTIME I YN="^"!('$T) S OUT=1
 Q
KIL K TL,TLIEN,PP,DIC,NN,X,C2,D,DFN,N1,N2,OUT,POP,T0,T1,Y,TN,Z,Y,YR Q
