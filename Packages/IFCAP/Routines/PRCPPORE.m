PRCPPORE ;WISC/RFJ-print errors before receiving ;1 Aug 91
 ;;4.0;IFCAP;;9/23/93
 N %,DATA,DATE,PAGE,SCREEN,TEXT,X,Y S Y="",$P(Y,"-",58)="" W !!?12,Y
 F %=0:1 S X=$P($T(TEXT+%),";",3,99) Q:X=""  W !?12,"| ",X,?68,"|"
 W !?12,Y
 K PRCPFLAG S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Purchase Order Packaging Errors",ZTRTN="DQ^PRCPPORE"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("P*")="",ZTSAVE("^TMP($J,""PRCPPOR"",")="",ZTSAVE("ZTREQ")="@"
DQ ;     |-> queue comes here
 D NOW^%DTC S Y=% X ^DD("DD") S DATE=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP
 U IO D HDR S LINEDA=0 F  S LINEDA=$O(^TMP($J,"PRCPPOR",LINEDA)) Q:'LINEDA!($D(PRCPFLAG))  S DATA=^TMP($J,"PRCPPOR",LINEDA),ERRORNUM=0 F  S ERRORNUM=$O(^TMP($J,"PRCPPOR",LINEDA,ERRORNUM)) Q:'ERRORNUM!($D(PRCPFLAG))  D
 .   I $Y>(IOSL-6) D:SCREEN P^PRCPU4 Q:$D(PRCPFLAG)  D HDR
 .   W !,$P(DATA,"^"),?7,$P($G(^PRC(441,+$P(DATA,"^",2),0)),"^",5),?29,$E($$DESCR^PRCPUX1(PRCP("I"),+$P(DATA,"^",2)),1,20),?51,"[#",+$P(DATA,"^",2),"]",?60,$J($P(DATA,"^",3),8),!?7,"DESCR: "
 .   K X S %=0 F I=1:1 S %=$O(^PRC(442,PODA,2,LINEDA,1,%)) Q:'%  S X(I)=^(%,0)
 .   F %=1:1 Q:'$D(X(%))  D  W $E(X(%),1,65),!?14 S:$E(X(%),66)'="" X(%+1)=$E(X(%),66,99)_$G(X(%+1)) I $Y>(IOSL-3) D:SCREEN P^PRCPU4 Q:$D(PRCPFLAG)  D HDR
 .   .   Q:$D(PRCPFLAG)  F I=1:1 Q:$E(X(%),I)'=" "
 .   .   S X(%)=$E(X(%),I,255)
 .   W !?2,"WARNING:" S %=$G(^TMP($J,"PRCPPOR",LINEDA,ERRORNUM)) F I=1:1 Q:$P(%,"|",I)=""  W ?11,$P(%,"|",I),!
 I '$D(PRCPFLAG) D END^PRCPUREP
 D ^%ZISC Q:$D(ZTQUEUED)
 W !!,"GO DIRECTLY TO JAIL.  DO NOT PASS GO.  DO NOT COLLECT 200 DOLLARS."
 W !!,"You will NOT be allowed to process this receiving until you review and correct",!,"ALL errors on the report!"
 Q
 ;
 ;
HDR S %=DATE_"    PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"RECEIVING ERROR REPORT",?(80-$L(%)),%,!,"FOR PURCHASE ORDER: ",PURORDER,?32,"PARTIAL: ",PARTLDA
 W !,"LI#",?7,"NSN",?29,"DESCRIPTION",?51,"[#MI]",?60,"QUANTITY ORDERED"
 S %="",$P(%,"-",80)="" W !,% Q
 ;
 ;
TEXT ;;                    WARNING!
 ;;The packaging multiples have changed for some items.
 ;;You should use the 'Procurement and Mandatory Sources'
 ;;edit type under the 'Enter/Edit Inventory Item Data'
 ;;menu option before proceeding with the receipt of this
 ;;purchase order.
 ;; 
 ;;You will now have the option to print the packaging
 ;;discrepancies.
