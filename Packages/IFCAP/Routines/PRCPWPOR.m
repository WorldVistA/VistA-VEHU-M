PRCPWPOR ;WISC/RFJ-transaction item report ;18 July 91
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
QUE ;     |-> called from posting/receiving routines, check on queuing
 K ZTSK I $D(IO("Q")) W !!,"QUEUING 'Transaction Item Report' to start NOW ..." D  Q
 .   K IO("Q") S ZTRTN="DQ^PRCPWPOR",ZTDESC="Transaction Item Report",ZTSAVE("PRCP*")="",ZTSAVE("^TMP($J,""POST"",")="",ZTSAVE("ZTREQ")="@",ZTDTH=$H D ^%ZTLOAD W " Finished."
 I IO'=IO(0) W !!,"Please wait while I print the 'Transaction Item Report'..."
DQ ;     |-> queue comes here
 N %,%H,%I,PRCP441V,PRCP445P,PRCP445V,PRCPDATE,PRCPFLAG,PRCPITEM,PRCPLIDA,PRCPOUT,PRCPPAGE,PRCPTRAN,PRCPX,SCREEN,X,Y
 D NOW^%DTC S Y=% X ^DD("DD") S PRCPDATE=Y,PRCPTRAN=$P($G(^PRCS(410,PRCPDA,0)),"^"),PRCP445V=$P($G(^PRCP(445,PRCP("I"),0)),"^",3),PRCP445V=$S(PRCP445V="W":"WHSE",PRCP445V="P":"PRIM",1:"")
 S PRCPPAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S PRCPLIDA=0 F %=0:0 S PRCPLIDA=$O(^PRCS(410,PRCPDA,"IT",PRCPLIDA)) Q:'PRCPLIDA  I $D(^(PRCPLIDA,0)) S PRCPX=^(0) D  Q:$D(PRCPFLAG)
 .   S PRCPITEM=+$P(PRCPX,"^",5),PRCP441V=$G(^PRC(441,+PRCPITEM,0)),PRCP445P=$G(^PRCP(445,PRCP("I"),1,PRCPITEM,0)),PRCPOUT=$P(PRCPX,"^",2)-$S(PRCP("DPTYPE")="W":$P(PRCPX,"^",12),1:$P(PRCPX,"^",13)) S:PRCPOUT<0 PRCPOUT=0
 .   S $P(PRCP445P,"^",7)=+$P(PRCP445P,"^",7),$P(PRCP445P,"^",8)=+$P(PRCP445P,"^",8),$P(PRCP445P,"^",20)=+$P(PRCP445P,"^",20)
 .   I '$D(^PRCP(445,PRCP("I"),1,PRCPITEM,0)) S $P(PRCP445P,"^",7,8)="?^?",$P(PRCP445P,"^",20)="?"
 .   S:$P(PRCPX,"^",14)'="" PRCPOUT=0 W:'SCREEN !
 .   W !,$P(PRCPX,"^"),?5,$P(PRCP441V,"^",5),?24,$J($P(PRCP445P,"^",7),8),$J($P(PRCP445P,"^",8),8),$J($P(PRCP445P,"^",20),8),$J(+$P(PRCPX,"^",2),8),$J(+$P(PRCPX,"^",12),8),$J(+$P(PRCPX,"^",13),8),$J(PRCPOUT,8)
 .   W !?5,$P(PRCP441V,"^",2)," (#",PRCPITEM,")",?59,"POSTED/REC'D:",$J(+$G(^TMP($J,"POST",PRCPLIDA)),8)
 .   I $P(PRCPX,"^",14)'="" W !?5,"ITEM HAS BEEN CANCELLED" W:$P(PRCPX,"^",14)["S" " AND SUBSTITUTED WITH LINE #(S): ",$P($P(PRCPX,"^",14),",",2,99)
 .   I $Y>(IOSL-4) D:SCREEN&($O(^PRCS(410,PRCPDA,"IT",PRCPLIDA))) P^PRCPU4 Q:$D(PRCPFLAG)  D:$O(^PRCS(410,PRCPDA,"IT",PRCPLIDA)) H
 W !! I '$D(PRCPFLAG) S %="",$P(%,"-",49)="" W:$D(PRCPREPT(1)) "REPORT PRINTED ",PRCPREPT(1) D END^PRCPUREP
 U IO(0) I PRCPREPT'=4 D ^%ZISC
 Q
 ;
 ;
H S %=PRCPDATE_"  PAGE "_PRCPPAGE,PRCPPAGE=PRCPPAGE+1 I PRCPPAGE'=2!(SCREEN) W @IOF
 W $C(13),"TRANSACTION '",PRCPTRAN,"' ITEM REPORT",?(80-$L(%)),%,!,"LINE",?24,$J(PRCP445V,8),$J(PRCP445V,8),$J(PRCP445V,8),$J("PRIM",8),?60,"WHSE",?65,"PRIMARY",!,"ITEM"
 W ?24,$J("QTY",8),$J("QTY",8),$J("QTY",8),$J("QTY",8),$J("QTY",8),$J("QTY",8),$J("QTY",8),!,"NO.",?5,"NSN/DESCRIPTION(#)",?24,$J("ON-HAND",8),$J("DUE-IN",8),$J("DUE-OUT",8),$J("ORDERED",8),$J("POSTED",8),$J("REC'D",8),$J("OUTST",8),!
 S %="",$P(%,"-",81)="" W % Q
 ;
 ;
REPASK ;     |-> ask to print report
 K PRCPREPT W !!!,"You now have the option to print a comprehensive list of items to post/receive"
 S DIR(0)="S^1:Do NOT Print;2:Before "_PRCPTYPE_";3:After "_PRCPTYPE_";4:Print Before and After "_PRCPTYPE_";",DIR("A")="Print TRANSACTION ITEM REPORT",DIR("B")="Do NOT Print"
 S DIR("?",1)="Enter 'Do NOT Print' to skip printing the report.",DIR("?",2)="Enter 'Before "_PRCPTYPE_"' to print the report before "_PRCPTYPE_"."
 S DIR("?",3)="Enter 'After "_PRCPTYPE_"' to print the report after "_PRCPTYPE_".",DIR("?",4)="Enter 'Print Before and After "_PRCPTYPE_"' to print the report both before",DIR("?")="and after "_PRCPTYPE_"." D ^DIR K DIR
 I Y'=1,Y'=2,Y'=3,Y'=4 K PRCPTYPE Q
 S PRCPREPT=Y I PRCPREPT'=1 W:PRCPREPT'=3 !,"THIS REPORT CANNOT BE QUEUED!" K %ZIS S:PRCPREPT=3 %ZIS="Q" D ^%ZIS I POP K PRCPREPT,PRCPTYPE Q
 W !,"I will ",$S(PRCPREPT=1:"NOT ",1:""),"print the report ",$S(PRCPREPT=2:"BEFORE",PRCPREPT=3:"AFTER",PRCPREPT=4:"BOTH BEFORE and AFTER",1:""),$S(PRCPREPT=1:"",1:" "_PRCPTYPE),!! K PRCPTYPE Q
