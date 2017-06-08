ZZTSET8 ;bciofo/maw-part 8 of test system reset procedures ;10/1/97
 ;;1.0;test system utilities;
 ;
 W !!,"PART 8:  START TASK MANAGER (routine ^ZZTSET8)"
 W !!,"Finally, I can start up Task Manager from here if you wish."
 S DIR(0)="YA"
 S DIR("A")="Okay to JOB Task Manager to start now? "
 S DIR("B")="NO"
 W ! D ^DIR K DIR
 I Y'=1!($D(DIRUT)) D  Q
 .W $C(7)
 .W " ...Part 8 ABORTED!!"
 .W !!,"NO ACTION TAKEN TO STARTUP TASK MANAGER!"
 .W !!,"Note:  if you use the RESTART option in the TaskMan Management Utilities menu,"
 .W !,"the options set for STARTUP in Part 4 of this process WILL NOT automatically"
 .W !,"start.  Only a complete startup of Task Manager will startup those options."
 .S DIR(0)="EA"
 .S DIR("A")="Press <return> to continue..."
 .W !
 .D ^DIR
 .K DIR,DIROUT,DIRUT,X,Y
 ;
 W !!,"J ^ZTMB"
 J ^ZTMB::5
 I '$T D
 .W $C(7)
 .W !!,"JOB request timed out -- TaskMan not started!"
 .S ZZJOBZTM=""
 I '$D(ZZJOBZTM) W !!,"Part 8 completed."
 S DIR(0)="EA"
 S DIR("A")="Press <return> to continue..."
 W !
 D ^DIR
 K DIR,DIROUT,DIRUT,X,Y,ZZJOBZTM
 Q
