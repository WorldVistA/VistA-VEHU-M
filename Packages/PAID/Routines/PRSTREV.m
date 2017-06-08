PRSTREV ; HISC/REL - 8B Review ;7/19/91  13:41
 ;;3.5;PAID;;Jan 26, 1995
 D CODES^PRSTUTL
A1 R !!,"Enter YEAR: ",YR:DTIME S:'$T YR="^" G:"^"[YR KIL I YR'?2N,YR'?4N W *7,!,"Enter year that data is in (ex. 1988 or 88)" G A1
A2 R !!,"Enter Pay Period: ",PP:DTIME S:'$T PP="^" G:"^"[PP KIL I PP'?1.2N W !,*7,"  Enter a Pay Period Number 1 through 27" G A2
 I PP<1!(PP>27) W !,*7," Enter a Pay Period Number 1 through 27" G A2
 S PP=$S(YR<100:200+YR,1:YR-1700)_$S(PP<10:"0"_PP,1:PP)
A3 I '$D(^PRST(455,PP,1,0)) W !,*7,"No data available for this pay period!" G KIL
 I PRSTLV'>3 D PICK^PRSTUTL G:TLIEN<1 KIL S TL=$P(^PRST(455.5,TLIEN,0),"^",1)
A4 K DIC S DIC="^PRSPC(",DIC(0)="AEQM",DIC("A")="Select EMPLOYEE: " S:PRSTLV'>3 DIC("S")="I $P(^(0),""^"",8)=TL" W ! D ^DIC K DIC G KIL:"^"[X,A4:Y<1 S DFN=+Y
 I '$D(^PRST(455,PP,1,DFN,0)) W *7,!!,"No 8B record exists for this Pay Period." G A4
 S CDIS=3 D ^PRSTDIS G A4
KIL K %,%H,%Y,DISYS,SN,Y,Z,CDIS,DIC,DFN,N1,N2,PP,OTL,T0,T1,TL,TLIEN,TLMETH,X,Y,YR Q
