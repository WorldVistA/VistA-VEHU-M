RCDPESP1 ;BIRM/SAB,hrubovcak - ePayment Lockbox Site Parameter Reports ;29 Jan 2019 18:00:14
 ;;4.5;Accounts Receivable;**298,304,318,321,326,332,345**;Mar 20, 1995;Build 34
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
RPT ; EDI Lockbox Parameters Report [RCDPE SITE PARAMETER REPORT]
 ; report data from:
 ;    AR SITE PARAMETER file (#342)
 ;    RCDPE PARAMETER file (#344.61)
 ;    RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ;
 ; LOCAL VARIABLES:
 ;    RTYPE - Type of Report to run (Medical, Pharmacy, or Both)
 ;
 N RCTYPE
 W !,$$HDRLN,!
 ;
 S RCTYPE=$$RTYPE^RCDPESP2  G:RCTYPE=-1 RPTQ
 W !!  ; skip lines before device prompt
 N %ZIS,POP S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 . N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 . S ZTRTN="SPRPT^RCDPESP1",ZTDESC=$$HDRLN,ZTSAVE("RC*")=""
 . D ^%ZTLOAD
 . W !!,$S($G(ZTSK):"Task number "_ZTSK_" has been queued.",1:"Unable to queue this task.")
 . K IO("Q") D HOME^%ZIS
 ;
 D SPRPT
 ;
RPTQ Q
 ;
SPRPT ; site parameter report entry point
 ; RCNTR - counter
 ; RCFLD - DD field number
 ; RCHDR - header information
 ; RCPARM - parameters
 ; RCSTOP - exit flag
 N J,RCACTV,RCCARCD,RCCIEN,RCCODE,RCDATA,RCDESC,RCFLD,RCGLB,RCHDR,RCI,RCITEM,RCNTR,RCPARM,RCSTAT,RCSTOP,RCSTRING,V,X,Y
 ;
 S X="RC" F  S X=$O(^TMP($J,X)) Q:'($E(X,1,2)="RC")  K ^TMP($J,X) ; clear out old data
 ;
 ; RCGLB - ^TMP global storage locations
 ; ^TMP($J,"RC342") - AR SITE PARAMETER file (#342)
 ; ^TMP($J,"RC344.6") - RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ; ^TMP($J,"RC344.61") - RCDPE PARAMETER file (#344.61)
 F J=342,344.6,344.61 S RCGLB(J)=$NA(^TMP($J,"RC"_J)) K @RCGLB(J)
 ;
 S RCHDR("RUNDATE")=$$FMTE^XLFDT($$NOW^XLFDT,"10S")
 S RCHDR("PGNMBR")=0  ; page number
 ;
 ; AR SITE PARAMETER file (#342)
 D GETS^DIQ(342,"1,",".01;.14;.15;7.02;7.03;7.04;7.05;7.06;7.07;7.08;7.09","E",RCGLB(342)) ; PRCA*4.5*345
 ; add site to header data
 S RCHDR("SITE")="Site: "_@RCGLB(342)@(342,"1,",.01,"E")
 ;
 ; PRCA*4.5*345 add field .14 and .15 for first party auto-decrease 
 F RCFLD=7.02,7.03,7.04,.14,.15,7.05,7.06,7.07,7.08,7.09 D  ; EFT and ERA days unmatched  - PRCA*4.5*321
 . S RCITEM=$S(RCFLD=.14!(RCFLD=.15)!(RCFLD>7.04):"TITLE",1:"LABEL") ; PRCA*4.5*345
 . I RCTYPE="P",(RCFLD=7.05)!(RCFLD=7.07) Q  ; Don't display if only showing Pharmacy parameters - PRCA*4.5*321
 . I RCTYPE="M",(RCFLD=7.06)!(RCFLD=7.08) Q  ; Don't display if only showing medical parameters - PRCA*4.5*321
 . S Y=$$GET1^DID(342,RCFLD,,RCITEM)_": "_@RCGLB(342)@(342,"1,",RCFLD,"E")
 . I RCFLD=7.05 D AD2RPT(" ")
 . I (RCFLD=7.06)&(RCTYPE="P") D AD2RPT(" ")
 . D AD2RPT(Y)
 ;
 D AD2RPT(" ")
 ;
 ; Display Medical Parameters
 ; RCDPE PARAMETER file (#344.61),  *future build*, add Tricare auto-decrease fields
 S Y=".02;.03;.04;.05;.06;.07;.1;.11;.12;.13;1.01;1.02;1.03;1.04"  ; PRCA*4.5*345
 D GETS^DIQ(344.61,"1,",Y,"E",RCGLB(344.61)) ; PRCA*4.5*321/PRCA*4.5*326/PRCA*4.5*332
 ;
 S Y=$$GET1^DID(344.61,.1,,"LABEL")_": "_@RCGLB(344.61)@(344.61,"1,",.1,"E") ; PRCA*4.5*321
 D AD2RPT(Y),AD2RPT(" ") ; PRCA*4.5*321
 ;
 ; get auto-post and auto-decrease settings, save zero node
 S X=$G(^RCY(344.61,1,0))
 S RCPARM("AUTO-POST")=$P(X,U,2)
 S RCPARM("AUTO-DECREASE")=$P(X,U,3),RCPARM(344.61,0)=X
 ;
 ; RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ;   screening logic: ^DD(344.6,.06,0)="EXCLUDE MED CLAIMS POSTING^S^0:No;1:Yes;^0;6^Q"
 D LIST^DIC(344.6,,"@;.01;.02;.06;1","P",,,,,"I $P(^(0),U,6)=1",,RCGLB(344.6))
 ;
 ; PRCA*4.5*304 - Print Medical Claim Parameters
 I RCTYPE'="P" D
 . ; RCDPE PARAMETER file (#344.61), auto-posting of medical claims
 . S X=$$GET1^DID(344.61,.02,,"TITLE"),V=" (Y/N)" S:X[V X=$P(X,V)_$P(X,V,2)  ; remove yes/no prompt
 . S Y=X_" "_@RCGLB(344.61)@(344.61,"1,",.02,"E")
 . D AD2RPT(Y)
 . D OPPAYS("Medical Auto-Posting") ; PRCA*4.5*345
 . ;
 . I RCPARM("AUTO-POST") D AD2RPT(" ")
 . K @RCGLB(344.6)  ; delete old data
 . ; RCDPE AUTO-PAY EXCLUSION file (#344.6)
 . ;   screening logic: ^DD(344.6,.07,0)="EXCLUDE MED CLAIMS DECREASE^S^0:No;1:Yes;^0;7^Q"
 . D LIST^DIC(344.6,,"@;.01;.02;.07;2","P",,,,,"I $P(^(0),U,7)=1",,RCGLB(344.6))
 . ; BEGIN PRCA*4.5*326
 . D AD2RPT(" ")
 . ; Display Auto-Decrease parameters for paid lines
 . D AUTOD(1,.RCGBL,RCTYPE,0) ; PRCA*4.5*345
 . ; Display Auto-Decrease parameters for no-pay lines
 . D AUTOD(0,.RCGBL,RCTYPE,0) ; ; PRCA*4.5*345
 . D AD2RPT(" ")
 . ; END PRCA*4.5*326
 . ;
 . D AD2RPT(" ")
 ;
 S X=$G(^RCY(344.61,1,1)) ; PRCA*4.5*345 Get pharmacy auto-post/decrease data
 S RCPARM("AUTO-POST")=$P(X,U)
 S RCPARM("AUTO-DECREASE")=$P(X,U,2)
 ;
 K @RCGLB(344.6)  ; delete old data
 ; RCDPE AUTO-PAY EXCLUSION file (#344.6)
 ;   screening logic: ^DD(344.6,.06,0)="EXCLUDE MED CLAIMS POSTING^S^0:No;1:Yes;^0;6^Q"
 D LIST^DIC(344.6,,"@;.01;.02;.08;3","P",,,,,"I $P(^(0),U,8)=1",,RCGLB(344.6))
 ;
 ; PRCA*4.5*304 - Print Pharmacy Claim Parameters
 I RCTYPE'="M" D
 . ; RCDPE PARAMETER file (#344.61), auto-posting of pharmacy claims
 . S X=$$GET1^DID(344.61,1.01,,"TITLE"),V=" (Y/N)" S:X[V X=$P(X,V)_": "  ; remove yes/no prompt
 . S Y=X_" "_@RCGLB(344.61)@(344.61,"1,",1.01,"E")
 . D AD2RPT(Y)
 . D OPPAYS("Pharmacy Auto-Posting")
 . ; Display Auto-Decrease parameters for paid lines
 . K @RCGLB(344.6)  ; delete old data
 . ; RCDPE AUTO-PAY EXCLUSION file (#344.6)
 . D LIST^DIC(344.6,,"@;.01;.02;.12;4","P",,,,,"I $P(^(0),U,12)=1",,RCGLB(344.6))
 . D AUTOD(1,.RCGBL,RCTYPE,1) ; PRCA*4.5*345
 . D AD2RPT(" ")
 ; RCDPE PARAMETER file (#344.61)
 ;  ^DD(344.61,.06,0) > "MEDICAL EFT POST PREVENT DAYS"
 ;  ^DD(344.61,.07,0) > "PHARMACY EFT POST PREVENT DAYS"
 ;  ^DD(344.61,.13,0) > "TRICARE EFT POST PREVENT DAYS"
 F RCFLD=.06,.07,.13 D 
 . Q:(RCFLD=.06)&(RCTYPE="P")  ; Don't display if only showing Pharmacy parameters
 . Q:(RCFLD=.07)&(RCTYPE="M")  ; Don't display if only showing medical parameters
 . S Y=$$GET1^DID(344.61,RCFLD,,"TITLE")_" "_@RCGLB(344.61)@(344.61,"1,",RCFLD,"E")
 . D AD2RPT(Y)
 ;
 D AD2RPT(" "),AD2RPT($$ENDORPRT^RCDPEARL)
 ;
 S RCSTOP=0 U IO D SPHDR(.RCHDR)
 S J=0 F  S J=$O(^TMP($J,"RC SP REPORT",J)) Q:'J!RCSTOP  S Y=^TMP($J,"RC SP REPORT",J,0) D
 . W !,Y Q:'$O(^TMP($J,"RC SP REPORT",J))  ; quit if last line
 . I '$G(ZTSK),$E(IOST,1,2)="C-",$Y+3>IOSL D ASK^RCDPEARL(.RCSTOP) I 'RCSTOP D SPHDR(.RCHDR) Q
 . Q:RCSTOP  Q:$Y+2<IOSL
 . D SPHDR(.RCHDR)
 ;
 I '$G(ZTSK),$E(IOST,1,2)="C-",'RCSTOP D ASK^RCDPEARL(.RCSTOP)
 ;
 ; close device
 U IO(0) D ^%ZISC
 K @RCGLB(344.6)  ; delete old data
 S X="RC" F  S X=$O(^TMP($J,X)) Q:'($E(X,1,2)="RC")  K ^TMP($J,X) ; clean up
 ;
 Q
 ;
SPHDR(HDR) ; HDR passed by ref.
 ; HDR("RUNDATE") - run date, external format
 ;  HDR("PGNMBR") - page number
 ;    HDR("SITE") - site name
 N P,X,Y
 S P=$G(HDR("PGNMBR"))+1,HDR("PGNMBR")=P  ; increment page count
 ; 
 S X=$$HDRLN
 S P=IOM-($L(X)+10)\2,Y=$J(" ",P)_X_$J(" ",P)_" Page: "_HDR("PGNMBR")
 W @IOF,Y
 S X="   Run Date: "_HDR("RUNDATE"),Y=X_$J(HDR("SITE"),IOM-($L(X)+1))
 W !,Y
 S Y=" "_$TR($J("",IOM-2)," ","-")  ; space_row of hyphens
 W !,Y
 Q
 ;
AD2RPT(A) ; add line to report
 Q:$G(A)=""
 N C S C=$G(^TMP($J,"RC SP REPORT",0))+1,^TMP($J,"RC SP REPORT",0)=C
 S ^TMP($J,"RC SP REPORT",C,0)=A Q
 ;
HDRLN() Q "EDI Lockbox Parameters Report"_$S($G(RCTYPE)="B":" - BOTH",$G(RCTYPE)="M":" - MEDICAL",$G(RCTYPE)="P":" - PHARMACY",1:"")  ; extrinsic variable
 ;
CARCCHK(RCTYPE,TYPE) ;Boolean function, are the CARC parameters to appear on the report?
 ; Returns 1 if valid to print, 0 otherwise
 Q:RCTYPE="B"&($G(TYPE)="M") +$P($G(^RCY(344.61,1,0)),U,3)  ; all parameters, check for medical auto-decrease
 Q:RCTYPE="B"&($G(TYPE)="P") +$P($G(^RCY(344.61,1,1)),U,2)  ; all parameters, check for Pharmacy auto-decrease
 ;Print if Report type is medical and auto-decrease for medical is on
 I RCTYPE="M" Q +$P($G(^RCY(344.61,1,0)),U,3)
 ;Print if Report type is pharmacy and auto-decrease for pharmacy is on
 I RCTYPE="P" Q +$P($G(^RCY(344.61,1,1)),U,2)
 Q 0  ; Don't print the CARCs
 ;
 ; BEGIN - PRCA*4.5*326
AUTOD(PAID,RCGBL,RCTYPE,WHICH) ; Display auto-decrease parameters - PRCA*4.5*345
 ; INPUT   PAID - 1 = paid line parameters 0 = no-payment line parameters
 ;         RCGBL - field value array from LIST^DIC call
 ;         RCTYPE - report type (P)harmacy, (M)edical
 ;         WHICH  - Printing auto-decrease info for 0 - Medical, 1 - Pharmacy
 ; OUTPUT   Lists parameters
 ;
 N CNT,FIELD,X,Y
 ; RCDPE PARAMETER file (#344.61), auto-decrease of medical claims 
 I WHICH=0 S FIELD=$S(PAID:.03,1:.11)
 I WHICH=1 S FIELD=1.02
 S X=$$GET1^DID(344.61,FIELD,,"TITLE")
 I X[" (Y/N): " S X=$P(X," (Y/N): ")_": " ; remove yes/no prompt
 S Y=$J(X,45)_@RCGLB(344.61)@(344.61,"1,",FIELD,"E")
 D AD2RPT(" "),AD2RPT(Y)
 I PAID D  ;
 . D OPPAYS($S(WHICH=0:"Medical",1:"Pharmacy")_" Auto-Decrease")
 D AD2RPT(" ")
 ; If auto-decrease is off - do not display CARCS or auto-decrease days or auto-decrease maximum
 I +$$GET1^DIQ(344.61,"1,",FIELD,"I")=0 Q
 ;
 I WHICH=0,PAID D AD2RPT("MAXIMUM DOLLAR AMOUNT TO AUTO-DECREASE PER MEDICAL CLAIM: "_"$"_$$GET1^DIQ(344.61,"1,",.05,"E"))
 I WHICH=1 D AD2RPT("MAXIMUM DOLLAR AMOUNT TO AUTO-DECREASE PER PHARMACY CLAIM: "_"$"_$$GET1^DIQ(344.61,"1,",1.04,"E"))
 ;
 S CNT=0
 ; Print the CARC Auto-decrease parameters
 I $$CARCCHK(RCTYPE,$S(WHICH=0:"M",1:"P")) D
 . D AD2RPT(" ")
 . S X=" AUTO-DECREASE "_$S(PAID:"PAID",1:"NO-PAY")
 . S X=X_" "_$S(WHICH=0:"MEDICAL",1:"PHARAMCY")
 . S X=X_" CLAIMS FOR THE FOLLOWING CARC/AMOUNTS ONLY:"
 . D AD2RPT(X)
 . D AD2RPT(" ")
 . S RCSTRING=$TR($J("",70)," ","-"),RCI=0
 . D AD2RPT(" CARC Description                                            Max. Amt")
 . D AD2RPT(" "_RCSTRING)
 . ;
 . ; Loop and print entries
 . S RCI=0 F  S RCI=$O(^RCY(344.62,RCI)) Q:'RCI  D
 .. S RCCODE=$$GET1^DIQ(344.62,RCI_",",.01) Q:'RCCODE
 ..  S RCCIEN=$O(^RC(345,"B",RCCODE,""))
 ..  S RCDESC=$G(^RC(345,RCCIEN,1,1,0)) ; WP field 345.04
 ..  I WHICH=0 S FIELD=$S(PAID:.02,1:.08)
 ..  I WHICH=1 S FIELD=2.01
 ..  S RCSTAT=$$GET1^DIQ(344.62,RCI,FIELD,"I") Q:RCSTAT'=1
 ..  S CNT=CNT+1
 ..  I $L(RCDESC)>50 S RCDESC=$E(RCDESC,1,50)_"..."
 ..  D GETCODES^RCDPCRR(RCCODE,"","A",$$DT^XLFDT,"RCCARCD","1^70")
 ..  S Y=" "_$J(RCCODE,4)_" "_$E(RCDESC,1,53) S:$L(RCDESC)<53 Y=Y_$J("",(53-$L(RCDESC)))
 ..  I WHICH=0 S FIELD=$S(PAID:.06,1:.12)
 ..  I WHICH=1 S FIELD=2.05
 ..  S Y=Y_$J($$GET1^DIQ(344.62,RCI,FIELD,"I"),10,0)
 ..  I '$$ACT^RCDPRU(345,RCCODE,) S Y=Y_" (I)"  ; if inactive, display (i)
 ..  D AD2RPT(Y)
 . I CNT=0 D AD2RPT(" No CARCs are set up for "_$S(PAID:"",1:"NO-PAY ")_"auto-decrease")
 ;
 ; Display auto-decrease days
 I WHICH=0 S FIELD=$S(PAID:.04,1:.12)
 I WHICH=1 S FIELD=1.03
 S X=$P($$GET1^DID(344.61,FIELD,,"TITLE")," (",1)_": "
 S Y=$J(X,40)_@RCGLB(344.61)@(344.61,"1,",FIELD,"E")
 D AD2RPT(" "),AD2RPT(Y)
 Q
 ; END - PRCA*4.5*326
 ;
OPPAYS(RCTYPE) ; Output list of excluded payers - Added for PRCA*4.5*345
 ; Input: RCTYPE - Type of list being displayed. Free text. 
 ;        RCPARM - array assumed to exist and contain AUTO-POST and AUTO-DECREASE flags for MED or PHARM 
 ;        RCGLB - array assumed to exist and contain output from GETS^DIQ for payer exclusions
 ;
 N X,XX
 I (RCPARM("AUTO-POST")!RCPARM("AUTO-DECREASE")) D  ; list auto-post excluded payers
 . I '$D(@RCGLB(344.6)@("DILIST",1,0)) D  Q
 . . S X="     No payers excluded from "_RCTYPE_"." D AD2RPT($J(" ",80-$L(X)\2)_X)
 . ;
 . S XX=$P(RCTYPE," ",1)
 . S XX=$S(XX="Pharmacy":"Rx",1:$E(XX,1,3))
 . S XX=XX_" "_$P(RCTYPE," ",2,3)
 . S X="   Excluded Payer ("_XX_")"_$J("",19-$L(XX))_"Comment"
 . D AD2RPT(X)
 . S RCNTR=0 F  S RCNTR=$O(@RCGLB(344.6)@("DILIST",RCNTR)) Q:'RCNTR  D
 . . S V=@RCGLB(344.6)@("DILIST",RCNTR,0),X=$E($P(V,U,2),1,35)
 . . S Y="   "_X_$J(" ",36-$L(X))_$P(V,U,5) D AD2RPT($E(Y,1,IOM))
