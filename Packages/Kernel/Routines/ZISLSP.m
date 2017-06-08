ZISLSP ;WILM/RJ - Purge Cumulative Statistics; 9-10-86
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 S DIR(0)="Y",DIR("A")="ARE YOU SURE YOU WANT TO PURGE THE CUMLATIVE STATISTICS",DIR("B")="NO",DIR("?")="Enter 'YES' to purge cumulative statistics, 'NO' or '^' to exit." W ! D ^DIR K DIR I Y'=1 Q
 W !,"Starting to Purge" D 1 W !,"Purging Completed." S X="T" D ^%DT S ^%ZISL(107,"PURGE")=Y K %DT,I,X,Y Q
1 S X=0 F I=1:1 S X=$O(^%ZISL(107.2,X)) Q:X=""!(X'?.N)  W "." K ^%ZISL(107.2,X,1)
 Q
