RCRPNP ;EDE/SAB - REPAYMENT PLAN UTILITIES;12/31/2020  8:40 AM
 ;;4.5;Accounts Receivable;**378,389,423**;Mar 20, 1995;Build 8
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
MAIN ; Entry Point for the nightly process
 ;
 D UPDSTAT
 D ADDBILLS
 D UPDCS
 Q
 ;
UPDSTAT ;Review all active plans to determine their current status.
 ;
 N RCI,RCJ,RCD0,RCCURST,RCNEWST,RCCRDT,RCSTSTRT,RCSTEND
 ;Loop through the Repayment Plan file
 ;
 ; Start calculating execution time
 S RCSTSTRT=$H
 ;
 S RCI=0
 S RCCRDT=$$DT^XLFDT  ;Set the current date
 ;
 F  S RCI=$O(^RCRP(340.5,RCI)) Q:'RCI  D
 . S RCD0=$G(^RCRP(340.5,RCI,0))
 . Q:'RCD0
 . ; Extract current status.
 . S RCCURST=$P(RCD0,U,7)
 . ;recalculate the status
 . S RCNEWST=$$STATUS^RCRPU1(RCI)
 . ;
 . ;If the status is different
 . I RCCURST'=RCNEWST D
 . . ; Update the status to the New Status
 . . D UPDSTAT^RCRPU1(RCI,RCNEWST)
 . . ; If the new status is Defaulted (5), update the PRINT DEFAULTED flag (1.02)
 . . I RCNEWST=5 D UPDPRDF(RCI,1)
 . . ; If the new status is Delinquent (4), update the PRINT DEFAULTED flag (1.03)
 . . I RCNEWST=4 D UPDPRDL(RCI,1)
 . . ; If the new status is Terminated
 . . I RCNEWST=6 D 
 . . . ;   Loop through each Bill
 . . . S RCJ=0
 . . . F  S RCJ=$O(^RCRP(340.5,RCI,6,RCJ)) Q:'RCJ  D
 . . . . S RCBILLDA=$G(^RCRP(340.5,RCI,6,RCJ,0))
 . . . . Q:'RCBILLDA
 . . . . ;  remove fields 41 and 45 from the bill
 . . . . D RMVPLN^RCRPU1(RCBILLDA)
 . . . . D TRAN^RCRPU(RCBILLDA,0,69)  ; file "RPP Terminated" transaction  PRCA*4.5*389
 . . . D UPDAUDIT^RCRPU2(RCI,RCCRDT,"C","S") ;Update Audit Log with System Termination Comment
 ;
 ; Update Processing time metrics
 S RCSTEND=$H
 D UPDMET^RCSTATU(2.03,$$HDIFF^XLFDT(RCSTEND,RCSTSTRT,2))
 Q
 ;
ADDBILLS ;Review a debtor and all non referred, Active bills to the plan.
 ;
 N RCACTDT,RCBILLDA,RCRPIEN,RCSTAT,RCACTIVE,RCDBTR,RCSTP,RCD0,RCRPSTAT,RCD7,RCAMT,RCMNPY,RCNOMN,RCNWLN,RCRPD0
 N RCNWMN,RCPLNBL,RCRMLN,RCSTSTRT,RCSTEND,RCREV36
 N RCFLG36,RCFLG60,RCQUIT  ; PRCA*4.5*423
 ;
 ; Start calculating execution time
 S RCSTSTRT=$H
 ;
 S RCACTDT=$$DT^XLFDT
 S (RCREV36,RCRPIEN)=0  ; PRCA*4.5*389
 F  S RCRPIEN=$O(^RCRP(340.5,RCRPIEN)) Q:'RCRPIEN  D
 .; Check to see if the plan is active.  If not, skip it and grab the next
 .S RCRPD0=$G(^RCRP(340.5,RCRPIEN,0)) Q:RCRPD0=""
 .Q:'+$P(RCRPD0,U,12)  ; Quit if the Repayment Plan's AUTO ADD field is not set to Yes (it is No or NULL)
 .S RCRPSTAT=$P(RCRPD0,U,7)
 .Q:RCRPSTAT>5   ;Plan is TERMINATED, CLOSED or PAID IN FULL.
 .; If the plan is under review, don't attempt to add bills
 .S RCFLG60=+$$GET1^DIQ(340.5,RCRPIEN_",",1.01,"I") ;  PRCA*4.5*423
 .S RCFLG36=$$GET36^RCRPWLUT(RCRPIEN) ;  PRCA*4.5*423
 .S RCRMLN=$$REMPMNTS^RCRPU3(RCRPIEN,$$GET1^DIQ(340.5,RCRPIEN_",",.06,"I")) ;  PRCA*4.5*423
 .D CHKFLGS^RCRPU1(RCRPIEN,RCRMLN,RCFLG36,RCFLG60)  ; PRCA*4.5*423
 .I RCFLG60 Q  ; don't add bills if plan length > 57 months PRCA*4.5*423
 .I RCRMLN>36,RCFLG36'=1 Q  ; don't add bills if plan length > 36 months and there's no approval PRCA*4.5*423
 .; Find the Debtor.
 .S RCDBTR=$$GET1^DIQ(340.5,RCRPIEN_",",.02,"I")
 .; Loop through the Active Bills for the Debtor
 .S RCACTIVE=$O(^PRCA(430.3,"B","ACTIVE",""))  ; Get the Active Status IEN
 .S (RCQUIT,RCBILLDA)=0 ;  PRCA*4.5*423
 .; Loop through all bills or until plan is flagged for review.
 .F  S RCBILLDA=$O(^PRCA(430,"AS",RCDBTR,RCACTIVE,RCBILLDA)) Q:'RCBILLDA  Q:RCQUIT  D
 ..; Only look at First Party Bills
 ..Q:'$$FIRSTPAR(+RCBILLDA)
 ..; Skip if bill already in plan.
 ..Q:+$$GET1^DIQ(430,RCBILLDA_",",45,"I")
 ..; Exclude bills referred to CS, TOP, or DMC
 ..S RCCSDT=+$$GET1^DIQ(430,RCBILLDA_",",151,"I")    ; get CS Date referral date
 ..S RCCSRCDT=+$$GET1^DIQ(430,RCBILLDA_",",153,"I")  ; get CS Recall date
 ..I RCCSDT,'RCCSRCDT Q    ;If still at Cross Servicing, the don't add bill to plan.
 ..Q:+$$GET1^DIQ(430,RCBILLDA_",",121,"I")    ; Bill at DMC, quit, don't add bill to plan
 ..I +$$GET1^DIQ(430,RCBILLDA_",",141,"I"),+$$GET1^DIQ(430,RCDBTR_",",6.02,"I") Q    ; Bill still at TOP, quit, don't add bill to plan
 ..; Add the Bill to the plan.
 ..D UPDBILL^RCRPU(RCRPIEN,RCBILLDA)
 ..; Add Plan to the Bill
 ..D ADDPLAN^RCRPU(RCRPIEN,RCBILLDA,RCACTDT)
 ..; Update the Total balance Owed.
 ..S RCD7=$G(^PRCA(430,RCBILLDA,7))
 ..S RCD0=$G(^PRCA(430,RCBILLDA,0))
 ..S RCAMT=$S(+RCD7:$P(RCD7,U,1)+$P(RCD7,U,2)+$P(RCD7,U,3)+$P(RCD7,U,4)+$P(RCD7,U,5),1:$P(RCD0,U,3))
 ..S RCPLNBL=$$GET1^DIQ(340.5,RCRPIEN_",",.11,"I")  ;get the current Plan amount Owed value.
 ..D UPDPAO^RCRPU1(RCRPIEN,RCAMT+RCPLNBL)
 ..;Calculate the new remaining balance
 ..S RCPLNBL=$$GET1^DIQ(340.5,RCRPIEN_",",.11,"I")  ;get the new Plan amount Owed value.
 ..; Recalculate the total # payments.
 ..S RCMNPY=$$GET1^DIQ(340.5,RCRPIEN_",",.06,"I")
 ..S RCNOMN=$$GET1^DIQ(340.5,RCRPIEN_",",.05,"I")
 ..S RCNWMN=RCPLNBL\RCMNPY,RCNWMOD=RCPLNBL#RCMNPY
 ..I RCNWMOD>0 S RCNWMN=RCNWMN+1
 ..; Calculate the # payments remaining
 ..S RCRMLN=$$REMPMNTS^RCRPU3(RCRPIEN,RCMNPY)  ; PRCA*4.5*389
 ..; If there is a change in term length, update the plan and the schedule.
 ..I RCNOMN'=RCNWMN D
 ...D UPDTERMS^RCRPU1(RCRPIEN,RCMNPY_"^"_RCNWMN)
 ...D ADJSCHED^RCRPENTR(RCRPIEN,RCNOMN,RCNWMN)
 ...I RCNWMN>36,RCFLG36'=1 S RCREV36=1  ; PRCA*4.5*389
 ...Q
 ..D CHKFLGS^RCRPU1(RCRPIEN,RCRMLN,RCFLG36,RCFLG60)  ; PRCA*4.5*423
 ..I +$$GET1^DIQ(340.5,RCRPIEN_",",1.01,"I")!($$GET36^RCRPWLUT(RCRPIEN)=0) S RCQUIT=1 ;  PRCA*4.5*423
 ..;
 ..;Update Audit Log
 ..D UPDAUDIT^RCRPU2(RCRPIEN,$$DT^XLFDT,"A","")
 ..;
 ..;Update the AR Metrics File with activity
 ..D UPDMET^RCSTATU(1.02,1)
 ..Q
 .Q
 I RCREV36 D MSGREV^RCRPWLUT  ; send Mailman notification for plans that need 36 months review  PRCA*4.5*389
 ; Update Processing time metrics
 S RCSTEND=$H
 D UPDMET^RCSTATU(2.02,$$HDIFF^XLFDT(RCSTEND,RCSTSTRT,2))
 Q
 ;
UPDCS ;Review all bills for the Debtor to see if any are still in Cross Service Debt Referral
 ;
 N RCIEN,RCD0,RCD1,RCSTAT,RCDBTR,RCOLDCS,RCNEWCS,RCBILL,RCBLSTAT,RCCSDT,RCCSRCDT
 ;
 ; Start calculating execution time
 S RCSTSTRT=$H
 ;
 ;Loop through all active Repayment Plans
 S RCIEN=0
 F  S RCIEN=$O(^RCRP(340.5,RCIEN)) Q:'RCIEN  D
 . S RCD0=$G(^RCRP(340.5,RCIEN,0)),RCD1=$G(^RCRP(340.5,RCIEN,1))
 . S RCSTAT=$P(RCD0,U,7)
 . Q:RCSTAT>5
 . ; extract the debtor, and the AT CS flag
 . S RCDBTR=$P(RCD0,U,2),RCOLDCS=$P(RCD1,U,4)
 . ; find all of the bills associated with that debtor
 . ; Initialize new AT CS flag to NULL
 . S RCNEWCS=0,RCBILL=0
 . F  S RCBILL=$O(^PRCA(430,"C",RCDBTR,RCBILL)) Q:'RCBILL  D  Q:RCNEWCS=1
 . . ; for each active bill
 . . S RCBLSTAT=$$GET1^DIQ(430,RCBILL_",",8,"I")
 . . Q:RCBLSTAT'=16
 . . ; Check to see if it is at cross servicing
 . . S RCCSDT=$$GET1^DIQ(430,RCBILL_",",151,"I")
 . . Q:'+RCCSDT           ;quit if not at Cross Servicing
 . . ;If at cross servicing (field 151 with data and 153 with no data), then set new AT CS flag = 1 and quit loop
 . . S RCCSRCDT=$$GET1^DIQ(430,RCBILL_",",153,"I")
 . . S:'+RCCSRCDT RCNEWCS=1
 . ; If the current AT CS flag matches the new AT CS flag get the next debtor
 . I +RCOLDCS'=+RCNEWCS D UPDATCS^RCRPU2(RCIEN,RCNEWCS)
 . ;If a bill has been newly referred to CS, send an alert to investigate
 . I '+RCOLDCS,+RCNEWCS D CSALERT^RCSTATU(RCBILL,RCIEN)
 ;
 ; Update Processing time metrics
 S RCSTEND=$H
 D UPDMET^RCSTATU(2.01,$$HDIFF^XLFDT(RCSTEND,RCSTSTRT,2))
 Q
 ;
UPDPRDL(RCIEN,RCFLG) ; Update the Print Deliquent Flag
 ;INPUT - RCIEN:  IEN of the Repayment Plan
 ;        RCFLG:  Value of the flag.
 ;                1        : To appear on the Print Delinquent Report
 ;                0 or NULL: Does not appear on the Print Delinquent Report
 ;
 N DA,DR,DIE,X,Y
 S DA=RCIEN,DIE="^RCRP(340.5,"
 S DR="1.03///"_RCFLG
 D ^DIE
 Q
 ;
UPDPRDF(RCIEN,RCFLG) ; Update the Print Default flag
 ;INPUT - RCIEN:  IEN of the Repayment Plan
 ;        RCFLG:  Value of the flag.
 ;                1        : To appear on the Print Default Report
 ;                0 or NULL: Does not appear on the Print Default Report
 ;
 N DA,DR,DIE,X,Y
 S DA=RCIEN,DIE="^RCRP(340.5,"
 S DR="1.02///"_RCFLG
 D ^DIE
 Q
 ;
FIRSTPAR(RCBILLDA) ; Check to see if the AR Category is a First Party AR Category.
 N RCCAT
 ;
 S RCCAT=+$$GET1^DIQ(430,RCBILLDA_",",2,"I")
 ;Retrieve whether or not the category is eligible for inclusion into a Repayment Plan.
 Q $$GET1^DIQ(430.2,RCCAT_",",1.06,"I")
 ;
BLDSTARY() ;Build a ^TMP array to define the field to store any status movement metrics in file #340.7
 ;
 ; Status Set of Code values
 ; NEW - 1
 ; CURRENT - 2
 ; LATE - 3
 ; DELINQUENT - 4
 ; DEFAULT - 5
 ; TERMINATED - 6
 ; CLOSED - 7
 ; PAID IN FULL - 8
 ;
 ;Clear any potential older arrays
 K ^TMP($J,"RPPFLDNO")
 ;
 ;Set the array
 S ^TMP($J,"RPPFLDNO",1,2)=1.11    ;New to Current
 S ^TMP($J,"RPPFLDNO",2,3)=1.12    ;Current to Late
 S ^TMP($J,"RPPFLDNO",3,4)=1.13    ;Late to Delinquent
 S ^TMP($J,"RPPFLDNO",4,5)=1.14    ;Delinquent to Defaulted
 S ^TMP($J,"RPPFLDNO",5,6)=1.15    ;Defaulted to Terminated
 S ^TMP($J,"RPPFLDNO",3,2)=1.16    ;Late to Current
 S ^TMP($J,"RPPFLDNO",4,3)=1.17    ;Delinquent to Late
 S ^TMP($J,"RPPFLDNO",4,2)=1.18    ;Delinquent to Current
 S ^TMP($J,"RPPFLDNO",5,4)=1.19    ;Defaulted to Delinquent
 S ^TMP($J,"RPPFLDNO",5,3)=1.21    ;Defaulted to Late
 S ^TMP($J,"RPPFLDNO",5,2)=1.22    ;Defaulted to Current
 S ^TMP($J,"RPPFLDNO",2,8)=1.23    ;Current to Paid in Full
 S ^TMP($J,"RPPFLDNO",3,8)=1.24    ;Late to Paid in Full
 S ^TMP($J,"RPPFLDNO",4,8)=1.25    ;Delinquent to Paid in Full
 S ^TMP($J,"RPPFLDNO",5,8)=1.26    ;Defaulted to Paid in Full
 S ^TMP($J,"RPPFLDNO",2,7)=1.29    ;New to Closed
 S ^TMP($J,"RPPFLDNO",3,7)=1.31    ;Current to Closed
 S ^TMP($J,"RPPFLDNO",4,7)=1.32    ;Late to Closed
 S ^TMP($J,"RPPFLDNO",5,7)=1.33    ;Delinquent to Closed
 S ^TMP($J,"RPPFLDNO",1,8)=1.34    ;New to Paid in Full
 Q
