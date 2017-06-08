PSRENEW ; XAK,MJK/ALBANY ; 01 NOV 84  2:36 PM
 ;4.02 ; 12/13/84
P2 K ^UTILITY($J),RX S PC=0,X1=DT,X2=-$P(%PSITE,"^",23) D C^%DTC S PSDTCUT=X F I=0:0 S I=$N(^PS(55,DFN,"P",I)) Q:I'>0  S J=+^(I,0),STAR="" D CHK
 K RX0,DRX,RX2,STAR
 Q:'$D(^UTILITY($J))!'$P(%PSITE,"^",4)  S DRUG="",W=0 W !! S PSLC=$S('$D(PSLC):1,1:PSLC+2) K PSESC D HD
 F I=0:0 S DRUG=$N(^UTILITY($J,DRUG)) Q:DRUG<0  S RXD=+^(DRUG),STAR=$P(^(DRUG),"^",2) F J=0:0 S J=$N(^UTILITY($J,DRUG,J)) Q:J<0  S RX0=^UTILITY($J,DRUG,J),ST=+$P(RX0,"^",15) D HD:PSLC<1 G ESC:$D(PSESC) D W
ESC K ^UTILITY($J),STAR,RXD1,PSLC,PSESC Q:LIM<99  G C
 ;
CHK Q:'$D(^PSRX(J,0))  Q:$P(^(0),"^",15)>LIM  S RX0=^(0),RX2=$S($D(^(2)):^(2),1:"")
 Q:'$D(^PSDRUG(+$P(RX0,"^",6),0))  I $D(^("I")),^("I")]"",DT>^("I") S PSTMP=$S($D(PSFROM):PSFROM="PSREF",1:0) I 'PSTMP!(PSTMP&('$P(%PSITE,"^",20))) Q
 S DRX0=^(0),DRX=$E($P(DRX0,"^",1),1,31) X ^PSF("STAT") S:ST0<11 RX(J)=""
 Q:LIM<ST0!(ST0=11&($P(RX2,"^",6)<PSDTCUT))
 I $P(DRX0,"^",3)["A" S STAR="*" Q:LIM<99
 I LIM=99 Q:'$D(^PS(53,+$P(RX0,"^",3),0))  S:'$P(^(0),"^",5) STAR="*"
 S II=J D LAST^PSRFL Q:ST0=12&(RFDATE<PSDTCUT)  I '$D(^UTILITY($J,DRX)) S ^(DRX)=RFDATE_"^"_STAR,^(DRX,J)=RX0 K RFL,RFDATE Q
 S OJ=$N(^(DRX,0)),ORX0=^(OJ) I ^UTILITY($J,DRX)'>RFDATE,$P(RX0,"^",15)>5 S ^(DRX)=RFDATE_"^"_STAR K ^(DRX,OJ) S ^(J)=RX0 K RFDATE,RFL,ORX0,OJ Q
 I ST0<$P(ORX0,"^",15) S ^UTILITY($J,DRX)=RFDATE_"^"_STAR K ^(DRX,OJ) S ^(J)=RX0
 K RFL,RFDATE,OJ,ORX0 Q
W Q:LIM<ST  S PC=PC+1,PSLC=$S(PSLC<21:PSLC+1,1:0)
 W $J(PC,2),$J($P(RX0,"^",1),10),?13,DRUG,?44,$E("AFRH S    DEC",ST+1),STAR S:STAR]"" W=1
 W ?47,$J($P(RX0,"^",7),6) S RXF=$P(RX0,"^",9)-$S($D(^PSRX(J,1,0)):$P(^(0),"^",4),1:0),RXD1=$P(RX0,"^",13)
 W ?55,$E(RXD1,4,5),"-",$E(RXD1,6,7),"-",$E(RXD1,2,3) W:RXD ?65,$E(RXD,4,5),"-",$E(RXD,6,7),"-",$E(RXD,2,3) W ?75,"(",RXF,")",!
 Q:STAR]""  S (PY(PC),PY($P(RX0,"^",1)))=J_"^"_RXD Q
HD I 'PSLC R ?5,"Enter '^' to stop: ",PSESC W @($S($E(IOST,1)="C":"$C(13)",1:"!")) Q:PSESC="^"  K PSESC Q
 W " #       RX# DRUG",?42,"STAT    QTY",?56,"ISSUED ",?65,"LAST FILL REM",! Q
C W:W !?5,"* indicates prescription is not renewable."
CR R !,"RENEW RX: ",X Q:"^"[X  G CR:X'?.ANP S PSPOP="Renew" D PY^PSUTL G CR:PSPOP
 K PSDUP,PSPR,PSPOP S PR=X,DIC="^PSRX(" G CC:$P(%PSITE,"^",7)
CD R !,"FILL DATE: TODAY// ",X Q:X="^"  S:X="" X="T" S %DT="EX" D ^%DT G CD:Y<0 S RXD=Y
CC S:$D(PSCLC) CC=PSCLC I '$D(PSCLC) R !,"CLERK CODE: ",CC Q:CC="^"  I $L(CC)<2!($L(CC)>5) W !?10,*7,"ANSWER MUST BE 2 TO 5 CHARACTERS" G CC
 G ^PSRENEW0
