A1CBTRND ; ;[ 05/03/93  12:20 PM ]
 ;;V1.0;;
 K A1CB
 S IOP="HOME" D ^%ZIS W @IOF
 W !!
 S %DT="AER",%DT("A")="Please Enter Beginning DATE/TIME: "
 D ^%DT G:Y=-1 QUIT S BVAL=Y,SVAL=Y
 S %DT="AER",%DT("A")="Please Enter    Ending DATE/TIME: "
 D ^%DT G:Y=-1 QUIT S EVAL=Y
 D ^%ZIS
 D MORE,EVAL S CNT=1
 U IO W @IOF,!,?25,"Trend of Jobs Per Hour",!
 U IO W !,?10,"Between " S Y=SVAL D DD^%DT U IO W Y," and " S Y=EVAL D DD^%DT U IO W Y
 U IO W !
 U IO W !,?20,"Time Of Day",?35,"Number of Jobs"
 U IO W ! F I=1:1:IOM W "="
 F I=+$E($P(SVAL,".",2),1,2):1:$E(+$P(EVAL,".",2),1,2) Q:I>24  U IO W !,?24,$J(I,2)_":00",?44,$J(A1CB(I),4)
 D ^%ZISC
 Q
EVAL ;
 S COUNT=0
 F I=0:0 S BVAL=$O(^%A1CB("START",BVAL)),N="" Q:BVAL>EVAL  Q:BVAL=""  F J=0:0 S N=$O(^%A1CB("START",BVAL,N)) Q:N=""  D TRND S COUNT=COUNT+1
 Q
MORE ;
 F I=0:1:24 S A1CB(I)=0    
 Q
TRND ;
 S X=$E($P(BVAL,".",2),1,2),A1CB(+X)=A1CB(+X)+1
 Q
QUIT ;
 K EVAL,BVAL,A1CB,COUNT
 Q
