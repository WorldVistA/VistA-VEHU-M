ZZTSET4 ;bciofo/maw-part 4 of test system reset procedures ;10/1/97
 ;1.0;test system reset utilities;
 ;
 W !!,"PART 4:  CLEAN UP ^%Z* GLOBALS (routine ^ZZTSET4)"
 W !!,"This will KILL ^%ZTSCH, ^%ZTSK, ^%ZUA, ^%ZTER, ^%ZISL for the Test system."
 W !,"All these globals will be re-set by a call to ^ZTMGRSET.  Killing the Task"
 W !,"Manager globals is critical to prevent restored production jobs from starting"
 W !,"up on the Test system."
 W !!,"Note:  ^%ZIS (Device and Terminal Type files) is not touched by this procedure."
 S DIR(0)="YA"
 S DIR("A")="Okay to continue with Part 4? "
 S DIR("B")="NO"
 W ! D ^DIR K DIR
 I Y'=1!($D(DIRUT)) D  Q
 .W $C(7)
 .W " ...Part 4 ABORTED!!"
 ;
 W !!,"Killing selected ^%Z globals..."
 K ^%ZTSCH,^%ZTSK,^%ZUA,^%ZTER,^%ZISL
 W !,"Calling ^ZTMGRSET to re-set..."
 S ^%ZTSCH=""
 D GLOBALS^ZTMGRSET
 W !?2,"^%ZTSCH ",$S($D(^%ZTSCH):"...okay",1:"--ERROR--NOT RE-SET.")
 W !?2,"^%ZTSK  ",$S($D(^%ZTSK):"...okay",1:"--ERROR--NOT RE-SET.")
 W !?2,"^%ZTER  ",$S($D(^%ZTER):"...okay",1:"--ERROR--NOT RE-SET.")
 W !?2,"^%ZISL  ",$S($D(^%ZISL):"...okay",1:"--ERROR--NOT RE-SET.")
 W !!,"The last part of this is to call ^ZTMGRSET to re-set the system"
 W !,"names and the corresponding ^%ZOSF nodes correctly.  (Remember that"
 W !,"the 'MGR' account should be set to the Test system namespace (e.g.,"
 W !,"TST) and NOT MGR.)",!
 W ! D NAME^ZTMGRSET
 W !!,"Part 4 completed."
 S DIR(0)="EA"
 S DIR("A")="Press <return> to continue..."
 W !
 D ^DIR
 K DIR,DIROUT,DIRUT,X,Y
 Q
