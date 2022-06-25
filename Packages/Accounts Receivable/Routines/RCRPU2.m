RCRPU2 ;EDE/YMG-REPAYMENT PLAN UTILITIES;02/03/2021  8:40 AM
 ;;4.5;Accounts Receivable;**381**;Mar 20, 1995;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
RECALL(BILL,RSN) ; recall bill from cross-servicing
 ;
 ; BILL - bill to recall (file 430 ien)
 ; RSN  - recall reason to use (code for field 430/154)
 ;
 ; returns 1 on success, 0^error on failure
 ;
 N DIERR,FDA,IENS
 I BILL'>0 Q "0^Invalid file 430 ien"
 I RSN="" Q "0^Invalid recall reason"
 L +^PRCA(430,BILL):5 I '$T Q "0^Unable to lock entry"
 S IENS=BILL_","
 S FDA(430,IENS,152)=1
 S FDA(430,IENS,154)=RSN
 D FILE^DIE("","FDA","DIERR")
 I $D(DIERR("DIERR")) Q "0^"_$G(DIERR("DIERR",1,"TEXT",1))
 L -^PRCA(430,BILL)
 D CSRCLPL^RCTCSPD5 ; CS Recall Placed comment tx in 433
 Q 1
 ;
DISPREF(TYPE) ; display referred bills
 ;
 ; TYPE - type of bills to display: 0 = TSCP, 1 = TOP/DMC
 ;
 ; assumes that ^TMP("RCRPP",$J,"CS") is populated
 ;
 N AMT,BILL,BILLNO,CAT,CATN,CS,DATA,DOS,HDRFLG,LEN,STAT,STATN,RCLRES,TSCP,Z
 S TSCP="",HDRFLG=0
 S Z="" F  S Z=$O(^TMP("RCRPP",$J,"CS",Z)) Q:'Z  D
 .S DATA=$G(^TMP("RCRPP",$J,"CS",Z)) Q:DATA=""
 .S BILL=$P(DATA,U)  ; file 430 ien
 .S CS=$P(DATA,U,7)  ; CS type: 1 = TSCP, 2 = DMC, 3 = TOP
 .I 'TYPE,CS'=1 Q    ; not at TSCP
 .I TYPE,CS'>1 Q     ; not at TOP/DMC
 .S BILLNO=$P(DATA,U,2),AMT=$P(DATA,U,3),DOS=$P(DATA,U,4),STAT=$P(DATA,U,5),CAT=$P(DATA,U,6)
 .S CATN=$P($G(^PRCA(430.2,CAT,0)),U),STATN=$P($G(^PRCA(430.3,STAT,0)),U)
 .I 'HDRFLG D
 ..I 'TYPE W !!,"Bills at Treasury for Cross-Servicing Debt Collection:",!
 ..I TYPE W !!,"Bills in either the Treasury Offset Program or the Debt Management Collection:",!
 ..S HDRFLG=1
 ..Q
 .; add bill to the list of TSCP bills
 .I 'TYPE S TSCP=$S(TSCP'="":",",1:"")_BILL
 .; display bill info
 .W !,BILLNO,?21,$E(CATN,1,24),?47,$TR($$FMTE^XLFDT(DOS,"2DZ"),"/","-"),?57,STATN,?67,"$",$J(AMT,8,2) W:TYPE ?77,$S(CS=2:"DMC",CS=3:"TOP",1:"")
 .Q
 I HDRFLG D
 .I TYPE W !!,"Review these bills to see if they should be included into the Repayment Plan.",! D PAUSE^RCRPU Q
 .; TSCP bills
 .W !
 .;Ask user if these bills should be recalled.
 .I $$ASKRCL()=1 S LEN=$L(TSCP,",") D
 ..F Z=1:1:LEN D
 ...; recall bill
 ...S BILL=$P(TSCP,",",Z),RCLRES=$$RECALL(BILL,"08")
 ...I +RCLRES<0 W !,"Recall failed for bill ",$$GET1^DIQ(430,BILL_",",.01)," - ",$P(RCLRES,U,2)
 ...Q
 ..W !!,"Recalls have been placed for the above bills."
 ..Q
 .Q
 Q
 ;
ASKRCL() ; display "recall bills?" prompt
 ;
 ; returns 1 for Yes, 0 for No, -1 for no selection
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("A")="Do you wish to recall these bills? (Y/N)",DIR("B")="NO"
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q Y
 ;
ASKCONT() ; display "press return to continue or ^ to quit" prompt
 ;
 ; returns 1 if user pressed <enter>, 0 on user exit.
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W ! S DIR(0)="E" D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q 0
 Q 1
 ;
UPDRVW(RCIEN,RCFLG) ; Update the Review Flag
 ;INPUT - RCIEN:  IEN of the Repayment Plan
 ;        RCFLG:  Value of the flag.
 ;                1        : To appear on the Term Length Exceeded Report
 ;                0 or NULL: Does not appear on the Term Length Exceeded Report
 ;
 N DA,DR,DIE,X,Y
 S DA=RCIEN,DIE="^RCRP(340.5,"
 S DR="1.01///"_RCFLG_";1.05////"_$$DT^XLFDT
 D ^DIE
 Q
 ;
UPDATCS(RCIEN,RCATCS) ; Update the AT CS Flag
 ;INPUT - RCIEN:  IEN of the Repayment Plan
 ;        RCATCS: The new value of the AT CS? (field 1.04) in the Repayment Plan 
 ;
 N DA,DR,DIE,X,Y
 S RCATCS=+$G(RCATCS)
 S DA=RCIEN,DIE="^RCRP(340.5,"
 S DR="1.04///"_RCATCS
 D ^DIE
 Q
 ;
CALCTOT(RCIEN) ; Calculate the total amount due on a Repayment Plan.
 ;INPUT - RCIEN - IEN of the Repayment Plan
 ;Returns - RCTOT - Total amount due.
 N RCTOT,RCBLLP,RCBLNO,RCI,RCD7
 S RCTOT=0,RCBLLP=0
 F  S RCBLLP=$O(^RCRP(340.5,RCIEN,6,RCBLLP)) Q:'RCBLLP  D
 . S RCBLNO=$G(^RCRP(340.5,RCIEN,6,RCBLLP,0))
 . Q:'RCBLNO  ; Bill number not stored correctly, get next bill.
 . S RCD7=$G(^PRCA(430,RCBLNO,7))
 . F RCI=1:1:5 S RCTOT=RCTOT+$P(RCD7,U,RCI)  ;add fields 71-75 to running total
 Q RCTOT
 ;
