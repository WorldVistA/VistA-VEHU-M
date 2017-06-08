ZZWFONT ;ISCSF/RWF - Clean out the volume set fields in taskman ;04/21/97  12:50
 ;;
A D HOME^%ZIS
 W !,"This routine will go through the taskman global and the device file"
 W !,"and remove or change any VOLUME SET data."
 S DIR(0)="Y",DIR("A")="Sure you want to run this!" D ^DIR Q:Y'=1
 N VOL,ZT,DUZ
 S ZT=0,U="^",VOL=^%ZOSF("VOL"),DUZ=0,DUZ(0)="@"
 D TASK1,TASK2,DEV,OPT,END
 Q
TASK1 ;Remove any VOLUME SET data from taskman tasks.
 S ZT=0
 F  S ZT=$O(^%ZTSK(ZT)) Q:ZT'>0  S $P(^%ZTSK(ZT,0),U,12)="",$P(^(0),U,14)="",$P(^(.01),U,2)="",$P(^(.02),U,2)=""
 W !,"%ZTSK DONE"
 W !,"Now to put IO waiting jobs back in the schedule"
 S DEV=""
 F  S DEV=$O(^%ZTSCH("IO",DEV)) Q:DEV=""  D REIO(DEV)
 W !,"Clean up un-needed parts of %ZTSCH"
 K ^%ZTSCH("IO"),^%ZTSCH("ER"),^%ZTSCH("LINK"),^%ZTSCH("SUB"),^%ZTSCH("STARTUP")
 Q
 ;
DEV W !,"Now to clean up the Device file." S ZT=0
 F  S ZT=$O(^%ZIS(1,ZT)) Q:ZT'>0  S $P(^%ZIS(1,ZT,0),U,9)=""
 F  S ZT=$O(^%ZIS(1,"C",1,ZT)) Q:ZT'>0  S $P(^%ZIS(1,ZT,0),U,12)=2 W !?5,$P(^(0),U,1)," has a $I of 1"
 W !,"%ZIS DONE"
 Q
 ;
TASK2 W !,"Now to fix the Taskman parameter files"
 W !,"Delete all entries from 14.7"
 F DA=0:0 S DA=$O(^%ZIS(14.7,DA)) Q:DA'>0  S DIK="^%ZIS(14.7," D ^DIK
 W !,"Build ROU entry"
 S $P(^%ZIS(14.7,0),U,3)=0,$P(^%ZIS(14.5,0),U,3)=0
 S X="ROU",DIC="^%ZIS(14.7,",DIC(0)="MQL" D ^DIC S DA=+Y
 S $P(^%ZIS(14.7,DA,0),U,2,12)="^N^^^120^240^0^G^^0^2"
 W !,"Build a ROU entry in 14.5"
 S DIC="^%ZIS(14.5,",DIC(0)="QML",X="ROU" D ^DIC S DA=+Y
 S $P(^%ZIS(14.5,DA,0),U,2,11)="N^Y^N^^VAH^^^^G^1"
 W !,"Remove all entries in 14.6"
 F DA=0:0 S DA=$O(^%ZIS(14.6,DA)) Q:DA'>0  S DIK="^%ZIS(14.6," D ^DIK
 W !,"Taskman Parameter's DONE"
 Q
 ;
OPT W !,"Check the Option Schedule file"
 F DA=0:0 S DA=$O(^DIC(19.2,DA)) Q:DA'>0  S $P(^DIC(19.2,DA,0),U,5)=""
 W !,"Rebuild the STARTUP option for this UCI"
 S DIK="^DIC(19.2,",DIK(1)=9 D ENALL^DIK
 Q
 ;
END ;Do some more cleanup
 K ^XMB(1,1,4) ;Dead data
 S $P(^XMB(1,1,0),U,12)=""
 W !,"Clean-up Menu build"
 S DDATE=$$HTFM^XLFDT($H+2),X=DDATE
 F  S X=$O(^DIC(19,"AT",X)) Q:X<DDATE  K:X>DDATE ^DIC(19,"AT",X)
 K X,%DT,Y,J,K,DDATE
 Q
REIO(DEV)       ;Move IO group to schedule
 N DH,ZT S DH=0
 F  S DH=$O(^%ZTSCH("IO",DEV,DH)),ZT=0 Q:DH'>0  D
 . F  S ZT=$O(^%ZTSCH("IO",DEV,DH,ZT)) Q:ZT'>0  S ^%ZTSCH(DH,ZT)=""
 . Q
 K ^%ZTSCH("IO",DEV)
 Q
