RCRPU3 ;EDE/YMG - REPAYMENT PLAN UTILITIES;11/01/2022  8:40 AM
 ;;4.5;Accounts Receivable;**389,422**;Mar 20, 1995;Build 13
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
PMNTS(RPIEN) ; calculate the sum of payments made for a given RPP
 ;
 ; RPIEN - file 340.5 ien
 ;
 ; returns sum of payments in sub-file 340.53
 ;
 N PMDT,PMIEN,RES
 S RES=0
 S PMDT=0 F  S PMDT=$O(^RCRP(340.5,RPIEN,3,"B",PMDT)) Q:'PMDT  D
 .S PMIEN="" F  S PMIEN=+$O(^RCRP(340.5,RPIEN,3,"B",PMDT,PMIEN)) Q:'PMIEN  S RES=RES+$P($G(^RCRP(340.5,RPIEN,3,PMIEN,0)),U,2)
 .Q
 Q RES
 ;
CBAL(RPIEN,TOTAMNT) ; calculate current balance for a given RPP
 ;
 ; RPIEN - file 340.5 ien
 ; TOTAMNT - plan amount owed (340.5/.11), optional
 ;
 ; returns plan amount owed - sum of all payments
 ;
 N RES
 S RES=0
 I +$G(RPIEN)>0 D
 .S TOTAMNT=$G(TOTAMNT,$P($G(^RCRP(340.5,RPIEN,0)),U,11))
 .S RES=TOTAMNT-$$PMNTS(RPIEN)
 .Q
 Q RES
 ;
REMPMNTS(RPIEN,MNAMNT) ; calculate remaining payments for a given RPP
 ;
 ; RPIEN - file 340.5 ien
 ; MNAMNT - amount per month (340.5/.06), optional
 ;
 ; returns # of remaining payments
 ;
 N CBAL,RES
 S RES=0
 I +$G(RPIEN)>0 D
 .S MNAMNT=$G(MNAMNT,$P($G(^RCRP(340.5,RPIEN,0)),U,6))
 .S CBAL=$$CBAL(RPIEN)
 .S RES=CBAL\MNAMNT+$S(CBAL#MNAMNT:1,1:0)
 .Q
 Q RES
 ;
CLSPLAN(RCIEN,RCREASON) ; close repayment plan (non-interactive)  PRCA*4.5*422
 ;
 ; RCIEN    - plan to close (ien in file 340.5)
 ; RCREASON - audit log comment (340.501/.01)
 ;
 N RCCURST,RCFIELD
 ;
 S RCCURST=$$GET1^DIQ(340.5,RCIEN_",",.07,"I") ; get current plan status
 D BLDSTARY^RCRPNP ; set up the field # array for the metrics file
 D UPDSTAT^RCRPU1(RCIEN,7) ; update plan status to CLOSED
 S RCFIELD=$G(^TMP($J,"RPPFLDNO",RCCURST,7)) D UPDMET^RCSTATU(RCFIELD,1) ; update the correct Status Movement Metric
 ; update the Close Reason Metric (Default reason updates field 1.28, otherwise, update 1.27 in the AR Metrics file (340.7)
 S RCFIELD=$S(RCREASON="D":1.28,1:1.27) D UPDMET^RCSTATU(RCFIELD,1)
 D UPDAUDIT^RCRPU2(RCIEN,$$DT^XLFDT,"C",RCREASON) ; update the audit log with the reason
 ; update the bills on the plan to remove the REPAYMENT PLAN DATE and AR REPAYMENT PLAN ID
 ; also, file a transaction indicating that the plan was closed.
 D RMBILL^RCRPU1(RCIEN)
 K ^TMP($J,"RPPFLDNO") ; kill temporary global created by BLDSTARY^RCRPNP
 Q
 ;
CPYPLAN(RCIEN,RCPLN) ; copy existing repayment plan into a new repayment plan (non-interactive)  PRCA*4.5*422
 ;
 ; RCIEN    - existing plan to copy (ien in file 340.5)
 ; RCPLN    - new plan monthly amount ^ new plan # of payments
 ;
 ; returns 1 on success
 ;
 N N0,RCAUTO,RCBILL,RCBLCH,RCCTS,RCDBTR,RCSVFLG,Z
 ;
 K ^TMP("RCRPP",$J)
 S N0=^RCRP(340.5,RCIEN,0)
 S RCDBTR=$P(N0,U,2),RCAUTO=$P(N0,U,12)
 S RCCTS=$$GETACTS^RCRPU(+RCDBTR),RCBLCH=""
 S Z=0 F  S Z=$O(^RCRP(340.5,RCIEN,6,Z)) Q:'Z  D
 .S RCBILL=$P(^RCRP(340.5,RCIEN,6,Z,0),U)
 .S RCBLCH=RCBLCH_$S(RCBLCH="":"",1:",")_RCBILL
 .S ^TMP("RCRPP",$J,"BILLS",RCBILL)=""
 .Q
 S RCSVFLG=$$GETDET^RCRPU(RCBLCH,RCTOT,RCDBTR,RCAUTO,"T",RCPLN) ; create new plan
 K ^TMP("RCRPP",$J)
 Q RCSVFLG
