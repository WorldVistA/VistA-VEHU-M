PRCPRPIP ;WISC/RFJ-print picking ticket for primary order to secondary (445.3) ;29 Aug 91
 ;;4.0;IFCAP;;9/23/93
 D ^PRCPUSEL Q:'$G(PRCP("I"))  I PRCP("DPTYPE")="W" W !!,"THIS OPTION CANNOT BE USED BY A WAREHOUSE INVENTORY POINT!" Q
 N ORDERDA,X,Y S DIC("A")="Select DISTRIBUTION ORDER: ",DIC="^PRCP(445.3,",DIC("S")="I $P(^(0),U,2)=PRCP(""I""),(($P(^(0),U,6)=""R"")!($P(^(0),U,6)=""B""))",DIC(0)="QEAMZ",PRCPPRIV=1 W !
 D ^DIC K PRCPPRIV,DIC Q:Y<1  S ORDERDA=+Y
PICKTKT ;called from enter/edit program to print picking ticket; orderda=internal order number
 N %,%I,DATA,DATE,INVDATA,INVPT,ITEMDA,NSN,ORDDATA,PAGE,PRCPFLAG,REPRINT,SCREEN,STORLOC,TOTAL,UNITCOST
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Print Picking Ticket (Primary to Secondary)",ZTRTN="DQ^PRCPRPIP"
 .   S ZTSAVE("PRCP*")="",ZTSAVE("ORDERDA")="",ZTSAVE("ZTREQ")="@"
DQ ;queue comes here
 K ^TMP($J,"PICK") S ORDDATA=$G(^PRCP(445.3,ORDERDA,0)) I ORDDATA=""!($P(ORDDATA,"^",6)="P")!($P(ORDDATA,"^",6)="") D PRINT Q
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.3,ORDERDA,1,ITEMDA)) Q:'ITEMDA  S DATA=$G(^(ITEMDA,0)) I ITEMDA'="" D
 .   S NSN=$$NSN^PRCPUX1(ITEMDA) S:NSN="" NSN=" " S INVDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),STORLOC=$$STORELOC^PRCPESTO($P(INVDATA,"^",6))
 .   S:+$P(INVDATA,"^",25)=0 $P(INVDATA,"^",25)=1 S UNITCOST=+$P(DATA,"^",3) S:UNITCOST=0 UNITCOST=+$P(INVDATA,"^",15) S:UNITCOST=0 UNITCOST=+$P(INVDATA,"^",22)
 .   S %=ITEMDA_"^"_NSN_"^"_STORLOC_"^"_$$DESCR^PRCPUX1(PRCP("I"),ITEMDA)_"^"_+$P(INVDATA,"^",7)_"^"_$J($$UNITVAL^PRCPUX1($P(INVDATA,"^",14),$P(INVDATA,"^",5)," per "),13)
 .   S ^TMP($J,"PICK",STORLOC,NSN,ITEMDA)=%_"^"_$P(INVDATA,"^",25)_"^"_$P(DATA,"^",2)_"^"_$P(DATA,"^",4)_"^"_UNITCOST_"^"_$J($P(DATA,"^",2)*UNITCOST,0,3)
PRINT D NOW^%DTC S Y=% X ^DD("DD") S DATE=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP K REPRINT S:$P(ORDDATA,"^",7)="Y" REPRINT=1 S Y=$P(ORDDATA,"^",4) X:+Y ^DD("DD") S $P(ORDDATA,"^",4)=Y S INVPT=$P($$INVNAME^PRCPUX1($P(ORDDATA,"^",3)),"-",2,99)
 S %=$P(ORDDATA,"^",8),$P(ORDDATA,"^",8)=$S(%="R":"REGULAR",%="C":"CALL-IN",%="E":"EMERGENCY",1:"")
 S %=$P(ORDDATA,"^",6),$P(ORDDATA,"^",6)=$S(%="R":"RELEASED TO FILL",%="P":"POSTING",%="B":"BACK-ORDERED",%="F":"BACK-ORDERED FILLED",1:""),TOTAL=0,STORLOC="" U IO D H
 F  S STORLOC=$O(^TMP($J,"PICK",STORLOC)) Q:STORLOC=""!($G(PRCPFLAG))  D STORLOC D
 .   S NSN="" F  S NSN=$O(^TMP($J,"PICK",STORLOC,NSN)) Q:NSN=""!($G(PRCPFLAG))  S ITEMDA=0 F  S ITEMDA=$O(^TMP($J,"PICK",STORLOC,NSN,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S DATA=^(ITEMDA) D
 .   .   I $Y>(IOSL-7),$Q(^TMP($J,"PICK",STORLOC,NSN,ITEMDA))'="" D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  D H,STORLOC
 .   .   W !!,$P(DATA,"^",2),?17,$E($P(DATA,"^",4),1,33),?52,"[#",ITEMDA,"]",?63,$J($P(DATA,"^",5),8),?72,"|------|"
 .   .   W !?4,"ISS MULT  QTY ORD  UNIT per ISS  UNIT COST   TOT COST",?60,"QTY TO PICK",?72,"|",?79,"|"
 .   .   W !?4,$J($P(DATA,"^",7),8) W:$P(DATA,"^",8)#$P(DATA,"^",7)'=0 "*" W ?14,$J($P(DATA,"^",8),7),$P(DATA,"^",6),?34,$J($P(DATA,"^",10),12,3),$J($P(DATA,"^",11),11,3),?61,$J($P(DATA,"^",8),10)," |______|"
 .   .   S TOTAL=TOTAL+$P(DATA,"^",11)
 I '$G(PRCPFLAG) D
 .   K DATA F %=1:1 S DATA=$P($T(DATA+%),";",3,99) Q:DATA=""  S DATA(%)=DATA
 .   I $Y>(IOSL-%-4) D:SCREEN P^PRCPU4 Q:$G(PRCPFLAG)  D H
 .   W !!,"TOTAL DOLLAR AMOUNT OF ORDER: ",$J(TOTAL,0,3)
 .   W ! S %=0 F  S %=$O(DATA(%)) Q:'%  W !,DATA(%)
 I $E(IOST)="P" I $D(^PRCP(445.3,ORDERDA,0)) S $P(^(0),"^",7)="Y" ;reprint flag
 I '$G(PRCPFLAG) D END^PRCPUREP
 D ^%ZISC K ^TMP($J,"PICK") Q
 ;
H S %=DATE_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"PICKING TICKET ",$S($D(REPRINT):"RE-",1:""),"PRINT",?(80-$L(%)),%
 W !,?4,"FROM: ",PRCP("IN"),?39,"TO: ",INVPT
 W !,"ORDER NO: ",$P(ORDDATA,"^"),?19,"DATE: ",$P(ORDDATA,"^",4),?37,"TYPE: ",$P(ORDDATA,"^",8),?54,"STATUS: ",$E($P(ORDDATA,"^",6),1,17)
 S %="",$P(%,"-",81)="" W !,"NSN",?17,"DESCRIPTION",?52,"[#MI]",?61,"QTY ON-HND",?74,"PICKED",!,% Q
 ;
STORLOC W !!?4,"STORAGE LOCATION: ",$S(STORLOC="?":"(NONE)",1:STORLOC) Q
 Q
 ;
DATA ;;print signature at bottom of report
 ;;SIGNATURE:_________________________                    PULLED BY:_______________
 ;;    TITLE:_________________________                  VERIFIED BY:_______________
 ;;     DATE:_________________________           DATE TO DELIVER ON:_______________
