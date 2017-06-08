ZZDGL ; B'ham ISC/CML3 - CREATE DSM GLOBAL LIST ;1/10/92  12:26
 ;;1T3
 ;
 D HOME^%ZIS W @IOF,!!!?28,"DSM  GLOBAL  LIST  BUILD"
 W !!,"These utilities create and update a list of globals to be moved from this DSM",!,"system to a PC-MSM system.  The process invloves the following steps:",!?10,"1. Build the global list.  (Translated globals are NOT included.)"
 W !?10,"2. Delete the entries from list that will not be moved.",!?10,"3. Produce a node count for each global to used as an integrity check."
 I '$G(DUZ) W *7,!!,"BUT I DON'T KNOW WHO YOU ARE! (DUZ)" Q
 ;
START ;
 S GC=$G(^ZZGL(0)) I 'GC D  G:%'=1 DONE G START
 .W !!,"No global list found"
 .F  W !!,"Do you want to build a list now" S %=1 D YN^DICN Q:%  W !!,"Answer 'YES' to build a global list now.  Answer 'NO' (or '^') to exit these",!,"utilities now."
 .Q:%'=1  D ENGB^ZZDGL0 S %=1
 ;
ASK ;
 K DIR S DIR(0)="SAO^1:REBUILD LIST;2:PRINT THE LIST;3:DELETE ENTRIES FROM THE LIST;4:START/RESTART GLOBAL NODE COUNT",DIR("A",1)="Select from:",DIR("A",2)="     1. - Rebuild the list",DIR("A",3)="     2. - Print the list"
 S DIR("A",4)="     3. - Delete entries from the list",DIR("A",5)="     4. - Start/restart global node count",DIR("A",6)="",DIR("A")="Select ACTION: ",DIR("?")="^D AH^ZZDGL" W ! D ^DIR I "^"[Y G DONE
 D @("EN"_$P("GB^PRT^P^RS","^",Y)_"^ZZDGL0") G ASK
 ;
DONE ;
 W !!,"Bye" K %,%Y,DIR,DIROUT,DIRUT,DTOUT,DUOUT,GC,X,Y Q
 ;
AH ;
 W !!?2,"Enter '1' to rebuild the list of globals.  WARNING! Rebuilding the list will",!,"delete ALL previous data, including any global node counts."
 W !!?2,"Enter '2' to print the list of globals."
 W !!?2,"Enter '3' to delete entries from the list that will not be moved to the PC",!,"system.  After entries are deleted, the list is automatically compressed, and"
 W !,"the globals are renumbered, SO A NEW PRINT OF THE GLOBAL LIST IS RECOMMENDED."
 W !!?2,"Enter '4' to start or restart the global node counts.  These counts are used",!,"as an integrity check after the globals are moved.  This process could take 24",!,"hours."
