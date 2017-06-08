PRCPPOR2 ;WISC/RFJ-post receipts to inventory ;2 Aug 91
 ;;4.0;IFCAP;;9/23/93
 N %,CAPONHND,DATA,DRUGACCT,ISMSFLAG,LINEDA,ORDERNO,PONO,PRCPFLAG,PRCPPOR2,PURNUM,REFDA,TRANDA,TRANID
 ;     |-> special inventory point type
 I PRCP("DPTYPE")="P",$P($G(^PRCP(445,PRCP("I"),0)),"^",20)="D" S X="PSAGIP" I $D(^%ZOSF("TEST")) X ^%ZOSF("TEST") I $T S DRUGACCT=1 W !?5,"Note: Primary is set up for drug accountability."
 W !!,"Now posting receiving to inventory/history..."
 ;     |-> get next orderno for inv pt
 S ORDERNO=$$ORDERNO^PRCPUTR(PRCP("I")),PURNUM=$P(^PRC(442,PODA,0),"^")
 S (LINEDA,CAPONHND)=0 F  S LINEDA=$O(^TMP($J,"PRCPPOR",LINEDA)) Q:'LINEDA  S DATA=^(LINEDA) D
 .   ;
 .   ;     |-> cost to another distribution point, %=distrpt ^ costcntr
 .   S %=$G(^TMP($J,"PRCPPORDIST",LINEDA)) I % D COSTCTR^PRCPUCC(+%,PRCP("I"),+$P(%,"^",2),+$P(DATA,"^",5)) Q
 .   ;
 .   ;     |-> for items stored in the inventory point
 .   S CAPONHND=CAPONHND+$P(DATA,"^",5)
 .   K PRCPPOR2 S PRCPPOR2("QTY")=$P(DATA,"^",3),PRCPPOR2("PKG")=$P(DATA,"^",4),(PRCPPOR2("INVVAL"),PRCPPOR2("SELVAL"))=$J($P(DATA,"^",5),0,2),PRCPPOR2("2237PO")=PURNUM
 .   S PRCPPOR2("TRANDA")=$P(DATA,"^",6),PRCPPOR2("REF")=$P(PURNUM,"-",2),PRCPPOR2("REF")=$E(PRCPPOR2("REF"))_$E(PRCPPOR2("REF"),3,6)
 .   I $G(DRUGACCT) S PRCPPOR2("DRUGACCT")=1
 .   D ITEM^PRCPUUIW(PRCP("I"),$P(DATA,"^",2),"RC",ORDERNO,.PRCPPOR2)
 ;
 ;     |-> if drug accountability, tell pharmacy we are done
 I $G(DRUGACCT) D EX^PSAGIP
 ;     |-> add to cap inventory value and subtract from due-in value
 I PRCP("DPTYPE")="W",CAPONHND D ADDCAP^PRCFWCAP(CAPONHND_"^"_(-CAPONHND)) ;add to cap inventory value and subtract from due-in value
 ;     |-> enter received for partial
 S Y="" D ENCODE^PRCHES2(PODA,PARTLDA,+DUZ,.Y) I Y>0 D NOW^%DTC S $P(^PRC(442,PODA,11,PARTLDA,0),"^",17,18)=%_"^"_+DUZ
 ;     |-> clean up outstanding transactions
 I FINAL S REFDA=0 F  S REFDA=$O(^PRC(442,PODA,13,REFDA)) Q:'REFDA  S TRANDA=$P(^(REFDA,0),"^"),LINEDA=0 F  S LINEDA=$O(^PRCS(410,TRANDA,"IT",LINEDA)) Q:'LINEDA  D KILLTRAN^PRCPUTRA(PRCP("I"),+$P(^(LINEDA,0),"^",5),TRANDA)
 W !!,"***** RECEIVING HAS BEEN POSTED *****",!
 I PRCP("DPTYPE")'="W" Q
 ;
 ;     |-> create code sheets
 W !!,"The program will automatically create and transmit the code sheets to Austin.",!,"Please verify the accuracy of the data and submit adjustment code sheets if",!,"necessary."
 S PRCPFLAG=0,PONO=$P(^PRC(442,PODA,0),"^"),TRANID="RC"_ORDERNO D DQ^PRCPSCLR
 S ISMSFLAG=$$ISMSFLAG^PRCPUX2(PRC("SITE")) I ISMSFLAG'=2 D DQ^PRCPSLOR
 I ISMSFLAG=2 D DQ^PRCPSMPR
 Q
