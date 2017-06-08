PRCPRVOU ;WISC/RFJ-voucher summary ;15 Jun 92
 ;;4.0;IFCAP;;9/23/93
 D ^PRCPUSEL Q:'$D(PRCP("I"))
 N %,%H,%I,MONTH,TRXDATE,X,Y
 D NOW^%DTC S Y=$E(X,1,5)_"00" S %DT(0)=-Y X ^DD("DD") S %DT="AEP",%DT("B")=Y,%DT("A")="Print Voucher Summary for MONTH and YEAR: " W ! D ^%DT K %DT Q:Y<1  S (Y,TRXDATE)=$E(Y,1,5) X ^DD("DD") S MONTH=Y
 S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Inventory Unit Cost Report",ZTRTN="DQ^PRCPRVOU"
 .   S ZTSAVE("PRC*")="",ZTSAVE("TRXDATE")="",ZTSAVE("MONTH")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
DQ ;queue starts here
 N %,ACCT,ACCTBAL,CC,D,DA,DATE,INVVAL,ISSUE,ITEMDA,NOW,OPEN,OPENBAL,P,PAGE,PRCPFLAG,REFNO,SA,SCREEN,SELLVAL,TACCISS,TACCISSA,TACCOTH,TACCREC,TACCRECA,TACCT,TRANSID,TRANSNO,TSUPISS,TSUPISSA,TSUPOTH,TSUPREC,TSUPRECA,X,Y
 K OPEN
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.1,PRCP("I"),1,ITEMDA)) Q:'ITEMDA  S X=$$GETOPEN^PRCPUBAL(PRCP("I"),ITEMDA,TRXDATE) I X'="" D
 .   S ACCT=$$ACCT^PRCPUX1($E($$NSN^PRCPUX1(ITEMDA),1,4))
 .   S $P(OPEN(ACCT),"^")=$P($G(OPEN(ACCT)),"^")+$P(X,"^",2)+$P(X,"^",3)
 .   S $P(OPEN(ACCT),"^",2)=$P($G(OPEN(ACCT)),"^",2)+$P(X,"^",8)
 K ^TMP($J,"PRCPRVOU")
 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(445.2,"AD",PRCP("I"),ITEMDA)) Q:'ITEMDA  S DA=0 F  S DA=$O(^PRCP(445.2,"AD",PRCP("I"),ITEMDA,DA)) Q:'DA  S D=$G(^PRCP(445.2,DA,0)) I $E($P(D,"^",3),1,5)=TRXDATE D
 .   I '$P(D,"^",5) Q
 .   ;     |-> non-issuable
 .   I $P(D,"^",11)'="" Q
 .   S ACCT=$$ACCT^PRCPUX1($P($$NSN^PRCPUX1($P(D,"^",5)),"-"))
 .   S REFNO=$P(D,"^",15),TRANSNO=$P(D,"^",19),TRANSID=$P(D,"^",2),(ISSUE,CC,SA)=""
 .   ;     |-> other
 .   I TRANSNO="" S TRANSNO="OTHER"
 .   ;     |-> its a purchase order
 .   I +TRANSNO,$P(TRANSNO,"-",3)="" S REFNO=$P($P(D,"^",19),"-",2),TRANSNO=$P(TRANSNO,"-")
 .   ;    |-> its an issue
 .   I +TRANSNO,$P(TRANSNO,"-",3)'="" S CC=$P($G(^PRCS(410,+$O(^PRCS(410,"B",TRANSNO,0)),3)),"^",3),CC=+$S($D(^PRCD(420.1,+CC,0)):$P(^(0),"^"),1:CC),SA=+$P($G(^PRC(441,+$P(D,"^",5),0)),"^",10),TRANSNO=$P(TRANSNO,"-")_"-"_$P(TRANSNO,"-",4,5)
 .   S:REFNO="" REFNO="?????"
 .   ;     |-> get inventory value and sell value (get it out of the bucket
 .   ;     |-> pieces 22 and 23 if its in use)
 .   S INVVAL=$P(D,"^",7)*$P(D,"^",8),SELLVAL=$P(D,"^",7)*$P(D,"^",9)
 .   I $P(D,"^",22)'="" S INVVAL=$P(D,"^",22),SELLVAL=$P(D,"^",23)
 .   I $P($P(D,"^",19),"-",3)="" S SELLVAL=INVVAL
 .   I $D(^TMP($J,"PRCPRVOU",ACCT,REFNO,$E($P(D,"^",3),1,7),TRANSID)) S %=^(TRANSID) I $P(%,"^",3)=CC S $P(%,"^",5)=$P(%,"^",5)+$P(D,"^",7),$P(%,"^",6)=$P(%,"^",6)+INVVAL,$P(%,"^",7)=$P(%,"^",7)+SELLVAL,^(TRANSID)=% Q
 .   S ^TMP($J,"PRCPRVOU",ACCT,REFNO,$E($P(D,"^",3),1,7),$P(D,"^",2))=TRANSNO_"^"_$P(D,"^",2)_"^"_CC_"^"_SA_"^"_$P(D,"^",7)_"^"_INVVAL_"^"_SELLVAL
 D PRINT^PRCPRVO1
 Q
