RCDPEAP ;ALB/PJH - AUTO POST MATCHING EFT ERA PAIR ;Oct 15, 2014@12:36:51
 ;;4.5;Accounts Receivable;**298,304,318,321,326,424,432**;Mar 20, 1995;Build 16
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^IBM(361.1) via Private IA 4051
 ;
EN ;Auto-post ERA Receipts
 ;Process newly matched and matched but unprocessed ERAs
 D EN1
 ;Process previously processed ERA's
 D EN2
 Q
 ;
EN1 ;Auto-post newly matched and matched but unprocessed ERA
 N RCRZ,RCEFTDA,RCZERO ; PRCA*4.5*424 Add RCZERO
 S RCRZ=0
 ;Scan ERA file for auto-post candidates with AUTO-POST STATUS = UNPOSTED
 F  S RCRZ=$O(^RCY(344.4,"E",0,RCRZ)) Q:'RCRZ  D
 .S RCZERO=$$ISZERO^RCDPEAP1(RCRZ) ; PRCA*4.5*424 Check for Zero balance ERA
 .I RCZERO I $$ISTYPE^RCDPEU1(344.4,RCRZ,"C") Q   ; PRCA*4.5*432 Zero balance ERA with CHAMPVA payer is not an auto-post candidate
 .;Get EFT reference
 .;PRCA*4.5*424 next, line don't require matched EFT for zero balance ERAs
 .S RCEFTDA=$O(^RCY(344.31,"AERA",RCRZ,"")) I 'RCZERO Q:'RCEFTDA
 .;Check that EFT funds were posted to FMS and Accepted by FMS.  If not, quit and go to next unposted ERA
 .N RCOK,RCDEPTDA,RCRECTDA
 .S RCOK=1
 .;PRCA*4.5*424 next, line don't check matched EFT for zero balance ERAs
 .I 'RCZERO,$P($G(^RCY(344.3,+$G(^RCY(344.31,+RCEFTDA,0)),0)),U,8),$P($G(^RCY(344.31,+RCEFTDA,0)),U,7) D  Q:'RCOK
 ..S RCDEPTDA=+$P($G(^RCY(344.3,+$G(^RCY(344.31,+RCEFTDA,0)),0)),U,3),RCRECTDA=+$O(^RCY(344,"AD",+RCDEPTDA,0)) ; Get deposit ticket and EFT receipt (CR - 8NZZ)
 ..I RCRECTDA N Z S Z=$P($$FMSSTAT^RCDPUREC(RCRECTDA),U,2) Q:$E(Z)="A"  Q:$E(Z)="O"  ; EFT Accepted by FMS or ON-LINE ENTRY - PRCA*4.5*326
 ..S RCOK=0
 .;
 .;Auto-Post
 .D AUTOPOST(RCEFTDA,RCRZ,RCZERO) ; PRCA*4.5*424 add parameter
 Q
 ;
 ; Process ERA
AUTOPOST(RCEFTDA,RCERA,RCZERO) ; PRCA*4.5*424 add parameter
 ; RCEFTDA = ien of file #344.31
 ; RCERA = ien of file #344.4
 ; RCZERO = 1 if this ERA is zero balance, otherwise 0 ; PRCA*4.5*424
 ;
 ;Lock ERA
 L +^RCY(344.4,RCERA):5 Q:'$T
 ;
 ;Build Scratchpad and Verify Lines
 N ALLOK,RCERR,RCLINES,RCRCPTDA,RCSCR,RCTRDA,ZEROBAL ; PRCA*4.5*318 Variables placed in alpha order
 K ^TMP($J,"RCDPEWLA")
 S RCSCR=$$SCRPAD(RCERA,RCZERO)     ;**PRCA*4.5*424 Added ,RCZERO
 ; Re-set AUTO-POST STATUS  if unable to create scratchpad
 I 'RCSCR,'RCZERO D  Q                          ;PRCA*4.5*424 Added 'RCZERO
 . D SETSTA(RCERA,"@","Auto Posting: Removed from Auto Posting-Unable to create scratchpad")
 . D AUTOQ
 ;
 ; ERA cannot be autoposted
 ; remove any pre-existing value to the AUTO-POST STATUS so ERA can be processed manually in the Worklist
 I $D(^TMP($J,"RCDPEWLA","ERA LEVEL ADJUSTMENT EXISTS")) D  Q
 . D SETSTA(RCERA,"@","Auto Posting: Removed from Auto Posting-ERA level Adjustment(s)")
 . D AUTOQ
 ;
 I $$UNBAL^RCDPEAP1(RCERA) D  Q  ; PRCA*4.5*318 Added line
 . D SETSTA(RCERA,"@","Auto Posting: Removed from Auto Posting-Unbalanced ERA") ; PRCA*4.5*321
 . D AUTOQ
 ;
 ; Check if all lines can be posted
 S ALLOK=$$ALLOK(RCERA,RCSCR,.ZEROBAL,.RCLINES)
 ;
 ; ; PRCA*4.5*424 Added line - post zero balance ERA
 I RCZERO D  Q  ;
 . I ZEROBAL D  ;
 . . D POST0^RCDPEAP2(RCERA)
 . I 'ZEROBAL D  ;
 . . D SETSTA(RCERA,"@","Auto Posting: Removed zero pay ERA has +/- Payments")
 . D AUTOQ
 ;
 ;If $$ALLOK post entire ERA and reset AUTO-POST STATUS = COMPLETE
 I ALLOK D POSTALL(RCERA)
 ;
 ;If 'ALLOK and some of the lines passed validation then post receipt to summary ERA and set AUTO-POST STATUS = PARTIAL
 ;Un-posted lines fall to APAR list for processing.
 I 'ALLOK D POSTERA(RCERA,.RCLINES)
 ;Unlock ERA
AUTOQ D UNLOCKE
 Q
 ;
EN2 ;Auto-Post Previously Processed ERA
 N AUTORCPT,CLAIM,COMPLETE,EOBIEN,RCDUZ,RCERA,RCIFN,RCRCPTDA,RCLINES
 S RCERA=0,AUTORCPT=1 ;Variable AUTORCPT suppresses #344 trigger update to ERA receipt field
 ;Scan ERA file for auto-post candidates with AUTO-POST STATUS = PARTIAL
 F  S RCERA=$O(^RCY(344.4,"E",1,RCERA)) Q:'RCERA  D
 . ;Ignore if it was just partially posted in POSTLNS so we do not process again
 . Q:$D(^TMP("RCDPEAP",$J,RCERA))
 . S RCDUZ=$$GET1^DIQ(344.4,RCERA_",",4.04,"I") ; PRCA*4.5*326
 . ;Set receipt variable to null for each ERA so that the receipt number from the previous ERA is not hanging around
 . S RCRCPTDA=""
 . ;Check if there are lines that are set for auto-posting and if they can be posted or have errors.
 . K RCLINES
 . S RCLINES=0
 . D VALID^RCDPEAP1(RCERA,.RCLINES)
 . ;If valid lines found create receipt for those lines (Variable RCLINES is only incremented for valid lines)
 . I RCLINES D
 . . N RCEFTDA,RCDEPTDA,RCRECTDA
 . . ;Get EFT reference
 . . S RCEFTDA=$O(^RCY(344.31,"AERA",RCERA,"")) Q:'RCEFTDA
 . . ;Get deposit ticket and EFT receipt
 . . S RCDEPTDA=+$P($G(^RCY(344.3,+$G(^RCY(344.31,+RCEFTDA,0)),0)),U,3),RCRECTDA=+$O(^RCY(344,"AD",+RCDEPTDA,0))
 . . ;ERA Receipt is created from scratchpad entry - type 14 is EDI Lockbox payment
 . . ; Creates basic receipt for ERA of payment type EDI LOCKBOX; 2nd parameter means an alpha suffix on receipt number
 . . S RCRCPTDA=$$BLDRCPT^RCDPEMA(RCERA,RCDUZ) ; PRCA*4.5*326 Add RCDUZ to call 
 . . I 'RCRCPTDA Q  ;PRCA*4.5*318 - Problem building receipt header
 . . K RCERR
 . . D RCPTDET^RCDPEMA(RCERA,RCRCPTDA,.RCLINES,.RCERR) ; Adds detail to a receipt based on file 344.49 and RCLINES array
 . . I $O(RCERR("")) Q  ; PRCA*4.5*318 - Do not attempt to process partially filed receipt
 . . ;Lock ERA receipt and deposit ticket
 . . I '$$LOCKREC^RCDPRPLU(RCRCPTDA) Q
 . . I '$$LOCKDEP^RCDPDPLU(RCDEPTDA) D UNLOCKR Q
 . . ;Process Receipt to FMS
 . . D PROCESS^RCDPURE1(RCRCPTDA,2) I $D(^TMP("RCDPE-RECEIPT-ERROR",$J)) D UNLOCKR Q
 . . ; update 344, .18 ERA REFERENCE field
 . . D ERAREF(RCERA,RCRCPTDA)
 . . ;Unlock deposit ticket and receipt
 . . D UNLOCKR
 . ;Update ERA and ERA detail lines with receipt # or auto-post rejection reason
 . D ERADET^RCDPEAP1(RCERA,RCRCPTDA,.RCLINES)
 . ;Determine if posting complete for this ERA
 . S COMPLETE=$$COMPLETE(RCERA)
 . ;If complete update ERA detail post status to POSTED
 . I COMPLETE S DIE="^RCY(344.4,",DR=".14////1",DA=RCERA D ^DIE
 . ;Update the audit log
 . D AUDITLOG(RCERA,$S(COMPLETE:2,1:1),"Auto Posting: Previously processed ERA posting attempt")
 . ;Set ERA auto-post status and update latest auto-post date
 . S DIE="^RCY(344.4,",DR="4.01////"_DT_";4.02////"_$S(COMPLETE:2,1:1),DA=RCERA D ^DIE
 ;Unlock ERA
 D UNLOCKE
 Q
 ;
ACTIVE(EOBIEN) ;Verify claim is active
 ; EOBIEN - IEN of file 361.1
 N RCIFN,RCBILL,RCSTATUS
 ;Get EOB number (implies this is 3rd Party claim)
 I 'EOBIEN Q 0
 ;Get #399 claim number from EOB
 S RCIFN=$P($G(^IBM(361.1,EOBIEN,0)),U) Q:'RCIFN 0
 S RCBILL=$P($G(^DGCR(399,RCIFN,0)),U) Q:RCBILL="" 0  ; IA 4051
 ;Check if bill is cancelled or closed
 S RCSTATUS=$P($G(^DGCR(399,RCIFN,0)),U,13)
 Q $S(RCSTATUS=0:0,RCSTATUS=7:0,1:1)
 ; 
ALLOK(RCERA,RCSCR,ZEROBAL,RCLINES) ;Verify which scratchpad lines are able to auto-post
 ; RCERA - 344.4 ien
 ; RCSCR - 344.49 ien
 ; ZEROBAL - flag that represents if ERA has zero payment balance after processing
 ;           matched positive/negative pairs, passed by reference
 ; RCLINES - array of ERA line references (passed in by reference)
 ;           NOTE:  ORIGINAL ERA SEQUENCES (344.491, .09) can have multiple ERA line 
 ;                  references separated by commas (e.g., 3,4)
 ; returns 0 or 1 (ALLOK)
 N ALLOK,AMT,ERALINE,STATUS,SUB,SUB1,CLAIM,WLINE,VERIFY
 K CLARRAY
 S (ZEROBAL,ALLOK)=1
 S (SUB,RCLINES)=0
 F  S SUB=$O(^RCY(344.49,RCSCR,1,"B",SUB)) Q:SUB=""  D
 . ;Get scratchpad line and data
 . S SUB1=$O(^RCY(344.49,RCSCR,1,"B",SUB,"")) Q:'SUB1  S WLINE=$G(^RCY(344.49,RCSCR,1,SUB1,0)),AMT=$P(WLINE,U,3)
 . ;If integer sequence, get ERA line reference and verify flag and then quit for this sequence and go on to the non-integer sequence to finish validation
 . I $P(WLINE,U)?1N.N S VERIFY=1 S ERALINE=$P(WLINE,U,9) S:'$P(WLINE,U,13) ALLOK=0,RCLINES(ERALINE)="0^^1",VERIFY=0 Q
 . ; ignore zero valued lines
 . Q:AMT=0  Q:AMT="0.00"
 . S ZEROBAL=0 ; PRCA*4.5*424 at least one line has non-zero balance
 . ;Get claim number from N.001 line - if not found treat as inactive
 . S CLAIM=$P(WLINE,U,7) I 'CLAIM S ALLOK=0,$P(RCLINES(ERALINE),U,3)=2 Q
 . ;Save claim number
 . S $P(RCLINES(ERALINE),U,2)=$P($G(^PRCA(430,CLAIM,0)),U) Q:'VERIFY
 . ;Claim must be OPEN or ACTIVE
 . S STATUS=$P($G(^PRCA(430,CLAIM,0)),"^",8) I STATUS'=42,STATUS'=16 S ALLOK=0,$P(RCLINES(ERALINE),U,3)=2 Q
 . ;Check that payment does not exceed balance and no pending payments (at the time of auto posting)
 . S CLARRAY(CLAIM)=+$G(CLARRAY(CLAIM))+$P(WLINE,U,3) I '$$CHECKPAY(.CLARRAY,CLAIM) S ALLOK=0,$P(RCLINES(ERALINE),U,3)=3 Q
 . ;Check if referred to general council
 . I $P($G(^PRCA(430,CLAIM,6)),U,4)]"" S ALLOK=0,$P(RCLINES(ERALINE),U,3)=4 Q
 . ;Line is potentially postable
 . S $P(RCLINES(ERALINE),U)=1,$P(RCLINES(ERALINE),U,3)=$P(WLINE,U,6),RCLINES=$G(RCLINES)+1
 Q ALLOK
 ;
AUDITLOG(DA,RCNEWST,RCREASON) ;
 ; Update the Auto-post Audit Log
 I '$G(DA) Q
 I $G(RCREASON)="" Q
 ;
 N RCAUDIT,RCOLDST,DIE,DR,X,Y,DTOUT,DUOUT,DROUT,DIRUT
 ; Get the current status
 S RCOLDST=$$GET1^DIQ(344.4,DA_",",4.02,"I")
 ; If the new status is null, set to old status (no change)
 I $G(RCNEWST)="" S RCNEWST=RCOLDST
 ; File
 S RCAUDIT(344.72,"+1,",.01)=$$NOW^XLFDT ;Date/Time Stamp
 S RCAUDIT(344.72,"+1,",.02)=$S($G(RCDUZ):RCDUZ,1:DUZ)         ;User PRCA*4.5*321 Use RCDUZ if defined
 S RCAUDIT(344.72,"+1,",.03)=DA          ;ERA #
 S RCAUDIT(344.72,"+1,",.04)=RCOLDST     ;Old Status
 I RCNEWST'="@" S RCAUDIT(344.72,"+1,",.05)=RCNEWST ;New status
 S RCAUDIT(344.72,"+1,",.06)=$E(RCREASON,1,80) ;Reason text
 D UPDATE^DIE(,"RCAUDIT")
 Q
 ;
BUILD(RCSCR,ARRAY) ; EP from EN2^RCDPEAD - Build list of ERA lines
 ; RCSCR = ien of file 344.49
 ; ARRAY = the array that will hold the list of ERA lines, passed by reference
 N ERALINE,FOUND,SCRLINE,SUB,SUB1
 K ARRAY
 S SUB=0,ARRAY=0
 F  S SUB=$O(^RCY(344.49,RCSCR,1,"B",SUB)) Q:SUB=""  D:SUB'["."
 . ;Get actual scratchpad ^RCY(344.49,RCSCR,1) node
 . S SUB1=$O(^RCY(344.49,RCSCR,1,"B",SUB,"")) Q:'SUB1
 . ;;Ignore zero lines - removed PRCA*4.5*326
 . ;Q:'$P($G(^RCY(344.49,RCSCR,1,SUB1,0)),U,3)
 . ; Get ERA line
 . S ERALINE=$$GET1^DIQ(344.491,SUB1_","_RCSCR,.09) ; PRCA*4.5*326
 . ; Ignore reversals
 . Q:ERALINE[","  ; PRCA*4.5*326
 . ;Index scratchpad line by ERA sequence
 . S ARRAY(ERALINE)=SUB1,ARRAY=$G(ARRAY)+1 ; PRCA*4.5*326
 Q
 ;
CHECKPAY(ARRAY,CLAIM) ;Check balance versus payments
 ; ARRAY = array of claim numbers and respective payment amounts
 ;         e.g. ARRAY(430 ien) = 123.04
 ; CLAIM = AR BILL (344.491, .07) - IEN of file 430
 Q:'CLAIM 0
 ; BEGIN PRCA*4.5*326
 N RCADMIN,RCBAL,RCCOURT,RCINT,RCMAR,RCPRIN
 S RCPRIN=$$GET1^DIQ(430,CLAIM_",",71) ; Principle Balance
 S RCINT=$$GET1^DIQ(430,CLAIM_",",72) ; Interest
 S RCADMIN=$$GET1^DIQ(430,CLAIM_",",73) ; Admin Cost
 S RCMAR=$$GET1^DIQ(430,CLAIM_",",74) ; Marshal Fee
 S RCCOURT=$$GET1^DIQ(430,CLAIM_",",75) ; Court Cost
 S RCBAL=RCPRIN+RCINT+RCADMIN+RCMAR+RCCOURT ; Total balance
 ; get the payment amount to be posted to the claim
 S AMT=ARRAY(CLAIM)
 ;Payment exceeds principle balance
 Q:AMT>RCBAL 0
 ; END PRCA*4.5*326
 ;Check pending payments for claim
 N PENDING S PENDING=$$PENDPAY^RCDPURET(CLAIM) K ^TMP($J,"RCDPUREC","PP")
 ;Pending payments is > billed
 I PENDING>AMT Q 0
 ;otherwise OK to post payment
 Q 1
 ; 
CLEAR(DA) ;Clear scratchpad
 N DIK S DIK="^RCY(344.49," D ^DIK
 Q
 ;
COMPLETE(RCSCR) ;Check for non-zero lines without a receipt
 ; RCSCR = ien of file 344.49
 ; Returns status of check (1 or 0)
 N RCSUB,SCRSUB,COMPLETE,SCRLINE,RCERA
 ;Default to complete
 S SCRSUB=0,COMPLETE=1,RCERA=RCSCR
 ;Scan scratchpad
 F  S SCRSUB=$O(^RCY(344.49,RCSCR,1,SCRSUB)) Q:'SCRSUB  D  Q:'COMPLETE
 . ;Ignore zero and split lines (splitting line should not change balance)
 . S SCRLINE=$G(^RCY(344.49,RCSCR,1,SCRSUB,0)) Q:$P(SCRLINE,U)'?1N.N  Q:$P(SCRLINE,U,3)=0  Q:$P(SCRLINE,U,3)="0.00"
 . ;Check if non-zero line has receipt on ERA, DETAIL line
 . S RCSUB=$P(SCRLINE,U,9) I RCSUB,$P($G(^RCY(344.4,RCERA,1,RCSUB,4)),U,3)]"" Q
 . ;Otherwise more AUTO-posting to do
 . S COMPLETE=0
 Q COMPLETE
 ;
ERAREF(RCSCR,RCRCPTDA) ; update ERA reference and EFT record IEN in file 344
 ; RCSCR - IEN of record in file 344.49
 ; RCRCPTDA - ien of record in file 344 (receipt ien)
 N Z,DR,DIE,DA
 S Z=+$O(^RCY(344.31,"AERA",RCSCR,0))
 S DIE="^RCY(344,",DA=RCRCPTDA,DR=".18////"_RCSCR_$S(Z:";.17////"_Z,1:"") D ^DIE
 Q
 ;
NOTOK(RCSCR) ;Verify all scratchpad lines passed auto verify (V)
 ; RCSCR = ien of file 344.49
 ; Returns status of check (1 or 0)
 N NOTOK,SUB
 S SUB=0,NOTOK=0
 F  S SUB=$O(^RCY(344.49,RCSCR,1,SUB)) Q:'SUB  D  Q:NOTOK
 . ;Set NOTOK if any single line is unverified
 . S:$P($G(^RCY(344.49,RCSCR,1,SUB,0)),U,13)'=1 NOTOK=1
 Q NOTOK
 ;
POSTALL(RCERA) ; all lines in ERA get posted on first attempt of auto-post
 ; RCERA = ien of 344.4
 ;ERA Receipt is created from scratchpad entry - type 14 is EDI Lockbox payment
 ; PRCA*4.5*326 begin modified code block
 N RCDUZ
 S RCDUZ=$$GET1^DIQ(344.4,RCERA_",",4.04,"I")
 S RCRCPTDA=$$BLDRCPT^RCDPUREC(DT,"",+$O(^RC(341.1,"AC",14,0)),RCDUZ)  ; Creates basic receipt for ERA of payment type EDI LOCKBOX; 2nd parameter means no alpha suffix on receipt number
 D RCPTDET^RCDPEM(RCSCR,RCRCPTDA,.RCERR,RCDUZ) ; Adds detail to a receipt based on file 344.49
 ; PRCA*4.5*326 end modified code block
 ;
 ;Unable to create receipt - clear scratchpad, reset AUTO-POST STATUS = NULL
 I $O(RCERR("")) D CLEAR(RCSCR),SETSTA(RCERA,"@","Auto Posting: Removed from Auto Posting-Unable to create receipt") Q
 ;
 ;Lock ERA receipt and deposit ticket
 I '$$LOCKREC^RCDPRPLU(RCRCPTDA) Q
 I '$$LOCKDEP^RCDPDPLU(RCDEPTDA) D UNLOCKR Q
 ;
 ;Process Receipt to FMS
 D PROCESS^RCDPURE1(RCRCPTDA,2)
 I $D(^TMP("RCDPE-RECEIPT-ERROR",$J)) D CLEAR(RCSCR),SETSTA(RCERA,"@","Auto Posting: Removed from Auto Posting-Error in receipt processing"),UNLOCKR Q
 ;
 ; update 344, .18 ERA REFERENCE field
 D ERAREF(RCSCR,RCRCPTDA)
 ;
 ;Unlock deposit ticket and receipt
 D UNLOCKR
 ;
 ;Update the audit log
 D AUDITLOG(RCERA,2,"Auto Posting: ERA posted successfully")
 ;Update ERA receipt and detail post status
 S DIE="^RCY(344.4,",DR=".14////1;.08////"_RCRCPTDA,DA=RCERA D ^DIE
 ;Set ERA auto-post status to 'complete' and update latest auto-post date
 S DIE="^RCY(344.4,"
 S DR="4.01////"_DT_";4.02////2"
 S DA=RCERA
 D ^DIE
 ;Update auto-post date for each claim line
 N RCLINE,RCSCSUB,RCSCD0
 S RCSCSUB=0
 F  S RCSCSUB=$O(^RCY(344.49,RCERA,1,RCSCSUB)) Q:'RCSCSUB  D
 . S RCSCD0=$G(^RCY(344.49,RCERA,1,RCSCSUB,0))
 . ;Ignore if zero value (line not on receipt) otherwise get original ERA line sequence
 . Q:'+$P(RCSCD0,U,3)  S RCLINE=$P(RCSCD0,U,9) Q:'RCLINE
 . ;Update ERA line with receipt number and auto-post date
 . N DA,DIE,DR S DA(1)=RCERA,DA=RCLINE,DIE="^RCY(344.4,"_DA(1)_",1,",DR=".25////"_RCRCPTDA_";9////"_DT D ^DIE
 Q
 ;
POSTERA(RCERA,RCLINES) ; only some of the EEOB lines passed validation on first attempt (DAY 1) of auto-post
 ; therefore assign the receipt number and 'partial' post status to ERA summary
 ; RCERA = ien of 344.4
 ; RCLINES = array of ERA line references
 ; no lines passed validation;  at lease 1 EEOB line needs to pass validation before assigning a receipt to the ERA
 I RCLINES=0 S RCRCPTDA="" G POSTERAQ
 ;ERA Receipt is created from scratchpad entry - type 14 is EDI Lockbox payment
 S RCRCPTDA=$$BLDRCPT^RCDPEMA(RCERA) ; Creates basic receipt for ERA of payment type EDI LOCKBOXA
 D RCPTDET^RCDPEMA(RCSCR,RCRCPTDA,.RCLINES,.RCERR) ; Adds detail to a receipt based on file 344.49 and RCLINES array
 ;
 ;Unable to create receipt - clear scratchpad, reset AUTO-POST STATUS = NULL
 I $O(RCERR("")) D CLEAR(RCSCR),SETSTA(RCERA,"@","Auto Posting: Removed from Auto Posting-Unable to create receipt") Q
 ;
 ;Lock ERA receipt and deposit ticket
 I '$$LOCKREC^RCDPRPLU(RCRCPTDA) Q
 I '$$LOCKDEP^RCDPDPLU(RCDEPTDA) D UNLOCKR Q
 ;
 ;Process Receipt to FMS
 D PROCESS^RCDPURE1(RCRCPTDA,2)
 I $D(^TMP("RCDPE-RECEIPT-ERROR",$J)) D CLEAR(RCSCR),SETSTA(RCERA,"@","Auto Posting: Removed from Auto Posting-Error in receipt processing"),UNLOCKR Q
 ;
 ; update 344, .18 ERA REFERENCE field
 D ERAREF(RCSCR,RCRCPTDA)
 ;
 ;Unlock deposit ticket and receipt
 D UNLOCKR
 ;Update ERA receipt and detail post status
 S DIE="^RCY(344.4,",DR=".14////5;.08////"_RCRCPTDA,DA=RCERA D ^DIE
POSTERAQ ;
 D POSTLNS(RCERA,RCRCPTDA,.RCLINES)
 Q
 ;
POSTLNS(RCERA,RCRCPTDA,RCLINES) ; this subroutine should only be called when some of the EEOB lines
 ;                                passed validation on FIRST attempt (DAY 1) of auto-post
 ; RCERA = ien of ERA entry in 344.4
 ; RCRCPTDA = ien of receipt entry in 344 or undefined if receipt not created since none of the lines passed validation
 ; RCLINES = array of ERA line references
 ;Mark ERA as processed to prevent reprocessing in EN2^RCDPEAP which runs next
 S ^TMP("RCDPEAP",$J,RCERA)=""
 S RCRCPTDA=$G(RCRCPTDA)
 ;Update individual claim lines on ERA
 N RCLIN,DA,DIE,DR,LNUM,RCI,REJECT
 S RCLIN=0 F  S RCLIN=$O(RCLINES(RCLIN)) Q:'RCLIN  D
 . ; flag the line if it was rejected during validation
 . S REJECT=0 I '$P(RCLINES(RCLIN),U) S REJECT=1
 . ;get all ERA line references (e.g. RCLINES(RCLIN) could have multiple line # references)
 . ;Need to parse out each line reference so that the necessary fields can be updated for the specific line
 . F RCI=1:1 S LNUM=$P(RCLIN,",",RCI) Q:LNUM=""  D
 . . S DA(1)=RCERA,DA=LNUM,DIE="^RCY(344.4,"_DA(1)_",1,"
 . . ;If not posted then the AUTO-POST REJECTION REASON (344.41,5) needs to be updated ;otherwise update line with receipt number and auto-post date
 . . I REJECT S DR="5////"_$P(RCLINES(RCLIN),U,3)
 . . E  S DR=".25////"_RCRCPTDA_";9////"_DT
 . . D ^DIE
 ;Update the Audit Log
 D AUDITLOG(RCERA,1,"Auto Posting: Some of the ERA lines went to APAR")
 ;Set ERA AUTO-POST STATUS = PARTIAL and update auto-post date
 S DIE="^RCY(344.4,",DR="4.01////"_DT_";4.02////1",DA=RCERA D ^DIE
 Q
 ;
SCRPAD(RCERA,RCZERO) ;Build Scratchpad entry in #344.49 for the ERA
 ; Input - RCERA    - IEN for #344.4
 ;         RCZERO   - Optional, if passed, 1 if zero balance ERA. 0 otherwise 
 ; Output - RCSCR = Scratchpad IEN (Success) or 0 (Fail)
 N RC0,RC5,RCSCR,RCDAT,X
 S RC0=$G(^RCY(344.4,RCERA,0)),RC5=$G(^RCY(344.4,RCERA,5))
 ;Ignore is this ERA already has a receipt
 I +$P(RC0,U,8) Q 0
 ;Ignore if this is zero ERA
 I '$G(RCZERO),+$P(RC0,U,5)=0 Q 0  ;PRCA*4.5*424 Added '$G(RCZERO),
 ; BEGIN PRCA*4.5*326
 ;Ignore if this is not a valid auto-post ERA type 
 ;I "^ACH^CHK^"'[(U_$P(RC0,U,15)_U) Q 0 ; added CHK - PRCA*4.5*321
 I "^ACH^CHK^NON^BOP^"'[(U_$P(RC0,U,15)_U) Q 0
 ;ERA must be matched to an EFT to be eligible for mark for autopost
 I '$G(RCZERO),'$O(^RCY(344.31,"AERA",RCERA,"")) Q 0  ;PRCA*4.5*424 Added '$G(RCZERO),
 ; END PRCA*4.5*326
 ;Scratchpad already exists
 S RCSCR=+$O(^RCY(344.49,"B",RCERA,0)) I RCSCR G SCRPADX
 ;Create new Scratchpad
 S RCSCR=+$$ADDREC^RCDPEWL(RCERA,.RCDAT) I 'RCSCR Q 0
 ;Add all the ERA lines to the Scratchpad entry
 D ADDLINES^RCDPEWLA(RCSCR)
SCRPADX ;Return Scratchpad IEN
 Q RCSCR
 ;
SETSTA(DA,STATUS,RCREASON) ;Set ERA auto-post status
 ; Log status change
 I '$G(DA) Q
 I $G(STATUS)="" Q
 D AUDITLOG(DA,STATUS,$G(RCREASON))
 ; Update status
 N DIE,DR
 S DIE="^RCY(344.4,"
 S DR="4.02////"_STATUS
 S DR=DR_";4.04///"_$S(STATUS=0&(DUZ'=.5):DUZ,1:"@")
 D ^DIE
 Q
 ;
UNLOCKR ;Unlock ERA receipt and deposit ticket
 L -^RCY(344,RCRCPTDA)
 L -^RCY(344.1,RCDEPTDA)
 Q
 ;
UNLOCKE ;Unlock ERA
 L -^RCY(344.4,RCERA)
 Q
