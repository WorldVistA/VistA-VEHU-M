PRCPRPID ;WISC/RFJ-distribution order print ;10 Sep 91 [ 09/18/94  11:25 AM ]
 ;;4.0;IFCAP;;9/23/93
 D ^PRCPUSEL Q:'$G(PRCP("I"))  I PRCP("DPTYPE")="W" W !,"This option is for distribution orders from a primary to a secodary!" Q
 N X,Y I PRCP("DPTYPE")="P" S DIC("S")="I $P(^(0),U,2)=PRCP(""I""),$P(^(0),U,6)'="""",""RB""[$P(^(0),U,6)"
 E  S DIC("S")="I $P(^(0),U,3)=PRCP(""I"")&(""RB""[$P(^(0),U,6)!($P(^(0),U,6)=""""))"
 K ^TMP($J,"O") W !!,"To select ALL Distribution Orders, press RETURN" F  S DIC("A")="Select DISTRIBUTION ORDER: ",DIC="^PRCP(445.3,",DIC(0)="QEAMZ",PRCPPRIV=1 D ^DIC K PRCPPRIV,DIC Q:Y<1  S ^TMP($J,"O",+Y)=""
 I '$O(^TMP($J,"O",0)) S XP="Do you want to print ALL distribution orders for this inventory",XH="Enter 'YES' to select all distribution orders, 'NO' or '^' to exit.",%=1 W ! D YN^PRCPU4 Q:%'=1
DISTORD ;     |-> called to print a distribution order; ^tmp($j,"O",orderda)
 ;     |-> called from prcpoen when inputting an order
 N %,%I,DATA,DATE,INVDATA,INVPT,INVPTP,ITEMDA,NSN,ORDDATA,ORDERDA,PAGE,PRCPFLAG,SCREEN,STORLOC,TOTAL,UNITCOST,X,Y
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK,^TMP($J,"O") Q
 .   S ZTDESC="Distribution Order Print",ZTRTN="DQ^PRCPRPID"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("^TMP($J,")="",ZTSAVE("ZTREQ")="@"
DQ ;queue comes here
 I '$O(^TMP($J,"O",0)) D  ;all orders
 .   I PRCP("DPTYPE")="P" S DIC("S")="I $P(^(0),U,2)=PRCP(""I""),$P(^(0),U,6)'="""",""RB""[$P(^(0),U,6)"
 .   E  S DIC("S")="I $P(^(0),U,3)=PRCP(""I"")&(""RB""[$P(^(0),U,6)!($P(^(0),U,6)=""""))"
 .   S Y=0 F  S Y=$O(^PRCP(445.3,Y)) Q:'Y  I $D(^PRCP(445.3,Y,0)) X DIC("S") I $T S ^TMP($J,"O",Y)=""
 ;
 K DIC S ORDERDA=0 F  S ORDERDA=$O(^TMP($J,"O",ORDERDA)) Q:'ORDERDA  S ORDDATA=$G(^PRCP(445.3,ORDERDA,0)) I ORDDATA'="" K ^TMP($J,"PICK") D
 .   S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.3,ORDERDA,1,ITEMDA)) Q:'ITEMDA  S DATA=$G(^(ITEMDA,0)) I ITEMDA'="" D
 .   .   S NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" " S INVDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),STORLOC=$$STORELOC^PRCPESTO($P(INVDATA,"^",6))
 .   .   S:+$P(INVDATA,"^",25)=0 $P(INVDATA,"^",25)=1 S UNITCOST=+$P(DATA,"^",3) S:UNITCOST=0 UNITCOST=+$P(INVDATA,"^",15) S:UNITCOST=0 UNITCOST=+$P(INVDATA,"^",22)
 .   .   S %=ITEMDA_"^"_NSN_"^"_STORLOC_"^"_$$DESCR^PRCPUX1(PRCP("I"),ITEMDA)_"^"_+$P(INVDATA,"^",7)_"^"_$J($$UNITVAL^PRCPUX1($P(INVDATA,"^",14),$P(INVDATA,"^",5)," per "),13)
 .   .   S ^TMP($J,"PICK",STORLOC,NSN,ITEMDA)=%_"^"_$P(INVDATA,"^",25)_"^"_$P(DATA,"^",2)_"^"_$P(DATA,"^",4)_"^"_UNITCOST_"^"_$J($P(DATA,"^",2)*UNITCOST,0,3)
 .   D NOW^%DTC S Y=% X ^DD("DD") S DATE=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP,Y=$P(ORDDATA,"^",4) X:+Y ^DD("DD") S $P(ORDDATA,"^",4)=Y S INVPT=$P($$INVNAME^PRCPUX1($P(ORDDATA,"^",3)),"-",2,99)
 .   S INVPTP=$P($$INVNAME^PRCPUX1($P(ORDDATA,"^",2)),"-",2,99)
 .   S %=$P(ORDDATA,"^",8),$P(ORDDATA,"^",8)=$S(%="R":"REGULAR",%="C":"CALL-IN",%="E":"EMERGENCY",1:"")
 .   S %=$P(ORDDATA,"^",6),$P(ORDDATA,"^",6)=$S(%="R":"RELEASED TO FILL",%="P":"POSTING",%="B":"BACK-ORDERED",%="F":"BACK-ORDERED FILLED",1:"<<NOT RELEASED>>"),TOTAL=0,STORLOC="" U IO D H
 .   F  S STORLOC=$O(^TMP($J,"PICK",STORLOC)) Q:STORLOC=""  D STORLOC S NSN="" F  S NSN=$O(^TMP($J,"PICK",STORLOC,NSN)) Q:NSN=""  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PICK",STORLOC,NSN,ITEMDA)) Q:'ITEMDA  S DATA=^(ITEMDA) D
 .   .   I $Y>(IOSL-7),$Q(^TMP($J,"PICK",STORLOC,NSN,ITEMDA))'="" D:SCREEN P^PRCPU4 S:$D(PRCPFLAG) (NSN,ITEMDA,ORDERDA)=99999999,STORLOC="zzzz" Q:$D(PRCPFLAG)  D H,STORLOC
 .   .   W !!,$P(DATA,"^",2),?17,$E($P(DATA,"^",4),1,33),?52,"[#",ITEMDA,"]",?63,$J($P(DATA,"^",5),8)
 .   .   W !?4,"ISS MULT     QTY ORD            UNIT per ISS  UNIT COST   TOT COST"
 .   .   W !?4,$J($P(DATA,"^",7),8) W:$P(DATA,"^",8)#$P(DATA,"^",7)'=0 "*" W ?14,$J($P(DATA,"^",8),10),$J($P(DATA,"^",9),10),$P(DATA,"^",6),?34,$J($P(DATA,"^",10),12,3),$J($P(DATA,"^",11),11,3)
 .   .   S TOTAL=TOTAL+$P(DATA,"^",11)
 .   I '$D(PRCPFLAG) W !!,"TOTAL DOLLAR AMOUNT OF ORDER: ",$J(TOTAL,0,3)
 .   I $O(^TMP($J,"O",ORDERDA)) D:SCREEN P^PRCPU4 S:$D(PRCPFLAG) (NSN,ITEMDA,ORDERDA)=99999999,STORLOC="zzzz"
 I '$D(PRCPFLAG) D END^PRCPUREP
 D ^%ZISC K ^TMP($J,"PICK"),^TMP($J,"O") Q
 ;
H S %=DATE_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"DISTRIBUTION ORDER PRINT",?(80-$L(%)),%
 W !,?4,"FROM: ",INVPTP,?39,"TO: ",INVPT
 W !,"ORDER NO: ",$P(ORDDATA,"^"),?19,"DATE: ",$P(ORDDATA,"^",4),?37,"TYPE: ",$P(ORDDATA,"^",8),?54,"STATUS: ",$E($P(ORDDATA,"^",6),1,17)
 S %="",$P(%,"-",81)="" W !,"NSN",?17,"DESCRIPTION",?52,"[#MI]",?61,"QTY ON-HND",!,% Q
 ;
STORLOC W !!?4,"STORAGE LOCATION: ",$S(STORLOC="?":"(NONE)",1:STORLOC) Q
