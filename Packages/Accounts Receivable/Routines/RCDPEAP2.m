RCDPEAP2 ;AITC/CJE - AUTO POST MATCHING EFT ERA PAIR - CONT. ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**424**;Mar 20, 1995;Build 11
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^IBM(361.1) via Private IA 4051
 ;
 Q
 ; PRCA*4.5*424 Added whole subroutine POST0 below
POST0(RCERA) ; Auto-post zero balance ERA (EP from AUTOPOST^RCDPEAP)
 ; Input - RCERA internal entry number of ERA from file #344.4
 ; Output - None
 ;
 ; Make sure the ERA passes all auto-posting rules
 Q:'$$AUTOCHK^RCDPEAP1(RCERA)
 ;
 ; Update the audit log
 D AUDITLOG^RCDPEAP(RCERA,2,"Auto Posting: ERA posted successfully")
 ;
 ; Update ERA detail post status, set ERA auto-post status to 'complete',update latest auto-post date
 ; set match status to MATCH-0 PAYMENT
 S DIE="^RCY(344.4,"
 S DR=".09///3;.14///1;4.01////"_DT_";4.02///2"
 S DA=RCERA
 D ^DIE
 ;
 ; Update auto-post date for each claim line
 N RCLINE,RCSCD0
 S RCLINE=0
 F  S RCLINE=$O(^RCY(344.4,RCERA,1,RCLINE)) Q:'RCLINE  D
 . S RCSCD0=$G(^RCY(344.4,RCERA,1,RCLINE,0))
 . Q:+$P(RCSCD0,U,3)
 . ;
 . ; Update ERA line with auto-post date
 . N DA,DIE,DR
 . S DA(1)=RCERA,DA=RCLINE,DIE="^RCY(344.4,"_DA(1)_",1,",DR="9///"_DT
 . D ^DIE
 Q
 ;
PAYEREXC(RCERA) ;EP from RCDPEM0
 ; Check to see if the payer is excluded from auto-posting
 ;PRCA*4.5*424 moved method from RCDPEM0
 ; Input:   RCERA   - IEN of the ERA being evaluated
 ; Returns: 1 - Payer is excluded, 0 otherwise
 N NAM0,RCERATYP,RCXCLDE,TIN0,XX
 S NAM0=$$GET1^DIQ(344.4,RCERA_",",.06,"E")  ; PRCA*4.5*345 - Added line - Payer Name
 S TIN0=$$GET1^DIQ(344.4,RCERA_",",.03,"E")  ; PRCA*4.5*345 - Added line - Payer TIN
 S XX=$$GETPAY^RCDPEU1(NAM0,TIN0)            ; PRCA*4.5*345 - Get the IEN from 344.6
 ;
 ; Determine if ERA should be excluded using the site parameters
 I $$CHKTYPE^RCDPEU1(XX,"T") S RCERATYP=2   ; PRCA*4.5*349 - Check if this is TRICARE ERA
 E  S RCERATYP=$$PHARM^RCDPEAP1(RCERA)      ; Else it must be a Medical or Rx ERA
 S RCXCLDE=0
 S:RCERATYP=0 RCXCLDE=$$EXCLUDE^RCDPEAP1(RCERA) ; PRCA*4.5*345 - Changed to =0 from 'RCERATYP
 S:RCERATYP=1 RCXCLDE=$$EXCLDRX^RCDPEAP1(RCERA) ; PRCA*4.5*345 - Changed to =1 from RCERATYP
 S:RCERATYP=2 RCXCLDE=$$EXCLDTR^RCDPEAP1(RCERA) ; PRCA*4.5*349 - Added Line
 Q RCXCLDE                                  ; Quit if the Payer is excluded from Auto-Post
 Q
 ;
