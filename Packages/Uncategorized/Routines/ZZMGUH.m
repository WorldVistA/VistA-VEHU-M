ZZMGUH ; B'ham ISC/CML3 - HELP FOR GLOBAL MOVE ;1/22/92  08:31 [ 02/05/92  10:55 AM ]
 ;;1T4
 ;
SH ;
 N %,%Y,X,Y
 W !!?2,"Select the globals you wish to move, by number (1-",SG,").  You can enter",!,"multiple numbers separated by commas (1,2,3,10) or a range of numbers (1-10),",!,"or a combination of both (1,2,6-10)."
 F  W !!,"Do you want a list of the globals" S %=2 D YN^DICN Q:%  W !!?2,"Answer 'YES' for a list of the globals that can be moved from the selected",!,"machine (",VOL,").  Answer 'NO' if you do not need a list."
 Q:%'=1  S X=SG\2,Y="" W !!?5,"Global list from ",UCI,",",VOL," (",SG," globals)"
 F Q=1:1:X W !,$J(Q,4)," ",$S($D(^[UCI,VOL]ZZGL(Q)):$P(^(Q),"^"),1:"* NOT FOUND *"),?40,$J(Q+X,4)," ",$S($D(^[UCI,VOL]ZZGL(Q+X)):$P(^(Q+X),"^"),1:"* NOT FOUND *") I '(Q#20) R !!,"Press RETURN to continue, '^' to stop: ",Y I Y["^" Q
 I Y'["^" S Q=Q+X I Q<SG F Q=Q+1:1:SG W !?40,$J(Q,4)," ",$S($D(^[UCI,VOL]ZZGL(Q)):$P(^(Q),"^"),1:"* NOT FOUND *")
 Q
 ;
SUH ;
 W !!?2,"Enter the UCI from which you wish to move globals.  The UCI selected must",!,"have a global list.  The UCI must be three (3) uppercase characters, such",!,"as 'VAH' or 'MGR'."
 Q
 ;
SVH ;
 W !!?2,"Enter the VOLUME SET from which you wish to move globals.  The UCI and",!,"volume set selected must contain a global list.  The volume set must be",!,"three (3) uppercase characters, such as 'AAA' or 'BBB'."
 Q
 ;
TSKH ;
 N X,Y,Z W !!,"Enter:",!,"S To START a new task." W:RSF !,"R To RESTART a previously started task that has been aborted." W:GSF !,"G To view the statistics on globals that have been moved."
 W:GSF !,"C To get a count of all global nodes.  This count is compared with the global",!,"  node count of the machine from which the globals were moved, as a rudimentary",!,"  integrity check."
 I SN W !!,"Simply press RETURN to get an update on the tasks that have already been",!,"started."
 W !!,"Enter an up-arrow ('^') to exit this utility.  (Exiting does not stop any",!,"tasks currently running.)" Q
 ;
DJH ;
 W !!?2,"Enter 'D' to perform the global move now on this terminal.  (WARNING! DOING",!,"the move will tie up your terminal until the move has completed!)  Enter 'J'",!,"to job the move (to start now), which will not tie up your terminal."
 Q
 ;
RSH ;
 N %,%Y,Q,X,Y
 W !!?2,"Select a task to restart.  Only tasks started from here (",HERE,") that have",!,"not finished are selectable."
 F  W !!,"Would you like a list of tasks that can be restarted" S %=2 D YN^DICN Q:%  W !!?2,"Answer 'YES' to see a list of tasks that can be restarted.  Answer 'NO' to",!,"continue now."
 I %=1 S RSHELP=1 D STAT^ZZMGU K RSHELP 
 Q
 ;
DTC(Y) ;
 I 'Y Q "********"
 S Y=Y_$E(".",Y'[".")_"0000000",Y=$E(Y,4,5)_"/"_$E(Y,6,7)_" "_$E(Y,9,10)_":"_$E(Y,11,12)_":"_$E(Y,13,14) Q Y
