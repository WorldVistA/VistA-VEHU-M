ZZTSET3 ;bciofo/maw-part 3 of test system reset procedures ;10/1/97
 ;;1.0;test system reset utilities;
 ;
 W !!,"PART 3:  DISABLE PRINTERS (routine ^ZZTSET3)"
 W !!,"Next, I want to reset several fields in the Device file.  These changes will"
 W !,"prevent unwanted, and perhaps damaging print jobs running from the Test system."
 W !,"After I'm done, you can easily use File Manager to edit those printers you do"
 W !,"want to use for output from the Test system."
 ;
 ; see if we can retrieve the null device's $I from the device file...
 W !!,"One of the changes is to reset $I to that of your NULL device...looking in"
 W !,"your device file for an entry for the NULL device..."
 S ZZDI=+$O(^%ZIS(1,"B","NULL",0))
 I ZZDI=0 S ZZDI=+$O(^%ZIS(1,"B","null",0))
 I ZZDI>0 D
 .S ZZDI=$P($G(^%ZIS(1,ZZDI,0)),U,2)
 .I ZZDI="" S ZZDI=0 Q
 .W "found it."
 I ZZDI=0 D
 .W $C(7)
 .W !!,"I can't find a usable file entry for a ""NULL"" device."
 .S DIR(0)="YA"
 .S DIR("A")="Do you want me to go ahead with the other changes anyway? "
 .S DIR("B")="NO"
 .S DIR("?",1)="Answer 'NO' to bail completely on Part 3."
 .S DIR("?")="Answer 'YES' and I'll show you what I have in mind...you can abort at that point if you want."
 .W ! D ^DIR K DIR
 .I Y'=1 S DIRUT=1 Q
 I $D(DIRUT) D  Q
 .W !!,"Okay.  You can always set up a valid ""NULL"" device and re-run this routine."
 .W !!,"Part 3 ABORTED!"
 .R X:5
 .K X,Y,ZZDI
 ;
 ; show what we'll be doing...
 W !!,"So, what I have in mind is:"
 W !!,"$I will ",$S(ZZDI=0:"not be touched",1:"be changed to:  "_ZZDI)
 W !,"OUT-OF-SERVICE DATE will be set to:  ",$$FMTE^XLFDT($$NOW^XLFDT())
 W !,"QUEUEING field will be set to:  Not Allowed"
 I ZZDI'=0 D
 .W !!,"(Note:  while changing the $I, you will see a message about other devices"
 .W !,"using the same $I -- this is informational, don't worry about it.)"
 ;
 ; do we go?...
 S DIR(0)="YA"
 S DIR("A")="Okay to continue with Part 3? "
 S DIR("B")="NO"
 W ! D ^DIR K DIR
 I Y'=1!($D(DIRUT)) D  Q
 .W $C(7)
 .W !!,"WARNING:  CLINICAL DATA COULD BE INADVERTENTLY PRINTED FROM THE TEST SYSTEM"
 .W !,"AND MISCONSTRUED AS ACTUAL CLINICAL ORDERS, DATA OR OTHER INFORMATION."
 .W !!,"Part 3 ABORTED!"
 .K X,Y,ZZDI
 ;
 S DIR(0)="YA"
 S DIR("A")="Would you like me to list the device names as I edit them? "
 S DIR("B")="NO"
 S DIR("?")="Answer 'YES' and I'll output the name of each device I've edited."
 W ! D ^DIR K DIR
 K DIRUT
 S ZZLIST=+Y
 W !!,"Okay, working..."
 S ZZDEV=0
 F  S ZZDEV=$O(^%ZIS(1,ZZDEV)) Q:'ZZDEV  D
 .S ZZSTYPE=+$G(^%ZIS(1,ZZDEV,"SUBTYPE"))
 .S ZZSTYPE=$P($G(^%ZIS(2,ZZSTYPE,0)),U)
 .I $E(ZZSTYPE)'="P" Q
 .I ZZSTYPE["MESSAGE"!(ZZSTYPE["BROWSER")!(ZZSTYPE["HFS") Q
 .S $P(^%ZIS(1,ZZDEV,90),U)=$$NOW^XLFDT()
 .S $P(^%ZIS(1,ZZDEV,0),U,12)=2
 .;
 .; do we edit the $I?...
 .I ZZDI'=0 D
 ..; call FileMan to edit $I...
 ..S DIE="^%ZIS(1,"
 ..S DA=ZZDEV
 ..S DR="1////^S X=ZZDI"
 ..D ^DIE
 ..K DA,DIE,DR
 .I ZZLIST=1 W !?2,$P(^%ZIS(1,ZZDEV,0),U) Q
 .W "."
 K X,Y,ZZDEV,ZZDI,ZZLIST,ZZSTYPE
 I $X>75 W !
 W !!,"Part 3 completed."
 S DIR(0)="EA"
 S DIR("A")="Press <return> to continue..."
 W !
 D ^DIR
 K DIR,DIROUT,DIRUT,X,Y
 Q
