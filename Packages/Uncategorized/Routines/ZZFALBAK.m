ZZFALBAK ; B'ham ISC/CML3 - SET ALL SYSTEMS' TIME BACK ONE HOUR ; [ 10/24/95  7:58 AM ]
 ;;
 D DT^DICRW
 I '$O(^DIZ(521550,0)) W *7,!!,"I need to know the name of each of your systems.  Please enter their 3 character",!,"names now.",! D NODESET I '$O(^DIZ(521550,0)) W *7,!!,"Sorry, but I cannot continue without your system names." G DONE
 ;
 W #!!?25,"SPRING  FORWARD,    FALL  BACK"
 W !!,"I'm about to set up a task (through the VA TaskMan) that will be scheduled to",!,"start up on October 29, 1995 at 2:05 am.  This task will set the time back ONE",!,"HOUR on each of your system's defined nodes.  (This is to convert your system"
 W !,"from Daylight Savings Time to Standard Time.)"
 F  S %=2 W !!,"Shall I continue" D YN^DICN Q:%  D ENCH
 G:%'=1 DONE
 ;
TASK ; build task
 S HERE=$ZU(0),X=$O(^DIZ(521550,"B",$P(HERE,",",2),0)) I X S X=$P($G(^DIZ(521550,X,0)),"^",2) I X]"" S $P(HERE,",")=X
 K ZTSAVE,ZTSK S ZTDTH="2951029.0205",ZTDESC="FALL BACK - RESET ALL SYSTEM'S NODES TO STANDARD TIME",ZTIO="",ZTRTN="ENSTART^ZZFALBAK" ; ,ZTUCI=HERE
 D ^%ZTLOAD W !!,"""FALL BACK"" job ",$S($D(ZTSK):"",1:"NOT "),"tasked" W:'$D(ZTSK) *7,"." I $D(ZTSK) W "  (task # ",ZTSK,")."
 G DONE
 ;
ENSTART ; code to do the work here
 D ENBACK S LOOP=0
 ;
LOOP ; loop through nodes
 S $ZT="LOOP^ZZFALBAK"
 F  S LOOP=$O(^DIZ(521550,LOOP)) Q:'LOOP  S ND=$G(^(LOOP,0)) I $P(ND,"^")?3U,$P(ND,"^",2)?3U,$P(ND,"^",2)_","_$P(ND,"^")'=$ZU(0) J ENBACK^ZZFALBAK[$P(ND,"^",2),$P(ND,"^")]
 ;
DONE ;
 K %,%Y,HERE,LOOP,ND,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTUCI Q
 ;
ENBACK ; code that moves time back an hour
 D NOW^%DTC S TIME=$E((%-.01)_"00000",9,14),X=$ZCALL(DATETIME,"",TIME)
 K %,%H,%I,TIME,X Q
 Q
 ;
NODESET ;
 K DA,DIC,DIE,DR
 F  S DIC="^DIZ(521550,",DIC(0)="AEQLM",DLAYGO=521550 W ! D ^DIC Q:Y'>0  S DA=+Y,DIE=DIC,DR="1;.02" D ^DIE
 K DA,DIC,DIE,DLAYGO,DR Q
 ;
ENCH ;
 W !!,"Answer 'YES' if I am to create this task.  (You should first be sure that this",!,"task has not already been started.)  Answer 'NO' (or enter an up-arrow) if you",!,"do not wish me to create this task at this time."
 Q
