ZZTSET1 ;bciofo/maw-part 1 of test system reset procedures ;10/1/97
 ;;1.0;test system reset utilities;
 ;
 W !!,"PART 1:  SET UP THE TEST SYSTEM ENVIORNMENT (routine ^ZZTSET1)"
 W !!,"Before doing anything else, we need to make sure that this environment"
 W !,"is established correctly.  So, calling KSP^XMYPOST2 to christen this"
 W !,"Test system domain...",!
 D KSP^XMYPOST2
 W !!,"Set the UCI (that is, namespace) in which XMAD will run (remember to"
 W !,"enter only the namespace (e.g., TST) -- volume set name is NOT needed.)"
 S DIE="^XMB(1,"
 S DA=1
 S DR="7.5//"_"TST"
 W ! D ^DIE
 K DA,DIE,DR
 W !!,"Part 1 completed."
 S DIR(0)="EA"
 S DIR("A")="Press <return> to continue..."
 W !
 D ^DIR
 K DIR,DIROUT,X,Y
 Q
