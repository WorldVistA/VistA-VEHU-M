PRCPSCLI ;WISC/RFJ-issues calm code sheets ;15 Jun 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
DQ ;     |-> create/trans issue code sheets to calm
 ;     |-> tranno=issue book number
 ;     |-> tranid=transaction register id number
 ;     |-> prc=standard variables defined (for creating code sheets)
 N ACCT,CANTEEN,COSTCNTR,COUNT,DATA,DATE,GENPOST,INVCOST,NSN,PRCPACCT,PRCPCALM,PRCPXMZ,REFNO,SELLCOST,STRING,SUBACCT,TRANDA,TRANREG,X
 S TRANDA=+$O(^PRCS(410,"B",TRANNO,0)),COSTCNTR=$P($G(^PRCS(410,TRANDA,3)),"^",3),COSTCNTR=$S($D(^PRCD(420.1,+COSTCNTR,0)):$P(^(0),"^"),1:COSTCNTR)
 ;     |-> is it an issue to the canteen or general post fund ?
 I $P($G(^PRC(420,PRC("SITE"),1,+$P(TRANNO,"-",4),0)),"^",12)=3 S CANTEEN=1
 I $P($G(^PRC(420,PRC("SITE"),1,+$P(TRANNO,"-",4),0)),"^",12)=1 S GENPOST=1
 K PRCPACCT S TRANREG=0 F  S TRANREG=$O(^PRCP(445.2,"C",TRANNO,TRANREG)) Q:'TRANREG  S DATA=$G(^PRCP(445.2,TRANREG,0)) I DATA'="",$P(DATA,"^",2)=TRANID D
 .   I '$G(DATE) S DATE=$P(DATA,"^",3)
 .   I '$D(REFNO),$P(DATA,"^",15)'="" S REFNO=$P(DATA,"^",15)
 .   S NSN=$$NSN^PRCPUX1($P(DATA,"^",5)),ACCT=$$ACCT^PRCPUX1($P(NSN,"-"))
 .   ;     |-> since issues appear as '-' in trans register, change sign
 .   S $P(DATA,"^",7)=-$P(DATA,"^",7),INVCOST=-$P(DATA,"^",22),SELLCOST=-$P(DATA,"^",23)
 .   I $G(CANTEEN)!($G(GENPOST)) S $P(PRCPACCT(ACCT),"^")=$P($G(PRCPACCT(ACCT)),"^")+SELLCOST,$P(PRCPACCT(ACCT),"^",2)=$P($G(PRCPACCT(ACCT)),"^",2)+INVCOST Q
 .   S SUBACCT=+$P($G(^PRCS(410,TRANDA,"IT",+$O(^PRCS(410,TRANDA,"IT","AG",+$P(DATA,"^",5),0)),0)),"^",4) S:'SUBACCT SUBACCT=+$P($G(^PRC(441,+$P(DATA,"^",5),0)),"^",10) S SUBACCT=SUBACCT_$E("0000",$L(SUBACCT)+1,4)
 .   S $P(PRCPACCT(ACCT,SUBACCT),"^")=$P($G(PRCPACCT(ACCT,SUBACCT)),"^")+SELLCOST,$P(PRCPACCT(ACCT,SUBACCT),"^",2)=$P($G(PRCPACCT(ACCT,SUBACCT)),"^",2)+INVCOST
 I '$G(DATE) D NOW^%DTC S DATE=X
 I '$D(REFNO) S REFNO=$E("DEFGHJKLMABC",+$E(DATE,4,5))_$P(TRANNO,"-",5)
 I $G(CANTEEN)!($G(GENPOST)) D 92003 Q
 S PRCPCALM="CLM."_$P(TRANNO,"-")_".920.01."_$E(DATE,4,7)_$E(DATE,2,3)_".P"_REFNO_"..."_$P(TRANNO,"-",4)_".."
 K ^TMP($J,"STRING") S COUNT=1,STRING=PRCPCALM,ACCT="" F  S ACCT=$O(PRCPACCT(ACCT)) Q:'ACCT  S SUBACCT="" F  S SUBACCT=$O(PRCPACCT(ACCT,SUBACCT)) Q:SUBACCT=""  S DATA=PRCPACCT(ACCT,SUBACCT) I +DATA D
 .   S STRING=STRING_"."_$E("00",$L(ACCT)+1,2)_ACCT_"."_$TR($J($P(DATA,"^"),12,2)," .",0)_"."_$TR($J($P(DATA,"^",2),12,2)," .",0)_"."_+COSTCNTR_"."_SUBACCT_"."
 .   I $L(STRING)>200 S ^TMP($J,"STRING",COUNT)=STRING_"$",COUNT=COUNT+1,STRING=PRCPCALM
 I STRING'=PRCPCALM S ^TMP($J,"STRING",COUNT)=STRING_"$",COUNT=COUNT+1
 I COUNT=1 Q
 D TRANSMIT^PRCPSMCC(PRC("SITE"),"CLI","920.01","CLI")
 W !!?4,"CLM 920.01 Transmitted in MailMan Messages:" I $D(PRCPXMZ) S %=0 F  S %=$O(PRCPXMZ(%)) Q:'%  W !?10,$P(PRCPXMZ(%),"^",2),"    ",+PRCPXMZ(%)
 Q
 ;
 ;
92003 ;     |-> create 920.03 or 09 calm code sheet for canteen issues
 S PRCPCALM="CLM."_$P(TRANNO,"-")_".920."_$S($G(CANTEEN):"03",1:"09")_"."_$E(DATE,4,7)_$E(DATE,2,3)_".P"_REFNO_".."_$S($G(CANTEEN):PRC("SITE"),1:"")_"..."
 K ^TMP($J,"STRING") S COUNT=1,STRING=PRCPCALM,ACCT="" F  S ACCT=$O(PRCPACCT(ACCT)) Q:'ACCT  S DATA=PRCPACCT(ACCT) I +DATA D
 .   S STRING=STRING_"."_$E("00",$L(ACCT)+1,2)_ACCT_"."_$TR($J($P(DATA,"^"),12,2)," .",0)_"."_$TR($J($P(DATA,"^",2),12,2)," .",0)_"."_$S($G(GENPOST):+COSTCNTR,1:"")_".."
 .   I $L(STRING)>200 S ^TMP($J,"STRING",COUNT)=STRING_"$",COUNT=COUNT+1,STRING=PRCPCALM
 I STRING'=PRCPCALM S ^TMP($J,"STRING",COUNT)=STRING_"$",COUNT=COUNT+1
 I COUNT=1 Q
 D TRANSMIT^PRCPSMCC(PRC("SITE"),"CLI",$S($G(GENPOST):"920.09",1:"920.03"),"CLI")
 W !!?4,"CLM ",$S($G(GENPOST):920.09,1:920.03)," Transmitted in MailMan Messages:" I $D(PRCPXMZ) S %=0 F  S %=$O(PRCPXMZ(%)) Q:'%  W !?10,$P(PRCPXMZ(%),"^",2),"    ",+PRCPXMZ(%)
 Q
