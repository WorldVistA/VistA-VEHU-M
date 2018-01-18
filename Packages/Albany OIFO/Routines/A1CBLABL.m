A1CBLABL ; ;[ 04/29/93  11:23 AM ]
 ;;V1.0;;
BEG S IOP="HOME" D ^%ZIS
 S N="",LCNT=2
 W @IOF
 W !,"*******",?25,"Tasked Jobs Evaluation",?73,"*******"
 W !,?25,"Label Evaluation Utilty"
 W !,?22,"Jobs Started Between Two Times"
 W !!
 S %DT="AER",%DT("A")="Please Enter Beginning DATE/TIME: "
 D ^%DT G:Y=-1 QUIT S BVAL=Y,SVAL=Y
 S %DT="AER",%DT("A")="Please Enter    Ending DATE/TIME: "
 D ^%DT G:Y=-1 QUIT S EVAL=Y
 W !,"Please Enter TaskMan Label^Routine: " R A1CB:120 G:A1CB="" QUIT
 D ^%ZIS W @IOF 
 D EVAL
 Q
QUIT ;
 K N,BVAL
 W !!,?10,"     <A USER INPUT ERROR HAS BEEN DETECTED>"
 W !,?10,"Either a Beginning or Ending DATE/TIME was ommitted,"
 W !,?10,"     or the TaskMan Label^Routine was blank."
 W !!,?10,"       Do you wish to try again? YES// " R X:10         
 I X="" G BEG
 I $E(X,1,1)["Y" G BEG
 I $E(X,1,1)["y" G BEG
 I $E(X,1,1)["?" W @IOF G QUIT
 W !!,?10,"    <Thanks for using the TaskMan Label Utilty>"
 Q
EVAL ;
 S COUNT=0
 D HEAD^A1CBRPT
 D LINE^A1CBRPT
 F I=0:0 S BVAL=$O(^%A1CB("START",BVAL)),N="" Q:BVAL>EVAL  Q:BVAL=""  F J=0:0 S N=$O(^%A1CB("START",BVAL,N)) Q:N=""  D NODE^A1CBRPT K:A1CBK=1 ^%A1CB("START",BVAL) Q:A1CBK=1  I $P(NODE,"^",1,2)[A1CB D TIME^A1CBRPT S COUNT=COUNT+1
 Q
