RCDPESP5 ;ALB/SAB,hrubovcak - ePayment Lockbox Site Parameters Definition - Files 344.71 ;29 Jan 2019 18:00:14
 ;;4.5;Accounts Receivable;**304,321,326,332,345**;Mar 20, 1995;Build 34
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
CARC(RCQUIT,PAID,RCARCTYP) ; Update the CARC/RARC inclusion table
 ; PRCA*4.5*345 - Added RCARCTYP for Rx Auto-Decrease CARC/RARC inclusion table
 ; Input:   RCQUIT  - Added RCQUIT as input parameter - PRCA*4.5*321
 ;          PAID    - 1 - Payment lines  0 = no-payment lines - PRCA*4.5*326
 ;          RCARCTYP   - 1 - Pharmacy, 0 - Medical
 ;                    Optional defaults to 0
 N F1,F2,RCANS,RCCARC,RCCHG,RCCDATA,RCCIEN,RCRSN,RCSTAT
 N RCAMT,RCNAMT,RCCARCDS,RCYN,RCVAL,RCACTV,RCTXT,XX
 S:'$D(RCARCTYP) RCARCTYP=0
 S RCTXT=$S(PAID:"",1:"NO-PAY ")  ; PRCA*4.5*326
 ;
 ; Display initial entry line
 W !,"AUTO-DECREASE "_RCTXT
 ;
 ; PRCA*4.5*345 - Added pharmacy check below
 W $S('RCARCTYP:"MEDICAL",1:"PHARMACY")_" CLAIMS FOR THE FOLLOWING CARC/AMOUNTS ONLY:",!
 ;
 ; Loop until the user quits
 S RCANS="" F  D  Q:RCANS="Q"
 . N RCAUDARY
 . ; Display list of currently enabled/disabled CARCs/RARCs
 . D PRTCARC(PAID,RCARCTYP)  ; PRCA*4.5*326, PRCA*4.5*345 added RCARCTYP
 . W !!  ; skip lines
 . ; Ask user for the CARC/RARC to enable/disable (QUIT) [default] to exit
 . S RCCARC=$$GETCARC^RCDPESPB
 . I RCCARC=-1 S RCQUIT=1,RCANS="Q" Q
 . I RCCARC=0 S RCANS="Q" Q
 . ; Validate CARC entered
 . S RCVAL=$$VAL^RCDPCRR(345,RCCARC)   ; Validate CARC against File 345
 . S RCACTV=$$ACT^RCDPRU(345,RCCARC,DT)   ; Check if CARC is an active code
 . ; If the CARC is invalid, warn user and quit
 . I 'RCVAL D  Q
 ..  W !,"The CARC code you have entered is not a valid CARC code.  Please try again"
 . ; Print CARC and description
 . S RCCARCDS=""
 . D GETCODES^RCDPCRR(RCCARC,"","A",$$DT^XLFDT,"RCCARCDS","1^100")
 . I $D(RCCARCDS("CARC",RCCARC))'=10 D
 ..  D GETCODES^RCDPCRR(RCCARC,"","I",$$DT^XLFDT,"RCCARCDS","1^100")
 . S RCCIEN=$O(RCCARCDS("CARC",RCCARC,""))
 . S RCDESC=$P(RCCARCDS("CARC",RCCARC,RCCIEN),U,6)
 . ; If description longer than 70 characters, truncate add ellipsis
 . S:$L(RCDESC)>70 RCDESC=$E(RCDESC,1,70)_"..."
 . W !,"  "_RCDESC,!
 . I 'RCACTV W "   *** WARNING: CARC code "_RCCARC_" is no longer active.",!
 . ;
 . ; Look up CARC/RARC in table.
 . S RCCIEN=$O(^RCY(344.62,"B",RCCARC,""))
 . S (RCAMT,RCSTAT)=0  ; Initialize if new code entry for table
 . D  ; determine enable/disable CARC audit field
 ..  I RCARCTYP=0 S FIELD=$S(PAID:.02,1:.08) Q  ; medical CARC
 ..  S FIELD=2.01  ; pharmacy CARC
 . I RCCIEN D  ; Code exists in table
 ..  ; PRCA*4.5*326, PRCA*4.5*345 begin
 ..  ; Get current payment Auto-decrease status and Max decrease amount
 ..  I PAID=1 D  ; Payment lines
 ...   S F1=$S(RCARCTYP=0:.02,1:2.01)
 ...   S F2=$S(RCARCTYP=0:.06,1:2.05)
 ...   S RCSTAT=$$GET1^DIQ(344.62,RCCIEN,F1,"I")
 ...   S RCAMT=$$GET1^DIQ(344.62,RCCIEN,F2)
 ..  I PAID=0 D  ; No payment lines
 ...   S F1=$S(RCARCTYP=0:.08,1:2.07)
 ...   S F2=$S(RCARCTYP=0:.12,1:2.11)
 ...   S RCSTAT=$$GET1^DIQ(344.62,RCCIEN,F1,"I")
 ...   S RCAMT=$$GET1^DIQ(344.62,RCCIEN,F2)
 ..  ; PRCA*4.5*326, PRCA*4.5*345 end
 . ; If CARC enabled
 . I RCCIEN,RCSTAT D  Q
 ..  S RCNAMT=0,RCRSN=""
 ..  ; Confirm that this is the correct CARC
 ..  S RCYN=$$CONFIRM(4,PAID,RCARCTYP)  ; PRCA*4.5*326 -Added PAID, PRCA4*5*345 -Added RCARCTYP
 ..  Q:RCYN=-1
 ..  ; Ask for reason
 ..  S RCRSN=$$GETREASN(RCCARC)
 ..  Q:RCRSN=-1  ; User indicated to quit
 ..  ; Confirm the disabling
 ..  S RCYN=$$CONFIRM(3,PAID,RCARCTYP)  ; PRCA*4.5*326 -Added PAID, PRCA4*5*345 -Added RCARCTYP
 ..  Q:RCYN=-1
 ..  D UPDDATA(RCCIEN,0,RCAMT,RCRSN,PAID,RCARCTYP) ; If disabling - PRCA4*5*345 - Added RCARCTYP
 ..  ; audit disabled CARC: "File^Field^IEN^New Value^Old Value^Comment"
 ..  S RCAUDARY(1)="344.62^"_FIELD_"^"_RCCIEN_"^0^1^"_RCRSN ; PRCA*4.5*326
 ..  D AUDIT^RCDPESP(.RCAUDARY)
 . ;
 . ; Confirm that this is the correct CARC to Enable
 . S RCYN=$$CONFIRM(1,PAID,RCARCTYP) ; Added PAID - PRCA*4.5*326
 . Q:RCYN=-1
 . ;
 . ; Ask for new amount
 . S RCNAMT=$$GETAMT^RCDPESPB(RCARCTYP)  ; PRCA4*5*345 - Added RCARCTYP
 . Q:RCNAMT=-1  ; User indicated to quit
 . ;
 . ; Ask for reason
 . S RCRSN=$$GETREASN(RCCARC)
 . Q:RCRSN=-1  ;User indicated to quit
 . ;
 . ; Confirm save
 . S RCYN=$$CONFIRM(2,PAID,RCARCTYP) ; Added PAID - PRCA*4.5*326 Added RCARCTYP
 . I (RCYN="N")!(RCYN=-1) W !,"NOT SAVED",!! Q
 . ;
 . ; Re-enable if disabled and quit
 . I RCCIEN D  Q
 ..  D UPDDATA(RCCIEN,1,RCNAMT,RCRSN,PAID,RCARCTYP)  ; Re-enable, update amount - PRCA*4.5*326 added RCARCTYP
 ..  ; Update audit file with reason and changes (field format above)
 ..  S RCAUDARY(1)="344.62^"_FIELD_"^"_RCCIEN_"^1^0^"_RCRSN  ; PRCA*4.5*326
 ..  D  ; audit field for CARC amount
 ...   I RCARCTYP=0 S FIELD=$S(PAID:.06,1:.12) Q  ; medical CARC
 ...   S FIELD=2.05  ; pharmacy CARC
 ..  S RCAUDARY(2)="344.62^"_FIELD_"^"_RCCIEN_"^"_RCNAMT_"^"_RCAMT_"^"_RCRSN ; PRCA*4.5*326
 ..  D AUDIT^RCDPESP(.RCAUDARY)
 . ;
 . ; Store new entry
 . D ADDDATA(RCCARC,RCNAMT,RCRSN,PAID,RCARCTYP) ; PAID added PRCA*4.5*326, PRCA4*5*345 - Added RCARCTYP
 . ;
 . ; Update audit file with reason and amount changes.
 . S RCCIEN=$$FIND1^DIC(344.62,"","",RCCARC,"","","RCERR")
 . S:RCCIEN="" RCCIEN="ERROR"
 . ;
 . S RCAUDARY(1)="344.62^"_FIELD_"^"_RCCIEN_"^1^0^"_RCRSN   ; PRCA*4.5*326
 . D  ; audit field for CARC amount
 ..  I RCARCTYP=0 S FIELD=$S(PAID:.06,1:.12) Q  ; medical CARC
 ..  S FIELD=2.05  ; pharmacy CARC
 . S RCAUDARY(2)="344.62^"_FIELD_"^"_RCCIEN_"^"_RCNAMT_"^0^"_RCRSN ; PRCA*4.5*326
 . D AUDIT^RCDPESP(.RCAUDARY)
 . ;
 Q
 ;
PRTCARC(PAID,RCARCTYP) ; Display current entries that have been defined for 
 ; inclusion or exclusion into - PAID added - PRCA*4.5*326
 ; PRCA4*5*345 - Added RCARCTYP parameter
 ; Input:   PAID:  0 - Auto-Decrease CARCs for Paid claim lines, 1 - Auto-Decrease CARCs for No-Pay claim lines
 ; RCARCTYP: 0 - Medical Auto-Decrease CARCs, 1 - Rx Auto-Decrease CARCs, Optional, defaults to 0
 ;
 N FIELD,RCCIEN,RCCODE,RCCT,RCDATA,RCDESC,RCI,RCSTAT,Y
 S:'$D(RCARCTYP) RCARCTYP=0  ; PRCA4*5*345 - Added line
 ; Print Header
 W !,"  CARC   Description"_$J("Max. Amt",55),!,"  "_$$EQLSGNS^RCDPESP2(73)
 ;
 ; Loop and print entries
 S (RCI,RCCT)=0
 F  D  Q:'RCI
 . N RCCARCD
 . S RCI=$O(^RCY(344.62,RCI)) Q:'RCI
 . S RCDATA=$G(^RCY(344.62,RCI,0)) Q:RCDATA=""
 . S RCCODE=$P(RCDATA,U,1),RCCIEN=$O(^RC(345,"B",RCCODE,""))
 . S RCDESC=$G(^RC(345,RCCIEN,1,1,0))
 . ;
 . ; PRCA4*5*345 - Added Rx checks below
 . D  ; determine enable/disable CARC audit field
 ..  I RCARCTYP=0 S FIELD=$S(PAID:.02,1:.08) Q  ; medical CARC
 ..  S FIELD=2.01  ; pharmacy CARC
 . S RCSTAT=$$GET1^DIQ(344.62,RCI,FIELD,"I")
 . Q:RCSTAT'=1
 . S RCCT=RCCT+1
 . I $L(RCDESC)>50 S RCDESC=$E(RCDESC,1,50)_" ..."
 . D GETCODES^RCDPCRR(RCCODE,"","B",$$DT^XLFDT,"RCCARCD","1^70")
 . D  ; amount field to display
 ..  I RCARCTYP=0 S FIELD=$S(PAID:.06,1:.12) Q  ; medical CARC
 ..  S FIELD=2.05  ; pharmacy CARC
 . S Y="   "_$$PAD^RCDPESPA(RCCODE,6)_$$PAD^RCDPESPA(RCDESC,55)_$J($$GET1^DIQ(344.62,RCI,FIELD,"I"),9)
 . I $P(RCCARCD("CARC",RCCODE,RCCIEN),U,3)'="" S Y=Y_" (I)"  ; if inactive, display (I)
 . W !,Y
 ;
 I RCCT=0 W !,"    NO CARC/AMOUNTS ENTERED"
 Q
 ;
CONFIRM(RCIDX,PAID,RCARCTYP) ; Ask user to change or disable an enabled CARC auto-decrement
 ; Added PAID - PRCA*4.5*326
 ; PRCA4*5*345 - Added RCARCTYP parameter
 ;Input: 
 ; RCIDX: 1 - Enable Auto-Decrease CARC, 2 - Confirm Enable of Auto-Decrease CARC, 3 - Confirm disable of Auto-Decrease CARC, 4 - Disable Auto-Decrease CARC
 ; PAID: 1 - Auto-Decrease CARCs for paid claims, 0 - Auto-Decrease CARCs for no-pay claims
 ; RCARCTYP: 0 - Medical Auto-Decrease CARCs, 1 - Rx Auto-Decrease CARCs, Optional, defaults to 0
 ;
 N DA,DIR,DTOUT,DUOUT,DIRUT,DIROUT,RCTXT,X,XX,Y
 S:'$D(RCARCTYP) RCARCTYP=0                       ; PRCA4*5*345 - Added line
 S RCTXT=$S(PAID:"",1:"NO-PAY ")            ; PRCA*4.5*326
 ;
 ; Confirm if the CARC code is correct
 I RCIDX=1 D
 . S DIR("?")="Either (Y)es to confirm that this is the correct code or (N)o to enter a different code."
 . ; PRCA4*5*345 - added Rx Check below
 . S XX="ENABLE this CARC for Auto-Decrease of "_RCTXT_$S(RCARCTYP=0:"Medical",1:"Pharmacy")_" Claims (Y/N)? "
 . S DIR("A")=XX
 ;
 ; Confirm user wishes to Enable changes
 I RCIDX=2 D
 . S DIR("?")="Either (Y)es to confirm changes or (N)o to exit without saving."
 . S DIR("A")="Save this CARC? (Y)es or (N)o: "
 ;
 ; Confirm user wishes to Disable changes
 I RCIDX=3 D
 . S DIR("?")="Either (Y)es to confirm changes or (N)o to exit without saving."
 . S DIR("A")="Remove this CARC? (Y)es or (N)o: "
 ;
 ; Confirm CARC code is correct
 I RCIDX=4 D
 . S DIR("?")="Either (Y)es to confirm that this is the correct code or (N)o to enter a different code."
 . S XX="DISABLE this CARC for Auto-Decrease of "_RCTXT
 . ; PRCA4*5*345 - Added Rx check below
 . S XX=XX_$S(RCARCTYP=0:"Medical",1:"Pharmacy")_" Claims (Y/N)? "
 . S DIR("A")=XX
 ;
 S DIR(0)="YA",DIR("S")="Y:Yes;N:No"
 D ^DIR
 K DIR
 I $G(DTOUT)!$G(DUOUT) S Y=-1
 I Y="0" S Y=-1
 Q Y
 ;
GETREASN(RCCARC) ; Get the reason for modification
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT
 S DIR("?")="Enter reason for enabling/disabling, or changing the Maximum Dollar decrease amount for CARC "_RCCARC_" (3-50 chars)."
 S DIR(0)="FA^3:50"
 S DIR("A")="COMMENT: "
 S DIR("PRE")="S X=$$TRIM^XLFSTR(X,""LR"")" ; comment required and should be significant
 D ^DIR
 K DIR
 I $G(DUOUT) S Y=-1
 Q Y
 ;
UPDDATA(RCCIEN,RCSTAT,RCAMT,RCRSN,PAID,RCARCTYP) ; Update the database and audit log
 ; PAID added PRCA*4.5*326
 ; PRCA4*5*345 - Added RCARCTYP
 ; Input:   RCCIEN      - IEN of the CARC (#344.62(
 ;          RCSTAT      - 1 - Enabling Auto-Decrease, 0 - Disabling
 ;          RCAMT       - Auto-Decrease amount for the CARC
 ;          RCRSN       - Comment
 ;          PAID        - 1 - Paid CARC list, 0 - No-Pay CARC List
 ;          RCARCTYP       - 0 - Medical Claims, 1 - Rx Claims
 N DA,DR,DIE,DTOUT,X,Y,DIC
 ; replaced //// with /// in following 5 lines - PRCA*4.5*321
 S DA=RCCIEN,(DIC,DIE)="^RCY(344.62,"
 ; BEGIN - PRCA*4.5*326
 ; CARCs for Paid Medical Claims PRCA4*5*345 - added RCARCTYP=0
 I PAID=1,RCARCTYP=0 D
 . S DR=".02///"_RCSTAT_";"
 . S DR=DR_".05///"_$$DT^XLFDT_";" ; PRCA*4.5*326
 . S DR=DR_".04///"_DUZ_";"
 . S DR=DR_".06///"_RCAMT_";"
 . S DR=DR_".07///"_RCRSN_";"
 ;
 ; CARCs for PAID Rx Claims PRCA4*5*345 - added If statement
 I PAID=1,RCARCTYP=1 D
 . S DR="2.01///"_RCSTAT_";"
 . S DR=DR_"2.04///"_$$DT^XLFDT_";"
 . S DR=DR_"2.03///"_DUZ_";"
 . S DR=DR_"2.05///"_RCAMT_";"
 . S DR=DR_"2.06///"_RCRSN_";"
 ;
 ; CARCs for No-pay Medical Claims PRCA4*5*345 - added RCARCTYP=0
 I PAID=0,RCARCTYP=0 D
 . S DR=".08///"_RCSTAT_";"
 . S DR=DR_".11///"_$$DT^XLFDT_";"
 . S DR=DR_".10///"_DUZ_";"
 . S DR=DR_".12///"_RCAMT_";"
 . S DR=DR_".13///"_RCRSN_";"
 ; END - PRCA*4.5*326
 ;
 L +^RCY(344.62,RCCIEN):10 E  Q  ; PRCA*4.5*326 timeout condition added
 D ^DIE
 L -^RCY(344.62,RCCIEN)
 Q  ; PRCA*4.5*326 - return value removed 
 ;
ADDDATA(RCCARC,RCAMT,RCRSN,PAID,RCARCTYP) ; Add new entry to the table
 ; PAID added PRCA*4.5*326
 ; PRCA4*5*345 - Added RCARCTYP
 ; Input:   RCCARC  - IEN of the CARC being added
 ;          RCAMT   - Auto-Decrease Amount
 ;          RCRSN   - Comment
 ;          PAID    - 1 - Paid Claims, 0 - No-Pay Claims
 ;          RCARCTYP   - 0 - Medical, 1 - Rx
 N MSGROOT,RCENTRY,RCROOT
 ;
 ; BEGIN - PRCA*4.5*326
 ; Set up array for Paid Medical Claims PRCA4*5*345 - Added RCARCTYP
 I PAID=1,RCARCTYP=0 D
 . S RCENTRY(344.62,"+1,",.01)=RCCARC       ; CARC Code
 . S RCENTRY(344.62,"+1,",.02)=1            ; Enabled status
 . S RCENTRY(344.62,"+1,",.03)=$$DT^XLFDT   ; Date added PRCA*4.5*326
 . S RCENTRY(344.62,"+1,",.04)=DUZ          ; User
 . S RCENTRY(344.62,"+1,",.06)=RCAMT        ; Max amount
 . S RCENTRY(344.62,"+1,",.07)=RCRSN        ; Comment
 ;
 ; Set up array for Paid RX Claims PRCA4*5*345 - Added If statement
 I PAID=1,RCARCTYP=1 D
 . S RCENTRY(344.62,"+1,",.01)=RCCARC       ; CARC Code
 . S RCENTRY(344.62,"+1,",2.01)=1           ; Enabled status
 . S RCENTRY(344.62,"+1,",2.02)=$$DT^XLFDT  ; Date added
 . S RCENTRY(344.62,"+1,",2.03)=DUZ         ; User
 . S RCENTRY(344.62,"+1,",2.05)=RCAMT       ; Max amount
 . S RCENTRY(344.62,"+1,",2.06)=RCRSN       ; Comment
 ;
 ; Set up array for No-Pay Medical Claims PRCA4*5*345 - Added RCARCTYP
 I PAID=0,RCARCTYP=0 D
 . S RCENTRY(344.62,"+1,",.01)=RCCARC       ; CARC Code
 . S RCENTRY(344.62,"+1,",.08)=1            ; Enabled status
 . S RCENTRY(344.62,"+1,",.09)=$$DT^XLFDT   ; Date/Time added
 . S RCENTRY(344.62,"+1,",.10)=DUZ          ; User
 . S RCENTRY(344.62,"+1,",.12)=RCAMT        ; Max amount
 . S RCENTRY(344.62,"+1,",.13)=RCRSN        ; Comment
 ; END - PRCA*4.5*326
 ;file entry
 D UPDATE^DIE(,"RCENTRY","RCROOT","MSGROOT")
 Q
 ;
AUDIT() ;EP from RCDPESP
 ; File Audit Trail entry
 ;
 N EMEDANS,ERXANS,MEDANS,RCPRM,RXANS ; PRCA*4.5*321
 W !
 ; Get existing answers for Medical and Pharmacy paper bills
 S RCPRM("oldMed")=$$GET1^DIQ(342,"1,",7.05,"I")
 S RCPRM("oldPharm")=$$GET1^DIQ(342,"1,",7.06,"I")
 ; Get existing (#7.09) AUTO-AUDIT TRICARE EDI BILLS [9S]
 S RCPRM("oldTri")=$$GET1^DIQ(342,"1,",7.09,"I")
 ;
 ; Get existing answers for Medical and Pharmacy EDI (electronic) bills ; PRCA*4.5*321
 S RCPRM("eOldMed")=$$GET1^DIQ(342,"1,",7.07,"I") ; PRCA*4.5*321
 S RCPRM("eOldPharm")=$$GET1^DIQ(342,"1,",7.08,"I") ; PRCA*4.5*321
 ;
 ; Get Medical paper bills
 S MEDANS=$$GETAUDIT(1)
 Q:MEDANS=-1 1
 ;
 ; File Medical paper bills
 I MEDANS'=RCPRM("oldMed") D
 . N RCAUDVAL
 . D FILEANS(7.05,MEDANS)
 . ; FILE NUMBER^FIELD NUMBER^IEN^NEW VALUE^OLD VALUE^COMMENT
 . S RCAUDVAL(1)="342^7.05^1^"_MEDANS_U_RCPRM("oldMed")_U_"Updating the Medical Auto-Audit of paper bills"
 . D AUDIT^RCDPESP(.RCAUDVAL)
 ;
 ; Get Pharmacy paper bills
 S RXANS=$$GETAUDIT(2)
 Q:RXANS=-1 1
 ;
 ; File Pharmacy paper bills
 I RXANS'=RCPRM("oldPharm") D
 . N RCAUDVAL
 . D FILEANS(7.06,RXANS)
 . S RCAUDVAL(1)="342^7.06^1^"_RXANS_U_RCPRM("oldPharm")_U_"Updating the Pharmacy Auto-Audit of paper bills"
 . D AUDIT^RCDPESP(.RCAUDVAL)
 ;
 ; BEGIN PRCA*4.5*321
 ; Get Medical electronic bills
 S EMEDANS=$$GETAUDIT(3)
 Q:EMEDANS=-1 1
 ;
 ; File Medical electronic bills
 I EMEDANS'=RCPRM("eOldMed") D
 . N RCAUDVAL
 . D FILEANS(7.07,EMEDANS)
 . ; FILE NUMBER^FIELD NUMBER^IEN^NEW VALUE^OLD VALUE^COMMENT
 . S RCAUDVAL(1)="342^7.07^1^"_EMEDANS_U_RCPRM("eOldMed")_U_"Updating the Medical Auto-Audit of electronic bills"
 . D AUDIT^RCDPESP(.RCAUDVAL)
 ;
 ; Get Pharmacy electronic bills
 S ERXANS=$$GETAUDIT(4)
 Q:ERXANS=-1 1
 ;
 ; File Pharmacy electronic bills
 I ERXANS'=RCPRM("eOldPharm") D
 . N RCAUDVAL
 . D FILEANS(7.08,ERXANS)
 . S RCAUDVAL(1)="342^7.08^1^"_ERXANS_U_RCPRM("eOldPharm")_U_"Updating the Pharmacy Auto-Audit of electronic bills"
 . D AUDIT^RCDPESP(.RCAUDVAL)
 ; END PRCA*4.5*321
 ;
 S RCPRM("newTri")=$$GETAUDIT(5)
 Q:RCPRM("newTri")=-1 1
 ; (#7.09) AUTO-AUDIT TRICARE EDI BILLS [9S] - PRCA*4.5*332
 I RCPRM("newTri")'=RCPRM("oldTri") D
 . N RCAUDVAL
 . D FILEANS(7.09,RCPRM("newTri"))
 . ; FILE NUMBER^FIELD NUMBER^IEN^NEW VALUE^OLD VALUE^COMMENT
 . S RCAUDVAL(1)="342^7.09^1^"_RCPRM("newTri")_U_RCPRM("oldTri")_U_"Updating the Auto-Audit of Tricare bills"
 . D AUDIT^RCDPESP(.RCAUDVAL)
 ;
 Q 0
 ;
GETAUDIT(FLAG) ; Retrieve the parameter for the bill type
 ; BEGIN PRCA*4.5*321
 ;FLAG - What audit type (1=Med Paper, 2=RX Paper, 3=Med EDI, 4=Rx EDI, 5=Tricare)
 Q:'$G(FLAG) -1
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FLDNO,RCANS,TYPL,TYPU,X,Y
 S TYPL=$S(FLAG>2:"electronic",1:"paper")
 S TYPU=$S(FLAG>2:"ELECTRONIC",1:"PAPER")
 S FLDNO=$S(FLAG=1:7.05,FLAG=2:7.06,FLAG=3:7.07,FLAG=4:7.08,FLAG=5:7.09,1:0)
 Q:'FLDNO -1
 ;
 ; Prompt for Medical Auto-audit
 D:$G(FLAG)#2=1
 . S DIR("A")="ENABLE AUTO-AUDIT FOR MEDICAL "_TYPU_" BILLS (Y/N): "
 . S DIR("?",1)="Allow a site to automatically audit their Medical "_TYPL_" Bills"
 . S DIR("?",2)="during the AR Nightly Process."
 . S DIR("?",3)=" "
 . S RCANS=$$GET1^DIQ(342,"1,",FLDNO)
 ;
 ; Prompt for Pharmacy Auto-audit
 D:$G(FLAG)#2=0
 . S DIR("A")="ENABLE AUTO-AUDIT FOR PHARMACY "_TYPU_" BILLS (Y/N): "
 . S DIR("?",1)="Allow a site to automatically audit their Pharmacy "_TYPL_" Bills"
 . S DIR("?",2)="during the AR Nightly Process."
 . S DIR("?",3)=" "
 . S RCANS=$$GET1^DIQ(342,"1,",FLDNO)
 ; END PRCA*4.5*321
 ;
 ; Prompt for Tricare Auto-audit PRCA*4.5*332
 D:$G(FLAG)=5
 . S DIR("A")="ENABLE AUTO-AUDIT FOR TRICARE BILLS (Y/N): "
 . S DIR("?",1)="Allow a site to automatically audit their Tricare Bills"
 . S DIR("?",2)="during the AR Nightly Process."
 . S DIR("?",3)=" "
 . S RCANS=$$GET1^DIQ(342,"1,",7.09)
 ;
 S DIR(0)="YAO"
 S DIR("?")="Enter Yes or No to select automatic processing of "_TYPL_" bills." ; PRCA*4.5*321
 S DIR("B")=$S($G(RCANS)'="":RCANS,1:"No")
 D ^DIR K DIR
 I Y="" Q ""
 I $D(DTOUT)!$D(DUOUT)!(Y="")  Q -1
 Q Y
 ;
FILEANS(FIELD,ANS) ; File the answer
 N DR,DIE,DA,DTOUT,DIDEL,X,Y
 ;
 ; Update Transaction
 S DR=FIELD_"///"_ANS  ; Original Confirmation #
 S DIE="^RC(342,",DA=1 D ^DIE
 Q
 ;
 ;BEGIN PRCA*4.5*326
CARCDSP(RCMAX,RCARCTYP) ; EP ^RCDPESP7
 ; Input:   RCMAX       - Maximum CARC amount
 ;          RCARCTYP       - 0 - Medical CARCs, 1 - Rx CARCs
 N RCCHECK
 ;
 ; Check for CARCs that will be reset to the new maximum and display
 S RCCHECK=0
 ; PRCA4*5*345 - Added RCARCTYP to next 2 lines
 D CHECK^RCDPESPB(RCMAX,1,1,.RCCHECK,RCARCTYP)  ; Paid line CARCs
 I RCARCTYP'=1 D CHECK^RCDPESPB(RCMAX,0,1,.RCCHECK,RCARCTYP)  ; No-Pay line CARCs
 ;
 ; Finish if none found
 Q:'RCCHECK 1
 ;
 ; Ask if OK to proceed and reduce these CARCs
 N DIR,DTOUT,DUOUT
 S DIR(0)="YA"
 S DIR("A")="Do you want to continue (Y/N)? "
 W ! D ^DIR
 I $D(DUOUT)!$D(DTOUT) Q "QUIT"  ; Abort
 ;
 ; Go back and re-enter maximum amount
 I 'Y Q 0
 S RCCHECK=0  ; Update the CARCs previously displayed
 ; PRCA4*5*345 - Added RCARCTYP to next 2 lines
 D CHECK^RCDPESPB(RCMAX,1,0,.RCCHECK,RCARCTYP)  ; Update paid line CARCs
 I RCARCTYP'=1 D CHECK^RCDPESPB(RCMAX,0,0,.RCCHECK,RCARCTYP)  ; Update no-pay line CARCs
 Q 1
 ;
