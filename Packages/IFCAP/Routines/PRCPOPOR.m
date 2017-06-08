PRCPOPOR ;WISC/RFJ-post distribution order error report ;28 Sep 92
 ;;4.0;IFCAP;**7**;9/23/93
 Q
 ;
 ;
TOP ;come here to print error report during posting distribution order
 W !!,"Errors have been found during the check.  Please enter the device for printing",!,"the error report."
 N PRCPDATA S PRCPDATA=^PRCP(445.3,ORDERNO,0)
 S %ZIS="Q" D ^%ZIS G:POP CONT I $D(IO("Q")) D  D ^%ZISC G CONT
 .   S ZTDESC="Primary Post Distribution Order",ZTRTN="DQ^PRCPOPOR"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("^TMP($J,")="",ZTSAVE("ZTREQ")="@"
 .   D ^%ZTLOAD K IO("Q"),ZTSK
 .   Q
 W !!,"<*> please wait <*>" D DQ
CONT ;continue with posting
 I $G(OVERPOST) D  I %=0 S PRCPQUIT=1 Q
 .   S XP="The quantity on-hand is less than the quantity to post for some items.",XP(1)="Do you want to over post into the NEGATIVE"
 .   S XH="Enter 'YES' to post the quantity on-hand into the negative.",XH(1)="Enter 'NO' to backorder quantities not available or '^' to exit.",%=2 W !! D YN^PRCPU4 I %=0 Q
 .   S OVERPOST=$S(%=1:1,1:0)
 S XP="ARE YOU SURE YOU WANT TO POST THIS ORDER",XH="ENTER 'YES' TO START POSTING THE ORDER, 'NO' OR '^' TO EXIT.",%=2 W !! D YN^PRCPU4 I %=1 Q
 S PRCPQUIT=1 Q
 ;
 ;
DQ ;     |-> print error report
 N %,%I,DATEORD,ERROR,ITEMDA,NOW,PAGE,PRCPFLAG,SCREEN,Y
 S Y=$P(PRCPDATA,"^",4) X ^DD("DD") S DATEORD=Y
 D NOW^%DTC S Y=% X ^DD("DD") S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"ERROR",ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  D
 .   W !,ITEMDA,?9,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,30),?44,$J(+$P($G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),"^",7),12,0),$J(^TMP($J,"ERROR",ITEMDA),12,0),$J(+$G(^TMP($J,"POST",ITEMDA)),12,0)
 .   S ERROR=0 F  S ERROR=$O(^TMP($J,"ERROR",ITEMDA,ERROR)) Q:'ERROR!($G(PRCPFLAG))  S %=^(ERROR) D
 .   .   W !?7,"*",?9,%
 .   .   I $Y>(IOSL-4) D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  D H
 .   I $Y>(IOSL-4) D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  D H
 I '$G(PRCPFLAG) D END^PRCPUREP
 D ^%ZISC
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"POST DISTRIBUTION ORDER ERROR REPORT",?(80-$L(%)),%,!?9,"ORDER NUMBER: ",$P(PRCPDATA,"^"),?30,"DATE ORDERED: ",DATEORD,!,"ITEM#",?9,"DESCRIPTION",?44,$J("QTY ONHAND",12),$J("QTY ORDER",12),$J("QTY POST",12)
 S %="",$P(%,"-",81)="" W !,% Q
