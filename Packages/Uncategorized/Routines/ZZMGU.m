ZZMGU ; B'ham ISC/CML3 - MOVE GLOBAL UTILITY ;1/22/92  15:03 [ 01/22/92  1:26 PM ]
 ;;1T4
 ;
INIT ;
 S HERE=$ZU(0),U="^"
 ;
AR ;
 F  W !!,"Would you like to use AUTO-RESTART" S %=1 D YN^DICN Q:%  W !!?2,"Answer 'YES' if want the task to attempt to re-start itself if possible when",!,"an error occurs.  Answer 'NO' to have the task stop when an error occurs."
 G:%<0 DONE S AR=%=1
 ;
START ;
 K RSHELP D STAT
 ;
S1 ;
 K DIR S DIR(0)="SAO^S:START A TASK",DIR("A",1)="Enter:",DIR("A",2)="  S to START A TASK",X=2
 I RSF S X=3,DIR("A",X)="  R to RESTART A TASK",DIR(0)=DIR(0)_";R:RESTART"
 I GSF S X=X+1,DIR("A",X)="  G to show GLOBAL STATISTICS",X=X+1,DIR("A",X)="  C to get a COUNT of ALL GLOBAL NODES",DIR(0)=DIR(0)_";G:GLOBAL STATISITCS;C:COUNT OF GLOBAL NODES"
 S DIR("A",X+1)=" ",DIR("A")="Or press RETURN for a STATUS UPDATE: ",DIR("T")=30,DIR("?")="^D TSKH^ZZMGUH" W ! D ^DIR
 G:$D(DUOUT) DONE G:Y=""!$D(DTOUT) START G:Y="R" RS G:Y="G" MS
 I Y="C" D ENGNC^ZZMGU0 G START
 ;
SU ;
 K DIR S DIR(0)="FA^3:3^K:X'?3U X",DIR("A")="Select UCI: ",DIR("?")="^D SUH^ZZMGUH" W ! D ^DIR K DIR G:"^"[Y START S UCI=Y
 ;
SV ;
 K DIR S DIR(0)="FA^3:3^K:X'?3U X",DIR("A")="Select VOLUME SET: ",DIR("?")="^D SVH^ZZMGUH" W ! D ^DIR K DIR G:"^"[Y START S VOL=Y
 I $D(^[UCI,VOL]ZZGL(0))[0 W *7,!!,"But the global list (^ZZGL) does not exist on ",UCI,",",VOL,"." G SU
 S SG=^(0) I 'SG W *7,!!,"But there are no globals in ",UCI,",",VOL," to move!" G SU
 ;
SG ;
 K DIR S DIR(0)="LA^1:"_SG,DIR("A")="Select GLOBAL(S): ",DIR("?")="^D SH^ZZMGUH" W ! D ^DIR G:$D(DIRUT) SU S SG=X
 ;
 ;
 D DORT G:"^"[DORT S1
 ;
GDA ;
 L +^ZZMG(0) S ND=$G(^ZZMG(0)) F DA=$P(ND,"^",3)+1:1 I '$D(^ZZMG(DA)) L +^ZZMG(DA):1 I  S $P(^(0),"^",3,4)=DA_"^"_DA,^(DA,0)=HERE_"^"_UCI_","_VOL_"^"_AR_"^"_DORT_"^"_SG,^ZZMG("B",HERE,DA)="" Q
 L -^ZZMG(0) S Q=0 F Q1=0:1 Q:'$D(Y(Q1))  F Q2=1:1 S X=$P(Y(Q1),",",Q2) Q:'X  S X=$P($G(^[UCI,VOL]ZZGL(X)),"^") I X]"" S Q=Q+1,^ZZMG(DA,1,Q,0)=X
 S $P(^ZZMG(DA,1,0),"^",3,4)=Q_"^"_Q I Q'>0 D NOW^%DTC S $P(^ZZMG(DA,0),"^",9)=%,^("E")=%_"^NO GLOBALS FOUND FOR THE TASK!" W *7,!!,"No globals were found for this task!" K DIR S DIR(0)="E" W ! D ^DIR K DIR G START
 L -^ZZMG(DA) W !!,"You're task number is ",DA I DORT'="D" J MOVE^ZZMGU0(DA) W "...sent!" H 5
 E  W "...working..." D MOVE^ZZMGU0(DA)
 G START
 ;
RS ; restart a task
 K DIR S DIR(0)="NA^1:"_RSF_":0^K:$S($P($G(^ZZMG(X,0)),""^"")'=HERE:1,1:$P(^(0),""^"",9)) X",DIR("A")="Select TASK TO RESTART: ",DIR("?")="^D RSH^ZZMGUH" W ! D ^DIR G:'Y START
 S DA=Y I $D(^ZZMGU(DA,"E")) S %=1
 E  W *7,!!,"BUT THIS TASK DOES NOT SHOW AN ERROR!"
 E  F  W !,"Are you sure you want to restart this task" S %=2 D YN^DICN Q:%  W !!?2,"This task (",DA,") does not show an error.  Answer 'YES' if you still want to",!,"restart it.  Answer 'NO' to select another task."
 G:%'=1 RS S J=$P($G(^ZZMG(DA,0)),"^",6) I 'J S %=1 
 E  W *7,!!,"BUT THIS TASK HAS A JOB NUMBER (",J,"), AND MAY STILL BE RUNNING!"
 E  F  W !,"Are you sure you want to restart this task" S %=2 D YN^DICN Q:%  W !!,?2,"This task has a job number (",J,").  Answer 'YES' if you still want to",!,"restart it.  Answer 'NO' to select another task."
 G:%'=1 RS S DORT=$P(^ZZMG(DA,0),"^",4) I DORT'="D" J MOVE^ZZMGU0(DA) W !,"...restart sent..." H 5
 E  W !,"...working..." D MOVE^ZZMGUO(DA)
 G START
 Q
 ;
DONE ;
 Q
 ;
STAT ;
 S:'$D(RSHELP) (GSF,RSF,SN)=0 D NOW^%DTC W #!,"You are signed on to ",HERE,?65,$$DTC^ZZMGUH(%) I '$O(^ZZMG("B",HERE,0)) W !!,"No moves have been started from here, yet." Q
 W !!,"TASK  JOB#  UCI,VOL  GLOBAL(S)             STARTED      RESTARTED    FINISHED",!,"--------------------------------------------------------------------------------"
 F Q=0:0 S Q=$O(^ZZMG("B",HERE,Q)) Q:'Q  S:'$D(RSHELP) SN=Q S ND=$G(^ZZMG(Q,0)) I $S('$D(RSHELP):1,1:'$P(ND,"^",9)) S E=$G(^("E")),LG=$G(^("LG")) D  W !
 .S:$L($P(ND,"^",5))>20 $P(ND,"^",5)=$E($P(ND,"^",5),1,17)_"..." I $Y>20 R !,"<>",X:30 S $Y=0
 .W !,$J(Q,4) W:'$P(ND,"^",9) ?6,$P(ND,"^",6) W ?12,$P(ND,"^",2),?21,$P(ND,"^",5),?43,$P($$DTC^ZZMGUH($P(ND,"^",7)),":",1,2) I $P(ND,"^",8),'$P(ND,"^",9) W ?56,$P($$DTC^ZZMGUH($P(ND,"^",8)),":",1,2)
 .I $P(ND,"^",9) W ?69,$P($$DTC^ZZMGUH($P(ND,"^",9)),":",1,2) S:'$D(RSHELP)&'GSF GSF=1 Q
 .S:'$D(RSHELP) RSF=Q I E]"" W !?10,"Error: ",$$DTC^ZZMGUH(+E)," - ",$P(E,"^",2,99)
 .W:LG]"" !?4,"Last Global: ",LG
 Q
 ;
DORT ;
 N Y K DIR S DIR(0)="SA^D:DO THE MOVE;J:JOB THE MOVE",DIR("A",1)="Would you like to:",DIR("A",2)="  DO the move (which will tie up this terminal)",DIR("A",3)="  JOB the move",DIR("A")="D/J: ",DIR("?")="^D DJH^ZZMGUH" W ! D ^DIR S DORT=Y Q
 ;
MS ; move statistics
 D NOW^%DTC W #,!?29,"GLOBAL MOVE STATISTICS",!,"You are signed on to ",HERE,?65,$$DTC^ZZMGUH(%),!!,"TASK  JOB#      STARTED              FINISHED",!!?10,"GLOBAL    NODES           TIME           NODES PER",!?20,"MOVED           TAKEN          MINUTE"
 W !,"-------------------------------------------------------------------------------" S Q=0
 F  S Q=$O(^ZZMG("B",HERE,Q)) Q:'Q  S ND=$G(^ZZMG(Q,0)) D:$P(ND,"^",10)  
 .I $Y>20 R !,"<>",X:30 S $Y=0
 .W !!,Q W:'$P(ND,"^",9) ?6,$P(ND,"^",6) W ?15,$$DTC^ZZMGUH($P(ND,"^",7)) I $P(ND,"^",9) W ?36,$$DTC^ZZMGUH($P(ND,"^",9))
 .W ! S X=0 F  S X=$O(^ZZMG(Q,1,X)) Q:'X  S ND1=$P($G(^(X,0)),"^") I ND1]"" S (TNM,TT,Y)=0 F  S Y=$O(^ZZMG(Q,1,X,1,Y)) D:Y  I 'Y S:TNM NPM=TT/TNM*60\1,TNM=TNM\3600_":"_(TNM#3600\60)_":"_(TNM#60) W:TNM]0 !?10,ND1,?20,TT,?35,$J(TNM,8),?50,NPM Q
 ..S ND2=$G(^ZZMG(Q,1,X,1,Y,0)) S A=$P(ND2,"^"),B=$P(ND2,"^",3) I A,B S TT=TT+$P(ND2,"^",2),TNM=$P(B,",")-$P(A,",")*86400+$P(B,",",2)-$P(A,",",2)+TNM
 R !,"<>",X:30 K ND,ND1,ND2,Q,X,Y,A,B,TNM,TT,NPM G START
