PRCPOR0 ;WISC/RFJ-distribution duein and dueout reports ;22 Oct 92
 ;;4.0;IFCAP;;9/23/93
 D ^PRCPUSEL Q:'$G(PRCP("I"))
 I PRCP("DPTYPE")="W" W !,"THIS OPTION SHOULD ONLY BE USED BY PRIMARIES AND SECONDARIES." Q
 N %,TYPE,UPDATE
 S TYPE="OUT" I PRCP("DPTYPE")="S" S TYPE="IN"
 W !!,"DUE-",TYPE," REPORT for inventory point ",PRCP("IN")
 I $$KEY^PRCPUREP("PRCP"_$S(TYPE="IN":"2",1:"")_" MGRKEY",DUZ) D  Q:%<1  S:%=1 UPDATE=1
 .   W !!,"You have the option to update the DUE-"_TYPE_"'s to the calculated values.",!,"If you choose to do this, the distribution order file and inventory point will"
 .   W !,"be locked and NO orders can be placed and NO data in the inventory point can be",!,"changed until the program finishes.  Therefore, I suggest this be done outside",!,"of normal business hours."
 .   S XP="Do you want to update the inventory DUE-"_TYPE_"'s"
 .   S XH="Enter 'YES' to update the DUE-"_TYPE_"'s, 'NO' to only print the report, '^' to exit."
 .   S %=2 W ! D YN^PRCPU4
 W ! I $G(UPDATE) W !,"In order to update the DUE-",TYPE,"'s, this report must be queued !"
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  Q
 .   S ZTDESC="Distribution Order Due-"_TYPE_" Report",ZTRTN="DQ^PRCPOR0"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("TYPE")="",ZTSAVE("UPDATE")="",ZTSAVE("ZTREQ")="@"
 .   D ^%ZTLOAD
 I $G(UPDATE) W !,"I am not updating the DUE-",TYPE,"'s since this report has not be QUEUED !" K UPDATE
 W !!,"<*> please wait <*>"
DQ ;     |-> queue comes here
 N %,%I,D,DATA,INVPT,ITEMDA,ITEMDATA,NOW,ORDDATA,ORDERNO,PAGE,PRCPFLAG,PRIMARDA,QTY,SCREEN,SECONDA,TOTAL,VDA,VDATA,XREF,X,Y
 K ^TMP($J,"PRCPOR0")
 I $G(UPDATE) L +^PRCP(445.3),+^PRCP(445,PRCP("I"),1)
 S XREF="AC" I PRCP("DPTYPE")="S" S XREF="AD"
 S ORDERNO=0 F  S ORDERNO=$O(^PRCP(445.3,XREF,PRCP("I"),ORDERNO)) Q:'ORDERNO  S ORDDATA=$G(^PRCP(445.3,ORDERNO,0)) I ORDDATA'="",$P(ORDDATA,"^",6)'="" D
 .   S PRIMARDA=+$P(ORDDATA,"^",2),SECONDA=+$P(ORDDATA,"^",3)
 .   S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.3,ORDERNO,1,ITEMDA)) Q:'ITEMDA  S ITEMDATA=$G(^PRCP(445.3,ORDERNO,1,ITEMDA,0)) I ITEMDATA'="" D
 .   .   S QTY=$P(ITEMDATA,"^",2)
 .   .   S VDATA=$$GETVEN^PRCPUVEN(SECONDA,ITEMDA,PRIMARDA_";PRCP(445,",1)
 .   .   S ^TMP($J,"PRCPOR0",ITEMDA,ORDERNO)=PRIMARDA_"^"_SECONDA_"^"_(QTY*$P(VDATA,"^",4))_"^"_QTY_"^"_$$UNIT^PRCPUX1(PRIMARDA,ITEMDA,"/")_"^"_$$UNIT^PRCPUX1(SECONDA,ITEMDA,"/")_"^"_$P(VDATA,"^",4)
 ;
 ;     |-> print report from tmp global
 K ^TMP($J,"PRCPUPDATE")
 D NOW^%DTC S Y=% X ^DD("DD") S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PRCPOR0",ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  D
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   S QTY=+$P(ITEMDATA,"^",20) I TYPE="IN" S QTY=+$P(ITEMDATA,"^",8)
 .   W !!,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,25),?27,"#",ITEMDA,?35,$J($$UNIT^PRCPUX1(PRCP("I"),ITEMDA,"/"),9),$J(+$P(ITEMDATA,"^",7),15),$J(QTY,21)
 .   S (ORDERNO,TOTAL)=0 F  S ORDERNO=$O(^TMP($J,"PRCPOR0",ITEMDA,ORDERNO)) Q:'ORDERNO!($G(PRCPFLAG))  S DATA=^(ORDERNO) D
 .   .   S D=$G(^PRCP(445.3,ORDERNO,0)),Y=$P($P(D,"^",4),".") S:'Y Y="?" X:Y ^DD("DD")
 .   .   W !?5,$P(D,"^"),?12,Y,?24,$S($P(D,"^",8)="R":"REGU",$P(D,"^",8)="C":"CALL",$P(D,"^",8)="E":"EMER",1:"----"),?29,$S($P(D,"^",6)="R":"RELE",$P(D,"^",6)="B":"BACK",1:"----")
 .   .   S INVPT=$P(DATA,"^") I TYPE="OUT" S INVPT=$P(DATA,"^",2)
 .   .   W ?36,$E($P($$INVNAME^PRCPUX1(INVPT),"-",2),1,16)
 .   .   I TYPE="OUT" W ?69,$J(+$P(DATA,"^",4),11) S TOTAL=TOTAL+$P(DATA,"^",4)
 .   .   I TYPE="IN" W ?53,$J($P(DATA,"^",6),9),$J($P(DATA,"^",7),7),$J(+$P(DATA,"^",3),11) S TOTAL=TOTAL+$P(DATA,"^",3)
 .   .   I $Y>(IOSL-5) D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  D H
 .   I $G(PRCPFLAG) Q
 .   I +TOTAL'=+QTY W !?5,"** CURRENT QUANTITY DUE-",TYPE,$S($G(UPDATE):" IS NOW EQUAL TO",1:" DOES NOT MATCH")," CALCULATED QUANTITY DUE-",TYPE," **"
 .   I $G(UPDATE) S ^TMP($J,"PRCPUPDATE",ITEMDA)=TOTAL
 .   I $Y>(IOSL-5) D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  D H
 ;
 ;     |-> update dueins or dueouts
 I $G(UPDATE) D
 .   S %=$S(TYPE="IN":8,1:20)
 .   S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  I $D(^(ITEMDA,0)) S $P(^PRCP(445,PRCP("I"),1,ITEMDA,0),"^",%)=$G(^TMP($J,"PRCPUPDATE",ITEMDA))
 .   L -^PRCP(445.3),-^PRCP(445,PRCP("I"),1)
 I '$G(PRCPFLAG) D END^PRCPUREP
 D ^%ZISC
 K ^TMP($J,"PRCPOR0"),^TMP($J,"PRCPUDPATE")
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"DUE-",TYPE," ITEM REPORT FOR ",PRCP("IN"),?(80-$L(%)),%
 W !,"ITEM DESCRIPTION",?27,"#MI",?35,$J("UNIT/IS",9),$J("QTY ON-HAND",15),$J("QTY DUE-"_TYPE,21)
 W !?5,"ORD#",?12,"DATE ORD",?24,"TYPE",?29,"STAT",?36,$S(TYPE="IN":"FROM",1:"TO")," INVPT"
 I TYPE="OUT" W ?69,"QTY DUE-OUT"
 I TYPE="IN" W ?55,"UNIT/REC",?67,"CF",?70,"QTY DUE-IN"
 S %="",$P(%,"-",81)="" W !,% Q
