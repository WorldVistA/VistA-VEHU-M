RCRPU1 ;EDE/SAB-REPAYMENT PLAN UTILITIES;12/11/2020  8:40 AM
 ;;4.5;Accounts Receivable;**377,381**;Mar 20, 1995;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
UPDTERMS(RCRPIEN,RCPLNS,RCRVW) ; Update the terms of the plan.
 ;
 N DR,DIE,DA,X,Y
 S DR=".05////"_$P(RCPLNS,U,2)_";.06////"_+RCPLNS
 S:$G(RCRVW) DR=DR_";1.01////1"
 S DIE="^RCRP(340.5,",DA=RCRPIEN
 D ^DIE
 Q
 ;
GETRSN() ;  Get the reason the plan was closed.
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT,RCIEN,RCDONE
 ;
 ; Prompt Summary or Detail version
 S DIR("A")="Reason for closing the plan: (A)dministrative or (D)efaulted  "
 S DIR(0)="SA^D:Defaulted for Non-Payment;A:Administratively Closed"
 S DIR("?")="Select a reason to close the plan. to peform the plan lookup by Debtor or Repayment Plan ID."
 ;
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!($G(Y)="") Q -1
 Q Y
 ;
UPDSTAT(RCRPIEN,RCSTATUS) ; Update the status of the plan
 ;INPUT - RCRPIEN:  IEN of the Repayment Plan
 ;        RCSTATUS: The Status to update to.
 ;
 N DA,DR,DIE,X,Y
 S DA=RCRPIEN,DIE="^RCRP(340.5,"
 S DR=".07///"_RCSTATUS_";.08///"_$$DT^XLFDT
 D ^DIE
 Q
 ;
RMBILL(RCIEN) ; Remove the Repayment Plan info from the bills in the plan
 ;INPUT - RCIEN:  IEN of the Repayment Plan
 ;
 N RCLP,RCBLIEN,RCI,RCD7,RCTOT
 ;
 S RCLP=0
 F  S RCLP=$O(^RCRP(340.5,RCIEN,6,RCLP)) Q:'RCLP  D
 .  S RCBLIEN=+$G(^RCRP(340.5,RCIEN,6,RCLP,0))
 .  S DA=RCBLIEN,DIE="^PRCA(430,"
 .  S DR="41///@;45///@"
 .  D ^DIE
 .  K DA,DR,DIE,X,Y
 .  S RCD7=$G(^PRCA(430,RCBLIEN,7)),RCTOT=0
 .  F RCI=1:1:5 S RCTOT=RCTOT+$P(RCD7,U,RCI)
 .  D TRAN^RCRPU(RCBLIEN,RCTOT,68)
 Q
 ;
UPDTRAN(RCIEN) ; Update all bills on a plan if an edit to the plan is made
 ;INPUT - RCIEN:  IEN of the Repayment Plan
 ;
 N RCLP,RCBLIEN,RCI,RCD7,RCTOT
 ;
 S RCLP=0
 F  S RCLP=$O(^RCRP(340.5,RCIEN,6,RCLP)) Q:'RCLP  D
 .  S RCBLIEN=+$G(^RCRP(340.5,RCIEN,6,RCLP,0))
 .  K DLAYGO,DD,DO,DIC,DA,X,Y
 .  S RCD7=$G(^PRCA(430,RCBLIEN,7)),RCTOT=0
 .  F RCI=1:1:5 S RCTOT=RCTOT+$P(RCD7,U,RCI)
 .  D TRAN^RCRPU(RCBLIEN,RCTOT,67)
 Q
 ;
DBTCOM(RCTRANDA,RCTXTFLG) ;Add Transaction comments
 ; RCDBTR   - Referance to #433 - IEN^Name
 ; RCTXTFLG - Comment text
 ;
 N DIC,X,Y,RCTEXT
 ;
 S RCTEXT="Supervisor Approval Obtained for "_$S(RCTXTFLG=1:"<$25 payment.",1:">36 months.")
 S DIC="^PRCA(433,"_+RCTRANDA_",7,",DIC(0)="L",X=RCTEXT
 D FILE^DICN
 Q
 ;
SELRPP() ; select RPP to display
 ;
 ; returns selected ien in file 340.5 or -1 for user exit / timeout
 ;
 N DIC,DTOUT,DUOUT,X,Y
 S DIC=340.5,DIC(0)="AEQM"
 S DIC("W")="W $$CJ^XLFSTR($$EXTERNAL^DILFD(340.5,.07,,$P(^RCRP(340.5,Y,0),U,7)),15),$$CJ^XLFSTR($$FMTE^XLFDT($P(^RCRP(340.5,Y,0),U,3),""5DZ""),12)"
 S DIC("A")="Select Repayment Plan: " D ^DIC
 Q $S(+Y>0:+Y,1:-1)
 ;
UPDPAY(RCIEN,RCTRAN,RCAMT) ; Update the payment information, schedule, and status.
 ;INPUT - RCIEN  - IEN of the repayment Plan to update
 ;        RCTRAN - AR Transaction file (#433) IEN to store)
 ;        RCAMT  - (Optional) Amount paid
 ;
 ;Update the Payment Node in the Plan
 N DA,DD,DIC,DLAYGO,DO,DR
 N RCCURST,RCSTAT
 ;
 Q:$G(RCIEN)=""  ; No RPP IEN sent it.
 ;
 S DLAYGO=340.5,DA(1)=RCIEN,DIC(0)="L",X=$$DT^XLFDT,DIC="^RCRP(340.5,"_DA(1)_",3,"
 S DIC("DR")="1///"_RCAMT_";2///"_RCTRAN
 D FILE^DICN
 ;
 ;Update the Paid status in the schedule, as appropriate
 D UPDPAYST^RCRPU(RCIEN)
 ;
 ;Calculate a new status and update if different.
 S RCCURST=$$GET1^DIQ(340.5,RCIEN_",",.07,"E")
 S RCSTAT=$$STATUS(RCIEN)
 D:RCCURST'=RCSTAT UPDSTAT(RCIEN,RCSTAT)
 Q
 ;
UPDPAID(RCIEN,RCCMP) ; Update the Paid flag in the payments.
 ;INPUT: RCIEN - IEN of plan to update
 ;       RCCMP - # payments completed.
 ;
 N DR,DIE,DA,X,Y
 N RCI,RCPD,RCPDFLG
 ;
 F RCI=1:1:RCCMP D
 . S RCPD=$G(^RCRP(340.5,RCIEN,2,RCI,0)),RCPDFLG=$P(RCPD,U,2)
 . I 'RCPDFLG D
 . . S DR="1////1"
 . . S DA(1)=RCIEN,DA=RCI
 . . S DIE="^RCRP(340.5,"_DA(1)_",2,"
 . . D ^DIE
 Q
 ;
UPDBAL(RCBILLDA,RCTRANDA,RCSPFLG) ; Update the Plan Amount Owed (#.11) in the AR
 ; REPAYMENT PLAN file (#340.5).
 ;
 ;INPUT:  RCBILLDA - IEN to ACCOUNTS RECEIVABLE file (#430)
 ;        RCTRANDA - IEN to the AR TRANSACTION file (#433)
 ;        RCSPFLG  - (Optional) Is the update a result of a bill being suspended.
 ;
 N RCIEN,RCTRTYPE,RCRPPFLG,RCAMT,RCPYMNTS,RCRMBAL,RCMNPY,RCNOMN,RCNWLN,RCNWMOD
 ;
 ;Initialize the RCSPFLG if not sent in
 S RCSPFLG=+$G(RCSPFLG)
 ;
 ; Check to see if Bill has an active Repayment Plan.  Exit if not
 S RCIEN=$$GET1^DIQ(430,RCBILLDA_",",45,"I")
 Q:RCIEN=""
 ;
 S RCTRTYPE=$$GET1^DIQ(433,RCTRANDA_",",12,"I")
 Q:RCTRTYPE=""
 ;
 ; remove bill from RPP if transaction type is "charge suspended"
 I RCTRTYPE=47 D 
 . D REMBILL^RCRPU(RCIEN,RCBILLDA)  ; REMOVE BILL FROM PLAN
 . D RMVPLN(RCBILLDA,0)               ; REMOVE PLAN FROM BILL,but don't file close transaction.
 ;
 ; Check to see if the Transaction type has an affect on the Repayment Plan
 ; Exit if the Transaction will not affect it.
 S RCRPPFLG=$$GET1^DIQ(430.3,RCTRTYPE_",",6,"I")
 Q:RCRPPFLG=""
 ;
 ; Extract the amount of the transaction.  Quit if no transaction amount filed.
 S RCAMT=$$GET1^DIQ(433,RCTRANDA_",",15,"I")
 Q:+RCAMT=0
 ;
 ; If the Transaction Type Repayment Plan Processing flag is set to P
 ;  then process the Transaction Type as a Payment and exit.
 I RCRPPFLG="P" D  Q
 . D UPDPAY(RCIEN,RCTRANDA,RCAMT)
 ;
 ; Retrieve the remaining Balance.
 S RCRMBAL=$$GET1^DIQ(340.5,RCIEN_",",.11,"I")
 ;
 ; If the transaction is supposed to be a decrease, then make the
 ;  transaction amount negative
 S:RCRPPFLG="D" RCAMT=-RCAMT
 ;
 ; Add (subtract if it is a decrease) the amount to the remaining balance.
 S RCRMBAL=RCRMBAL+RCAMT
 ;
 ; Store the new Balance.
 D UPDPAO(RCIEN,RCRMBAL)
 ;
 ; Recalculate terms with the new balance
 S RCMNPY=$$GET1^DIQ(340.5,RCIEN_",",.06,"I")
 S RCNOMN=$$GET1^DIQ(340.5,RCIEN_",",.05,"I")
 S RCNWLN=RCRMBAL\RCMNPY,RCNWMOD=RCRMBAL#RCMNPY
 I RCNWMOD>0 S RCNWLN=RCNWLN+1
 ;
 ; If there is a change in term length, update the plan.
 I RCNOMN'=RCNWLN D UPDTERMS(RCIEN,RCMNPY_U_RCNWLN),ADJSCHED^RCRPENTR(RCIEN,RCNOMN,RCNWLN)
 ;
 ;Check current balance.  If 0 or lower, close the plan as paid in full
 S RCPYMNTS=$$PMNTS^RCRPINQ(RCIEN)
 I (RCRMBAL-RCPYMNTS)'>0 D
 . D PAID(RCIEN,RCSPFLG)
 . I RCSPFLG D TRAN^RCRPU(RCBILLDA,0,68)      ; file transaction if the bill which closed the plan was suspended.
 ;
 Q
 ;
UPDPAO(RCIEN,RCAMT) ; Update the terms of the plan.
 ;
 N DR,DIE,DA,X,Y
 S DR=".11////"_RCAMT
 S DIE="^RCRP(340.5,",DA=RCIEN
 D ^DIE
 Q
 ;
PAID(RCIEN,RCSPFLG) ; Repayment Plan is paid in full, update the status to PAID IN FULL and attempt to remove plan information from bills in plan.
 ;
 N RCI,RCBILLDA
 ;
 ;Update the plan status to Paid in Full. If not suspended
 I '+RCSPFLG D
 . D UPDSTAT(RCIEN,8)
 . I '$D(ZTQUEUED) W !!,"This repayment plan has been closed and is PAID IN FULL.",!!
 ;
 ;Update the plan status to Closed because remaining bill(s) suspended AND exit.
 I RCSPFLG D  Q
 . D UPDSTAT(RCIEN,7)
 . D UPDAUDIT^RCRPU(RCIEN,$$DT^XLFDT,"C","A")   ; AUDIT LOG
 . ;I '$D(ZTQUEUED) W !!,"This repayment plan has been CLOSED.",!!
 ;
 ;Remove the Plan info from the bills is the Bill is at a 0 balance, or is Suspended, Terminated or written off.
 S RCI=0
 F  S RCI=$O(^RCRP(340.5,RCIEN,6,RCI)) Q:'RCI  D
 .  S RCBILLDA=$G(^RCRP(340.5,RCIEN,6,RCI,0))
 .  Q:'RCBILLDA
 .  D RMVPLN(RCBILLDA,1)
 Q
 ;
RMVPLN(RCBILLDA,RCNOCLS) ;Remove the Plan info from a bill and file a Close Plan Transaction file.
 ; Input:  RCBILLDA - IEN of the AR Bill (from file #430) to remove 
 ;         RCNOCLS  - (Optional) - Flag to indicate whether to file a close Repayment Plan transaction or not.
 N X,Y,DIC,DIE,DR,RCAMT,PRCA
 ;
 ;Init RC NOCLS if necessary
 S RCNOCLS=+$G(RCNOCLS)
 ;
 ;Store the RPP IEN into the AR file (#430) AR Repayment Plan (#45) field. 
 S (DIC,DIE)="^PRCA(430,",DA=RCBILLDA,DR="41////@;45////@"
 S PRCA("LOCK")=0 D LOCKF^PRCAWO1 D:PRCA("LOCK")=0 ^DIE
 K DA,DIC,DIE,DR
 ;get the current amount owed.
 ;File a Close Plan Transaction into the Transaction file.
 D:RCNOCLS TRAN^RCRPU(RCBILLDA,0,68)
 Q
 ;
STATUS(RCRPIEN) ; Returns the current status of the plan.
 ;
 N RCD0,RCFRDT,RCSTAT,RCLSTDT,RCSTATDT,RCCURDT,RCDIFF
 ;
 S RCD0=$G(^RCRP(340.5,RCRPIEN,0))
 S RCFRDT=$P(RCD0,U,4)
 S RCSTAT=$P(RCD0,U,7)
 S RCSTATDT=$P(RCD0,U,8)
 S RCCURDT=$$DT^XLFDT                  ;Get current date
 I RCSTAT=5,RCCURDT>RCSTATDT Q 6       ;plan is defaulted, set new status to terminate and exit.
 I RCSTAT>5 Q RCSTAT                   ;Plan is closed
 I RCSTAT=1,RCCURDT<RCFRDT Q 1         ;Plan hasn't started yet.  Status stays New
 S RCLSTDT=$$GETNXTPY^RCRPU(RCRPIEN)   ;get the date of the next payment due
 I RCLSTDT="" Q 8                      ;No payments left, plan is Paid in Full.
 S RCDIFF=$$FMDIFF^XLFDT(RCCURDT,RCLSTDT,1)
 S RCSTAT=$S(RCDIFF>90:5,RCDIFF>30:4,RCDIFF>0:3,1:2)
 Q RCSTAT
