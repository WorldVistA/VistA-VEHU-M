IBYZ20QC ;ALB/ARH - AUTO CANCEL THIRD PARTY BILLS ; 1-APR-96
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;;FOR USE AT HOUSTON ONLY
 ;
 ; purpose is to cancel a large number of bills created in error
 ;
 ;
FIND ; cancel all Entered/Not Reviewed bills created by the auto biller for events before 1996
 ;
 ;Find bills to cancel:  (processes only 1000 bills at a time)
 ; - must have a Status of Entered/Not Reviewed
 ; - event date must be before 1/1/1996
 ; - bill must have been created by the auto biller
 ; 
 ; all bills in auto biller list (#362.1) which met the above criteria are cancelled 
 ; and all CT entries directly linked to the bill have a Reason Not Billable of OTHER added
 ;
 N IBCOUNT,IBBILL,IBBILLN,IBRNB
 ;
 S IBRNB=$O(^IBE(356.8,"B","OTHER",0)) I 'IBRNB W !!,"No RNB of OTHER defined, can not continue" Q
 W !,"Beginning cancellation of bills "
 ;
 S (IBCOUNT,IBBILL)=0 F  S IBBILL=$O(^IBA(362.1,"D",IBBILL)) Q:'IBBILL  D  Q:IBCOUNT>1000
 . ;
 . S IBBILLN=$G(^DGCR(399,IBBILL,0))
 . I $P(IBBILLN,U,13)'=1 Q  ; status'=entered
 . ;I $P(IBBILLN,U,5)<3 Q  ; inpatient bill
 . I '$P(IBBILLN,U,20) Q  ; not created by the auto biller
 . I $P(IBBILLN,U,3)'<2960101 Q  ; event date must be before 1996
 . ;I $D(^DGCR(399,IBBILL,"OP")) Q  ; has opt visit dates
 . ;I $D(^IBA(362.5,("AIFN"_IBBILL))) Q  ; has prosthetic items
 . ;I '$D(^IBA(362.4,("AIFN"_IBBILL))) Q  ; does not have an RX refill
 . ;
 . D CANCEL(IBBILL)
 . D RNB(IBBILL,IBRNB)
 . S IBCOUNT=IBCOUNT+1 I IBCOUNT#10=0 W "."
 ;
 W !,IBCOUNT," bills cancelled."
 Q
 ;
RNB(IBBILL,IBRNB) ; Set RNB to OTHER for all CT events directly linked to bill cancelled, 
 ; if CT record doesn't already have one
 ;
 N IBY,IBCT,DIE,DIC,DR,X,Y Q:'$G(IBBILL)
 ;
 S IBY=0 F  S IBY=$O(^IBT(356.399,"C",IBBILL,IBY)) Q:'IBY  D
 . S IBCT=+$G(^IBT(356.399,IBY,0)) Q:'IBCT
 . I $G(^IBT(356,+IBCT,0)),'$P($G(^IBT(356,+IBCT,0)),U,19) D
 .. S DIE="^IBT(356,",DR=".19////"_IBRNB,DA=IBCT D ^DIE K DIE,DA,DR
 Q
 ;
 ;
CANCEL(IBBILL) ; Cancel a bill.
 ;
 ; change status of bill to cancelled
 S DIE="^DGCR(399,",DA=IBBILL,DR="16////1" D ^DIE K DIE,DR,DA
 ;
 ; delete comments for bill from auto biller comment log and INITIAL BILL NUMBER from CT
 D BSTAT^IBCDC(IBBILL)
 ;
 ; update bill status in AR
 F IBI="S","U1" S IB(IBI)=$G(^DGCR(399,IBBILL,IBI))
 S PRCASV("ARREC")=IBBILL
 S PRCASV("AMT")=$S(IB("U1")']"":0,$P(IB("U1"),"^",1)]"":$P(IB("U1"),"^",1),1:0)
 S PRCASV("DATE")=$P(IB("S"),"^",17)
 S PRCASV("BY")=$P(IB("S"),"^",18)
 S PRCASV("COMMENT")=$S($P($G(^IBE(350.9,1,2)),"^",7)'="":$P(^(2),"^",7),1:"BILL CANCELLED IN MAS")
 ;
 ; Cancel the Accounts Receivable record if the A/R status is equal to
 ;   104  -  NEW BILL
 ;   201  -  BILL INCOMPLETE
 ;   220  -  RETURNED FROM AR (NEW)
 ; Otherwise, the A/R record should be amended.
 ;
 D @($S(("^104^201^220^")[("^"_+$$STA^PRCAFN(IBBILL)_"^"):"CANCEL",1:"AMEND")_"^PRCASVC1")
 ;
 ;
 K IB,IBI,PRCASV,DA,DR,DIE,DIC
 Q
