A1CBCNT ; ;[ 12/09/92  11:04 AM ]
 ;;V1.0;;
BEG S IOP="HOME" D ^%ZIS
 S N=""
 W @IOF
 W !,"*******",?25,"Tasked Jobs Evaluation",?73,"*******"
 W !,?28,"Counting Utilty"
 W !,?22,"Jobs Started Between Two Times"
 W !!
 S %DT="AER",%DT("A")="Please Enter Beginning DATE/TIME: "
 D ^%DT G:Y=-1 QUIT S BVAL=Y,SVAL=Y
 S %DT="AER",%DT("A")="Please Enter    Ending DATE/TIME: "
 D ^%DT G:Y=-1 QUIT S EVAL=Y
 D EVAL
 W @IOF
 W !,?24," Total Number of Jobs Between " S Y=SVAL X ^DD("DD")
 W !,?24," ---------------------------- "
 W !!,?30,Y,!,?37,"and" S Y=EVAL X ^DD("DD") W !,?30,Y,!,?37,"is",!!,?35,$J(COUNT,4)
 Q
QUIT ;
 K N,BVAL
 W !!,?10,"     <A USER INPUT ERROR HAS BEEN DETECTED>"
 W !,?10,"Either a Beginning or Ending DATE/TIME was ommitted."
 W !!,?10,"       Do you wish to try again? YES// " R X:10         
 I X="" G BEG
 I $E(X,1,1)["Y" G BEG
 I $E(X,1,1)["y" G BEG
 I $E(X,1,1)["?" W @IOF G QUIT
 W !!,?10,"    <Thanks for using the Counting Utilty>"
 Q
EVAL ;
 S COUNT=0
 F I=0:0 S BVAL=$O(^%A1CB("START",BVAL)),N="" Q:BVAL>EVAL  Q:BVAL=""  F J=0:0 S N=$O(^%A1CB("START",BVAL,N)) Q:N=""  S COUNT=COUNT+1
 Q
