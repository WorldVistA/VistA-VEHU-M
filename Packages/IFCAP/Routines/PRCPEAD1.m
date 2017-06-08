PRCPEAD1 ;WISC/RFJ-adjust inventory level issue or po correction ;14 Apr 92
 ;;4.0;IFCAP;;9/23/93
 Q
 ;
 ;     |-> input data for an issue or purchase order correction and
 ;     |-> store the data in tmp($j,"prcpadj","process").  finally
 ;     |-> process all the selected items and the data into an
 ;     |-> adjustment.
 ;
REVERSE ;correction of receipt or issue adjustment
 N CALMSHTS,CANTEEN,COUNT,DATE,DEPOT,ITEMDA,MONTH,OTHERPT,PRCPFLAG,SOURCE,TRANDA,TRANNO,TRANTYPE
 D NUMBER^PRCPEAD2 I TRANNO["^" Q
 W !?10,">> YOU HAVE SELECTED ",$S($P(TRANNO,"-",3)="":"PURCHASE ORDER",1:"ISSUE")," NUMBER: ",TRANNO," <<"
 D NOW^%DTC S DATE=X W ! D MONTH^PRCPEAD2(DATE) Q:MONTH["^"
 ;
 ;     |-> an issue has been selected.
 ;
 I $P(TRANNO,"-",3)'="" S TRANTYPE="ISSUE",TRANDA=$O(^PRCS(410,"B",TRANNO,0)) D
 .   I $P($G(^PRC(420,PRC("SITE"),1,+$P($P(^PRCS(410,TRANDA,0),"^"),"-",4),0)),"^",12)=3 S CANTEEN=1 ;canteen control point
 .   I $P($G(^PRCS(410,TRANDA,0)),"^",6) S OTHERPT=+$P(^(0),"^",6) W !!?10,">> Distribution to: ",$$INVNAME^PRCPUX1(OTHERPT)," inventory point. <<"
 ;
 ;     |-> a purchase order has been selected.
 ;
 I $P(TRANNO,"-",3)="" S TRANTYPE="RECEIPT",TRANDA=+$O(^PRC(442,"B",TRANNO,0)),SOURCE=+$P($G(^PRCD(420.8,+$P($G(^PRC(442,TRANDA,1)),"^",7),0)),"^",3) I SOURCE=1 D  Q:DEPOT["^"
 .   S DEPOT=$P($G(^PRC(442,TRANDA,18)),"^") W ! D DEPOT^PRCPEAD2(DEPOT)
 ;
 ;     |-> get the items which are in the transaction register
 ;     |-> for this 2237 or purchase order.
 ;
 W !!,"...please wait while I gather the list of items on the ",TRANTYPE
 K ^TMP($J,"PRCPADJ")
 S %=0 F  S %=$O(^PRCP(445.2,"C",TRANNO,%)) Q:'%  S X=$G(^PRCP(445.2,%,0)) W "." I $P(X,"^")=PRCP("I"),"RA"[$E($P(X,"^",4)),$P(X,"^",5) D
 .   S ^TMP($J,"PRCPADJ","ITEM",$P(X,"^",5),%)=X
 I '+$O(^TMP($J,"PRCPADJ","ITEM",0)) W !!?5,">> NO ITEMS CAN BE FOUND IN THE TRANSACTION REGISTER FOR THIS NUMBER <<" Q
 ;
 ;     |-> select item from the list and ask for input.
 ;
 F  D  Q:ITEMDA["^"  W !!!!!
 .   N DATA,DOCID,ITEMDATA,ITEMDESC,ITEMNSN,ITEMQTY,QTY,RANGEH,RANGEL,REASON,SUBACCT,TOTADJ,TOTREC,UNIT,VALUE,VALUEINV,VALUESAL,VOUCHER
 .   W !!,"  >> Select an item number from the ",TRANTYPE," number ",TRANNO," <<"
 .   D ITEM^PRCPEAD2 Q:ITEMDA["^"
 .   I $D(^TMP($J,"PRCPADJ","PROCESS",ITEMDA)) S XP="  THIS ITEM WAS PREVIOUSLY SELECTED DURING THIS SELECTION PROCESS.",XP(1)="  OK TO REMOVE THE ADJUSTMENT SO YOU CAN ENTER A NEW ONE",%=1 W !! D YN^PRCPU4 Q:%'=1
 .   K ^TMP($J,"PRCPADJ","PROCESS",ITEMDA)
 .   S ITEMDATA=$G(^PRCP(445,PRCP("I"),1,ITEMDA,0)),UNIT=$$UNITVAL^PRCPUX1($P(ITEMDATA,"^",14),$P(ITEMDATA,"^",5)," per "),ITEMQTY=+$P(ITEMDATA,"^",7)
 .   S ITEMDESC=$P($G(^PRC(441,ITEMDA,0)),"^",2),ITEMNSN=$P($G(^(0)),"^",5)
 .   D PRINT^PRCPEADP
 .   W !!,"****************  E N T E R    A D J U S T M E N T    D A T A  ****************"
 .   I $P(TRANNO,"-",3)="" S RANGEL=TOTADJ+TOTREC S:RANGEL>ITEMQTY RANGEL=ITEMQTY S RANGEH=0 S:TOTADJ<0 RANGEH=-TOTADJ
 .   I $P(TRANNO,"-",3)'="" S RANGEL=TOTADJ S:TOTADJ>ITEMQTY TOTADJ=ITEMQTY S RANGEH=-(TOTREC+TOTADJ)
 .   W ! D QTY^PRCPEAD2(-RANGEL,RANGEH) Q:QTY["^"
 .   W ! D VALUE^PRCPEAD2(-99999.99,99999.99," INVENTORY"_$S($P(TRANNO,"-",3)="":"/PAYABLE",1:""),"") Q:VALUE["^"  S VALUEINV=VALUE,VALUESAL=VALUE
 .   S RANGEL=$S(VALUE>0:0,1:-99999.99),RANGEH=$S(VALUE<0:0,1:99999.99)
 .   I $P(TRANNO,"-",3)'="" W ! D VALUE^PRCPEAD2(RANGEL,RANGEH," SALES",VALUE) Q:VALUE["^"  S VALUESAL=VALUE
 .   I '+QTY,'+VALUEINV,'+VALUESAL W !!?10,">> EITHER QUANTITY OR VALUE NEEDS TO BE ENTERED FOR AN ADJUSTMENT <<" Q
 .   I $P(TRANNO,"-",3)="" S %=$P(TRANNO,"-",2),DOCID=$E(%)_$E(%,3,6),VOUCHER=1 W !!?2,"VOUCHER NUMBER: ",DOCID
 .   I VOUCHER'=1 W ! D VOUCHER^PRCPEAD2 Q:$G(DOCID)["^"
 .   I '$D(DOCID) S DOCID=$O(^TMP($J,"PRCPADJ","LOG","")) W !!?2,"VOUCHER NUMBER: ",DOCID
 .   K SUBACCT I $P(TRANNO,"-",3)'="",'$D(CANTEEN) W ! D SUBACCT^PRCPEAD2($P($G(^PRC(441,ITEMDA,0)),"^",10)) Q:SUBACCT["^"
 .   W ! D REASON^PRCPEAD2("correction of "_TRANTYPE) Q:REASON["^"
 .   S ^TMP($J,"PRCPADJ","PROCESS",ITEMDA)=QTY_"^"_VALUESAL_"^"_VALUEINV_"^"_$G(SUBACCT)_"^"_DOCID_"^"_REASON
 ;
 ;     |-> start processing adjustment if okay.
 ;
 I '$O(^TMP($J,"PRCPADJ","PROCESS",0)) W !!?10,">> NO ITEMS HAVE BEEN SELECTED <<" Q
 S XP="ARE YOU READY TO START PROCESSING THE ADJUSTMENTS YOU HAVE MADE",XH="ENTER 'YES' TO PROCESS THE ADJUSTMENTS YOU HAVE MADE,'NO' OR '^' TO EXIT.",%=1 W !! D YN^PRCPU4
 I %'=1 W !!?10,">> NO CHANGES HAVE BEEN MADE TO THE DATABASE <<" S:%'=2 TRANNO="^" Q
 S CALMSHTS=1 D CONTINUE^PRCPEAD3
 Q
