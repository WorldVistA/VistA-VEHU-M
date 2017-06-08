PRCPEAD3 ;WISC/RFJ-update inventory point, transaction register ;16 Apr 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;     |-> otherpt = other inventory point for issues
 ;     |-> tranno  = 2237 or purchase order number
 ;     |-> nonissue = 1 for nonissue adjustment
 ;     |-> other = 1 for other type adjustment
 ;
CONTINUE ;start processing adjustments
 D CODESHTS^PRCPEAC0
 ;
 ;
 ;start updating inventory
 N %,CAPONHND,CONV,DATA,DRUGACCT,ERROR,ITEMDA,ORDERNO,PRCPEAD3,PRCPID,PRCPMULT,PRIMORD
 I $G(OTHER)!($G(NONISSUE)) G UPDATE
 ;     |-> primary updated by warehouse
 S %=$P($G(^PRCP(445,+$G(OTHERPT),0)),"^",16) I %="N" W !!?5,"Note: Primary set up so it will NOT be updated by the warehouse."
 E  S PRIMORD=$$ORDERNO^PRCPUTR(+$G(OTHERPT))
 ;     |-> special inventory point type
 I $G(PRIMORD),$P($G(^PRCP(445,+$G(OTHERPT),0)),"^",20)="D" S X="PSAGIP" I $D(^%ZOSF("TEST")) X ^%ZOSF("TEST") I $T S DRUGACCT=1 W !!?5,"Note: Primary is set up for drug accountability."
UPDATE ;start updating
 W !!,"-> updating the " I $G(PRIMORD) W "PRIMARY and "
 W "WAREHOUSE inventory point",$S($G(PRIMORD):"s",1:""),". <<" K ^TMP($J,"PRCPADJ","ITR") S ORDERNO=$$ORDERNO^PRCPUTR(PRCP("I"))
 S (ITEMDA,CAPONHND)=0 F  S ITEMDA=$O(^TMP($J,"PRCPADJ","PROCESS",ITEMDA)) Q:'ITEMDA  S DATA=^(ITEMDA) I DATA'="" D WHSE I $G(OTHERPT),$G(PRIMORD) D PRIMARY
 ;     |-> if drug accountability, tell pharmacy were done
 I $G(DRUGACCT) D EX^PSAGIP
 I CAPONHND D ADDCAP^PRCFWCAP(-CAPONHND) I $D(ERROR) W !,ERROR K ERROR ;subtract from cap inv value
 ;
 ;     |-> automatically queue adjustment form on fiscal and supply
 ;     |-> printers.
 ;
 S PRCPMULT=1
 W !!,"Queueing Approval Form to Print on 'Fiscal (Receiving Reports)' Printer ..." S %=$O(^PRC(411,PRC("SITE"),2,"AC","FR",0))
 I %="" W !?5,">> WARNING: DEVICE NOT FOUND IN SITE PARAMETERS FILE 411. >>"
 E  S IOP="Q;"_%,ZTDTH=$H D DEVICE^PRCPEAR0 K IOP D ^%ZISC
 W !,"Queueing Approval Form to Print on 'Supply (PPM)' Printer ..." S %=$O(^PRC(411,PRC("SITE"),2,"AC","S",0))
 I %="" W !?5,">> WARNING: DEVICE NOT FOUND IN SITE PARAMETERS FILE 411. >>"
 E  S IOP="Q;"_%,ZTDTH=$H D DEVICE^PRCPEAR0 K IOP D ^%ZISC
 Q
 ;
 ;
WHSE ;     |-> update whse inventory point
 S CAPONHND=CAPONHND+$P(DATA,"^",3)
 K PRCPEAD3 S PRCPEAD3("QTY")=$P(DATA,"^"),PRCPEAD3("SELVAL")=$P(DATA,"^",2),PRCPEAD3("INVVAL")=$P(DATA,"^",3),PRCPEAD3("REF")=$P(DATA,"^",5),PRCPEAD3("REASON")="0:"_$P(DATA,"^",6)
 S PRCPEAD3("2237PO")="" I '$G(NONISSUE),'$G(OTHER) S PRCPEAD3("2237PO")=TRANNO S:$G(OTHERPT) PRCPEAD3("OTHERPT")=OTHERPT
 I $G(NONISSUE) S PRCPEAD3("ISSUE")=$S(PRCPEAD3("QTY")<0:"N",PRCPEAD3("QTY")>0:"I",1:"")
 D ITEM^PRCPUUIW(PRCP("I"),ITEMDA,"A",ORDERNO,.PRCPEAD3) K PRCPEAD3
 ;     |->returns transaction register number for approval report
 I PRCPID S ^TMP($J,"PRCPADJ","ITR","A"_ORDERNO,PRCPID)=""
 Q
 ;
 ;
PRIMARY ;     |-> update primary inventory point
 K PRCPEAD3 S PRCPEAD3("QTY")=-$P(DATA,"^")
 S PRCPEAD3("QTY")=PRCPEAD3("QTY")*$P($$GETVEN^PRCPUVEN(OTHERPT,ITEMDA,+$O(^PRC(440,"AC","S",0))_";PRC(440,",1),"^",4)
 S PRCPEAD3("SELVAL")=-$P(DATA,"^",2),PRCPEAD3("INVVAL")=-$P(DATA,"^",2),PRCPEAD3("REF")=$P(DATA,"^",5)
 S PRCPEAD3("REASON")="0:ISSUE adjustment by the WHSE [QTY: "_PRCPEAD3("QTY")_"  INV VALUE: "_PRCPEAD3("INVVAL")_"  SALES VALUE: "_PRCPEAD3("SELVAL")_"]"
 S PRCPEAD3("2237PO")=TRANNO,PRCPEAD3("OTHERPT")=PRCP("I")
 I $G(DRUGACCT) S PRCPEAD3("DRUGACCT")=1
 D ITEM^PRCPUUIW(OTHERPT,ITEMDA,"A",PRIMORD,.PRCPEAD3) K PRCPEAD3
 Q
