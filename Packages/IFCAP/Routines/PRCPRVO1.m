PRCPRVO1 ;WISC/RFJ-voucher summary (continued) ;15 Jun 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
PRINT ;     |-> print report
 S SCREEN=$$SCRPAUSE^PRCPUREP,PAGE=1 D NOW^%DTC S Y=% X ^DD("DD") S NOW=Y U IO
 S (TSUPISS,TSUPISSA,TSUPOTH,TSUPREC,TSUPRECA,ACCT,ACCTBAL,OPENBAL)=""
 F  S ACCT=$O(OPEN(ACCT)) Q:'ACCT!($G(PRCPFLAG))  D H D
 .   S (TACCISS,TACCISSA,TACCOTH,TACCREC,TACCRECA)=""
 .   S $P(OPENBAL,"^")=$P(OPENBAL,"^")+$P(OPEN(ACCT),"^"),$P(OPENBAL,"^",2)=$P(OPENBAL,"^",2)+$P(OPEN(ACCT),"^",2)
 .   S REFNO="" F  S REFNO=$O(^TMP($J,"PRCPRVOU",ACCT,REFNO)) Q:REFNO=""!($G(PRCPFLAG))  S DATE="" F  S DATE=$O(^TMP($J,"PRCPRVOU",ACCT,REFNO,DATE)) Q:'DATE!($G(PRCPFLAG))  D
 .   .   S TRANSID=0 F  S TRANSID=$O(^TMP($J,"PRCPRVOU",ACCT,REFNO,DATE,TRANSID)) Q:(TRANSID)=""!($G(PRCPFLAG))  S D=^(TRANSID) D
 .   .   .   S CC=$E($P(D,"^",3),1,4) I CC'="" S CC=CC_"/"_$P(D,"^",4)
 .   .   .   W !,REFNO,?8,$E(DATE,6,7),?13,$P(D,"^"),?27,$P(D,"^",2),?37,CC,?49,$J($FN($P(D,"^",5),"T+"),9),$$SHOWVALU($P(D,"^",6)),$$SHOWVALU($P(D,"^",7))
 .   .   .   S TRANSNO=$P(D,"^") I TRANSNO="OTHER" D SETVAR("TACCOTH")
 .   .   .   ;    |-> set totals for receipts
 .   .   .   I +TRANSNO,$P(TRANSNO,"-",2)="" D
 .   .   .   .   I $E($P(D,"^",2))="R" D SETVAR("TACCREC") Q
 .   .   .   .   D SETVAR("TACCRECA")
 .   .   .   ;    |-> set totals for issues
 .   .   .   I +TRANSNO,$P(TRANSNO,"-",2)'="" D
 .   .   .   .   I $E($P(D,"^",2))="R" D SETVAR("TACCISS") Q
 .   .   .   .   D SETVAR("TACCISSA")
 .   .   .   I $Y>(IOSL-4) D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  D H
 .   .   I '$G(PRCPFLAG),$Y>(IOSL-4) D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  D H
 .   .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>"
 .   I $G(PRCPFLAG) Q
 .   I $Y>(IOSL-11) D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  D H
 .   W !!?4,"TOTAL ACCT CODE ISSUES:",?49,$$SHOWTOTL("TACCISS")
 .   W !?4,"TOTAL ACCT CODE ISSUE ADJ:",?49,$$SHOWTOTL("TACCISSA")
 .   W !?4,"TOTAL ACCT CODE RECEIPTS:",?49,$$SHOWTOTL("TACCREC")
 .   W !?4,"TOTAL ACCT CODE RECEIPT ADJ:",?49,$$SHOWTOTL("TACCRECA")
 .   W !?4,"TOTAL ACCT CODE OTHER ADJ:",?49,$$SHOWTOTL("TACCOTH")
 .   S TACCT="" F %="TACCISS","TACCISSA","TACCOTH","TACCREC","TACCRECA" F P=1:1:3 S $P(TACCT,"^",P)=$P(TACCT,"^",P)+$P(@%,"^",P),X="TSUP"_$E(%,5,8),$P(@X,"^",P)=$P(@X,"^",P)+$P(@%,"^",P)
 .   W !!?4,"OPEN BALANCE FOR ACCT CODE '",ACCT,"':",?49,$J($FN($P($G(OPEN(ACCT)),"^"),"T+"),9),$$SHOWVALU($P($G(OPEN(ACCT)),"^",2))
 .   W !?4,"TOTALS FOR ACCT CODE '",ACCT,"':",?49,$$SHOWTOTL("TACCT")
 .   S %="",$P(%,"^")=$P($G(OPEN(ACCT)),"^")+$P(TACCT,"^"),$P(%,"^",2)=$P($G(OPEN(ACCT)),"^",2)+$P(TACCT,"^",2)
 .   S $P(ACCTBAL,"^")=$P(ACCTBAL,"^")+$P(%,"^"),$P(ACCTBAL,"^",2)=$P(ACCTBAL,"^",2)+$P(%,"^",2)
 .   W !?4,"CLOSING BALANCE FOR ACCT CODE '",ACCT,"':",?49,$J($FN($P(%,"^"),"T+"),9),$$SHOWVALU($P(%,"^",2))
 .   I $O(^TMP($J,"PRCPRVOU",ACCT)) D:SCREEN P^PRCPU4
 I $G(PRCPFLAG) D Q Q
 I $Y>(IOSL-12) D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  S ACCT="END OF REPORT" D H
 W !!,"** TOTAL SUPPLY ISSUES:",?49,$$SHOWTOTL("TSUPISS")
 W !,"** TOTAL SUPPLY ISSUE ADJ:",?49,$$SHOWTOTL("TSUPISSA")
 W !,"** TOTAL SUPPLY RECEIPTS:",?49,$$SHOWTOTL("TSUPREC")
 W !,"** TOTAL SUPPLY RECEIPT ADJ:",?49,$$SHOWTOTL("TSUPRECA")
 W !,"** TOTAL OTHER ADJ:",?49,$$SHOWTOTL("TSUPOTH")
 S TACCT="" F %="TSUPISS","TSUPISSA","TSUPOTH","TSUPREC","TSUPRECA" F P=1:1:3 S $P(TACCT,"^",P)=$P(TACCT,"^",P)+$P(@%,"^",P)
 W !!,"** TOTALS FOR SUPPLY:",?49,$$SHOWTOTL("TACCT")
 W !!,"** OPENING BALANCE FOR SUPPLY:",?49,$J($FN($P(OPENBAL,"^"),"T+"),9),$$SHOWVALU($P(OPENBAL,"^",2))
 W !,"** CLOSING BALANCE FOR SUPPLY:",?49,$J($FN($P(ACCTBAL,"^"),"T+"),9),$$SHOWVALU($P(ACCTBAL,"^",2))
 D END^PRCPUREP
Q D ^%ZISC K ^TMP($J,"PRCPRVOU") Q
 ;
 ;
SETVAR(V1) ;set total variable v1
 F %=1:1:3 S $P(@V1,"^",%)=$P(@V1,"^",%)+$P(D,"^",%+4)
 Q
 ;
 ;
SHOWTOTL(V1) ;print totals for variable v1
 Q $J($FN($P(@V1,"^"),"T+"),9)_$$SHOWVALU($P(@V1,"^",2))_$$SHOWVALU($P(@V1,"^",3))
 ;
 ;
SHOWVALU(V1) ;show value
 N % S %="+" S:+V1=0 %=" " I V1<0 S V1=-V1,%="-"
 Q $J(V1,10,2)_%
 ;
 ;
H ;heading
 S %=NOW_"  PAGE: "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"VOUCHER SUMMARY REPORT: ",MONTH,?(80-$L(%)),%
 W !?4,"ACCOUNT CODE: ",ACCT,?30,"STA-INVENTORY POINT: ",PRC("SITE"),"-",PRCP("IN")
 W !,"REF #",?8,"DT",?13,"STA-FCP-2237",?27,"TRANSID",?37,"  CC/SA",?54,"QTY",?63,"INV $",?73,"SELL $"
 S %="",$P(%,"-",81)="" W !,%
 Q
