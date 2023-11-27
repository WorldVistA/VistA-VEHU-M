RCRPU3 ;EDE/YMG - REPAYMENT PLAN UTILITIES;11/01/2022  8:40 AM
 ;;4.5;Accounts Receivable;**389**;Mar 20, 1995;Build 36
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
