PRCP4PRE ;WISC/RFJ-pre init for inventory version 4 ;29 Jun 92
 ;;4.0;IFCAP;;9/23/93
 ;
 ;
START ;start pre init to delete all PRCP options (except PRCPZ)
 N %,DA,DIK,DIU,MENUDA,MENUDA1,PRCPDA,PRCPOPT,X
 W ! F %=1:1 S X=$P($T(TEXT+%),";",3,999) Q:X=""  W !,X
 W ! S PRCPOPT="PRCP" F  S PRCPOPT=$O(^DIC(19,"B",PRCPOPT)) Q:$E(PRCPOPT,1,4)'="PRCP"!($E(PRCPOPT,1,5)="PRCPZ")  S PRCPDA=0 F  S PRCPDA=$O(^DIC(19,"B",PRCPOPT,PRCPDA)) Q:'PRCPDA  D
 .   I PRCPOPT="PRCP MAIN MENU"!(PRCPOPT="PRCP2 MAIN MENU")!(PRCPOPT="PRCPW MAIN MENU") Q
 .   W !,"  deleting option: ",PRCPOPT
 .   ;     |-> clean up menus first
 .   S MENUDA=0 F  S MENUDA=$O(^DIC(19,"AD",PRCPDA,MENUDA)) Q:'MENUDA  S MENUDA1=0 F  S MENUDA1=$O(^DIC(19,"AD",PRCPDA,MENUDA,MENUDA1)) Q:'MENUDA1  D
 .   .   N DA,DIK S DIK="^DIC(19,"_MENUDA_",10,",DA(1)=MENUDA,DA=MENUDA1 D ^DIK Q
 .   ;     |-> remove option
 .   S DIK="^DIC(19,",DA=PRCPDA D ^DIK W "  deleted!"
 ;
 ;     |-> delete input, sort, and print templates
 W !!,"deleting INPUT TEMPLATES:" S PRCPOPT="PRCP" F  S PRCPOPT=$O(^DIE("B",PRCPOPT)) Q:$E(PRCPOPT,1,4)'="PRCP"!($E(PRCPOPT,1,5)="PRCPZ")  S PRCPDA=0 F  S PRCPDA=$O(^DIE("B",PRCPOPT,PRCPDA)) Q:'PRCPDA  D
 .   W !?9,PRCPOPT S DIK="^DIE(",DA=PRCPDA D ^DIK W "  deleted!"
 W !!,"deleting SORT TEMPLATES:" S PRCPOPT="PRCP" F  S PRCPOPT=$O(^DIBT("B",PRCPOPT)) Q:$E(PRCPOPT,1,4)'="PRCP"!($E(PRCPOPT,1,5)="PRCPZ")  S PRCPDA=0 F  S PRCPDA=$O(^DIBT("B",PRCPOPT,PRCPDA)) Q:'PRCPDA  D
 .   W !?9,PRCPOPT S DIK="^DIBT(",DA=PRCPDA D ^DIK W "  deleted!"
 W !!,"deleting PRINT TEMPLATES:" S PRCPOPT="PRCP" F  S PRCPOPT=$O(^DIPT("B",PRCPOPT)) Q:$E(PRCPOPT,1,4)'="PRCP"!($E(PRCPOPT,1,5)="PRCPZ")  S PRCPDA=0 F  S PRCPDA=$O(^DIPT("B",PRCPOPT,PRCPDA)) Q:'PRCPDA  D
 .   W !?9,PRCPOPT S DIK="^DIPT(",DA=PRCPDA D ^DIK W "  deleted!"
 ;
 ;     |-> remove file 446.2
 I $D(^PRCP(446.2,0)) W !!,"REMOVING FILE 446.2 ",$P($G(^DIC(446.2,0)),"^") S DIU="^PRCP(446.2,",DIU(0)="DEST" D EN^DIU2
 ;     |-> remove file 446.3
 I $D(^PRCP(446.3,0)) W !!,"REMOVING FILE 446.3 ",$P($G(^DIC(446.3,0)),"^") S DIU="^PRCP(446.3,",DIU(0)="DEST" D EN^DIU2
 W !! Q
 ;
TEXT ;;display help info at the top
 ;;This pre-init to the Generic Inventory Package will delete all PRCP
 ;;options (except PRCPZ) from the OPTION file.  It will also clean
 ;;up all menu pointers which reference the deleted PRCP options.
 ;; 
 ;;The pre-init to the Generic Inventory Package will also delete all
 ;;PRCP input templates, sort templates, and print templates except
 ;;the PRCPZ namespaced entries.
 ;; 
 ;;Also, if the files PHYSICAL INVENTORY COUNT WORK (file number 446.2)
 ;;or INVENTORY LABEL FORMAT (file number 446.3) exists, the pre-init
 ;;will delete them from the system.
