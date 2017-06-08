ZZSPGFWD ; B'ham ISC/CML3 - SET ALL SYSTEMS' TIME AHEAD ONE HOUR ; [ 03/29/95  8:42 AM ]
 ;;
 D DT^DICRW
 I '$O(^DIZ(521550,0)) W *7,!!,"I need to know the name of each of your systems.  Please enter their 3 character",!,"names now.",! D NODESET I '$O(^DIZ(521550,0)) W *7,!!,"Sorry, but I cannot continue without your system names." G DONE
 ;
 W #!!?25,"SPRING  FORWARD,    FALL  BACK"
 W !!,"I'm about to set up a task (through the VA TaskMan) that will be scheduled to",!,"start up on April 2,1995 at 2:05 am.  This task will set the time AHEAD ONE",!,"HOUR on each of your system's defined nodes.  (This is to convert your system"
 W !,"from Standard Time to Daylight Savings Time.)"
 F  S %=2 W !!,"Shall I continue" D YN^DICN Q:%  D ENCH
 G:%'=1 DONE
 ;
TASK ; build task
 S HERE=$ZU(0),X=$O(^DIZ(521550,"B",$P(HERE,",",2),0))
 I X S X=$P($G(^DIZ(521550,X,0)),"^",2) I X]"" S $P(HERE,",")=X
 K ZTSAVE,ZTSK
 S ZTDTH="2950402.0205",ZTDESC="SPRING FORWARD - RESET ALL SYSTEM'S NODES TO DAYLIGHT SAVINGS TIME",ZTIO="",ZTRTN="ENSTART^ZZSPGFWD" ; ,ZTUCI=HERE
 D ^%ZTLOAD
 W !!,"""SPRING FORWARD"" job ",$S($D(ZTSK):"",1:"NOT "),"tasked" W:'$D(ZTSK) *7,"." I $D(ZTSK) W "  (task # ",ZTSK,")."
 G DONE
 ;
ENSTART ; code to do the work here
 D ENFWD S LOOP=0
 ;
LOOP ; loop through nodes
 S $ZT="LOOP^ZZSPGFWD"
 F  S LOOP=$O(^DIZ(521550,LOOP)) Q:'LOOP  S ND=$G(^(LOOP,0)) I $P(ND,"^")?3U,$P(ND,"^",2)?3U,$P(ND,"^",2)_","_$P(ND,"^")'=$ZU(0) D SYS J ENFWD^ZZSPGFWD[$P(ND,"^",2),$P(ND,"^"),SYS]
 ;
DONE ;
 K %,%Y,HERE,LOOP,ND,X,Y,ZTDESC,ZTDTH,ZTRTN,ZTUCI,SYS Q
 ;
SYS S SYS=$E($P(ND,"^"),1)_"S"_$E($P(ND,"^"),3)
 Q
ENFWD ; code that moves time ahead an hour
 D NOW^%DTC S DATE=$$CHANGE(%,3600)
 S TIME=$E(DATE_"00000",9,14),DATE=$E(DATE,4,5)_$E(DATE,6,7)_$E(DATE,2,3)
 S X=$ZCALL(DATETIME,DATE,TIME)
 K %,%H,%I,DATE,TIME,X Q
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
 ;
CHANGE(DATETIME,TDIFF) ;
 N H,HRS,M,MIN,S,SEC,T,X,X1,X2
 S DATETIME=DATETIME_"00000",X=$P(DATETIME,".")
 S T=1 S:TDIFF<0 T=-1,TDIFF=-TDIFF
 S M=TDIFF\60,S=TDIFF#60,H=M\60,M=M#60,X2=H\24,H=H#24
 S HRS=+$E(DATETIME,9,10),MIN=+$E(DATETIME,11,12),SEC=+$E(DATETIME,13,14)
 I S S SEC=SEC+(S*T) S:SEC>59 SEC=SEC-60,M=M+1 S:SEC<0 SEC=SEC+60,M=M+1
 I M S MIN=MIN+(M*T) S:MIN>59 MIN=MIN-60,H=H+1 S:MIN<0 MIN=MIN+60,H=H+1
 S:H HRS=HRS+(H*T)
 S:HRS>24!(HRS=24&MIN) HRS=HRS-24,X2=X2+1 S:HRS<0 HRS=HRS+24,X2=X2+1
 I X2 S X1=X,X2=X2*T D C^%DTC
 S X=X_"."_$E(0,HRS<10)_HRS_$E(0,MIN<10)_MIN_$E(0,SEC<10)_SEC
 Q X
