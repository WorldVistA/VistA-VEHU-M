PRCPEINF ;WISC/RFJ-inventory point control flags ;2 Feb 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
EMER ;     |-> emergency stock level flag
 D ^PRCPUSEL Q:'$G(PRCP("I"))  I "WP"'[PRCP("DPTYPE") W !,"THIS OPTION SHOULD ONLY BE USED BY A WAREHOUSE OR PRIMARY INVENTORY POINT." Q
 N %,X W ! F %=1:1 S X=$P($T(EMERTEXT+%),";",3,99) Q:X=""  W !,X
 W ! D EDIT(PRCP("I"),7) Q
 ;
 ;
ISSU ;     |-> whse issues
 D ^PRCPUSEL Q:'$G(PRCP("I"))  I PRCP("DPTYPE")'="P" W !,"THIS OPTION SHOULD ONLY BE USED BY A PRIMARY INVENTORY POINT." Q
 N %,X W ! F %=1:1 S X=$P($T(ISSUTEXT+%),";",3,99) Q:X=""  W !,X
 W ! D EDIT(PRCP("I"),10) Q
 ;
 ;
EDIT(V1,V2) ;     |-> edit fields option (v2=fields in dr string)
 ;      |-> for invpt v1
 N %DT,D,D0,DA,DI,DIC,DIE,DR,DQ,DZ,X,Y S (DIC,DIE)="^PRCP(445,",DA=V1,DR=V2 D ^DIE Q
 ;
 ;
ISSUTEXT ;     |-> info text for issues
 ;;Delete this date to discontinue the message notifying you that your
 ;;next request for warehouse issues is due; or change it to a later
 ;;date, if you wish to be reminded later.
 ;
 ;
EMERTEXT ;     |-> emergency stock level info
 ;;Set this flag to NO to discontinue the notification that you have
 ;;items at the emergency stock level.  The next time the automatically
 ;;scheduled program that scans and finds any items at the emergency
 ;;stock level is run again, it will reset the flag and the message will
 ;;reappear until you turn it off (using this option).
