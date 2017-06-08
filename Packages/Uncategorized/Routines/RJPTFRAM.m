RJPTFRAM ;RJ WILM DE -RAM REPORT; 12-12-85
 ;;4.0
 S %DT="APE",%DT("A")="From Discharge Date: " D ^%DT G:Y=-1 X S Z1=Y,%DT("A")="To Discharge Date: " D ^%DT G:Y=-1 X S Z2=Y
 K ^UTILITY($J,"RJPTF") W !,"This may take a while..." S U="^" S I=0 F P=1:1 S I=$O(^DGPT(I)) Q:I'?.N  D:$D(^DGPT(I,70)) 1
 D ^RJPTFRAO
X K %DT,Z1,Z2,X1,X2 Q
1 Q:$P(^DGPT(I,70),U,1)=""  S X1=Z1,(X2,D)=$P(^DGPT(I,70),U,1) D ^%DTC Q:X>0  S X1=Z2,X2=D D ^%DTC Q:X<0
 I '$D(^DGPT(I,"RJ",0)) S:$D(^DGP(45.84,I,0)) ^UTILITY($J,"RJPTF","D",I)="" Q
 I ^DGPT(I,"RJ",0)="" S:$D(^DGP(45.84,I,0)) ^UTILITY($J,"RJPTF","D",I)="" Q
 I '$D(^DGP(45.84,I,0)) S ^UTILITY($J,"RJPTF","D",I)="" Q
 I $P(^DGP(45.84,I,0),U,2)="" S ^UTILITY($J,"RJPTF","D",I)="" Q
 S B=$P(^DGPT(I,70),U,2),D=^DGPT(I,"RJ",0) S:'$D(^UTILITY($J,"RJPTF",B,D)) ^UTILITY($J,"RJPTF",B,D)=0 S ^UTILITY($J,"RJPTF",B,D)=^UTILITY($J,"RJPTF",B,D)+1 W "." Q
