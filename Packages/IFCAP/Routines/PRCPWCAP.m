PRCPWCAP ;WISC/RFJ-calculate and store supply fund cap ;15 Oct 91
 ;;4.0;IFCAP;**7**;9/23/93
 N %,%I,CAPDUEIN,CAPONHND,D,D0,DA,DI,DQ,ERROR,FCPDATA,ITEMDA,NOW,SCREEN,VALUE,X,Y
 D ^PRCPUSEL Q:'$G(PRCP("I"))  I PRCP("DPTYPE")'="W" W !,"ONLY THE WAREHOUSE CAN CALCULATE THE SUPPLY FUND CAP!" Q
 I '$D(^PRC(420,PRC("SITE"),0)) W !!,"NO ENTRY INTO FILE 420 FOR THIS STATION: ",PRC("SITE") Q
 S FCPDATA=$P(^PRC(420,PRC("SITE"),0),"^",3,6) ;supplyfundcap^inventoryvalue^dueinvalue^capavailable
 S DA=$O(^DIC(19,"B","PRCP CAP RECALC NIGHTLY",0)) I DA D
 .   W !! F %=1:1 S X=$P($T(TEXT+%),";",3,99) Q:X=""  W !,X
 .   S (DIE,DIC)="^DIC(19,",DR="200Queued to run NIGHTLY starting with DATE@TIME;201Device for printing NIGHTLY queued task;202///1D" W ! D ^DIE K DA,DIC,DIE,DR
 S XP="THIS OPTION WILL RECALCULATE THE SUPPLY FUND CAP FOR STATION: "_PRC("SITE"),XP(1)="ARE YOU SURE YOU WANT TO CONTINUE:",XH="ENTER 'YES' TO RECALCULATE THE CAP, 'NO' OR '^' TO EXIT.",%=2 W !! D YN^PRCPU4 Q:%'=1
 W ! S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Recalculate Supply Fund Cap",ZTRTN="DQ^PRCPWCAP"
 .   S ZTSAVE("PRC*")="",ZTSAVE("FCP*")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;queue comes here
 D NOW^%DTC S Y=% X ^DD("DD") S NOW=Y,SCREEN=$$SCRPAUSE^PRCPUREP,(ITEMDA,CAPDUEIN,CAPONHND)=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S D=$G(^(ITEMDA,0)) I D'="" D
 .   S CAPDUEIN=CAPDUEIN+($P(D,"^",8)*$P(D,"^",15))
 .   S VALUE=$P(D,"^",27) I VALUE="" S VALUE=$J(($P(D,"^",7)+$P(D,"^",19))*$P(D,"^",22),0,2)
 .   S CAPONHND=CAPONHND+VALUE
 U IO S %=NOW_"  PAGE 1" I SCREEN W @IOF
 W $C(13),"SUPPLY FUND CAP CALCULATION",?(80-$L(%)),%,!?3,"FOR STATION NUMBER: ",PRC("SITE"),!?5,"WHSE INVENTORY POINT: ",PRCP("IN") S %="",$P(%,"-",81)=""
 W !,% S %="",$P(%,"-",21)="" W !!?27,"PREVIOUS VALUES",?61,"NEWLY STORED VALUES",!?22,%,?60,%
 W !!?3,"TOTAL CAP FOR FY",PRC("FY"),":",$J($FN($P(FCPDATA,"^"),"T,",2),20),?60,$J($FN($P(FCPDATA,"^"),"T,",2),20),!?3,"TOTAL DUE-IN VALUE:",$J($FN(-$P(FCPDATA,"^",3),"T,",2),20),?60,$J($FN(-CAPDUEIN,"T,",2),20)
 S %="",$P(%,"=",21)="" W !?3,"TOTAL ONHAND VALUE:",$J($FN(-$P(FCPDATA,"^",2),"T,",2),20),?60,$J($FN(-CAPONHND,"T,",2),20),!?22,%,?60,%,!,"TOTAL FUNDS AVAILABLE:",$J($FN($P(FCPDATA,"^",4),"T,",2),20)
 S %=$P(FCPDATA,"^")-CAPDUEIN-CAPONHND W ?60,$J($FN(%,"T,",2),20)
 D ENTERCAP^PRCFWCAP(CAPONHND_"^"_CAPDUEIN) I $D(ERROR) W !!,"*** TOTAL CAP AVALIABLE COULD NOT BE UPDATED ***"
 D END^PRCPUREP,^%ZISC Q
 ;
NIGHTLY ;queue every night comes here
 D NOW^%DTC S PRC("FY")=$E(X,2,3) I $E(X,4,5)>9 S PRC("FY")=$E(X,2,3)+1
 S PRC("SITE")=0 F  S PRC("SITE")=$O(^PRC(420,PRC("SITE"))) Q:'PRC("SITE")  S PRCP("I")=0 F  S PRCP("I")=$O(^PRCP(445,"AC","W",PRCP("I"))) Q:'PRCP("I")  S D=$$INVNAME^PRCPUX1(PRCP("I")) I +D=PRC("SITE") D  Q
 .   S PRCP("IN")=$P($P(D,"^"),"-",2,99),FCPDATA=$P($G(^PRC(420,PRC("SITE"),0)),"^",3,6) D DQ
 Q
 ;
TEXT ;;display info
 ;;You can use the next two prompts to set up the option to run on a
 ;;nightly recurring basis.  If you do not want the report to run nightly,
 ;;you may leave the fields blank.  Example:
 ;; 
 ;;    Queued to run NIGHTLY starting with DATE@TIME: TODAY@23:00
 ;;    **note: please enter a TIME in the late evening or early morning**
 ;;    Device for printing NIGHTLY queued task: SUPPLY;80
 ;; 
 ;;will automatically queue the report to run on the 80 column supply
 ;;printer every night at 11:00pm starting TODAY.
