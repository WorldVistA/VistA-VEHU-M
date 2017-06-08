PRCPEAC1 ;WISC/RFJ-build calm code sheets and transmit ;15 Apr 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
CALM ;create and transmit calm code sheets
 N ACCT,COSTCNTR,COUNT,PRCPCALM,PRCPXMZ,REFNO,STRING,SUBACCT,TYPE
 ;
 ;     |-> its a purchase order, create 922.01 code sheet and quit
 ;
 I $P(TRANNO,"-",3)="" D 922 Q
 ;
 ;     |-> its an issue, create 920.** code sheets (** = 31,32,33,34).
 ;
 S REFNO=MONTH_$P(TRANNO,"-",5),COSTCNTR=$P($G(^PRCS(410,TRANDA,3)),"^",3),COSTCNTR=$S($D(^PRCD(420.1,+COSTCNTR,0)):$P(^(0),"^"),1:+COSTCNTR)
 ;
 ;     |-> its an issue to the canteen, create 920.33 and 920.34
 ;     |-> code sheets and quit.
 ;
 I $D(CANTEEN) D 92033 Q
 ;
 ;     |-> its a regular warehouse issue.  create 920.31 for positive
 ;     |-> adjustments and 920.32 for negative adjustments.
 ;
 F TYPE=31,32 D
 .   S COUNT=1 K ^TMP($J,"STRING")
 .   S (PRCPCALM,STRING)="CLM."_$E(TRANNO,1,3)_".920."_TYPE_"."_$E(DATE,4,7)_$E(DATE,2,3)_".P"_REFNO_"..."_$P(TRANNO,"-",4)_".."
 .   S ACCT="" F  S ACCT=$O(^TMP($J,"PRCPCALM",TYPE,ACCT)) Q:'ACCT  S SUBACCT="" F  S SUBACCT=$O(^TMP($J,"PRCPCALM",TYPE,ACCT,SUBACCT)) Q:SUBACCT=""  S %=^(SUBACCT) D
 .   .   S STRING=STRING_"."_$E("00",$L(ACCT)+1,2)_ACCT_"."_$TR($J($P(%,"^"),12,2)," .",0)_"."_$TR($J($P(%,"^",2),12,2)," .",0)_"."_+COSTCNTR_"."_SUBACCT_"."
 .   .   I $L(STRING)>200 S ^TMP($J,"STRING",COUNT)=STRING_"$",COUNT=COUNT+1,STRING=PRCPCALM
 .   I STRING'=PRCPCALM S ^TMP($J,"STRING",COUNT)=STRING_"$",COUNT=COUNT+1
 .   I COUNT=1 Q
 .   D TRANSMIT^PRCPSMCC($E(TRANNO,1,3),"CLI",920_"."_TYPE,"CLI")
 .   W !!?4,"CLM 920."_TYPE_" Transmitted in MailMan Messages:" I $D(PRCPXMZ) S %=0 F  S %=$O(PRCPXMZ(%)) Q:'%  W !?10,$P(PRCPXMZ(%),"^",2),"    ",+PRCPXMZ(%)
 Q
 ;
 ;
 ;     |-> its a  warehouse issue to canteen.  create 920.33 for positive
 ;     |-> adjustments and 920.34 for negative adjustments.
 ;
92033 ;canteen issue
 F TYPE=33,34 D
 .   S COUNT=1 K ^TMP($J,"STRING")
 .   S (PRCPCALM,STRING)="CLM."_$E(TRANNO,1,3)_".920."_TYPE_"."_$E(DATE,4,7)_$E(DATE,2,3)_".P"_REFNO_".."_$E(TRANNO,1,3)_"..."
 .   S ACCT="" F  S ACCT=$O(^TMP($J,"PRCPCALM",TYPE,ACCT)) Q:'ACCT  S %=^(ACCT) D
 .   .   S STRING=STRING_"."_$E("00",$L(ACCT)+1,2)_ACCT_"."_$TR($J($P(%,"^"),12,2)," .",0)_"."_$TR($J($P(%,"^",2),12,2)," .",0)_"..."
 .   .   I $L(STRING)>200 S ^TMP($J,"STRING",COUNT)=STRING_"$",COUNT=COUNT+1,STRING=PRCPCALM
 .   I STRING'=PRCPCALM S ^TMP($J,"STRING",COUNT)=STRING_"$",COUNT=COUNT+1
 .   I COUNT=1 Q
 .   D TRANSMIT^PRCPSMCC($E(TRANNO,1,3),"CLI",920_"."_TYPE,"CLI")
 .   W !!?4,"CLM 920."_TYPE_" Transmitted in MailMan Messages:" I $D(PRCPXMZ) S %=0 F  S %=$O(PRCPXMZ(%)) Q:'%  W !?10,$P(PRCPXMZ(%),"^",2),"    ",+PRCPXMZ(%)
 Q
 ;
 ;
 ;     |-> its a purchase order receipt by the warehouse. create the
 ;     |-> 922.01 code sheets.
 ;
922 ;purchase order create 922
 S REFNO=$P(TRANNO,"-",2)
 F TYPE=1,2 D
 .   S COUNT=1 K ^TMP($J,"STRING")
 .   S (PRCPCALM,STRING)="CLM."_$E(TRANNO,1,3)_".922.01."_$E(DATE,4,7)_$E(DATE,2,3)_"."_REFNO
 .   S ACCT="" F  S ACCT=$O(^TMP($J,"PRCPCALM",TYPE,ACCT)) Q:'ACCT  S %=^(ACCT) D
 .   .   S STRING=STRING_"."_REFNO_".01."_$E("00",$L(ACCT)+1,2)_ACCT_"."_SOURCE_"."_$TR($J(+%,12,2)," .",0)_"."_$TR($J(+%,12,2)," .",0)_"."_$S(SOURCE=1:$G(DEPOT),1:"")_"."_TYPE
 .   .   I $L(STRING)>200 S ^TMP($J,"STRING",COUNT)=STRING_"$",COUNT=COUNT+1,STRING=PRCPCALM
 .   I STRING'=PRCPCALM S ^TMP($J,"STRING",COUNT)=STRING_"$",COUNT=COUNT+1
 .   I COUNT=1 Q
 .   D TRANSMIT^PRCPSMCC($E(TRANNO,1,3),"CLI","922.01","CLI")
 .   W !!?4,"CLM 922.01 Transmitted in MailMan Messages:" I $D(PRCPXMZ) S %=0 F  S %=$O(PRCPXMZ(%)) Q:'%  W !?10,$P(PRCPXMZ(%),"^",2),"    ",+PRCPXMZ(%)
 Q
