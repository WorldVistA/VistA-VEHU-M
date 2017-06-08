PRCPPOR ;WISC/RFJ-receiving ;31 July 91
 ;;4.0;IFCAP;**7**;9/23/93
 D ^PRCPUSEL Q:'$G(PRCP("I"))  I "PW"'[PRCP("DPTYPE") W !,"YOU MUST BE A WAREHOUSE OR PRIMARY INVENTORY POINT TO USE THIS OPTION." Q
 I $P($G(^PRCP(445,PRCP("I"),0)),"^",2)'="Y" W !,"THE INVENTORY POINT MUST BE KEEPING A PERPETUAL INVENTORY." Q
 I $P($G(^PRCP(445,PRCP("I"),0)),"^",6)'="Y" W !,"THE INVENTORY POINT MUST BE KEEPING A DETAILED TRANSACTION HISTORY." Q
 N %,%I,DI,FINAL,I,LOCK,OVERAGE,PARTLDA,PARTLDAT,PODA,PRCPFLAG,PRCPID,PURORDER,VENDORDA,X,XH,Y
 S X="" W ! D ESIG^PRCUESIG(DUZ,.X) I X'>0 Q
PO W !!,"Select PURCHASE ORDER: " R X:DTIME S:'$T X="^" Q:X["^"!(X="")  I X["?" D  G PO
 .   S D="G",DIC="^PRC(442,",DIC(0)="QECM",DIC("W")="D DICW^PRCPPOR",DIC("S")="I $D(^PRC(442,""G"",PRCP(""I""),+Y)) S %=$P($G(^PRCD(442.3,+$G(^PRC(442,+Y,7)),0)),U,2) I %>24,%<42" D IX^DIC K DIC
 S DIC="^PRC(442,",DIC(0)="EQMZ",DIC("S")="I $D(^PRC(442,""G"",PRCP(""I""),+Y)) S %=$P($G(^PRCD(442.3,+$G(^PRC(442,+Y,7)),0)),U,2) I %>24,%<42" D ^DIC K DIC G:Y<0 PO S PODA=+Y,PURORDER=$P($P(^PRC(442,PODA,0),"^"),"-",2)
 W !!,"LOCKING PURCHASE ORDER: ",PURORDER,"   and",!,"INVENTORY POINT: ",PRCP("IN") S LOCK(1)="^PRC(442,"_PODA_")",LOCK(2)="^PRCP(445,"_PRCP("I")_")" D LOCK^PRCPU4(.LOCK,1,10) G:'$D(LOCK) PO
 W !,"PURCHASE ORDER AND INVENTORY POINT LOCKED.  OTHER JOBS WILL NOT BE ABLE TO",!,"ACCESS THE PURCHASE ORDER OR INVENTORY POINT UNTIL RECEIVING IS COMPLETED."
 S VENDORDA=+$G(^PRC(442,PODA,1))_";PRC(440," I $P($G(^PRC(440,+VENDORDA,0)),"^")="" W !,"ERROR--MISSING OR INVALID VENDOR ON THIS PURCHASE ORDER." D LOCK^PRCPU4(.LOCK,0,0) G PO
 I '$D(^PRC(442,PODA,11,0)) S ^(0)="^442.11D^^"
 S DIC="^PRC(442,"_PODA_",11,",DA(1)=PODA,DIC(0)="QEAMZ",DIC("S")="I $P(^(0),U,16)=""""" W ! D ^DIC K DIC,DA I +Y<1 D LOCK^PRCPU4(.LOCK,0,0) G PO
 S PARTLDA=+Y,PARTLDAT=^PRC(442,PODA,11,PARTLDA,0)
 S FINAL=$S($P(PARTLDAT,"^",9)="F":1,1:0),OVERAGE=$S($P(PARTLDAT,"^",10)="Y":1,1:0) W:FINAL !?5,"-- FINAL PARTIAL --" W:OVERAGE !?5,"-- OVERAGE RECEIVED ON THIS ITEM --"
 W ! S XP="ARE YOU SURE YOU WANT TO UPDATE THE INVENTORY WITH THIS RECEIVING",XH="" F %=1:1 S X=$P($T(HELP+%),";",3,99) Q:X=""  S XH(%)=X W !,X
 W ! S %=1 D YN^PRCPU4 I %'=1 D LOCK^PRCPU4(.LOCK,0,0) G PO
 D ^PRCPPOR1,LOCK^PRCPU4(.LOCK,0,0) K ^TMP($J),PRCPFLAG G PO
 ;
 ;
DICW ;     |-> write id for purchase order lookup
 N %,PODATA S PODATA=^PRC(442,+Y,0) W "  ",$P(PODATA,U) S %=$P($G(^(1)),"^",15) W:% "  ",$E(%,4,5),"-",$E(%,6,7),"-",$E(%,2,3) S %=$P($G(^PRCD(442.5,+$P(PODATA,"^",2),0)),"^") W:%'="" "  ",%
 S %=$P($G(^PRCD(442.3,+$G(^PRC(442,+Y,7)),0)),"^") W !?7,$E(%,1,34),?45,"FCP: ",$P($P(PODATA,"^",3)," ",1),"    $ ",$P(PODATA,"^",15) Q
 ;
 ;
HELP ;help text
 ;;If you answer this question 'YES', the program will read all the receiving
 ;;data for this partial selected, and will update your inventory with the
 ;;quantities received, converted to your current unit of issue.
 ;; 
 ;;Note: The program will first check to make sure the packaging units have not
 ;;changed.  If they have, it will print a report notifying you of the changes.
 ;;You will then be allowed to either continue posting the receiving, or to exit
 ;;the receiving function, WITHOUT updating any files.
