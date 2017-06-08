RJPTFSC ;RJ WILM DE -STATE&COUNTY STATISTICS; 1-8-86
 ;;4.0
 K ^UTILITY("S&C",$J) S:'$D(DTIME) DTIME=300 S %DT="APE",%DT("A")="Start with Discharge Date: " D ^%DT G:Y=-1 Q S Z1=Y,%DT("A")="End with Discharge Date: " D ^%DT G:Y=-1 Q S Z2=Y
 K IOP D ^%ZIS G:POP Q W !,"This will take a while." S I=0 F RJCT=1:1 S I=$O(^DGPT(I)) Q:I'?.N  D LU
 D H,O
Q X ^%ZIS("C") K IOP,%DT,^UTILITY("S&C",$J),COUNTY,STATE,C,D,J,K,RJCT,Z1,Z2 Q
LU Q:'$D(^DGPT(I,70))  Q:$P(^(70),"^",1)=""  S X1=Z1,(X2,D)=$P(^(70),"^",1) D ^%DTC Q:X>0  S X2=D,X1=Z2 D ^%DTC Q:X<0
 S K=$P(^DGPT(I,0),"^",1)
 I '$D(^DPT(K,.11)) S:'$D(^UTILITY("S&C",$J,"SUNK")) ^("SUNK")=0 S ^("SUNK")=^("SUNK")+1 S:'$D(^UTILITY("S&C",$J,"CUNK")) ^("CUNK")=0 S ^("CUNK")=^("CUNK")+1 Q
 S X=^DPT(K,.11) S D=$P(X,"^",5) I D="" S:'$D(^UTILITY("S&C",$J,"SUNK")) ^("SUNK")=0 S ^("SUNK")=^("SUNK")+1 Q
 S:'$D(^UTILITY("S&C",$J,D)) ^(D)=0 S ^(D)=^(D)+1
 S C=$P(X,"^",7) I C="" S:'$D(^UTILITY("S&C",$J,"CUNK")) ^("CUNK")=0 S ^("CUNK")=^("CUNK")+1 Q
 S:'$D(^UTILITY("S&C",$J,D,C)) ^(C)=0 S ^(C)=^(C)+1
 Q
H U IO W @IOF W !,"COUNT OF STATE AND COUNTY PATIENTS" K %DT S X="T" D ^%DT W "  ",$E(Y,4,5),"-",$E(Y,6,7),"-",$E(Y,2,3)
 W !!,"STATE",?20,"COUNTY",?40,"COUNT",! F I=1:1:60 W "-"
 Q
O S D=0 F I=1:1 S D=$N(^UTILITY("S&C",$J,D)) Q:D=-1  D O1
 Q
O1 S STATE=$S('$D(^DIC(5,D,0)):"UNKNOWN",1:$P(^DIC(5,D,0),"^",1)) W !,STATE S C=0 F J=1:1 S C=$N(^UTILITY("S&C",$J,D,C)) Q:C=-1  D O2
 W ! F I=1:1:60 W "-"
 W !,?30,"TOTAL->   ",^UTILITY("S&C",$J,D),!!
 Q
O2 S COUNTY=$P(^DIC(5,D,1,C,0),"^",1)
 W ?20,COUNTY,?40,^UTILITY("S&C",$J,D,C),!
 Q
