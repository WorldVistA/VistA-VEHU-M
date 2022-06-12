RCDPESP ;BIRM/EWL - ePayment Lockbox Site Parameters Definition - Files 344.61 & 344.6 ;29 Jan 2019 18:00:14
 ;;4.5;Accounts Receivable;**298,304,318,321,326,332,345**;Mar 20, 1995;Build 34
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; entry point for EDI Lockbox Parameters [RCDPE EDI LOCKBOX PARAMETERS]
 N DA,DIC,DIE,DIR,DIRUT,DLAYGO,DR,DTOUT,DUOUT,X,Y  ; FileMan variables
 ;
 W !," Update AR Site Parameters",!
 ;
 S X="RCDPE AUTO DEC" I '$D(^XUSEC(X,DUZ)) W !!,"You do not hold the "_X_" security key." Q
 ; Lock the parameter file
 L +^RCY(344.61,1):DILOCKTM E  D  Q
 . W !!," Another user is currently using the AR Site Parameters option."
 . W !," Please try again later."
 ;
 ; PRCA*4.5*326 - Once lock is successful, take a snapshot of the parameters for monitoring
 D EN^RCDPESP6
 ;
 ; Check parameter file
 N FDAEDI,FDAPAYER,IEN,IENS,RCQUIT
 ; FDAPAYER - FDA array for RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ; FDAEDI - FDA array for RCDPE PARAMETER file (#344.61)
 ; RCAUDVAL - audit data for RCDPE PARAMETER AUDIT file (#344.7)
 ; IEN - entry #
 ; IENS - IEN_comma
 ; RCQUIT - exit flag
 ;
 ; Call below answers:
 ; NUMBER OF DAYS EFT UNMATCHED
 ; NUMBER OF DAYS ERA UNMATCHED
 ; # OF DAYS ENTRY CAN REMAIN IN SUSP
 ; AUTO-DECREASE FIRST PARTY
 S Y=$$EDILOCK^RCMSITE  ; Update EDI Lockbox site parameters
 I 'Y G ABORT  ; user entered '^'
 ;
 ; PRCA*4.5*304 - Enable/disable auto-auditing of paper bills
 S RCQUIT=$$AUDIT^RCDPESP5  ; Auto-Audit site parameters
 I RCQUIT G ABORT ; PRCA*4.5*326 must have single exit point
 ;
 I '$D(^RCY(344.61,1,0)) W !!,"There is a problem with the RCDPE PARAMETER file (#344.61).",! G EXIT
 ;
 S RCQUIT=$$BULLDAY  ; Workload Notification Day parameter
 I RCQUIT G ABORT
 ;
  ; Ask Medical Claims Auto-Post/Auto-Decrease questions
 S RCQUIT=$$MPARMS
 I $G(RCQUIT) D ABORT Q
 W !
 ;
 ; Ask Rx Auto-Post/Auto-Decrease questions
 S RCQUIT=$$RXPARMS
 I $G(RCQUIT) D ABORT Q
 W !
 S RCQUIT=$$EFTLK  ; Set EFT lock-out paramters
 I $G(RCQUIT) D ABORT Q
 D EXIT Q
 ;
BULLDAY() ; Workload Notification Bulletin Days question
 ; (SELECT DAY TO SEND WORKLOAD NOTIFICATION)
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 ; PRCA*4.5*321 - New parameter
 N BULL,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FDAEDI,RCAUDVAL,X,Y
 ;
 S BULL=$$GET1^DIQ(344.61,"1,",.1,"I")
 K DIR
 S:BULL'="" DIR("B")=$$GET1^DIQ(344.61,"1,",.1,"E")
 S DIR("?")=$$GET1^DID(344.61,.1,,"HELP-PROMPT")
 S DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,.1,,"TITLE"))
 S DIR(0)="344.61,.1"
 W ! D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 I BULL'=Y D  ; update and audit
 . S RCAUDVAL(1)="344.61^.1^1^"_Y_U_BULL
 . S FDAEDI(344.61,"1,",.1)=Y
 . D FILE^DIE(,"FDAEDI")
 . D AUDIT(.RCAUDVAL)
 W !
 Q 0
 ; 
APOST(AUPSTYP,ONOFF) ; Turn Auto-Posting On/Off for Medical,RX Claims
 ; PRCA*4.5*345
 ; Input: AUPSTYP - 0 - Medical Auto-Posting, 1 - pharm Auto-Posting
 ; ONOFF passed by ref. 1 - Auto-Posting of Medical Claims with Payments on, 0 otherwise
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 N APCT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FLD,FDAEDI,RCAUDVAL
 S FLD=$S(AUPSTYP=0:.02,1:1.01)
 S APCT=$$GET1^DIQ(344.61,"1,",FLD,"I")
 S DIR(0)="YA",DIR("B")=$S((APCT=1)!(APCT=""):"Yes",1:"No")
 S DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,FLD,,"TITLE"))
 S DIR("?")=$$GET1^DID(344.61,FLD,,"HELP-PROMPT")
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 S ONOFF=Y
 I APCT'=Y D  ; User updated value
 . S FDAEDI(344.61,"1,",FLD)=Y
 . D FILE^DIE(,"FDAEDI")
 . D NOTIFY(Y)
 . S RCAUDVAL(1)="344.61^"_FLD_"^1^"_Y_U_APCT
 . D AUDIT(.RCAUDVAL)
 Q 0
 ;
MPARMS() ; Medical Claims Auto-Posting/Auto-Decrease questions
 ; function returns: 1 - User '^' or timed out, 0 otherwise
 N DIR,ONOFF,RCOLD,RCQUIT
 S RCQUIT=$$APOST(0,.ONOFF)  ; Auto-Posting of Med Claims parameter
 Q:RCQUIT 1
 Q:ONOFF=0 0  ; Medical Claim Auto-Posting turned off
 ;
 D EXCLLIST(1)  ; Display existing Payer exclusions for Med Auto-Post
 Q:$$SETEXCL(1) 1  ; Set/Reset Payer Exclusions
 D EXCLLIST(1)  ; Display new Payer Exclusion list
 ;
 ; Enable/disable Auto-Decrease of medical claims with payments
 S RCQUIT=$$PAID^RCDPESP7(0)  ; PRCA*4.5*345 - Added 0 parameter
 Q:RCQUIT=1 1
 Q:RCQUIT=2 0  ; Auto-Decrease of Med Claims w/Payments is OFF
 ;
 ;(#.04) AUTO-DECREASE MED DAYS DEFAULT [4N]
 S RCOLD=$$GET1^DIQ(344.61,"1,",.04,"I")
 K DIR S DIR(0)="NA^0:7:0" S:$L(RCOLD) DIR("B")=RCOLD
 S DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,.04,,"TITLE"))
 S DIR("?")=$$GET1^DID(344.61,.04,,"HELP-PROMPT")
 W ! D ^DIR I $D(DTOUT)!$D(DUOUT) Q 1
 I RCOLD'=Y D  ; user updated value
 . N FDAEDI,RCAUDVAL S FDAEDI(344.61,"1,",.04)=Y D FILE^DIE(,"FDAEDI")
 . D NOTIFY(Y,1)
 . S RCAUDVAL(1)="344.61^.04^1^"_Y_U_RCOLD D AUDIT(.RCAUDVAL)
 ;
 ; Enable/disable Auto-Decrease of Med Claims with/No Payments
 S RCQUIT=$$NOPAY^RCDPESP7(0)  ; PRCA*4.5*345 - Added 0 parameter
 I RCQUIT=1 Q 1
 ; Set/Reset payer exclusions for medical claim decrease
 D EXCLLIST(2)  ; Display exclusion list
 S RCQUIT=$$SETEXCL(2)
 Q:RCQUIT 1
 D EXCLLIST(2)  ; Display exclusion list
 ;
 Q 0
 ;
RXPARMS() ; function, Enable/disable auto-posting of pharmacy claims
 N APPC,RCOLD
 ; APPC=AUTO POSTING OF PHARMACY CLAIMS ENABLED
 ; RCOLD=TEMP APMC
 S RCOLD=$$GET1^DIQ(344.61,"1,",1.01,"I"),APPC=$S(RCOLD=1:"Yes",RCOLD=0:"No",1:"")
 K DIR S DIR(0)="YA",DIR("B")=$S(APPC="":"Yes",1:APPC)
 S DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,1.01,,"TITLE"))
 S DIR("?")=$$GET1^DID(344.61,1.01,,"HELP-PROMPT")
 D ^DIR I $D(DTOUT)!$D(DUOUT) Q 1
 I RCOLD'=Y D  ; user updated value
 . N FDAEDI,RCAUDVAL S FDAEDI(344.61,"1,",1.01)=Y D FILE^DIE(,"FDAEDI") K FDAEDI
 . D NOTIFY(Y,1)
 . S RCAUDVAL(1)="344.61^1.01^1^"_Y_U_('Y) D AUDIT(.RCAUDVAL)
 ;
 ; If yes, set/Reset payer exclusions for pharmacy claims posting
 I Y=1 D
 . D EXCLLIST(3) ; Display the exclusion list
 . D SETEXCL(3) Q:$G(RCQUIT)  ; SET/RESET exclusions
 . D EXCLLIST(3) ; Display the exclusion list
 . W !
 ;
 Q:RCQUIT 1
 ; Enable/disable Auto-Decrease of pharmacy claims with payments
 S RCQUIT=$$PAID^RCDPESP7(1) ; PRCA*4.5*345 - Added 1 parameter
 Q:RCQUIT=1 1
 Q:RCQUIT=2 0
 ;
 ; Set/Reset payer exclusions for pharmacy claim decrease
 D EXCLLIST(4) ; Display the exclusion list
 Q:$$SETEXCL(4) 1
 D EXCLLIST(4) W !  ; Display the exclusion list
 ;(#1.03) AUTO-DECREASE PHARM DAYS DEFAU [3N]
 S RCOLD=$$GET1^DIQ(344.61,"1,",1.03,"I")
 K DIR S DIR(0)="NA^0:7:0" S:$L(RCOLD) DIR("B")=RCOLD
 S DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,1.03,,"TITLE"))
 S DIR("?")=$$GET1^DID(344.61,1.03,,"HELP-PROMPT")
 D ^DIR I $D(DTOUT)!$D(DUOUT) Q 1
 I RCOLD'=Y D  ; user updated value
 . N FDAEDI,RCAUDVAL S FDAEDI(344.61,"1,",1.03)=Y D FILE^DIE(,"FDAEDI") K FDAEDI
 . D NOTIFY(Y,1)
 . S RCAUDVAL(1)="344.61^1.03^1^"_Y_U_RCOLD D AUDIT(.RCAUDVAL)
 ;
 Q 0
 ;
ABORT ; Called when user enters a '^' or times out
 ; fall through to EXIT
 ;
EXIT ; Unlock, ask user to press return, exit
 D EXIT^RCDPESP6 ; PRCA*4.5*326 - Send mail message if parameters have been edited.
 L -^RCY(344.61,1)
 D PAUSE
 Q
 ;
EFTLK() ; Set EFT lock-out parameters, PRCA*4.5*345
 ; Returns: 1 - User '^' or timed out
 ; 0 otherwise
 Q:$$EFTLKPRM(.06) 1  ; (#.06) MEDICAL EFT POST PREVENT DAYS [6N]
 Q:$$EFTLKPRM(.07) 1  ; (#.07) PHARMACY EFT POST PREVENT DAYS [7N]
 Q:$$EFTLKPRM(.13) 1  ; (#.13) TRICARE EFT POST PREVENT DAYS [13N]
 Q 0
 ;
EFTLKPRM(FLD) ; Ask a Medical/Rx EFT lock-out question, PRCA*4.5*345
 ; NUMBER OF DAYS (AGE) OF UNPOSTED xxx EFTS TO PREVENT POSTING
 ; Input: FLD - Field # of question being asked
 ; Returns: 1 - User '^' or timed out
 ; 0 otherwise
 N DA,DIR,DIROUT,DIRUT,DTOUT,DUOUT,RCVAL,X,Y
 S RCVAL=$$GET1^DIQ(344.61,"1,",FLD)
 S:RCVAL'="" DIR("B")=RCVAL,DA=1  ; default value and IEN
 S DIR(0)="344.61,"_FLD_"A",DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,FLD,,"TITLE"))
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 I RCVAL'=Y D  ; Update and audit
 . N AUDVAL
 . S RCAUDVAL(1)="344.61^"_FLD_"^1^"_Y_U_RCVAL
 . S FDAEDI(344.61,"1,",FLD)=Y D FILE^DIE(,"FDAEDI")
 . D AUDIT(.RCAUDVAL)
 Q 0
 ;
PAUSE ; prompt user to press return
 W ! N DIR
 S DIR("T")=3,DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR
 Q
 ;
WKLDMDY(WKLDMMDY) ; Boolean function, SELECT DAY TO SEND WORKLOAD NOTIFICATION question
 ; WKLDMMDY - DAY FOR WORKLOAD NOTIFICATIONS current value, internal format
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 ; PRCA*4.5*321 - New parameter
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FDAEDI,RCAUDVAL
 ;
 S:WKLDMMDY'="" DIR("B")=$$GET1^DIQ(344.61,"1,",.1,"E")
 S DIR("?")=$$GET1^DID(344.61,.1,,"HELP-PROMPT"),DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,.1,,"TITLE"))
 S DIR(0)="344.61,.1"
 W ! D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 I WKLDMMDY'=Y D  ; update and audit
 . S RCAUDVAL(1)="344.61^.1^1^"_Y_U_WKLDMMDY
 . S FDAEDI(344.61,"1,",.1)=Y
 . D FILE^DIE(,"FDAEDI")
 . D AUDIT(.RCAUDVAL)
 W !
 Q 0
 ;
MDCLMPR() ; function, Medical Claims Auto-Posting/Auto-Decrease questions
 ; Returns: 1   - User '^' or timed out, 0 otherwise
 N ONOFF,RETURN
 S RETURN=$$MPAUDPST(0,.ONOFF)  ; Auto-Posting of Med Claims parameter
 Q:RETURN 1
 Q:ONOFF=0 0  ; Medical Claim Auto-Posting turned off
 D EXCLLIST(1)  ; Display existing Payer exclusions for Med Auto-Post
 D SETEXCL(1)  ; Set/Reset Payer Exclusions
 D EXCLLIST(1)  ; Display the new Payer Exclusion list
 ;
 ; Enable/disable Auto-Decrease of medical claims with payments
 S RETURN=$$PAID^RCDPESP7(0)  ; PRCA*4.5*345, Added 0 parameter
 Q:RETURN=1 1
 Q:RETURN=2 0  ; Auto-Decrease of Medical Claims w/Payments is OFF
 ;
 ; Enable/disable Auto-Decrease of Med Claims with/No Payments
 S RETURN=$$NOPAY^RCDPESP7(0)  ; PRCA*4.5*345 - Added 0 parameter
 I RETURN=1 Q 1
 ;
 ; Set/Reset payer exclusions for medical claim decrease
 D EXCLLIST(2)  ; Display the exclusion list
 Q:$$SETEXCL(2) 1
 D EXCLLIST(2)  ; Display the exclusion list
 W !
 Q 0
 ;
MPAUDPST(AUPOSTYP,ONOFF) ; function, toggle Auto-Posting for Medical, pharm Claims
 ; PRCA*4.5*345 - Added method
 ; Input:   AUPOSTYP - 0 - Medical Auto-Posting, 1 - Rx Auto-Posting
 ; Output:  1 - Auto-Posting of Claims with Payments on, 0 otherwise
 ; Returns: 1 - User '^' or timed out, 0 otherwise
 N APCT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FLD,FDAEDI,RCAUDVAL
 ;(#.02) AUTO-POST MED CLAIMS ENABLED [2S]
 ;(#1.01) AUTO-POST RX CLAIMS ENABLED [1S]
 S FLD=$S(AUPOSTYP=0:.02,1:1.01)
 S APCT=$$GET1^DIQ(344.61,"1,",FLD,"I")
 S DIR(0)="YA",DIR("B")=$S((APCT="")!(APCT=1):"Yes",1:"No")
 S DIR("A")=$$PADPRMPT^RCDPESPB($$GET1^DID(344.61,FLD,,"TITLE"))
 S DIR("?")=$$GET1^DID(344.61,FLD,,"HELP-PROMPT")
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) Q 1
 S ONOFF=Y
 I APCT'=Y D  ; User updated value
 . S FDAEDI(344.61,"1,",FLD)=Y
 . D FILE^DIE(,"FDAEDI")
 . K FDAEDI
 . D NOTIFY(Y)
 . S RCAUDVAL(1)="344.61^"_FLD_"^1^"_Y_U_APCT
 . D AUDIT(.RCAUDVAL)
 Q 0
 ;
COUNT(ACTVCARC,PDCLM,CLMTYP) ;Count active CARCs in file 344.62 (RCDPE CARC-RARC AUTO DEC)
 ; PRCA*4.5*345 - Added PDCLM,CLMTYP
 ; Input: ACTVCARC: 0 - Count inactive CARCs, 1 - Count active CARCs
 ; PDCLM: 0 - Paid Claims, 1 - No-Pay Claims
 ; CLMTYP: - 0 - Medical, 1 - pharm
 ; Returns: 0 - Invalid parameter, otherwise the number of active CARCs are returned
 N I,NUM,XREF  ; PRCA&4.5*345 - Added XREF
 I (ACTVCARC'=0),(ACTVCARC'=1) Q 0 ; If ACTVCARC is not active (1) or inactive (0) quit with zero
 S XREF=""
 I 'PDCLM,'CLMTYP S XREF="ACTV"  ; (#.02) CARC AUTO DECREASE [2S]
 I XREF="",'PDCLM,CLMTYP=1 S XREF="ACTVR"  ; (#2.01) CARC PHARM AUTO DECREASE
 ;I XREF="" 'PDCLM,CLMTYP=2 S XREF="ACTVT"  ; *future build* (#3.01) CARC TRICARE W PYMNTS AUTO-DEC [1S]
 I XREF="",PDCLM,CLMTYP=0 S XREF="ACTVN"  ; (#.08) CARC AUTO DECREASE NO-PAY [1S]
 ;I XREF="" S XREF="ACTVNT"  ; *future build* (#3.07) CARC TRICARE AUTO-DECRS NO-PAY [7S]
 ;
 I XREF="" Q 0  ; need a cross-reference, return zero
 ; count entries on the cross-ref.
 S NUM=0,I="" F  S I=$O(^RCY(344.62,XREF,ACTVCARC,I)) Q:I=""  S NUM=NUM+1
 Q NUM
 ;
EXCLLIST(TYP) ; CHOICE determines which exclusions to list
 ; TYP - type of exclusion, required
 ; IX - which index to use
 ; IEN - points to an excluded payer for the selected choice
 Q:'("^1^2^3^4^"[(U_$G(TYP)_U))  ; TYP must be valid
 N CT,EXCHDR,IEN,IX S (IEN,CT)=0 W !
 S IX=$S(TYP=1:"EXMDPOST",TYP=2:"EXMDDECR",TYP=3:"EXRXPOST",TYP=4:"EXRXDECR",1:U)  ; IX cannot be null
 S EXCHDR("TXT")="Payers excluded from "_$S(TYP=1:"Medical Auto-Posting:",TYP=3:"Pharmacy Auto-Posting",TYP=4:"Pharmacy Auto-Decrease",1:"Medical Auto-Decrease:")
 S EXCHDR=$S(TYP=1:"",TYP=3:"",1:"** Additional ")_EXCHDR("TXT")
 F  S IEN=$O(^RCY(344.6,IX,1,IEN)) Q:'IEN  D
 . S CT=CT+1 W:CT=1 !,EXCHDR
 . W !,"  "_$P(^RCY(344.6,IEN,0),U,1)_" "_$P(^RCY(344.6,IEN,0),U,2)
 ;
 I TYP=2 W !,"All payers excluded from Auto-Posting are also excluded from Auto-Decrease."
 W:CT=0 !,"   No "_$S(TYP=2:"additional ",1:"")_EXCHDR("TXT")
 ; if list is for auto-decrease and there are exclusions write a message
 Q
 ;
SETEXCL(TYP) ; LOOP FOR SETTING PAYER EXCLUSIONS
 ; TYP - type of exclusion
 N CMT,CT,DIC,DIR,DONE,FDAPAYER,FLD,IEN,PREC,RCAUDVAL,RCQUIT,RTYP,X,Y
 ; FDAPAYER - FDA FOR FILE 344.6
 ; FLD - FIELD BEING MODIFIED
 ; RTYP - STRING REPRESENTING FIELD
 ; DONE - INDICATOR TO LEAVE LOOP
 ; RCAUDVAL - ARRAY FOR AUDITING
 ; PREC - HOLDER FOR Y(0) AFTER ^DIC CALL
 ;         FILE NUMBER^FIELD NUMBER^IEN^NEW VALUE^OLD VALUE,COMMENT
 S FLD=0
 I $G(TYP)=1 S FLD=.06,CMT=1,RTYP="MEDICAL CLAIMS POSTING"
 I $G(TYP)=2 S FLD=.07,CMT=2,RTYP="MEDICAL CLAIMS DECREASE"
 I $G(TYP)=3 S FLD=.08,CMT=3,RTYP="PHARMACY CLAIMS POSTING"
 I FLD=0 S FLD=.12,CMT=4,RTYP="PHARMACY CLAIMS DECREASE"
 ;
 W !!,"Select a Payer to add or remove from the exclusion list.",!
 S (RCQUIT,CT,DONE)=0 F  Q:DONE!RCQUIT  D
 . S DIC="^RCY(344.6,",DIC(0)="AEMQZ",DIC("A")="Payer: "
 . S DIC("S")="I $$SCREEN^RCDPESP(Y)" ; PRCA*4.5*326
 . D ^DIC I X="^" S RCQUIT=1 Q
 . I +$G(Y)<1 S DONE=1 Q
 . S CT=CT+1,IEN=+Y,PREC=Y(0)
 . K FDAPAYER
 . N COMMENT,STAT
 . S COMMENT="",STAT='$$GET1^DIQ(344.6,IEN_",",FLD,"I")
 . S FDAPAYER(344.6,IEN_",",FLD)=STAT
 . ; GET COMMENT HERE
 . K Y S DIR("A")="COMMENT: ",DIR(0)="FA^3:72"
 . S DIR("PRE")="S X=$$TRIM^XLFSTR(X,""LR"")" ; comment required and should be significant
 . S DIR("?")="Enter an explanation for "_$S(STAT:"adding the payer to",1:"removing the payer from")_" the list of Excluded Payers."
 . D ^DIR I $D(DTOUT)!$D(DUOUT) S RCQUIT=1 Q
 . I Y="" S DONE=1 Q  ; stop loop
 . S COMMENT=Y
 . I COMMENT]"" D
 ..  S FDAPAYER(344.6,IEN_",",CMT)=$S(STAT:COMMENT,1:"")
 ..  W !,$P(PREC,U)_" "_$P(PREC,U,2)_" has been "_$S(STAT:"added to",1:"removed from")_" the list of Excluded Payers"
 ..  I TYP=1 D
 ...   W !,"If medical auto-decrease is turned on, "
 ...   I STAT W "this payer will be excluded from medical auto-decrease too."
 ...   I 'STAT,'$$GET1^DIQ(344.6,IEN_",",.07,"I") W "this payer will no longer be excluded from Medical Auto-Decrease."
 ...   I 'STAT,$$GET1^DIQ(344.6,IEN_",",.07,"I") W "Medical Auto-Decrease is set to be excluded for this payer."
 ..  N RCAUDVAL
 ..  D FILE^DIE(,"FDAPAYER")
 ..  S RCAUDVAL(1)="344.6"_U_FLD_U_IEN_U_STAT_U_('STAT)_U_COMMENT
 ..  D AUDIT(.RCAUDVAL)
 ;
 Q RCQUIT
 ;
NOTIFY(VAL,TYPE) ; Notification of change to Site Parameters
 N C,GBL,MSG,SITE,SUBJ,XMINSTR,XMTO
 S SITE=$$SITE^VASITE
 S TYPE=$G(TYPE)  ; optional parameter
 ; limit subject to 65 chars.
 S SUBJ=$E("Site Parameter edit, Station #"_$P(SITE,U,3)_" - "_$P(SITE,U,2),1,65)
 D XMSGBODY^RCDPESPB(.MSG)  ; body of message
 S C=MSG  ; line count
 S C=C+1,MSG(C)="  ENABLE AUTO-POSTING OF "_$S(TYPE=1:"PHARMACY",1:"MEDICAL")_" CLAIMS = "_$$FRMT^RCDPESP6(VAL,"B")
 S C=C+1,MSG(C)=" "
 ;send message to mail group
 S XMTO(DUZ)="",XMTO("G.RCDPE AUDIT")=""
 K ^TMP("XMERR",$J)
 D SENDMSG^XMXAPI(DUZ,SUBJ,"MSG",.XMTO,.XMINSTR)
 I $D(^TMP("XMERR",$J)) D
 . N G,GLO
 . D MES^XPDUTL("MailMan reported a problem trying to send the notification message.")
 . D MES^XPDUTL("MailMan error text:")
 . S (G,GLB)=$NA(^TMP("XMERR",$J))
 . F  S G=$Q(@G) Q:G'[GLB  D MES^XPDUTL(" "_@G)
 . D MES^XPDUTL("* End of MailMan Error *")
 Q
 ;
AUDIT(INP) ; WRITE AUDIT RECORD(S)
 ; INP = audit value in this format:
 ;       FILE NUMBER^FIELD NUMBER^IEN^NEW VALUE^OLD VALUE^COMMENT
 Q:'$O(INP(0))   ; nothing to audit
 N RCI,RCNOW
 S RCNOW=$$NOW^XLFDT
 S RCI=0 F  S RCI=$O(INP(RCI)) Q:'RCI  D
 . N FDAUDT,X S X=INP(RCI)
 . S FDAUDT(344.7,"+1,",.01)=RCNOW  ;TIMESTAMP [1D]
 . S FDAUDT(344.7,"+1,",.02)=$P(X,U,3)  ;MODIFIED IEN [2N]
 . S FDAUDT(344.7,"+1,",.03)=DUZ  ;CHANGED BY [3P:200]
 . S FDAUDT(344.7,"+1,",.04)=$P(X,U,2)  ;CHANGED FIELD [4N]
 . S FDAUDT(344.7,"+1,",.05)=$P(X,U)  ;MODIFIED FILE [5S]
 . S FDAUDT(344.7,"+1,",.06)=$P(X,U,4)  ;NEW VALUE [6F]
 . S FDAUDT(344.7,"+1,",.07)=$P(X,U,5)  ;OLD VALUE [7F]
 . S FDAUDT(344.7,"+1,",.08)=$P(X,U,6)  ;COMMENT [8F]
 . D UPDATE^DIE(,"FDAUDT")
 Q
 ;
 ; *************************************************************
 ; CALLS RELATED TO CREATING EPAYMENT PAYER EXCLUSION PARAMETERS
 ; *************************************************************
 ;
NEWPYR ;Add new payers to payer table - called from AR Nightly Job (EN^RCDPEM)
 ; PRCA*4.5*326 - Add payers that are just on EFTs to file 344.6
 N RCDATE,RCFDA,RCEFT,RCERA,RCUPD,RCXD
 ;Get date/time of last run otherwise start at previous day
 S RCDATE=$P($G(^RCY(344.61,1,0)),U,8) S:RCDATE="" RCDATE=$$FMADD^XLFDT($$NOW^XLFDT\1,-1)
 S RCXD=RCDATE
 F  S RCXD=$O(^RCY(344.4,"AFD",RCXD)) Q:'RCXD  D
 . S RCERA="" F  S RCERA=$O(^RCY(344.4,"AFD",RCXD,RCERA)) Q:'RCERA  D  ;
 . . S RCUPD=$$PAYRINIT(RCERA,344.4)
 ;
 S RCXD=$$FMADD^XLFDT($P(RCDATE,".",1),-1)
 F  S RCXD=$O(^RCY(344.31,"ADR",RCXD)) Q:'RCXD  D
 . S RCEFT="" F  S RCEFT=$O(^RCY(344.31,"ADR",RCXD,RCEFT)) Q:'RCEFT  D  ;
 . . S RCUPD=$$PAYRINIT(RCEFT,344.31)
 ;
 ;Update last run date
 S RCFDA(344.61,"1,",.08)=$$NOW^XLFDT()
 D FILE^DIE("","RCFDA")
 ; PRCA*4.5*326 - End modified block
 Q
 ;
PAYERPRM(IEN,EXMDPOST,EXMDDECR) ; update new payer
 Q:'$G(IEN)!('$D(^RCY(344.4,+$G(IEN),0))) 0  ; IEN valid?
 N ID,PAYER,PFDA,PIENS
 S PAYER=$E($$GET1^DIQ(344.4,IEN_",",.06),1,35)
 Q:PAYER="" 0
 S ID=$E($$GET1^DIQ(344.4,IEN_",",.03),1,30)
 I '$D(^RCY(344.6,"CPID",PAYER,ID)) Q 0
 ; FILE CURRENT SETTINGS
 S PIENS=$O(^RCY(344.6,"CPID",PAYER,ID,0))_","
 S PFDA(344.6,PIENS,.04)=DUZ
 S PFDA(344.6,PIENS,.05)=$$NOW^XLFDT
 S PFDA(344.6,PIENS,.06)=+$G(EXMDPOST)
 S PFDA(344.6,PIENS,.07)=+$G(EXMDDECR)
 D FILE^DIE(,"PFDA")
 Q 1
 ;
PAYRINIT(IEN,FILE) ; Add Payer Name and Payer ID to Payer table #344.6 
 ;
 N PFDA,PAYER,ID,PIENS,ERADATE,RCFLD
 ;
 Q:'$G(IEN)!('$D(^RCY(FILE,+$G(IEN)))) 0
 ; PRCA*4.5*326 - Add payers from EFTs
 S RCFLD("NAME")=$S(FILE=344.4:.06,1:.02)
 S RCFLD("ID")=.03
 S RCFLD("DATE")=$S(FILE=344.4:.07,1:.13)
 ;
 S PAYER=$$GET1^DIQ(FILE,IEN_",",RCFLD("NAME")) Q:PAYER="" 0
 S ID=$$GET1^DIQ(FILE,IEN_",",RCFLD("ID")) Q:ID="" 0
 I $D(^RCY(344.6,"CPID",PAYER,ID)) Q 1
 S ERADATE=$$GET1^DIQ(FILE,IEN_",",RCFLD("DATE"),"I")
 ; PRCA*4.5*326 - End modified block
 ;
 ; UPDATE PAYER PARAMETERS
 S PIENS="+1,"
 S PFDA(344.6,PIENS,.01)=PAYER
 S PFDA(344.6,PIENS,.02)=ID
 S PFDA(344.6,PIENS,.03)=ERADATE
 S PFDA(344.6,PIENS,.04)=.5
 S PFDA(344.6,PIENS,.05)=$$NOW^XLFDT
 S PFDA(344.6,PIENS,.06)=0
 S PFDA(344.6,PIENS,.07)=0
 I FILE=344.31 S PFDA(344.6,PIENS,.11)=1 ; PRCA*4.5*326
 D UPDATE^DIE(,"PFDA")
 Q 1
 ;
SCREEN(IEN) ; Screen out payers that don't have an associated ERA - PRCA*4.5*326
 ; Input: IEN - Internal entry number from file 344.6
 ; Returns: 1 - Payer has an associated ERA, otherwise 0.
 N NAME,ID
 S NAME=$$GET1^DIQ(344.6,IEN_",",.01)
 S ID=$$GET1^DIQ(344.6,IEN_",",.02)
 I NAME=""!(ID="") Q 0
 I $D(^RCY(344.4,"APT",NAME,ID)) Q 1
 Q 0
