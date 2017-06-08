PRCPEAD2 ;WISC/RFJ-adjustment utilities ;14 Apr 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;
NUMBER ;select 2237 or po from transaction register
 ;     |-> returns variable tranno.
 ;     |-> tranno=^ if no selection.
 K PRCPFLAG,TRANNO W !!,"Select TRANSACTION (2237) OR PURCHASE ORDER NUMBER: " R X:DTIME S:'$T X="^" I X["^"!(X="") S TRANNO="^" Q
 I X=" " S X=$P($G(^PRCP(445.2,+$G(^DISV(DUZ,"^PRCP(445.2,")),0)),"^",19) I X'="" W "  ",X
 I $P(X,"-")'=PRC("SITE") D
 .   I $E(X)?1U S X=PRC("SITE")_"-"_X Q
 .   S %=PRC("SITE")_"-" I $P(X,"-",4)'="" S X=%_X Q
 .   S %=%_PRC("FY")_"-" I $P(X,"-",3)'="" S X=%_X Q
 .   S X=%_PRC("QTR")_"-"_X
 I $D(^PRCP(445.2,"C",X)) S Y=0 F  S Y=$O(^PRCP(445.2,"C",X,Y)) Q:'Y  S %=$G(^PRCP(445.2,Y,0)) I $P(%,"^")=PRCP("I"),$E($P(%,"^",2))="R" S TRANNO=X Q
 I $D(TRANNO) Q
 W !,"Select the TRANSACTION (2237) OR PURCHASE ORDER NUMBER from the list below:",!
 S COUNT=0,X="" F  S X=$O(^PRCP(445.2,"C",X)) Q:X=""!($G(PRCPFLAG))  D
 .   S Y=0 F  S Y=$O(^PRCP(445.2,"C",X,Y)) Q:'Y  S %=$G(^PRCP(445.2,Y,0)) I $P(%,"^")=PRCP("I"),$E($P(%,"^",2))="R" D  Q
 .   .   W "  ",$S($P(X,"-",3)'="":"ISSUE  ",1:"RECEIPT"),": ",X S COUNT=COUNT+1
 .   .   I COUNT#20=0 D P^PRCPU4 W $C(13),"                                                                               "
 .   .   W !
 G NUMBER
 ;
 ;
ITEM ;select item from tmp($j,"prcpadj","item",*itemnumber*) global
 ;     |-> returns variable itemda.
 ;     |-> itemda=^ if no selection.
 K ITEMDA,PRCPFLAG W !,"  Select ITEM: " R X:DTIME S:'$T X="^" I X["^"!(X="") S ITEMDA="^" Q
 I $D(^TMP($J,"PRCPADJ","ITEM",+X)) S ITEMDA=+X Q
 W !,"Select the ITEM NUMBER from the list below:",!
 S COUNT=0,X="" F  S X=$O(^TMP($J,"PRCPADJ","ITEM",X)) Q:X=""!($G(PRCPFLAG))  D
 .   W "  ITEM NUMBER: ",X,?23,$E($P($G(^PRC(441,+X,0)),"^",2),1,30),?58,"NSN: ",$P(^(0),"^",5) S COUNT=COUNT+1
 .   I COUNT#20=0 D P^PRCPU4 W $C(13),"                                                                               "
 .   W !
 G ITEM
 ;
 ;
VOUCHER ;get doc id (log voucher number)
 ;     |-> returns variable docid.
 ;     |-> docid=^ if no selection.
 ;     |->
 ;     |-> if tmp($j,"prcpadj","log",*lognumber*) is defined,
 ;     |-> only allow selection from the list.  otherwise, allow any.
 I $O(^TMP($J,"PRCPADJ","LOG",""))="" D LOG Q
 K DOCID,PRCPFLAG W !,"  Select VOUCHER NUMBER (DOCUMENT IDENTIFIER): " R X:DTIME S:'$T X="^" I X["^"!(X="") S DOCID="^" Q
 I $D(^TMP($J,"PRCPADJ","LOG",X)) S DOCID=X Q
 W !,"Select the VOUCHER NUMBER from the list below:",!
 S COUNT=0,X="" F  S X=$O(^TMP($J,"PRCPADJ","LOG",X)) Q:X=""!($G(PRCPFLAG))  D
 .   W "  VOUCHER NUMBER: ",X S COUNT=COUNT+1
 .   I COUNT#20=0 D P^PRCPU4 W $C(13),"                                                                               "
 .   W !
 G VOUCHER
 ;
 ;
LOG ;enter log voucher number if not found in list
 S DIR(0)="FA^5:5",DIR("A")="  VOUCHER NUMBER: ",DIR("A",1)="  >> Enter DOCUMENT IDENTIFIER number. <<" D ^DIR K DIR S DOCID=Y Q
 ;
 ;
QTY(V1,V2) ;adjust quantity from v1 to v2
 S DIR(0)="NA^"_V1_":"_V2_":0",DIR("A")="  ADJUSTED QUANTITY: ",DIR("B")=0
 S DIR("A",1)="  >> Enter the adjusted quantity (in "_UNIT_") in the range "_V1_" to "_V2_". <<"
 D ^DIR K DIR S QTY=Y Q
 ;
 ;
VALUE(V1,V2,V3,V4) ;adjust value from v1 to v2
 ;ask v3 in prompt with v4=default value
 S DIR(0)="NAO^"_V1_":"_V2_":2",DIR("A")="  ADJUSTED TOTAL"_V3_" VALUE: " S:V4'="" DIR("B")=V4
 S DIR("A",1)="  >> Enter the adjusted value in the range "_V1_" to "_V2_". <<"
 D ^DIR K DIR S VALUE=Y Q
 ;
 ;
MONTH(V1) ;ask fiscal month v1=date
 S DIR(0)="SA^1:JAN;2:FEB;3:MAR;4:APR;5:MAY;6:JUN;7:JUL;8:AUG;9:SEP;10:OCT;11:NOV;12:DEC",DIR("A")="  CALM FISCAL MONTH: ",DIR("B")=$P($P($P(DIR(0),"^",2),";",+$E(V1,4,5)),":",2)
 S DIR("A",1)="  >> Enter the month (JAN, FEB, etc) or the number of the month (1, 2, etc) <<"
 D ^DIR K DIR S MONTH=$S(Y["^":"^",1:$E("DEFGHJKLMABC",+Y)) Q
 ;
 ;
REASON(V1) ;reason text ;v1=default
 S DIR(0)="F^1:80",DIR("A")="  REASON TEXT",DIR("B")=V1
 S DIR("A",1)="  >> Enter the reason text which will appear on the transaction register. <<"
 D ^DIR K DIR S REASON=Y Q
 ;
 ;
SUBACCT(V1) ;get subacct for issues
 S DIR(0)="P^420.2:QEAM",DIR("A")="  SUBACCOUNT",DIR("B")=V1
 S DIR("A",1)="  >> Select the subaccount for this item which will be used by CALM. <<"
 D ^DIR K DIR S SUBACCT=$S($P(Y,"^"):$P(Y,"^"),1:"^") Q
 ;
 ;
DEPOT(V1) ;ask depot number v1=default
 S DIR(0)="FA^3:3",DIR("A")="  DEPOT NUMBER: " S:V1'="" DIR("B")=V1
 S DIR("A",1)="  >> Enter the 3 character depot number. <<"
 D ^DIR K DIR S DEPOT=Y Q
