RCDPESP7 ;AITC/PJH - ePayment Lockbox Site Parameters Definition - auto-decrease ;29 Jan 2019 18:00:14
 ;;4.5;Accounts Receivable;**298,304,318,321,326,345**;Mar 20, 1995;Build 34
 ;Per VA Directive 6402, this routine should not be modified.
 ;
PAID(PARMTYP) ;function, Paid claim auto-decrease parameters, PRCA*4.5*345 added PARMTYP
 ; PARMTYP = 1: Paid Pharmacy Auto-Decrease, 0: Paid Medical Auto-Decrease
 ;   Optional, defaults to 0
 ; Returns 0:CONTINUE, 1:ABORT , 2:SKIP
 ;
 ; PRCA*4.5*345 logic changed below, FLD and CLMTYP variables added
 N ADAMT,ADMC,ADNAMT,CLMTYP,DIR,DTOUT,DUOUT,FDAEDI,FLD,RCAUDVAL,RCOK,RCQUIT,X,Y
 S:'$G(PARMTYP) PARMTYP=0,CLMTYP="MEDICAL"
 S:$G(PARMTYP) CLMTYP="PHARMACY"
 S FLD=$S(PARMTYP=0:.03,1:1.02)
 S ADMC=$$GET1^DIQ(344.61,"1,",FLD,"I")
 S DIR(0)="YA",DIR("B")=$S(ADMC=""!(ADMC=1):"Yes",1:"No")
 ;
 S DIR("A")="ENABLE AUTO-DECREASE OF "_CLMTYP_" CLAIMS WITH PAYMENTS (Y/N): "
 S DIR("?")=$$GET1^DID(344.61,FLD,,"HELP-PROMPT")
 W ! D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 ;
 ; If user changed value, update and audit
 S FLD=$S(PARMTYP=0:.03,1:1.02)
 I ADMC'=Y D  ;
 . S FDAEDI(344.61,"1,",FLD)=Y
 . S RCAUDVAL(1)="344.61^"_FLD_"^1^"_Y_U_ADMC
 . D:$D(FDAEDI) FILE^DIE(,"FDAEDI"),AUDIT^RCDPESP(.RCAUDVAL)
 . K RCAUDVAL
 I Y=0 Q 2  ; Value set to No, update if needed
 ;
 ; Set auto-decrease maximum amount
ADAMT ; BEGIN - PRCA*4.5*326
 S FLD=$S(PARMTYP=0:.05,1:1.04),ADAMT=$$GET1^DIQ(344.61,"1,",FLD)
 K DIR
 S DIR("B")=ADAMT
 S DIR("?")=$$GET1^DID(344.61,FLD,,"HELP-PROMPT")
 S DIR(0)="NA^0:99999:0"
 S DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,FLD,,"TITLE"))
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 I ADAMT'=Y D
 . S FDAEDI(344.61,"1,",FLD)=Y,RCAUDVAL(2)="344.61^"_FLD_"^1^"_Y_U_ADAMT
 S ADNAMT=Y
 ;
 ; Check if any CARCs need reset and give choice to proceed
 S RCOK=$$CARCDSP^RCDPESP5(ADNAMT,PARMTYP)
 ;
 ; Finish if user exit selected
 Q:RCOK="QUIT" 1
 ;
 ; If user chooses to not reset then go back to re-enter maximum
 I RCOK=0 K FDAEDI(344.61,"1,",FLD),RCAUDVAL(2) G ADAMT
 ; END - PRCA*4.5*326
 ;
 ; File changes to Medical/Pharmacy Auto-Decrease parameters
 D:$D(FDAEDI) FILE^DIE(,"FDAEDI")
 D:$D(RCAUDVAL) AUDIT^RCDPESP(.RCAUDVAL)
 K FDAEDI,RCAUDVAL
 ; PRCA*4.5*345 - updated logic below with FLD and PARMTYP
 ; If auto-decrease on, ask about CARC/RARC auto-decrease setup
 W ! S RCQUIT=0 D CARC^RCDPESP5(.RCQUIT,1,PARMTYP)
 W ! S FLD=$S(PARMTYP=0:.03,1:1.02)
 ;
 ; If no active CARCs Turn medical Auto-Decrease off 
 I ($$COUNT^RCDPESP(1,0,PARMTYP)=0),($$GET1^DIQ(344.61,"1,",FLD,"I")=1) D  Q 2
 . N FDAEDI,MSGTXT,RCAUDVAL
 . S ADMC=$$GET1^DIQ(344.61,"1,",FLD,"I")
 . S FDAEDI(344.61,"1,",FLD)=0
 . S RCAUDVAL(1)="344.61^"_FLD_"^1^"_0_U_ADMC_U
 . S MSGTXT="SYSTEM disabled "_$S(PARMTYP=0:"Medical",1:"Pharmacy")_" Auto-decrease, there are NO active CARCs"
 . S RCAUDVAL(1)="344.61^"_FLD_"^1^"_0_U_ADMC_U_MSGTXT
 . D FILE^DIE(,"FDAEDI"),AUDIT^RCDPESP(.RCAUDVAL)
 . W !,"*** The "_MSGTXT_".",!
 . D PAUSE^RCDPESP
 Q:RCQUIT 1
 ;
 Q 0
 ;
NOPAY(CLMTYP) ; function, No-payment claim auto-decrease parameters
 ; PRCA*4.5*345- Added CLMTYP
 ; Input CLMTYP - 0: Medical Claims, 1:Pharmacy
 ; Returns: 0: no issues, 1: ABORT, 2: SKIP
 ;
 ; If auto-decrease of paid claims is off skip auto-decrease no-pay parameters
 Q:'$$GET1^DIQ(344.61,"1,",.03,"I") 0
 N ADMC,ADMT,DIR,DTOUT,DUOUT,FDAEDI,FLD,RCAUDVAL,RCQUIT,X,Y
 S ADMC=$$GET1^DIQ(344.61,"1,",.11,"I")  ; Get current value
 S DIR(0)="YA",DIR("B")=$S(ADMC=""!(ADMC=1):"Yes",1:"No")
 ;
 S DIR("A")="ENABLE AUTO-DECREASE OF "_$S(CLMTYP=0:"MEDICAL",1:"PHARMACY")_" CLAIMS WITH NO PAYMENTS (Y/N): "
 S DIR("?")=$$GET1^DID(344.61,.11,,"HELP-PROMPT")
 W !
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 ; if user changed value, update and audit
 I ADMC'=Y S FDAEDI(344.61,"1,",.11)=Y,RCAUDVAL(1)="344.61^.11^1^"_Y_U_ADMC
 ;
 I Y=0 D  Q 2  ; Value set to No, update (if needed), go to Pharmacy params.
 . I $D(FDAEDI) D FILE^DIE(,"FDAEDI"),AUDIT^RCDPESP(.RCAUDVAL) K RCAUDVAL
 ; If no-pay auto-decrease on, ask about CARC/RARC auto-decrease setup
 W !
 S RCQUIT=0 D CARC^RCDPESP5(.RCQUIT,0,CLMTYP)
 W !
 ; If no active CARCs Turn medical no-pay auto-decrease off, Then go to Pharmacy params
 S ADMC=$$GET1^DIQ(344.61,"1,",.11,"I")
 I ($$COUNT^RCDPESP(1,1,CLMTYP)=0)&(ADMC=1) D  Q 1
 . N FDAEDI,MSGTXT,RCAUDVAL
 . S FDAEDI(344.61,"1,",.11)=0
 . S MSGTXT="SYSTEM disabled MEDICAL No-pay Auto-decrease, there are NO active CARCs"
 . S RCAUDVAL(1)="344.61^.11^1^0^"_ADMC_U_MSGTXT
 . D FILE^DIE(,"FDAEDI"),AUDIT^RCDPESP(.RCAUDVAL)
 . W !,"*** The "_MSGTXT,!
 . D PAUSE^RCDPESP
 Q:RCQUIT 1
 ;
 ; Set number of days to wait before no-pay auto-decrease amount
 S FLD=.12,ADMT=$$GET1^DIQ(344.61,"1,",.12)
 K DIR
 S:ADMT'="" DIR("B")=ADMT
 S DIR("?")=$$GET1^DID(344.61,FLD,,"HELP-PROMPT"),DIR(0)="NA^0:45:0"
 S DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,FLD,,"TITLE"))
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 I ADMT'=Y D  ;
 . S FDAEDI(344.61,"1,",.12)=Y
 . S RCAUDVAL(2)="344.61^.12^1^"_Y_U_ADMT
 . ; File changes to medical no-pay auto-decrease parameters
 . D FILE^DIE(,"FDAEDI")
 . D:$D(RCAUDVAL) AUDIT^RCDPESP(.RCAUDVAL)
 . K RCAUDVAL
 Q 0
 ;
