PRCPEAR0 ;WISC/RFJ-print register approval form ;15 Apr 92
 ;;4.0;IFCAP;;9/23/93
 ;
 ;     |-> option to print unapproved adjustments.
 ;
 D ^PRCPUSEL Q:'$G(PRCP("I"))  I PRCP("DPTYPE")'="W" W !,"ONLY THE WAREHOUSE CAN USE THIS OPTION." Q
 N %I,ADJNO,COUNT,PRCPALL,PRCPBUIL,PRCPMULT,TOTAL,X,Y
 ;
 ;     |-> select a list of adjustments to print or all adjustments.
 ;     |-> $g(prcpbuil) is true if all adjustments are selected.
 ;
 K ^TMP($J,"ADJ") S PRCPBUIL=1 W !!,"To select ALL adjustments, press RETURN."
 S TOTAL=0 F  D ADJUSTNO^PRCPEAAP Q:ADJNO["^"  S ^TMP($J,"ADJ",ADJNO)="",TOTAL=TOTAL+1
 I $O(^TMP($J,"ADJ",""))="" S XP="Do you want to select ALL adjustments",XH="Enter 'YES' to select ALL adjustments, 'NO' or '^' to exit.",%=1 W ! D YN^PRCPU4 Q:%=0  I %=1 S PRCPALL=1
 I '$G(PRCPALL),$O(^TMP($J,"ADJ",""))="" Q
 ;
 ;     |-> if more than one adjustment is selected, ask to print one
 ;     |-> report or multiple reports.
 ;
 S PRCPMULT=1 I $G(PRCPALL)!(TOTAL>1) D  I %<1 Q
 .   S XP="DO YOU WANT TO PRINT A SEPARATE REPORT FOR EACH ADJUSTMENT (THIS WILL",XP(1)="USE A LOT OF PAPER)"
 .   S XH="ENTER 'YES' TO PRINT EACH UNAPPROVED ADJUSTMENT ON A SINGLE PIECE OF PAPER,",XH(1)="      'NO' TO PRINT ALL UNAPPROVED ADJUSTMENTS ON THE SAME REPORT."
 .   S %=2 W ! D YN^PRCPU4 I %=2 K PRCPMULT
 ;
DEVICE ;     |-> call this entry point to print the data already stored in the
 ;     |-> tmp global.
 ;
 S %ZIS="Q" W ! D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK,^TMP($J,"ADJ") Q
 .   S ZTDESC="Adjustment Approval Form",ZTRTN="DQ^PRCPEAR0"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("^TMP($J,""ADJ"",")="",ZTSAVE("^TMP($J,""PRCPADJ"",""ITR"",")="",ZTSAVE("ZTREQ")="@"
 ;
DQ ;     |-> queue starts here.
 ;     |-> print the report from ^tmp($j,"prcpadj","itr",adjustment
 ;     |->     number,entry number) or build it if $g(prcpbuil)
 ;
 N ACCT,ADJDT,DA,DATA,INVPT,ITEMDATA,NOW,NSN,PAGE,PRCPFLAG,PRCPMSG,SCREEN,TOTAL,TRANID,VALUEINV,VALUESAL,VOUCHER,X,Y
 ;
 ;     |-> build adjustment numbers if $g(prcpbuil).
 ;
 I $G(PRCPBUIL) D BUILD^PRCPEAR1
 ;
 ;     |-> start printing report.
 ;
 D NOW^%DTC S Y=% X ^DD("DD") S NOW=Y,PAGE=0,SCREEN=$$SCRPAUSE^PRCPUREP U IO K ^TMP($J,"ACCT")
 S TRANID="A" F  S TRANID=$O(^TMP($J,"PRCPADJ","ITR",TRANID)) Q:$E(TRANID)'="A"!($D(PRCPFLAG))  K ADJDT,INVPT S DA=0 F  S DA=$O(^TMP($J,"PRCPADJ","ITR",TRANID,DA)) Q:'DA!($D(PRCPFLAG))  D
 .   S DATA=$G(^PRCP(445.2,DA,0)) I DATA="" Q
 .   S VOUCHER=$P(DATA,"^",15) I $G(PRCPMULT),'$D(ADJDT) S Y=$P(DATA,"^",17) I +Y X ^DD("DD") S ADJDT=Y
 .   I $G(PRCPMULT),'$D(INVPT),$P(DATA,"^",18) S INVPT=$$INVNAME^PRCPUX1($P(DATA,"^",18))
 .   I PAGE=0 S PAGE=1 D H
 .   ;
 .   ;     |-> no po/2237 number or issue/nonissue, so it must be other
 .   ;
 .   I $G(PRCPMULT),'$D(PRCPMSG),$P(DATA,"^",19)="",$P(DATA,"^",11)="" S PRCPMSG="YOU SHOULD MANUALLY CREATE AND TRANSMIT THE CALM TRANSACTION 928.01 TO AUSTIN."
 .   S ITEMDATA=$G(^PRC(441,+$P(DATA,"^",5),0)),NSN=$P(ITEMDATA,"^",5),ACCT=$$ACCT^PRCPUX1($E(NSN,1,4))
 .   W !!,NSN,?19,$E($$DESCR^PRCPUX1(PRCP("I"),$P(DATA,"^",5)),1,28),?49,"#",$P(DATA,"^",5),?60,"ACCT: ",ACCT,?73,$J($$INITIALS^PRCPUREP($P(DATA,"^",16)),6)
 .   S VALUEINV=$J($P(DATA,"^",7)*$P(DATA,"^",8),0,2),VALUESAL=$J($P(DATA,"^",7)*$P(DATA,"^",9),0,2)
 .   I $P(DATA,"^",22)'="" S VALUEINV=$J($P(DATA,"^",22),0,2),VALUESAL=$J($P(DATA,"^",23),0,2)
 .   S ^TMP($J,"ACCT",ACCT)=$G(^TMP($J,"ACCT",ACCT))+VALUEINV
 .   W !,$P(DATA,"^",2),?13,$P(DATA,"^",19),?33,$J($P(DATA,"^",6),8),$J($P(DATA,"^",7),11),$J(VALUESAL,14,2),$J(VALUEINV,14,2)
 .   I $D(^PRCP(445.2,DA,1)) W !,$P(^(1),"^")
 .   I $Y>(IOSL-7) D:$G(SCREEN) P^PRCPU4 Q:$D(PRCPFLAG)  D H
 .   I '$D(PRCPFLAG),$G(PRCPMULT),'$O(^TMP($J,"PRCPADJ","ITR",TRANID,DA)) D END^PRCPEAR1 Q:$D(PRCPFLAG)
 I $D(PRCPFLAG) S PRCPMULT=1
 I '$D(PRCPMULT) D END^PRCPEAR1
 D ^%ZISC K ^TMP($J,"PRCPADJ","ITR"),^TMP($J,"ACCT") Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"ADJUSTMENT APPROVAL FORM FROM ",PRCP("IN"),?(80-$L(%)),%
 I $D(INVPT) W !?5,"DISTRIBUTION TO: ",INVPT
 I $D(ADJDT) W !?5,"ADJUSTMENT DATE: ",ADJDT,?50,"VOUCHER: ",VOUCHER
 W !,"NSN",?19,"DESCRIPTION",?49,"[#MI]",?60,"ACCT CODE",?72,"INITIALS"
 S %="",$P(%,"-",81)="" W !,"TRANSID",?13,"TRANS./P.O.",?38,"U/I",?43,$J("QUANTITY",9),$J("SELL VALUE",14),$J("INV VALUE",14),!,%
 Q
