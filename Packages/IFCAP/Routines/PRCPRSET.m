PRCPRSET ;WISC/AKS-set packs only report ;6 May 92
 ;;4.0;IFCAP;;9/23/93
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 N %,PRCPSORT W !?2,"START WITH GROUP CATEGORY CODE: FIRST// @   <<-- ENTER '@' TO PRINT ITEMS",!?51,"WITHOUT A GROUP CATEGORY CODE" S BY="[PRCP SORT:GROUP]"
 S DIC="^PRCP(445,",L=0,FLDS="[PRCP REPORT:SET/PACKS ONLY]",DIS(0)="I D0=PRCP(""I"")",PRCPSORT="D SORT^PRCPRSET",DIOEND="D END^PRCPUREP" D EN1^DIP Q
 ;
SORT ;Sort lookup for set/pack items
 I $O(^PRCP(445,D0,1,D1,8,0)) S X=D1 Q
 S X="" Q
