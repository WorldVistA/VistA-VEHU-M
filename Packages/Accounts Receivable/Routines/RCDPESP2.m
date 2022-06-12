RCDPESP2 ;BIRM/SAB - ePayment Lockbox Parameter Audit and Exclusion Reports ;29 Jan 2019 18:00:14
 ;;4.5;Accounts Receivable;**298,304,317,321,326,332,345**;Mar 20, 1995;Build 34
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
RPT1 ; EDI Lockbox Parameters Report [RCDPE SITE PARAMETER REPORT]
 G AUDPARM^RCDPESPA  ; PRCA*4.5*332, report moved, 11 October 2018
 Q
 ;
RPT2 ; EDI Lockbox Exclusion Audit Report [RCDPE EXCLUSION AUDIT REPORT]
 ;
 ; DESCRIPTION: a listing of the RCDPE PARAMETER AUDIT file
 ;              including changes to the RCDPE AUTO-PAY EXCLUSION file.
 ;
 ; ^TMP("RCDPESP2",$J) - storage for LIST^DIC output
 ; RCT - storage locations in ^TMP for report
 ; RCRPT("dtRange") - date range for report
 ; RCRPT("begDt")  - report start date
 ; RCRPT("endDt")  - report end date
 ; RCRPT("excel") - true if report in Excel format
 ; RCSCR - screening logic for LIST^DIC
 ; RCFLDS  - fields for LIST^DIC
 ; RCDIERR - errors from LIST^DIC
 ; RCHDR("PAGE")  - page counter
 ; RCHDR("RUNDATE") - date/time report was run 
 ; RCSTOP  - report exit flag
 ; RCPARAM - parameter that was changed
 ; RCPARAM("TIME")   - time parameter changed
 ; RCPARAM("OLDVAL") - old parameter value
 ; RCPARAM("NEWVAL") - new parameter value
 ; RCPARAM("USER")  - USER WHO CHANGED A PARAMETER
 ; RCTMP - one record from LIST^DIC
 ; RCFND - flag indicating records returned
 ; RCTYPE  - type of report (MEDICAL, PHARMACY, or BOTH)
 ;
 W !!,"   EDI Lockbox Exclusion Audit Report",!
 ; PRCA*4.5*345 - Added RCT
 N RCFLDS,RCFND,RCHDR,RCIEN,RCDIERR,RCPARAM,RCRPT,RCSCR,RCT,RCSTOP,RCTMP,RCTYPE,RCSCRTYP,X1,X2,X,Y,%ZIS,POP
 ;
 W !!," EDI Lockbox Exclusion Audit Report",!
 ; PRCA*4.5*345 Begin
 S (RCHDR("PAGE"),RCSTOP,RCIEN,RCRPT("excel"),RCFND)=0 ; Initialize values
 S RCT("MedPost")=$NA(^TMP("RC-MedPost",$J)) K @RCT("MedPost")
 S RCT("MedDecr")=$NA(^TMP("RC-MedDecr",$J)) K @RCT("MedDecr")
 S RCT("RxPost")=$NA(^TMP("RC-RxPost",$J)) K @RCT("RxPost")
 S RCT("RxDecr")=$NA(^TMP("RC-RxDecr",$J)) K @RCT("RxDecr")
 ; *future build* add Tricare below
 ;S RCT("triAuPyrExcl")=$NA(^TMP("RC-triAuPyrExc",$J)) K @RCT("triAuPyrExcl")
 ;S RCT("triAuExcl")=$NA(^TMP("RC-triAuExcl",$J)) K @RCT("triAuExcl")
 ; PRCA*4.5*345 end
 S RCTYPE=$$RTYPE^RCDPESPA  ; PRCA*4.5*345 - changed to M,P,T,ALL
 Q:RCTYPE=-1
 S RCHDR("rprtTyp")=RCTYPE  ; Save filter selection
 S RCRPT("dtRange")=$$DTRNG  ; Get date range
 Q:RCRPT("dtRange")=0
 S RCRPT("begDt")=$P(RCRPT("dtRange"),U,2)-.1
 S RCRPT("endDt")=$P(RCRPT("dtRange"),U,3)+.9
 S RCFLDS="@;.04;.01I;.06;.03;.08;.02"  ; Output fields for LIST^DIC
 ; .04 - CHANGED FIELD .01 - TIMESTAMP .06 - NEW VALUE
 ; .03 - CHANGED BY .08 - COMMENT .02 - MODIFIED IEN
 ;
 ; first part of LIST^DIC screening logic
 S RCSCR="I ($P(^(0),U,5)=344.6)&($P(^(0),U,1)>"_RCRPT("begDt")_")&($P(^(0),U,1)<"_RCRPT("endDt")_")"
 ;
 S RCRPT("excel")=$$DISPTY^RCDPEM3  ; output to Excel?
 Q:+RCRPT("excel")=-1
 I RCRPT("excel") D INFO^RCDPEM6
 S %ZIS="M" D ^%ZIS Q:POP  U IO  ; Select output device
 ;
 S RCHDR("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"5S")
 ;
 ; Process Auto-Post Payer Exclusions
 ; Get screening logic based on the type of audit report
 S RCSCR(.06)=RCSCR_"&($P(^(0),U,4)=.06)"  ; screening logic for medical auto-post
 S RCSCR(.07)=RCSCR_"&($P(^(0),U,4)=.07)"  ; screening logic for medical auto-decrease
 S RCSCR(.08)=RCSCR_"&($P(^(0),U,4)=.08)"  ; screening logic for pharmacy auto-post
 S RCSCR(.12)=RCSCR_"&($P(^(0),U,4)=.12)"  ; screening logic for pharmacy auto-decrease, PRCA*4.5*345
 ; *future build*
 ;S RCSCR(.13)=RCSCR_"&($P(^(0),U,4)=.13)"  ; screening logic for TRICARE auto-post
 ;S RCSCR(.14)=RCSCR_"&($P(^(0),U,4)=.14)"  ; screening logic for TRICARE auto-decrease
 ; Get  medical Auto-Post Payer exclusions
 D LIST^DIC(344.7,,RCFLDS,"P",,,,,RCSCR(.06),,RCT("MedDecr"),"RCDIERR")
 I $D(RCDIERR) D  Q   ;  exit if errors
 . W !!,"Error collecting auto-post report data."
 . D ASK^RCDPEARL(.RCSTOP)
 ; Get medical Auto-Decrease Payer exclusions
 D LIST^DIC(344.7,,RCFLDS,"P",,,,,RCSCR(.07),,RCT("MedPost"),"RCDIERR")
 I $D(RCDIERR) D  Q  ;  exit if errors
 . W !!,"Error collecting Payer auto-decrease report data."
 . D ASK^RCDPEARL(.RCSTOP)
 ; Get the pharmacy Auto-Post Payer exclusions
 D LIST^DIC(344.7,,RCFLDS,"P",,,,,RCSCR(.08),,RCT("RxPost"),"RCDIERR")
 I $D(RCDIERR) D  Q   ; exit if errors
 . D ERR4USR("Pharmacy Auto-Post"),ASK^RCDPEARL(.RCSTOP)
 ; Get pharmacy Auto-Decrease Payer exclusions
 D LIST^DIC(344.7,,RCFLDS,"P",,,,,RCSCR(.12),,RCT("RxDecr"),"RCDIERR")
 I $D(RCDIERR) D  Q   ; exit if errors
 . D ERR4USR("Pharmacy Auto-Decrease"),ASK^RCDPEARL(.RCSTOP)
 ;
 I (RCTYPE="B")!(RCTYPE="M") D  G:RCSTOP RPT2Q  ; Display Medical Payer exclusions
 . D OPTYPE("MedPost",.06,RCTYPE)
 . D OPTYPE("MedDecr",.07,RCTYPE)
 ;
 I (RCTYPE="B")!(RCTYPE="P") D  G:RCSTOP RPT2Q  ; Display pharmacy Payer exclusions
 . D OPTYPE("RxPost",.08,RCTYPE)
 . D OPTYPE("RxDecr",.12,RCTYPE)
 ;
 ; PRCA*4.5*345 end
 ; end of report
 W !!,$$ENDORPRT^RCDPEARL
 D ASK^RCDPEARL(.RCSTOP)
 ;
RPT2Q ; exit point
 S X="" F  S X=$O(RCT(X)) Q:X=""  K @RCT(X)  ; clean up ^TMP storage
 Q
 ;
GETPAYER() ; GET THE PAYER NAME + PAYER ID
 N RCIEN,RCPAYR
 S RCIEN=$P(RCTMP,U,6)
 I '$D(^RCY(344.6,RCIEN)) Q ""
 S RCPAYR=$$GET1^DIQ(344.6,RCIEN_",",.01)_" "_$$GET1^DIQ(344.6,RCIEN_",",.02)
 Q RCPAYR
 ;
HDRXAR(RCTYP,RCEXCTYP) ; Report header for auto-posting exclusion report
 ; Input:   
 ; RCTYP - .06 = Auto-Posting exclusion (medical)
 ;         .07 = Auto-Decrease exclusion (medical)
 ;         .08 = Auto-Posting exclusion (pharmacy)
 ;         .12 = Auto-Decrease exclusion (pharmacy)
 ; RCEXCTYP  - M - Medical, P - Pharmacy, B - Both
 ; *future build* add Tricare, change 'Both' to 'All'
 I RCRPT("excel") D  Q
 . Q:RCHDR("PAGE")
 . ; Excel header for parameter audits
 . W !!,"TYPE^CHANGE^PAYER^TIMESTAMP^USER^COMMENT"
 . S RCHDR("PAGE")=1  ; only print it once
 ;
 I RCHDR("PAGE") D ASK^RCDPEARL(.RCSTOP) Q:RCSTOP
 W @IOF
 S RCHDR("PAGE")=RCHDR("PAGE")+1
 ; report header for parameter audits
 W $$CNTR("EDI Lockbox Exclusion Audit Report"),?IOM-8,"Page: "_RCHDR("PAGE")
 W !,$$CNTR("DIVISIONS: ALL")
 W !,$$CNTR("RUN DATE: "_$G(RCHDR("RUNDATE")))
 W !,$$CNTR("DATE RANGE: "_$$FMTE^XLFDT($P(RCRPT("dtRange"),U,2),"5D")_" - "_$$FMTE^XLFDT($P(RCRPT("dtRange"),U,3),"5D"))
 W !,$$CNTR("REPORT TYPE: "_$S(RCEXCTYP="M":"MEDICAL",RCEXCTYP="P":"PHARMACY",1:"BOTH"))
 D SECTHDR(RCTYP,RCEXCTYP)
 Q
 ; PRCA*4.5*345 begin
SECTHDR(RCTYPE,RCREPT) ; SECTION HEADER
 ; PRCA*4.5*345 - Added Rx Auto-Decrease
 ; Input: RCTYP - .06 = Auto-Posting exclusion (medical)
 ; .07 = Auto-Decrease exclusion (medical)
 ; .08 = Auto-Posting exclusion (Rx)
 ; .12 = Auto-Decrease exclusion (Rx)
 ; .13 = Auto-Posting exclusion (TRICARE)
 ; .14 = Auto-Decrease exclusion (TRICARE)
 ; RCREPT - M - Medical, P - Pharmacy, B - Both
 ; *future build* add Tricare, change 'Both' to 'All'
 Q:$G(RCRPT("excel"))
 I RCTYPE=.06 D TXPEQLS("MEDICAL AUTO-POSTING PAYER EXCLUSION LIST")
 I RCTYPE=.07 D TXPEQLS("MEDICAL AUTO-DECREASE PAYER EXCLUSION LIST")
 I RCTYPE=.08 D TXPEQLS("PHARMACY AUTO-POSTING PAYER EXCLUSION LIST")
 I RCTYPE=.12 D TXPEQLS("PHARMACY AUTO-DECREASE PAYER EXCLUSION LIST")
 ;
 W !,"Change Payer Date/Time Edited User"
 W !,$$EQLSGNS(IOM-1)  ; row of equal signs
 Q
 ;
TXPEQLS(Y) ; write text in Y then row of equal signs
 Q:$G(Y)=""   ; must have text
 W !!,Y,!,$$EQLSGNS($L(Y)) Q
 ;
EQLSGNS(N) Q $S($G(N)>0:$TR($J("",N)," ","="),1:"")  ; row of N equal signs
 ;
ERR4USR(TXT) ; error message display
 W !!,"Error collecting "_$G(TXT)_" report data." Q
 ; PRCA*4.5*345 end
CNTR(TXT) ; center TXT
 Q $J("",IOM-$L(TXT)\2)_TXT
 ;
DTRNG() ; function, returns date range for the report
 N DIR,DUOUT,RNGFLG,X,Y,RCSTART,RCEND
 S (RCSTART,RCEND)=0 D DATES(.RCSTART,.RCEND)
 Q:RCSTART=-1 0
 Q:RCSTART "1^"_RCSTART_"^"_RCEND
 Q:'RCSTART "0^^"
 Q 0
 ;
DATES(BDATE,EDATE) ; Get a date range, both values passed by ref.
 N DIR,DTOUT,DUOUT,X,Y
 S (BDATE,EDATE)=0
 S DIR("?")="Enter the earliest AUDIT DATE to include on the report"
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Report start date: " D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S BDATE=Y K DIR,X,Y
 S DIR("?")="Enter the latest AUDIT DATE to include on the report"
 S DIR(0)="DAO^"_BDATE_":"_DT_":APE",DIR("A")="Report end date: ",DIR("B")=$$FMTE^XLFDT(DT)
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S EDATE=Y
 Q
 ;
DSPXCLSN(RCX) ; display exclusion
 ; RCX - exclusion value from ^DIC call
 N RCXCLSN
 S RCXCLSN("CHANGE")=$S($P(RCX,U,3):"Added",1:"Removed")
 S RCXCLSN("TIME")=$$FMTE^XLFDT($P(RCX,U,2),"2")
 S RCXCLSN("USER")=$P(RCX,U,4)
 S RCXCLSN("PAYER")=$$GETPAYER
 S RCXCLSN("COMMENT")=$P(RCX,U,5)
 ;
 I 'RCRPT("excel") D  Q
 .N Y S Y=RCXCLSN("CHANGE"),$E(Y,9)=$E(RCXCLSN("PAYER"),1,30),$E(Y,41)=" "_RCXCLSN("TIME"),Y=Y_" "_RCXCLSN("USER")
 .W !,Y,!,"  Comment: "_RCXCLSN("COMMENT")
 ; Excel format
 S RCXCLSN("LABEL")=$$GET1^DID(344.6,$P(RCX,U,1),,"LABEL")
 W !,RCXCLSN("LABEL")_U_RCXCLSN("CHANGE")_U_RCXCLSN("PAYER")_U_RCXCLSN("TIME")_U_RCXCLSN("USER")_U_RCXCLSN("COMMENT")
 ;
 Q
 ;
 ;Retrieve the parameter for the type of information to display
RTYPE(DEF) ;EP from RCDPEAA1
 ; Input:   DEF     - Value to use a default
 ; Returns: -1      - User ^ or timed out
 ;           M      - User selected MEDICAL
 ;           P      - User selected PHARMACY
 ;           B      - User selected BOTH
 N DA,DIR,DTOUT,DUOUT,X,Y,DIRUT,DIROUT,RCTYPE
 S RCTYPE=""
 S DIR("?")="Enter the type of information to display on the report"
 S DIR(0)="SA^M:MEDICAL;P:PHARMACY;B:BOTH"
 S DIR("A")="(M)EDICAL, (P)HARMACY, or (B)OTH: "    ; PRCA*4.5*317 changed 'OR' to 'or'
 S DIR("B")=$S($G(DEF)'="":DEF,1:"BOTH")
 D ^DIR
 K DIR
 I $D(DTOUT)!$D(DUOUT) Q -1
 Q:Y="" "B"
 Q $E(Y)
 ;
 ;Check to see if the Data element matches the report type
RPTYPE(RCTYPE,RCPARAM) ;
 ; Return 1 if valid to print, 0 otherwise
 N RCDATA,RCMEN,RCREN
 ;
 S (RCMEN,RCREN)=""
 ; Get Auto Decrease parameters
 I RCTYPE="M" S RCMEN=$P($G(^RCY(344.61,1,0)),U,3)
 I RCTYPE="P" S RCREN=$P($G(^RCY(344.61,1,1)),U,2)
 ;
 Q:RCTYPE="B" 1
 Q:(RCTYPE="M")&(RCPARAM["MED") 1       ; Medical Parameters
 Q:(RCTYPE="P")&(RCPARAM["RX") 1        ; Pharmacy parameters
 Q:(RCTYPE="P")&(RCPARAM["PHARM") 1        ; Pharmacy parameters
 Q:(RCTYPE="M")&(RCMEN)&(RCPARAM["DECREASE") 1         ; Auto-decrease for med is on
 Q:(RCTYPE="P")&(RCREN)&(RCPARAM["DECREASE") 1         ; Auto-decrease for pharmacy
 Q 0
 ;
OPTYPE(SUB,FIELD,RCTYPE) ; Output data for each type
 ; Input: SUB - Subscript to array that contain the data for this type
 ;        FIELD - Changed field from field 4 file 344.7
 ;        RCTYPE  - M - Medical, P - Pharmacy, B - Both
 D HDRXAR(FIELD,RCTYPE) ; complete header
 S RCFND=$D(@RCT(SUB)@("DILIST",1)) ; check for payer exclusions
 I 'RCFND D  ;
 . W !,"No "
 . I FIELD=.06 W "Medical Auto-Post"
 . I FIELD=.07 W "Medical Auto-Decrease"
 . I FIELD=.08 W "Pharmacy Auto-Post"
 . I FIELD=.12 W "Pharmacy Auto-Decrease"
 . W " Exclusions to Display",!
 I RCFND D  ; Display medical Auto-post Payer exclusions
 . S RCIEN=0,RCSTOP=0
 . F  S RCIEN=$O(@RCT(SUB)@("DILIST",RCIEN)) Q:RCSTOP!('RCIEN)  D
 . . S RCTMP=$P(@RCT(SUB)@("DILIST",RCIEN,0),U,2,7)
 . . I $Y+4>IOSL D HDRXAR(FIELD,RCTYPE) Q:RCSTOP
 . . D DSPXCLSN(RCTMP)
 Q
