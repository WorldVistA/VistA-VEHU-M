PRCPSCLR ;WISC/RFJ-receiving calm code sheets ;15 Jun 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
DQ ;     |-> create/trans receiving code sheets to calm
 ;     |-> pono=purchase order number
 ;     |-> tranid=transaction register id number
 ;     |-> prc=standard variables defined (for creating code sheets)
 N %,%H,%I,ACCT,COUNT,DATA,DATE,DEPOT,DISYS,NSN,PO,PODA,PRCF,PRCFA,PRCFASYS,PRCPACCT,PRCPCALM,PRCPXMZ,SOURCE,STRING,TRANREG,X
 S PODA=+$O(^PRC(442,"B",PONO,0)),SOURCE=+$P($G(^PRCD(420.8,+$P($G(^PRC(442,PODA,1)),"^",7),0)),"^",3) I SOURCE=1 S DEPOT=$P($G(^PRC(442,PODA,18)),"^") D ASKDEPOT^PRCPSLOI I $G(PRCPFLAG) W !,$$ERROR
 K PRCPACCT S TRANREG=0 F  S TRANREG=$O(^PRCP(445.2,"C",PONO,TRANREG)) Q:'TRANREG  S DATA=$G(^PRCP(445.2,TRANREG,0)) I DATA'="",$P(DATA,"^",2)=TRANID D
 .   I '$G(DATE) S DATE=$P(DATA,"^",3)
 .   S NSN=$$NSN^PRCPUX1($P(DATA,"^",5)),ACCT=$$ACCT^PRCPUX1($P(NSN,"-")),PRCPACCT(ACCT)=$G(PRCPACCT(ACCT))+$P(DATA,"^",22)
 I '$G(DATE) D NOW^%DTC S DATE=X
 S PO=$P(PONO,"-",2),PRCPCALM="CLM."_$P(PONO,"-")_".922.00."_$E(DATE,4,7)_$E(DATE,2,3)_"."_PO
 K ^TMP($J,"STRING") S COUNT=1,STRING=PRCPCALM,ACCT="" F  S ACCT=$O(PRCPACCT(ACCT)) Q:'ACCT  S DATA=PRCPACCT(ACCT) I +DATA D
 .   S DATA=$TR($J(DATA,12,2)," .",0),STRING=STRING_"."_PO_".01."_$E("00",$L(ACCT)+1,2)_ACCT_"."_SOURCE_"."_DATA_"."_DATA_"."_$S(SOURCE=1:$G(DEPOT),1:"")_"."
 .   I $L(STRING)>200 S ^TMP($J,"STRING",COUNT)=STRING_"$",COUNT=COUNT+1,STRING=PRCPCALM
 I STRING'=PRCPCALM S ^TMP($J,"STRING",COUNT)=STRING_"$",COUNT=COUNT+1
 I COUNT=1 Q
 D TRANSMIT^PRCPSMCC(PRC("SITE"),"CLI","922.00","CLI")
 W !!?4,"CLM 922.00 Transmitted in MailMan Messages:" I $D(PRCPXMZ) S %=0 F  S %=$O(PRCPXMZ(%)) Q:'%  W !?10,$P(PRCPXMZ(%),"^",2),"    ",+PRCPXMZ(%)
 Q
 ;
 ;
ERROR() ;display error message on input
 Q "WARNING -- CODE SHEETS WILL PROBABLY REJECT AND HAVE TO BE RESUBMITTED."
