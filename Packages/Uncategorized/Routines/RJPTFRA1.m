RJPTFRA1 ;RJ WILM DE -OUTPUT STATUS OF PTF PATIENTS; 12-12-85
 ;;4.0
 S %DT="APE",%DT("A")="From Discharge Date: " D ^%DT G:Y=-1 X S Z1=Y,%DT("A")="To Discharge Date: " D ^%DT G:Y=-1 X S Z2=Y
 W !!,"This report can be Queued by typing a ""Q"" at the DEVICE: prompt."
 S %IS="QM",%IS("B")="" K IOP D ^%ZIS G:POP X I $D(IO("Q")) S PGM="QQ^RJPTFRA1" D ^RJPTFQ S ^%ZTSK(ZTSK,"Z1")=Z1,^%ZTSK(ZTSK,"Z2")=Z2 G X
 W !,"This may take a while..."
S K ^UTILITY($J,"RJPTF") S U="^" S I=0 F P=1:1 S I=$O(^DGPT(I)) Q:I'?.N  D 1
 D ^RJPTFRA2 K ^UTILITY($J,"RJPTF","D")
X K %IS,IO("Q"),%DT,Z1,Z2,X1,X2 Q
1 Q:'$D(^DGPT(I,70))  Q:$P(^DGPT(I,70),U,1)=""  S X1=Z1,(X2,D)=$P(^DGPT(I,70),U,1) D ^%DTC Q:X>0  S X1=Z2,X2=D D ^%DTC Q:X<0
 I '$D(^DGP(45.84,I,0)) S ^UTILITY($J,"RJPTF","D",I)="" Q
 I $P(^DGP(45.84,I,0),U,2)="" S ^UTILITY($J,"RJPTF","D",I)="" Q
 I '$D(^DGPT(I,"RJ",0)) S:$D(^DGP(45.84,I,0)) ^UTILITY($J,"RJPTF","D",I)="" Q
 I ^DGPT(I,"RJ",0)="" S:$D(^DGP(45.84,I,0)) ^UTILITY($J,"RJPTF","D",I)="" Q
 Q
QQ S Z1=^%ZTSK(ZTSK,"Z1"),Z2=^%ZTSK(ZTSK,"Z2") G S
