PRCPEAC0 ;WISC/RFJ-adjustment code sheets create and trans ;14 Apr 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
 ;     |-> create & transmit log 605a code sheets (in tmp($j,"string")).
 ;     |-> create & transmit isms code sheets (in tmp($j,"ismsadj")).
 ;     |-> if +$g(calmshts), build the calm code sheets and call the
 ;     |-> routine calm^prcpeac1 to create and transmit the code sheets.
 ;
CODESHTS ;     |-> log 605a code sheet or isms code sheets
 N %H,%I,CALM,COUNT,DATA,ISMSCNT,ITEMDA,PRCPXMZ,STRING,VOUCHER
 K ^TMP($J,"PRCPCALM"),^TMP($J,"STRING"),^TMP($J,"ISMSADJ") S (ITEMDA,CALM)=0,(COUNT,ISMSCNT)=1
 F  S ITEMDA=$O(^TMP($J,"PRCPADJ","PROCESS",ITEMDA)) Q:'ITEMDA  S DATA=^(ITEMDA) I DATA'="" D
 .   I '$D(VOUCHER) S VOUCHER=$P(DATA,"^",5)
 .   N ACCT,AVG,INVDATA,NSN,QSIGN,QTY,VALUE,VSIGN
 .   S NSN=$$NSN^PRCPUX1(ITEMDA),ACCT=$$ACCT^PRCPUX1($E(NSN,1,4))
 .   I ISMSFLAG=2 D
 .   .   ;     |-> quantity adjustment
 .   .   I $P(DATA,"^") D ADJUST^PRCPSMA0(PRCP("I"),ITEMDA,+$P(DATA,"^"),"","","") I STRING("AT")'="" S ^TMP($J,"ISMSADJ",ISMSCNT)=STRING("AT"),ISMSCNT=ISMSCNT+1
 .   .   ;     |-> value adjustment
 .   .   I $P(DATA,"^",3) D
 .   .   .   ;     |-> calculate new average cost
 .   .   .   S INVDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0))
 .   .   .   S AVG=0,%=$P(INVDATA,"^",7)+$P(INVDATA,"^",19)+$P(DATA,"^") I % S AVG=$J($P(INVDATA,"^",27)+$P(DATA,"^",3)/%,0,2)
 .   .   .   D ADJUST^PRCPSMA0(PRCP("I"),ITEMDA,"",$P(DATA,"^",3),AVG,"") I STRING("AT")'="" S ^TMP($J,"ISMSADJ",ISMSCNT)=STRING("AT"),ISMSCNT=ISMSCNT+1
 .   S NSN=$E($TR($P(NSN,"-",2,4),"-")_"          ",1,10)
 .   S QTY=+$P(DATA,"^"),QSIGN="+" S:QTY<0 QSIGN="-",QTY=QTY*-1 S QTY=$S(QTY=0:"     ",1:$E("00000",$L(QTY)+1,5)_QTY)
 .   S VALUE=$P(DATA,"^",3) I VALUE'="" S VALUE=+VALUE,VALUE=$TR($J(VALUE,0,2),"."),VSIGN="+" S:VALUE<0 VSIGN="-",VALUE=VALUE*-1 S VALUE=$E("0000000",$L(VALUE)+1,7)_VALUE
 .   I VALUE="" S VALUE="       ",VSIGN=QSIGN
 .   I QSIGN=VSIGN S ^TMP($J,"STRING",COUNT)="   "_NSN_$E(TRANNO,1,3)_"605A"_ACCT_QTY_VALUE_QSIGN_$P(DATA,"^",5)_$E(DATE,4,7)_$E(DATE,2,3)_"                                   ",COUNT=COUNT+1 D:$G(CALMSHTS) BUILDCLM Q
 .   I +QTY S ^TMP($J,"STRING",COUNT)="   "_NSN_$E(TRANNO,1,3)_"605A"_ACCT_QTY_"0000000"_QSIGN_$P(DATA,"^",5)_$E(DATE,4,7)_$E(DATE,2,3)_"                                   ",COUNT=COUNT+1
 .   I +VALUE S ^TMP($J,"STRING",COUNT)="   "_NSN_$E(TRANNO,1,3)_"605A"_ACCT_"00000"_VALUE_VSIGN_$P(DATA,"^",5)_$E(DATE,4,5)_$E(DATE,6,7)_$E(DATE,2,3)_"                                   ",COUNT=COUNT+1
 .   D:$G(CALMSHTS) BUILDCLM
 ;
 ;     |-> if log code sheets were created, call the program to transmit.
 ;
 I COUNT'=1,ISMSFLAG'=2 D
 .   D TRANSMIT^PRCPSMCL($E(TRANNO,1,3),605,"LOG")
 .   W !!?4,"LOG 605 Transmitted in MailMan Messages:" I $D(PRCPXMZ) S %=0 F  S %=$O(PRCPXMZ(%)) Q:'%  W " ",PRCPXMZ(%),"  "
 I ISMSCNT,ISMSFLAG=2 D
 .   K ^TMP($J,"STRING") S %X="^TMP("_$J_",""ISMSADJ"",",%Y="^TMP("_$J_",""STRING""," D %XY^%RCR
 .   D CODESHT^PRCPSMGO($E(TRANNO,1,3),"ADJ",VOUCHER)
 .   K ^TMP($J,"STRING"),^TMP($J,"ISMSADJ")
 ;
 ;     |-> if +$g(calmshts), call the program to create & transmit.
 ;
 D:$G(CALMSHTS) CALM^PRCPEAC1
 Q
 ;
 ;
 ;     |-> set up the global tmp($j,"prcpcalm",*sign*,*acct*) for
 ;     |-> the calm code sheets.  *sign*=1 for positive adjustments,
 ;     |-> or *sign*=2 for negative adjustments.  *acct*=the items
 ;     |-> account code which is determined by the items nsn.
 ;
BUILDCLM ;build calm code sheets
 I $P(DATA,"^",2)<0 S $P(DATA,"^",2)=-$P(DATA,"^",2)
 I $P(DATA,"^",3)<0 S $P(DATA,"^",3)=-$P(DATA,"^",3)
 ;
 ;     |-> its an issue correction, build 920.31 and 920.32 code sheets.
 ;     |-> the tmp global will equal sales amount ^ inventory amount.
 ;
 I $P(TRANNO,"-",3)'="" D  Q
 .   I '$D(CANTEEN) S %=$G(^TMP($J,"PRCPCALM",$S(VSIGN="+":32,1:31),ACCT,+$P(DATA,"^",4))),^(+$P(DATA,"^",4))=($P(%,"^")+$P(DATA,"^",2))_"^"_($P(%,"^",2)+$P(DATA,"^",3)) Q
 .   S %=$G(^TMP($J,"PRCPCALM",$S(VSIGN="+":34,1:33),ACCT)),^(ACCT)=($P(%,"^")+$P(DATA,"^",2))_"^"_($P(%,"^",2)+$P(DATA,"^",3)) Q
 ;
 ;     |-> its a purchase order correction, build 922.01 code sheets.
 ;     |-> the tmp global will equal the inventory amount.
 ;
 S ^TMP($J,"PRCPCALM",$S(VSIGN="+":1,1:2),ACCT)=$G(^TMP($J,"PRCPCALM",$S(VSIGN="+":1,1:2),ACCT))+$P(DATA,"^",3)
 Q
