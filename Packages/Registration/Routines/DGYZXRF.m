DGYZXRF ;ALB/MIR - CROSS-REFERENCES OR DELETES NON-X-REFED ENTRIES IN DGPM ;AUG 2, 1991
 ;;MAS VERSION 5.0;
 ;
 ;
 D DT^DICRW,HOME^%ZIS
 I 'DUZ W !,"You must have DUZ defined in order to continue!!",!! G Q
 ;
REDO ;want to restart?
 I '$D(^UTILITY("DGYZXRF")) G CONT
 W !,"Results exist...do you want to restart this process" S %=2 D YN^DICN I %<0!(%=2) G Q
 I '% W !?5,"Answer 'YES' to kill results and restart or 'NO' to quit" G REDO
 ;
CONT W !! F I=1:1 S X=$P($T(TEXT+I),";;",2) Q:X="QUIT"  W:X'="PAUSE" !,X I X="PAUSE" S DIR(0)="E" D ^DIR Q:'Y  W @IOF
 I 'Y G Q
ASK ;ask if changes should be made
 W !!,"Do you want these entries cross-referenced or purged automatically" S %=2 D YN^DICN I %<0 G Q
 I '% W !,?3,"Enter:  'Y'es for entries to be cross-referenced or purged",!?11,"'N'o to receive a report of findings only",!?11,"'^' to abort this process" G ASK
 S DGYZAUTO='(%-1)
 S ZTDESC="Search for non-cross-referenced entries in ^DGPM",ZTSAVE("DGYZAUTO")="",ZTRTN="EN^DGYZXRF1",ZTIO="" D ^%ZTLOAD
Q K %,%Y,DGYZAUTO,DIR,I,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE
 Q
 ;
TEXT ;Write out description of routine
 ;;A few sites have reported having non-cross-referenced entries in the new
 ;;PATIENT MOVEMENT file.  In rare cases, this could be caused by a system
 ;;crash or conversion failure.  This would occur if the job stopped after
 ;;hard setting the entries into ^DGPM, but before cross-referencing them.
 ;;In this case, the conversion would restart and reconvert these patients
 ;;causing duplicates to be created in ^DGPM (one cross-referenced and one
 ;;without cross-references).  This would not cause an operational problem.
 ;;
 ;;The second problem involves a KERNEL job called 'Clean old job nodes in
 ;;XUTL'.  This job will kill ^UTILITY nodes for jobs that have been on the
 ;;system for more than 24 hours (which would likely be the case with part
 ;;II of the conversion).  The cross-references for the ^DGPM global were
 ;;stored in the ^UTILITY global and executed upon creation of an entry in
 ;;the new file.  If the ^UTILITY global were killed, there could be many
 ;;entries in the PATIENT MOVEMENT file which are not visible through any
 ;;MAS or VA FileMan options.
 ;;
 ;;PAUSE
 ;;
 ;;Whether or not you feel you may have had one of the above mentioned occur
 ;;we strongly recommend you run this routine.  It will look for non-cross-
 ;;referenced entries and delete them if they are duplicates or cross-reference
 ;;them if they are not.  It will also look for cross-referenced duplicates.
 ;;You may choose whether or not to have the routine make the changes.  In
 ;;either case a report of findings will be generated.
 ;;
 ;;You will receive a message upon completion of this job.  It will then
 ;;instruct you how to obtain a report of the findings.
 ;;
 ;;
 ;;
 ;;QUIT
 ;
 ;
REPORT ;queue off report of findings
 I $D(^UTILITY("DGYZXRF"))'=11 W !,"No findings exist...you must regenerate!" G REPORTQ
 S DGYZAUTO=^UTILITY("DGYZXRF")
 W !!,"This report will require 132 column output",!
 S DGPGM="EN^DGYZXRF2",DGVARS="DGYZAUTO" D ZIS^DGUTQ
 I 'POP U IO D EN^DGYZXRF2
REPORTQ K DGVARS,DGPGM,POP
 Q
