A1CBD ; ;[ 04/29/93  11:22 AM ]
 ;;V1.0;;
BEG S IOP="HOME" D ^%ZIS
 S N="",GTTIME=0,LCNT=0
 W @IOF
 W !,"*******",?25,"Tasked Jobs Evaluation",?73,"*******"
 W !!
 S %DT="AER",%DT("A")="Please Enter Beginning DATE/TIME: "
 D ^%DT G:Y=-1 QUIT S BVAL=Y,SVAL=Y
 S %DT="AER",%DT("A")="Please Enter    Ending DATE/TIME: "
 D ^%DT G:Y=-1 QUIT S EVAL=Y
 D ^%ZIS
 D HEAD
 D LINE^A1CBRPT
 D EVAL
 S LCNT=LCNT+2 U IO W !!,?2,"Total Elapsed Taskman Time is",$J(GTTIME\86400,3)," days,",$J(GTTIME\3600,3)," hours,",$J(GTTIME\60,3)," minutes, and",$J(GTTIME#60,3)," seconds."
 S LCNT=LCNT+1 U IO W !,?2,"Total Number of Tasks was: ",COUNT
 D ^%ZISC
 Q
HEAD ;
 S LCNT=LCNT+1 U IO W @IOF W !,?30,"TaskMan Tasks Between"
 S Y=BVAL D DD^%DT S LCNT=LCNT+1 W !,?2,Y,?39,"and" S Y=EVAL D DD^%DT W ?60,Y,!!
 S LCNT=LCNT+3 U IO W !,"Label^Routine",?17,"DD",?20,"HH",?23,"MM",?26,"SS",?36,"Task",?46,"Task Description",?69,"Username"
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
 W !!,?10,"    <Thanks for using the Utility>"
 Q
EVAL ;
 S COUNT=0
 F I=0:0 S BVAL=$O(^%A1CB("START",BVAL)),N="" Q:BVAL>EVAL  Q:BVAL=""  F J=0:0 S N=$O(^%A1CB("START",BVAL,N)) Q:N=""  D NODE^A1CBRPT K:A1CBK=1 ^%A1CB("START",BVAL) Q:A1CBK=1  D NODES S COUNT=COUNT+1
 Q
NODES ;
 S BTIME=$P(NODE,"^",3),ETIME=$P(NODE,"^",4)
 S %H=BTIME D YMD^%DTC S BDATE=X,BTIME=$P(%,".",2),BL=$L(BTIME)
 I $L(BL)<6 F I=1:1:6-BL S BTIME=BTIME_"0"
 S BHRS=$E(BTIME,1,2),BMINS=$E(BTIME,3,4),BSECS=$E(BTIME,5,6)
 D BTIME
 S %H=ETIME D YMD^%DTC S EDATE=X,ETIME=$P(%,".",2),EL=$L(ETIME)
 I $L(EL)<6 F I=1:1:6-EL S ETIME=ETIME_"0"
 S EHRS=$E(ETIME,1,2),EMINS=$E(ETIME,3,4),ESECS=$E(ETIME,5,6)
 D ETIME
 D DATES
 S TESECS=TESECS+TIME
 S TTIME=TESECS-TBSECS
 S GTTIME=GTTIME+TTIME
 S LCNT=LCNT+1
 S USR=$P(NODE,"^",8)
 U IO W !,$P(NODE,"^",1,2)
 U IO W ?17,$J(TTIME\86400,2),":",$J(TTIME\3600,2),":",$J(TTIME\60,2),":",$J(TTIME#60,2),$J(N,12),?42,$E($P(NODE,"^",7),1,24)
 U IO W ?68,$S($D(^VA(200,+$P(NODE,"^",8),0)):$E($P(^(0),"^",1),1,12),1:"<UNDEF USER>")
 Q
BTIME ;
 S TBSECS=(BHRS*3600)+(BMINS*60)+BSECS
 Q
ETIME ;
 S TESECS=(EHRS*3600)+(EMINS*60)+ESECS
 Q
DATES ;
 S X1=EDATE,X2=BDATE D ^%DTC
 S TIME=$S(X=0:0,X=1:86400,X=2:176800,1:0)
 Q
