ZZTSET5 ;bciofo/maw-part 5 of test system reset procedures ;10/1/97
 ;;1.0;test system reset utilities;
 ;
 W !!,"PART 5:  SET STARTUP SCHEDULING FOR SELECTED OPTIONS (routine ^ZZTSET5)"
 W !!,"I will now re-establish startup scheduling for a few selected options."
 W !,"Once TaskMan is started up, these basic, yet necessary options will"
 W !,"startup, too.  If any of the following process fails, you should take"
 W !,"a look at these options and make sure they get set up correctly.  The"
 W !,"options should have entries in BOTH files 19 (Option) and 19.2"
 W !,"(Option Scheduling)."
 W !!,"The current list of options includes:",!
 F ZZX=1:1 S ZZOPTN=$T(STRTOPT+ZZX^ZZTSET5) Q:ZZOPTN=""  D
 .W !?2
 .W $P($P(ZZOPTN,";;",2),"^")
 .W " (",$P($P(ZZOPTN,";;",2),"^",2),")"
 W !!,"Note:  the list of options can be found in the module STRTOPT at the end of"
 W !,"this routine.  If there are other options you would like to include, add them"
 W !,"to the list (use the exact same format as the existing entries in the module.)"
 ;
 S DIR(0)="YA"
 S DIR("A")="Okay to continue with Part 5? "
 S DIR("B")="NO"
 W ! D ^DIR K DIR
 I Y'=1!($D(DIRUT)) D  Q
 .W $C(7)
 .W " ...Part 5 ABORTED!!"
 .K X,Y,ZZOPTN,ZZX
 ;
 W !
 F ZZX=1:1 S ZZOPTN=$P($T(STRTOPT+ZZX^ZZTSET5),";;",2) Q:ZZOPTN=""  D
 .S ZZOPTN=$P(ZZOPTN,"^")
 .;
 .W !?2,ZZOPTN
 .S ZZXDA=+$O(^DIC(19,"B",ZZOPTN,0))
 .I 'ZZXDA D  Q
 ..W $C(7)
 ..W "...not in file 19!  Please check this out."
 .S ZZYDA=+$O(^DIC(19.2,"B",ZZXDA,0))
 .I $D(^%ZTSCH("STARTUP",ZZYDA)) D  Q
 ..W $C(7)
 ..W " ...already in STARTUP!!"
 .I 'ZZYDA D  Q
 ..W $C(7)
 ..W "...not in file 19.2!  Please check this out."
 .I ZZYDA D
 ..S DIE="^DIC(19.2,"
 ..S DA=ZZYDA
 ..S DR="9///^S X=""STARTUP"""
 ..D ^DIE
 ..K DA,DIE,DR
 ..W "...startup set."
 K X,Y,ZZOPTN,ZZX,ZZXDA,ZZYDA
 W !!,"Part 5 completed."
 S DIR(0)="EA"
 S DIR("A")="Press <return> to continue..."
 W !
 D ^DIR
 K DIR,DIROUT,DIRUT,X,Y
 Q
 ;     
STRTOPT ;; startup options **DO NOT ADD MODULES BELOW THIS ONE**...
 ;;XMRONT^TCP/IP MailMan listener
 ;;XWB LISTENER STARTER^RPC Broker listener
 ;;XMMGR-START-BACKGROUND-FILER^Local MailMan delivery
