PRCPRCA1 ;WISC/RFJ-catalog/order form (print) ;26 Aug 91
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
DQ ;     |-> queue comes here
 K ^TMP($J,"PRCPRCAT")
 S INVPT=0 F  S INVPT=$O(PRCPD(INVPT)) Q:'INVPT  D
 .   ;     |-> get the inventory point the items are being ordered from
 .   ;     |-> issues:
 .   ;     |-> from = printing from whse;  to = printing from primary
 .   ;     |-> catalog:
 .   ;     |-> from = printing from primary;  to = printing from second
 .   I PRCPTYPE="FROM" S TOINV=INVPT,FROMINV=PRCP("I")
 .   I PRCPTYPE="TO" S TOINV=PRCP("I"),FROMINV=INVPT
 .   S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,TOINV,1,ITEMDA)) Q:'ITEMDA  S D=$G(^(ITEMDA,0)) I D'="" D
 .   .   ;     |-> if secondary, use primary as vendory
 .   .   I PRCP("DPTYPE")="S" S PRCPVEND=FROMINV_";PRCP(445,"
 .   .   I '$$GETVEN^PRCPUVEN(TOINV,ITEMDA,PRCPVEND,1) Q
 .   .   S D1=$G(^PRCP(445,FROMINV,1,ITEMDA,0)) I D1="" Q
 .   .   S COST=$P(D1,"^",22) I $P(D1,"^",15)>COST S COST=$P(D1,"^",15)
 .   .   S DESCR=$$DESCR^PRCPUX1(TOINV,ITEMDA),UNITI=$$UNIT^PRCPUX1(TOINV,ITEMDA) S:DESCR="" DESCR=" "
 .   .   S GROUPNM=$$GROUPNM^PRCPEGRP(+$P(D,"^",21)) I GROUPNM'="" S GROUPNM=$E(GROUPNM,1,15)_" (#"_$P(D,"^",21)_")"
 .   .   S:GROUPNM="" GROUPNM=" "
 .   .   S ^TMP($J,"PRCPRCAT",FROMINV,TOINV,GROUPNM,$E(DESCR,1,20),ITEMDA)=$E(DESCR,1,50)_"^"_$$NSN^PRCPUX1(ITEMDA)_"^"_UNITI_"^"_$P(D,"^",10)_"^"_$P(D,"^",9)_"^"_COST
 ;
 D NOW^%DTC S Y=% X ^DD("DD") S NOW=Y,SCREEN=$$SCRPAUSE^PRCPUREP U IO
 S FROMINV=0 F  S FROMINV=$O(^TMP($J,"PRCPRCAT",FROMINV)) Q:'FROMINV!($G(PRCPFLAG))  D
 .   S FROMINVN=$$INVNAME^PRCPUX1(FROMINV)
 .   S TOINV=0 F  S TOINV=$O(^TMP($J,"PRCPRCAT",FROMINV,TOINV)) Q:'TOINV!($G(PRCPFLAG))  D
 .   .   S TOINVN=$$INVNAME^PRCPUX1(TOINV),PAGE=1 D H
 .   .   S GROUPNM="" F  S GROUPNM=$O(^TMP($J,"PRCPRCAT",FROMINV,TOINV,GROUPNM)) Q:GROUPNM=""!($G(PRCPFLAG))  D
 .   .   .   I $Y>(IOSL-7) D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  D H
 .   .   .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>" Q
 .   .   .   W !!?5,"GROUP CATEGORY: ",GROUPNM
 .   .   .   S DESCR="" F  S DESCR=$O(^TMP($J,"PRCPRCAT",FROMINV,TOINV,GROUPNM,DESCR)) Q:DESCR=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPRCAT",FROMINV,TOINV,GROUPNM,DESCR,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S D=^(ITEMDA) D
 .   .   .   .   I $Y>(IOSL-6) D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  D H
 .   .   .   .   W !!,ITEMDA,?7,$P(D,"^"),?60,$P(D,"^",2),?80,$J($P(D,"^",3),13),$J($P(D,"^",4),13),$J($P(D,"^",5),13),$J($P(D,"^",6),12,3)
 .   .   .   .   I PRCP("DPTYPE")="P",PRCPREPT="CAT" D  I $G(PRCPFLAG) Q
 .   .   .   .   .   S %=$$STORAGE^PRCPESTO(PRCP("I"),ITEMDA) I %="?" Q
 .   .   .   .   .   W !?7,"MAIN STORAGE: ",%
 .   .   .   .   .   S Y=0 F  S Y=$O(^PRCP(445,PRCP("I"),1,ITEMDA,1,Y)) Q:'Y!($G(PRCPFLAG))  S X=+$P($G(^(Y,0)),"^") I X D
 .   .   .   .   .   .   W "  **",$$STORELOC^PRCPESTO(Y) I $X>110 W !?7
 .   .   .   .   .   .   I $Y>(IOSL-5) D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  D H
 .   .   .   .   W !?2,"DAY: "
 .   .   .   .   S X="" F %=1:1:PRCPEND W "| ",$J(%,2) S X=X_"|   "
 .   .   .   .   W "|",!?2,"QTY: ",X,"|"
 .   .   I $G(PRCPFLAG) Q
 .   .   S IOM=132 D END^PRCPUREP
 K ^TMP($J,"PRCPRCAT") D ^%ZISC Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),$S(PRCPREPT="ISS":"ISSUE BOOK",1:"CATALOG")," ORDER FORM FOR DATE: ",PRCPDATE,?(132-$L(%)),%
 W !?5,"FROM INVENTORY POINT: ",FROMINVN,?60,"TO INVENTORY POINT: ",TOINVN
 W !,?93,$J("STANDARD",13),$J("NORMAL",13),!,"MI#",?7,"DESCRIPTION",?60,"NSN",?80,$J("UNIT/IS",13),$J("REORD PT",13),$J("STOCK LVL",13),$J("UNIT COST",12)
 S %="",$P(%,"-",133)="" W !,%
 Q
