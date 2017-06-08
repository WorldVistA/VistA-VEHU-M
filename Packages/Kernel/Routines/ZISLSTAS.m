ZISLSTAS ;WILM/RJ - Capture Statistics Started; 3-1-87
 ;;7.1;KERNEL;;May 11, 1993
 ;;Version 4.51
 S X=0,X=$O(^%ZISL(107,"RUN",X)) I X'="" W !!,"Job ",X," is currently capturing statistics."
 S DIR(0)="Y",DIR("A")="Are You Sure",DIR("B")="NO",DIR("?")="Enter 'YES' to start capturing statistics, 'NO' or '^' to exit." W ! D ^DIR K DIR I Y'=1 Q
 K ^%ZISL(107,"RUN") X "J 1^ZISLSTAT" W !!,"Capturing Statistic job started in background." Q
