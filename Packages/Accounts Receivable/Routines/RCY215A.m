RCY215A ;WISC/RFJ-sf215 report ;1 Oct 97
 ;;4.5;Accounts Receivable;**90**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 N DATA,RCTYPE,RECEIPDA
 ;
 F  D  Q:RECEIPDA
 .   S RECEIPDA=$$GETRECPT I 'RECEIPDA S RECEIPDA=-1 Q
 .   S DATA=$G(^RCY(344,RECEIPDA,0))
 .   I '$P(DATA,"^",9)!('$P(DATA,"^",10)) W !,"THIS RECEIPT HAS NOT BEEN POSTED" S RECEIPDA=0
 I RECEIPDA<1 Q
 ;
 S RCTYPE=$$GETTYPE
 I RCTYPE="" Q
 ;
 ;  select device
 W ! S %ZIS="Q" D ^%ZIS Q:POP
 I $D(IO("Q")) D  D ^%ZTLOAD K IO("Q"),ZTSK Q
 .   S ZTDESC="Print 215 Report",ZTRTN="DQ^RCY215A"
 .   S ZTSAVE("RECEIPDA")="",ZTSAVE("RCTYPE")="",ZTSAVE("ZTREQ")="@"
 W !!,"<*> please wait <*>"
 ;
DQ ;  queued report starts here, input RECEIPDA
 N %H,%I,BILL,BILLDA,COUNT,DA,DATA,DATA0,DATA1,DEPOSIT,DETAIL,FMSDOCNO,FUND
 N NOW,PAGE,PAYAMT,PIECE,PRINTOTL,PROCAMT,RCSTFLAG,RCYLINE,RECEIPT
 N SCREEN,TOTAL,TOTLAMT,X,Y
 ;
 ;  calculate report
 ;  input receipda (ien of receipt)
 K ^TMP($J,"RCFMSCR")
 D FMSLINES^RCXFMSC1(RECEIPDA)
 ;
 ;  print report
 S DATA=$G(^RCY(344,RECEIPDA,0))
 S RECEIPT=$P(DATA,"^")
 S DEPOSIT=$P($G(^RCY(344.1,+$P(DATA,"^",6),0)),"^")
 S FMSDOCNO=$P($G(^RCY(344.1,+$P(DATA,"^",6),2)),"^")
 ;
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y
 S PAGE=0,RCYLINE="",$P(RCYLINE,"-",81)=""
 S SCREEN=0 I '$D(ZTQUEUED),IO=IO(0),$E(IOST)="C" S SCREEN=1
 U IO D H
 ;
 S TOTAL=""  ;  stores printotal^inttotal^admintotal^marshtotal^cctotal
 S FUND="" F  S FUND=$O(^TMP($J,"RCFMSCR",FUND)) Q:'FUND!($G(RCSTFLAG))  D
 .   I $Y>(IOSL-6) D:SCREEN PAUSE Q:$G(RCSTFLAG)  D H
 .   W !!?5,"Appropriation: ",FUND
 .   I RCTYPE="D" W !
 .   ;
 .   S PRINTOTL=0
 .   S COUNT=0
 .   S BILLDA=0 F  S BILLDA=$O(^TMP($J,"RCFMSCR",FUND,BILLDA)) Q:'BILLDA!($G(RCSTFLAG))  D
 .   .   I $Y>(IOSL-5) D:SCREEN PAUSE Q:$G(RCSTFLAG)  D H
 .   .   S COUNT=COUNT+1
 .   .   S BILL=$P($G(^PRCA(430,BILLDA,0)),"^")
 .   .   S DATA=^TMP($J,"RCFMSCR",FUND,BILLDA)
 .   .   S PRINTOTL=PRINTOTL+$P(DATA,"^")
 .   .   F PIECE=1:1:5 S $P(TOTAL,"^",PIECE)=$P(TOTAL,"^",PIECE)+$P(DATA,"^",PIECE)
 .   .   ;  if accrued report, do not show detail
 .   .   I RCTYPE="A" Q
 .   .   ;
 .   .   W !?5,COUNT,")",?10,BILL,?30,$J($P(DATA,"^"),10,2),?45,"DEBTOR: ",$E($$DEBTOR(BILLDA),1,25)
 .   .   W !?15,"INT:",$J($P(DATA,"^",2),10,2)," ADMIN:",$J($P(DATA,"^",3),10,2)," MARS: ",$J($P(DATA,"^",4),10,2)," CC: ",$J($P(DATA,"^",5),10,2)
 .   ;
 .   I $G(RCSTFLAG) Q
 .   I RCTYPE="D" W !?30,"----------",!?5,"TOTAL for ",FUND
 .   W ?30,$J(PRINTOTL,10,2)
 ;
 I $G(RCSTFLAG) D Q Q
 I $Y>(IOSL-6) D:SCREEN PAUSE I '$G(RCSTFLAG) D H
 I $G(RCSTFLAG) D Q Q
 ;
 ;  show int, admin, etc totals
 W !
 W !?5,"INTEREST : (APP: 1435)",?30,$J($P(TOTAL,"^",2),10,2)
 W !?5,"ADMIN    : (APP: 3220)",?30,$J($P(TOTAL,"^",3),10,2)
 W !?5,"MARSHALL : (APP: 0869)",?30,$J($P(TOTAL,"^",4),10,2)
 W !?5,"COURTCOST: (APP: 0869)",?30,$J($P(TOTAL,"^",5),10,2)
 W !?30,"----------"
 W !?30,$J($P(TOTAL,"^",2)+$P(TOTAL,"^",3)+$P(TOTAL,"^",4)+$P(TOTAL,"^",5),10,2)
 ;
 I $Y>(IOSL-6) D:SCREEN PAUSE I '$G(RCSTFLAG) D H
 I $G(RCSTFLAG) D Q Q
 ;
 ;  check total for receipt and for errors
 W !!,"ERRORS: "
 S (PAYAMT,PROCAMT)=0
 S DA=0 F  S DA=$O(^RCY(344,RECEIPDA,1,DA)) Q:'DA!($G(RCSTFLAG))  D
 .   S DATA0=$G(^RCY(344,RECEIPDA,1,DA,0))
 .   S PAYAMT=PAYAMT+$P(DATA0,"^",4),PROCAMT=PROCAMT+$P(DATA0,"^",5)
 .   ;
 .   ;  node 1 = posting error ^ comment
 .   S DATA1=$G(^RCY(344,RECEIPDA,1,DA,1))
 .   I $P(DATA1,"^")="" Q
 .   I $Y>(IOSL-5) D:SCREEN PAUSE Q:$G(RCSTFLAG)  D H
 .   W !,"TRANS. #: ",$P(DATA0,"^"),?15,"PAYMENT AMT:",$J($P(DATA0,"^",4),9,2)
 .   W !?15,"APPLIED AMT:",$J($P(DATA0,"^",5),9,2),"    UNAPPLIED AMT:",$J($P(DATA0,"^",4)-$P(DATA0,"^",5),9,2)
 .   W !,$P(DATA1,"^")
 .   I $P(DATA1,"^",2)'="" W !,$P(DATA1,"^",2)
 ;
 I $G(RCSTFLAG) D Q Q
 I $Y>(IOSL-6) D:SCREEN PAUSE I '$G(RCSTFLAG) D H
 I $G(RCSTFLAG) D Q Q
 ;
 S TOTLAMT=0 F PIECE=1:1:5 S TOTLAMT=TOTLAMT+$P(TOTAL,"^",PIECE)
 W !!,"TOTALS: "
 W !?5,"TOTAL AMOUNT POSTED:",?30,$J(TOTLAMT,10,2)
 W !?5,"TOTAL UNAPPLIED AMOUNT:",?30,$J(PAYAMT-PROCAMT,10,2)
 I PAYAMT'=(TOTLAMT+PAYAMT-PROCAMT) W !!,"**** WARNING **** THE REPORT DOES NOT BALANCE ********"
 ;
Q D ^%ZISC
 K ^TMP($J,"RCFMSCR")
 Q
 ;
 ;
GETRECPT() ;  select the receipt, returns -1 for no selection or timeout
 N %,%Y,C,DATA0,DDC,DIC,RESULT,USER,X,Y
 S DIC(0)="QEAMZ",DIC="^RCY(344,"
 S DIC("S")="I $S($P(^(0),U,2)=DUZ:1,$D(^XUSEC(""PRCAY PAYMENT SUP"",DUZ)):1,1:0)"
 S DIC("A")="Select RECEIPT #: "
 D ^DIC
 S RESULT=Y
 I Y<0,'$G(DUOUT),'$G(DTOUT) S RESULT=0
 ;
 I RESULT D
 .   S DATA0=$G(^RCY(344,+Y,0))
 .   I $P(DATA0,"^",11),$P(DATA0,"^",11)'=DUZ D
 .   .   S USER=$P($G(^VA(200,+$P(DATA0,"^",11),0)),"^")
 .   .   S Y=$P(DATA0,"^",12) I Y D DD^%DT
 .   .   W !?5,"*** NOTICE ***"
 .   .   W !?5,"This RECEIPT was last edited by: ",USER,"  on: ",Y
 ;
 Q +RESULT
 ;
 ;
GETTYPE() ;  ask the type of report to print
 N DIR,X,Y
 S DIR(0)="S^A:ACCRUED;D:DETAILED",DIR("A")="ACCRUED OR DETAILED REPORT",DIR("B")="ACCRUED",DIR("?")="A DETAILED Report will list out accrued bills separately"
 S DIR("?",1)="An ACCRUED Report will list just the accrued total under each appropriation"
 D ^DIR
 I Y'="A",Y'="D" Q ""
 Q Y
 ;
 ;
DEBTOR(DA) ;  returns the debtor name for ien of bill (da) in file 430
 N D0,DEBTOR,DIC,DIQ,DR
 S DIC="^PRCA(430,",DR=9,DIQ(0)="E",DIQ="DEBTOR"
 D EN^DIQ1
 Q $G(DEBTOR(430,DA,9,"E"))
 ;
 ;
H ;  header
 S PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"Page ",PAGE,?(80-$L(NOW)),NOW
 W !,$E($TR(RCYLINE,"-","*"),1,34)," 215 REPORT ",$E($TR(RCYLINE,"-","*"),1,34)
 W !!,"RECEIPT #: ",RECEIPT,?25,"for DEPOSIT #: ",DEPOSIT
 I FMSDOCNO'="" W ?51,"FMS Document #: ",FMSDOCNO
 W !,RCYLINE
 Q
 ;
 ;
PAUSE ;  pause at end of page
 N X U IO(0) W !,"Press RETURN to continue, '^' to exit:" R X:DTIME S:'$T X="^" S:X["^" RCSTFLAG=1 U IO
 Q
