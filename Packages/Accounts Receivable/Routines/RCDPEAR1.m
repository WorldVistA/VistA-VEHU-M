RCDPEAR1 ;ALB/TMK/PJH - ERA Unmatched Aging Report (file #344.4) ;Dec 20, 2014@18:41:35
 ;;4.5;Accounts Receivable;**173,269,276,284,293,298,321,326,371,409**;Mar 20, 1995;Build 17
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; PRCA*4.5*298 routine completely refactored
EN1 ; entry point - ERA Unmatched Aging Report [RCDPE ERA AGING REPORT]
 ; data from ELECTRONIC REMITTANCE ADVICE file (#344.4)
 N POP,RCDADJ,RCDISPTY,RCDT,RCDTRNG,RCHDR,RCJOB,RCLNCNT,RCLSTMGR,RCOUT      ;PRCA*4.5*409 Added POP,RCADJ
 N RCPAR,RCPAY,RCPGNUM,RCPYRLST,RCSTOP,RCTMPND,RCTYPE,RCXCLUDE,RCZROBAL,VAUTD,XX,Y
 ;
 ; RCDADJ               - Display Adjustment/Code info flag     ;PRCA*4.5*409 Added line
 ; RCDISPTY             - Display type (Excel)
 ; RCDTRNG              - Selected date range
 ; RCDT("BEG")          - Start date, RCDT("END") - end date
 ; RCHDR                - Header array
 ; RCLSTMGR             - list manager flag
 ; RCDTRNG              - "1^start date^end date"
 ; RCXCLUDE("CHAMPVA")  - boolean, exclude CHAMPVA
 ; RCXCLUDE("TRICARE")  - boolean, exclude TriCare
 ; RCZROBAL             - Zero balance flag
 ; VAUTD                - Division information
 ; RCTYPE               - MEDICAL/PHARMACY/TRICARE/ALL = M/P/T/A
 ; RCPAY                - S=SELECTED, R=RANGE, A=ALL
 ;                        (Selected or range - payers stored in ^TMP(""RCDPEU1"",$J))
 ;
 K ^TMP($J,"RC TOTAL")                          ; Clear old totals
 W !,$$HDRNM
 D DIVISION^VAUTOMA                             ; Returns VAUTD
 I 'VAUTD&($D(VAUTD)'=11) D EN1Q Q
 S RCLSTMGR=""                                  ; Initial value, won't be asked if non-null
 S (RCXCLUDE("CHAMPVA"),RCXCLUDE("TRICARE"))=0  ; Default to false
 S RCDTRNG=$$DTRNG^RCDPEM4()
 I 'RCDTRNG D EN1Q Q
 S RCDT("BEG")=$P(RCDTRNG,U,2),RCDT("END")=$P(RCDTRNG,U,3)
 ;
 ; PRCA*4.5*326 - Ask to show Medical/Pharmacy Tricare or All
 S RCTYPE=$$RTYPE^RCDPEU1("A")
 I RCTYPE=-1 D EN1Q Q
 ;
 S RCPAR("SELC")=$$PAYRNG^RCDPEU1()             ; PRCA*4.5*326 - Selected or Range of Payers
 I RCPAR("SELC")=-1 D EN1Q Q                    ; PRCA*4.5*326 '^' or timeout
 S RCPAY=RCPAR("SELC")
 ;
 I RCPAR("SELC")'="A" D  Q:XX=-1                ; PRCA*4.5*326 - Since we don't want all payers 
 . S RCPAR("TYPE")=RCTYPE                       ;                prompt for payers we do want
 . S RCPAR("DICA")="Select Insurance Company NAME: "
 . S XX=$$SELPAY^RCDPEU1(.RCPAR)
 ;
 S RCZROBAL=$$ZROBAL()                          ; Get Zero Balance Filter
 I RCZROBAL<0 D EN1Q Q
 ;
 S RCDADJ=$$DADJCDE()                           ; Get Adjustment/Code Filter ;PRCA*4.5*409 Added line
 I RCDADJ<0 D EN1Q Q
 ;
 ; Display type, ask for Excel format
 S RCDISPTY=$$DISPTY^RCDPEM3()
 I RCDISPTY=-1 D EN1Q Q
 ;
 ; Display device info about Excel format, set ListMan flag to prevent question
 I RCDISPTY S RCLSTMGR="^" D INFO^RCDPEM6
 I $D(DUOUT)!$D(DTOUT) D EN1Q Q
 S RCJOB=$J                                     ; Needed in RPTOUT
 ;
 ; If not output to Excel ask for ListMan display, exit if timeout or '^' - PRCA*4.5*298
 I RCLSTMGR="" S RCLSTMGR=$$ASKLM^RCDPEARL G:RCLSTMGR<0 EN1Q
 ;
 ; Display in ListMan format and exit on return
 I RCLSTMGR D  Q
 . S RCTMPND=$T(+0)_"^ERA UNMATCHED AGING"  K ^TMP($J,RCTMPND)  ; clean any residue
 . D RPTOUT
 . N H,L,HDR S L=0
 . S HDR("TITLE")=$$HDRNM
 . F H=1:1:7 I $D(RCHDR(H)) S L=H,HDR(H)=RCHDR(H)  ; take first 7 lines of report header
 . I $O(RCHDR(L)) D  ; any remaining header lines at top of report
 . . N N S N=0,H=L F  S H=$O(RCHDR(H)) Q:'H  S N=N+.001,^TMP($J,RCTMPND,N)=RCHDR(H)
 . ;
 . ; invoke ListMan
 . D LMRPT^RCDPEARL(.HDR,$NA(^TMP($J,RCTMPND))) ; generate ListMan display
 . D EN1Q
 ;
 ; Ask device
 N %ZIS S %ZIS="QM"
 D ^%ZIS
 I POP D EN1Q Q
 I $D(IO("Q")) D  Q
 . N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK,ZTSTOP
 . S ZTRTN="RPTOUT^RCDPEAR1",ZTDESC="AR - EDI LOCKBOX ERA AGING REPORT"
 . S ZTSAVE("RC*")="",ZTSAVE("VAUTD")=""
 . S ZTSAVE("^TMP(""RCDPEU1"",$J,")="" ; PRCA*4.5*326
 . D ^%ZTLOAD
 . W !!,$S($G(ZTSK):"Task number "_ZTSK_" has been queued.",1:"Unable to queue this task.")
 . K ZTSK,IO("Q")
 . D HOME^%ZIS
 . D EN1Q
 ;
 U IO
 S RCTMPND=""
 D RPTOUT
 ;
EN1Q ; exit and clean up
 K ^TMP("RCSELPAY",$J),^TMP("RCPAYER",$J),^TMP("RCDPEU1",$J) ; PRCA*4.5*326
 I '$G(RCLSTMGR) D ^%ZISC
 Q
 ;
RPTOUT ; Entry point for listing report
 ; Input:   RCTMPND - Name of the subscript for ^TMP to use to return all lines
 ;                    (for bulletin).  If undefined or null, output is printed
 ; Returns: Global if RCTMPND not null: ^TMP($J,RCTMPND,line#)=line text
 N ERADT,J,LNECNT,PYMNTFRM,RC0,RCEDT,RCEXCEP,RCFLIEN,RCITM,RCNT,RCSF0,RCZ
 N STA,STNAM,STNUM,X,XX,Y,Z,Z0
 ; ERADT    - Date of entry
 ; LNECNT   - # of Lines displayed on the current page
 ; RCDADJ   - Display Adjustment/Code Filter        ;PRCA*4.5*409 Added line        
 ; RCNT     - Count of items
 ; RCFLIEN  - Entry number in file #344.4
 ; RCITM    - Entry in ^RCY(344.4,0) = ELECTRONIC REMITTANCE ADVICE^344.4I
 ; RCSF0    - Zero node of sub-file entry
 ;
 S LNECNT=0
 S RCTMPND=$G(RCTMPND)
 I RCTMPND'="" K ^TMP($J,RCTMPND)               ; Clear residual data
 K ^TMP($J,"RCERA_AGED"),^TMP($J,"RCERA_ADJ")
 S RCFLIEN=0,RCNT=0
 F  S RCFLIEN=$O(^RCY(344.4,"AMATCH",0,RCFLIEN)) Q:'RCFLIEN  D
 . K RCITM
 . M RCITM=^RCY(344.4,RCFLIEN)                  ; Grab entire entry
 . Q:$P($G(RCITM(6)),U)                         ; Who removed the ERA - PRCA*4.5*293
 . S ERADT=+$P($G(RCITM(0)),U,7)                ; (#.07) FILE DATE/TIME [7D]
 . Q:'ERADT                                     ; No date, don't include
 . ;
 . ; Check date range
 . Q:(RCDT("BEG")>ERADT\1)!(ERADT\1>RCDT("END"))
 . ;
 . ; Check Station/Division
 . ;I '$$CHKDIV^RCDPEDAR(RCFLIEN,1,.VAUTD) Q
 . I 'VAUTD D ERASTA^RCDPEM4(RCFLIEN,.STA,.STNUM,.STNAM) I '$D(VAUTD(STA)) Q
 . ;
 . I RCPAY'="A" D  Q:'XX
 . . S XX=$$ISSEL^RCDPEU1(344.4,RCFLIEN)        ; PRCA*4.5*326 Check if payer was selected
 . E  I RCTYPE'="A" D  Q:'XX                    ; If all of a give type of payer selected
 . . S XX=$$ISTYPE^RCDPEU1(344.4,RCFLIEN,RCTYPE)    ;  Check that payer matches type
 . ;
 . ; Check for Zero Bal
 . I 'RCZROBAL,'$P($G(RCITM(0)),U,5) Q          ; (#.05) TOTAL AMOUNT PAID [5N]
 . S ^TMP($J,"RCERA_AGED",$$FMDIFF^XLFDT(ERADT,DT),RCFLIEN)=0,RCNT=RCNT+1
 ;
 S ^TMP($J,"RC TOTAL","COUNT")=RCNT             ; Save counter
 ;
 ; Build header, initialize stop flag
 D:'RCLSTMGR HDRBLD
 S RCSTOP=0
 D:RCLSTMGR HDRLM
 ;
 ; Excel format, print and exit
 I RCDISPTY D EXCEL,^%ZISC,EXIT Q
 ;
 D  ;  Calculate total amount for ERA
 . N T S T=0  ; total
 . S RCZ=""
 . F  D  Q:RCZ=""
 . . S RCZ=$O(^TMP($J,"RCERA_AGED",RCZ))
 . . Q:RCZ=""
 . . S RCFLIEN=0
 . . F  S RCFLIEN=$O(^TMP($J,"RCERA_AGED",RCZ,RCFLIEN)) Q:'RCFLIEN  D
 . . . S RC0=$G(^RCY(344.4,RCFLIEN,0)),T=T+$P(RC0,U,5)
 . ;
 . S ^TMP($J,"RC TOTAL","AMOUNT")=T
 ;
 S RCLNCNT=0                                    ; Line counter
 D:'RCLSTMGR HDRLST^RCDPEARL(.RCSTOP,.RCHDR)    ; First header in report
 ;
 ; List totals
 S Y=" Total NUMBER Aged Electronic ERA messages found: "_$FN(^TMP($J,"RC TOTAL","COUNT"),",")
 D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND) S LNECNT=LNECNT+1
 S Y=" Total AMOUNT Aged Electronic ERA messages found: $"_$FN(^TMP($J,"RC TOTAL","AMOUNT"),",",2)
 D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND) S LNECNT=LNECNT+1
 ;
 ; If filters selected show total excluded
 F J="CHAMPVA","TRICARE" I $G(RCXCLUDE(J)) D
 . S Y=" "_J_" exclusion count: "_(+$G(^TMP($J,"RC TOTAL",J)))
 . D SL^RCDPEARL(Y,.RCLNCNT,RCTMPND) S LNECNT=LNECNT+1
 D SL^RCDPEARL(" "_$TR($J("",78)," ","="),.RCLNCNT,RCTMPND) S LNECNT=LNECNT+1  ; Row of equal signs
 ;
 S RCZ="" F  S RCZ=$O(^TMP($J,"RCERA_AGED",RCZ)) Q:RCZ=""  S RCFLIEN=0 F  S RCFLIEN=$O(^TMP($J,"RCERA_AGED",RCZ,RCFLIEN)) Q:'RCFLIEN  D  G:RCSTOP EXIT
 .I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPGNUM) W:RCTMPND="" !!,"***TASK STOPPED BY USER***" Q
 .I RCPGNUM D SL^RCDPEARL(" ",.RCLNCNT,.RCTMPND) S LNECNT=LNECNT+1 ; On detail list, skip line
 .I 'RCLSTMGR,'RCPGNUM!(($Y+5)>IOSL) D HDRLST^RCDPEARL(.RCSTOP,.RCHDR) Q:RCSTOP
 .S RC0=$G(^RCY(344.4,RCFLIEN,0))
 .S RCEXCEP=$$XCEPT^RCDPEWLP(RCFLIEN)  ; PRCA*4.5*298  assignment of ERA exception flag (will either be "" or "x")
 .S Z=$$SETSTR^VALM1($J(RCEXCEP_-RCZ,4),"",1,5)  ; PRCA*4.5*298 display ERA exception flag
 .S Z=$$SETSTR^VALM1("  "_$P(RC0,U,2),Z,5,50)
 .D SL^RCDPEARL(Z,.RCLNCNT,RCTMPND) S LNECNT=LNECNT+1
 .S Z=$$SETSTR^VALM1($$PAYTIN^RCDPRU2($P(RC0,U,6)_"/"_$P(RC0,U,3),78),"",3,78) ; PRCA*4.5*321
 .D SL^RCDPEARL(Z,.RCLNCNT,RCTMPND) S LNECNT=LNECNT+1
 .S Z=$$SETSTR^VALM1($J("",16)_$S($P(RC0,U,7):$$FMTE^XLFDT($P(RC0,U,7)\1,2),1:""),"",1,25)
 .S Z=$$SETSTR^VALM1("  "_$J($P(RC0,U,5),15,2),Z,26,17)
 .;
 .;PRCA*4.5*409 Added if statement
 .I RCDADJ D
 ..S Z=$$SETSTR^VALM1("  "_+$P(RC0,U,11),Z,43,11)
 .;
 .;PRCA*4.5*409 Replaced 43 with $S(RCDADJ:54,1:43)
 .S Z=$$SETSTR^VALM1("  "_$P(RC0,U),Z_$S('$$HACERA^RCDPEU(RCFLIEN):"",1:" (HAC ERA)"),$S(RCDADJ:54,1:43),16) ; PRCA*4.5*321
 .;PRCA*4.5*371 Moved ERA Date column over from 70 to 59 below
 .;
 .;PRCA*4.5*409 Replaced 59 with $S(RCDADJ:70,1:59)
 .S Z=$$SETSTR^VALM1("  "_$$FMTE^XLFDT($P(RC0,U,4),2),Z,$S(RCDADJ:70,1:59),10)                 ; PRCA*4.5*321
 .D SL^RCDPEARL(Z,.RCLNCNT,RCTMPND) S LNECNT=LNECNT+1
 .Q:'RCDADJ                                     ;PRCA*4.5*409 Added line
 .;
 .;PRCA*4.5*409 Added call to new routine due to routine size limitations
 .D RPTOUT2^RCDPEAR4
 ;
 ; PRCA*4.5*298, put end-of-report into SL^RCDPEARL
 I 'RCSTOP D SL^RCDPEARL(" ",.RCLNCNT,RCTMPND),SL^RCDPEARL($$ENDORPRT^RCDPEARL,.RCLNCNT,RCTMPND)
 D EXIT
 Q
 ;
EXIT ; Exit the report
 ; PRCA*4.5*298, added ListMan check
 I '$D(ZTQUEUED),'RCLSTMGR D
 . I 'RCSTOP,RCPGNUM,RCTMPND="" D ASK^RCDPEARL(.RCSTOP)
 . D ^%ZISC
 ;
 S:$D(ZTQUEUED) ZTREQ="@"
 K ^TMP($J,"RCERA_AGED"),^TMP("RCSELPAY",$J),^TMP($J,"RC TOTAL"),^TMP("RCDPEU1",$J) ; PRCA*4.5*326
 Q
 ;
HDRBLD ; Create the report header
 ; Input:   RCADJ           - 1 - Display Adjustment/Code information, 0 otherwise ;PRCA*4.5*409 Added RCADJ
 ;          RCDISPTY        - 1 - Output to excel, 0 otherwise
 ;          RCDTRNG         - Date range selected
 ;          RCXCLUDE        - TRICARE /CHAMPVA flags
 ;          VAUTD           - Divisions to include in report (if listed in VAUTD array)
 ; Output:  RCHDR(0)        - Header text line count
 ;          RCHDR(1)        - Excel column data (only set If DISPTY=1)
 ;          RCHDR("XECUTE") - M code for page number
 ;          RCHDR("RUNDATE")- Date/time report generated, external format
 ;          RCPGNUM         - Page counter
 ;          RCSTOP          - Flag to exit
 ;
 N CHATRI,DIV,HCNT,XX,Y
 K RCHDR
 S RCHDR("RUNDATE")=$$NOW^RCDPEARL,RCPGNUM=0,RCSTOP=0
 I RCDISPTY D  Q  ; Excel format, xecute code is QUIT, null page number
 . S RCHDR(0)=1,RCHDR("XECUTE")="Q",RCPGNUM=""
 . S XX="Aged Days^Trace #^Payment From/ID^ERA Date^File Date^Amount Paid"
 . ;
 . ;PRCA*4.5*409 Replaced S XX=XX_"^ERA #" with If/Else below
 . I RCDADJ D
 . . S XX=XX_"^EEOB Cnt^ERA #^EEOB Detail"
 . E  D
 . . S XX=XX_"^ERA #"
 . S RCHDR(1)=XX
 ;
 S XX="N Y S RCPGNUM=RCPGNUM+1,Y=$$HDRNM^"
 S XX=XX_$T(+0)_",RCHDR(1)=$J("" "",80-$L(Y)\2)_Y"_"_""          Page: ""_RCPGNUM,LNECNT=RCHDR(0)"
 S RCHDR("XECUTE")=XX
 S HCNT=1
 S Y="RUN DATE: "_RCHDR("RUNDATE"),HCNT=HCNT+1
 S RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 ;
 ; Divisions
 S Y="DIVISIONS: "
 I $D(VAUTD)=1 S Y=Y_"ALL",Y=$J("",80-$L(Y)\2)_Y,HCNT=HCNT+1,RCHDR(HCNT)=Y
 I $D(VAUTD)>1 D
 . N S,X S S=0
 . F  S S=$O(VAUTD(S)) Q:'S  D
 . . S X=VAUTD(S)_$S($O(VAUTD(S)):", ",1:"")
 . . I $L(X)+$L(Y)>80 D
 . . . S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y,Y=$J(" ",12)
 . . S Y=Y_X
 . ;
 . S:$TR(Y," ")]"" HCNT=HCNT+1,RCHDR(HCNT)=Y  ; any residual data
 ;
 ; Payers - PRCA*4.5*326
 S Y="PAYERS: "
 S Y=Y_$S(RCPAY="S":"SELECTED",RCPAY="R":"RANGE",1:"ALL")
 S Y=Y_$J("",45-$L(Y))_"MEDICAL/PHARMACY/TRICARE: "
 S Y=Y_$S(RCTYPE="M":"MEDICAL",RCTYPE="P":"PHARMACY",RCTYPE="T":"TRICARE",1:"ALL")
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 ;
 S Y("1ST")=$P(RCDTRNG,U,2),Y("LST")=$P(RCDTRNG,U,3)
 F Y="1ST","LST" S Y(Y)=$$FMTE^XLFDT(Y(Y),"2Z")
 S Y="DATE RANGE: "_Y("1ST")_" - "_Y("LST")_" (ERA FILE DATE)"
 S HCNT=HCNT+1,RCHDR(HCNT)=$J("",80-$L(Y)\2)_Y
 ;
 S HCNT=HCNT+1,RCHDR(HCNT)=""
 S Y="AGED"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="DAYS  TRACE #"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="  PAYMENT FROM/ID" ; PRCA*4.5*321 - Allow extra room for 60 character Payer Name
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 ;
 ;PRCA*4.5*371 Removed EEOB CNT below
 ;PRCA*4.5*409 Replaced S Y="                FILE DATE      AMOUNT PAID  ERA #           ERA DATE"
 ;             with I/E statment below
 I RCDADJ D
 . S Y="                FILE DATE      AMOUNT PAID  EEOB CNT   ERA #           ERA DATE"
 E  D
 . S Y="                FILE DATE      AMOUNT PAID  ERA #           ERA DATE"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="",$P(Y,"=",80)="",HCNT=HCNT+1,RCHDR(HCNT)=Y
 S RCHDR(0)=HCNT                                ; Total lines in header
 Q
 ;
HDRLM ; Create the list manager version of the report header
 ; Input:   RCDADJ      - 1 - Display Adjustment/Code info 0 otherwise ;PRCA*4.5*409 Added RCDADJ
 ;          RCDTRNG     - Date range filter value to be printed as part of the
 ;                        header
 ;          RCPAY       - 1 - All Payers
 ;                        2 - Selected Payers
 ;          RCPAY()     - Array of selected Payers if RCPAY=2
 ;          RCLSTMGR    -
 ;          VAUTD       - 1 - All divisions
 ;                        2 - Selected divisions
 ;          VAUTD()     - Array of selected divisions (if VAUTD=2)
 ; Output:  RCHDR(0)    - Header text line count
 N DATE,DIV,HCNT,MSG,Y,Z0
 K RCHDR
 S Z0="",RCPGNUM=0,RCSTOP=0
 S RCHDR(1)="DATE RANGE: "_$$FMTE^XLFDT($P(RCDTRNG,U,2),"2Z")
 S RCHDR(1)=RCHDR(1)_" - "_$$FMTE^XLFDT($P(RCDTRNG,U,3),"2Z")_" (ERA FILE DATE)"
 S HCNT=1
 ;
 S Y="DIVISIONS: "
 I $D(VAUTD)=1 S Y=Y_"ALL",HCNT=HCNT+1,RCHDR(HCNT)=Y
 I $D(VAUTD)>1 D
 . N S,X
 . S S=0
 . F  S S=$O(VAUTD(S)) Q:'S  D
 . . S X=VAUTD(S)_$S($O(VAUTD(S)):", ",1:"")
 . . I $L(X)+$L(Y)>80 S HCNT=HCNT+1,RCHDR(HCNT)=Y,Y=$J(" ",12)
 . . S Y=Y_X
 . ;
 . S:$TR(Y," ")]"" HCNT=HCNT+1,RCHDR(HCNT)=Y  ; any residual data
 ;
 ; Payers - PRCA*4.5*326
 S Y="PAYERS: "
 S Y=Y_$S(RCPAY="S":"SELECTED",RCPAY="R":"RANGE",1:"ALL")
 S Y=Y_$J("",45-$L(Y))_"MEDICAL/PHARMACY/TRICARE: "
 S Y=Y_$S(RCTYPE="M":"MEDICAL",RCTYPE="P":"PHARMACY",RCTYPE="T":"TRICARE",1:"ALL")
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 ;
 S Y="AGED"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="DAYS  TRACE #"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S Y="  PAYMENT FROM/ID" ; PRCA*4.5*321 - Allow extra room for 60 character Payer Name
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 ; PRCA*4.5*371 Removed EEOB CNT below
 ;PRCA*4.5*409 Replaced S Y="                FILE DATE      AMOUNT PAID  ERA #           ERA DATE"
 ;             with I/E statment below
 I RCDADJ D
 . S Y="                FILE DATE      AMOUNT PAID  EEOB CNT   ERA #           ERA DATE"
 E  D
 . S Y="                FILE DATE      AMOUNT PAID  ERA #           ERA DATE"
 S HCNT=HCNT+1,RCHDR(HCNT)=Y
 S RCHDR(0)=HCNT                                ; Total lines in header
 Q
 ;
HDRNM() ; Extrinsic variable, name for header PRCA*4.5*298
 Q "ERA UNMATCHED AGING REPORT"
 ;
EXCEL ; Print report to screen, one record per line for export to MS Excel.
 N D,RCSF0,RC1ST,RCEXCEP,RCFLIEN,RCLN,RCSFIEN,RCZ,Z
 ; RCDADJ   - Adjustment/Code filter            ;PRCA*4.5*409 Added line
 ; RCSFIEN  - sub-file ien
 D HDRLST^RCDPEARL(.RCSTOP,.RCHDR)
 S RCZ=""
 F  S RCZ=$O(^TMP($J,"RCERA_AGED",RCZ)) Q:RCZ=""  D
 . S RCFLIEN=0
 . F  S RCFLIEN=$O(^TMP($J,"RCERA_AGED",RCZ,RCFLIEN)) Q:'RCFLIEN  D  G:RCSTOP PRTQ2
 . . I $D(ZTQUEUED),$$S^%ZTLOAD S (RCSTOP,ZTSTOP)=1 K ZTREQ I +$G(RCPGNUM) W:RCTMPND="" !!,"***TASK STOPPED BY USER***" Q
 . . S RC0=$G(^RCY(344.4,RCFLIEN,0))
 . . S RCEXCEP=$$XCEPT^RCDPEWLP(RCFLIEN)  ; PRCA*4.5*298  assignment of ERA exception flag (will either be "" or "x")
 . . S Z=$J(RCEXCEP_-RCZ,4)_U_$P(RC0,U,2)_U_$P(RC0,U,6)_"/"_$P(RC0,U,3)
 . . ;
 . . ;PRCA*4.5*371 Changed external date/times below to be just date (,2 to ,"2D")
 . . S Z=Z_U_$$FMTE^XLFDT($P(RC0,U,4),"2D")_U_$$FMTE^XLFDT($P(RC0,U,7),"2D")_U
 . . ;
 . . ;PRCA*4.5*409 Replaced S Z=Z_$P(RC0,U,5)_U_$P(RC0,U,1) with I/E below
 . . I RCDADJ D
 . . . S Z=Z_$P(RC0,U,5)_U_$P(RC0,U,11)_U_$P(RC0,U,1)
 . . E  D
 . . . S Z=Z_$P(RC0,U,5)_U_$P(RC0,U,1)
 . . W !,Z
 . . S RCLN=Z,RC1ST=0
 . . Q:'RCDADJ                                  ;PRCA*4.5*409 Added line
 . . ;
 . . ;PRCA*4.5*409 Begin - Lines restored ePayments Build 17 version of routine
 . . K Z
 . . I "23"[$$ADJ^RCDPEU(RCFLIEN) D LSTXCEL W "^** CLAIM LEVEL ADJUSTMENTS EXIST FOR THIS ERA ***"
 . . I $O(^RCY(344.4,RCFLIEN,2,0)) D  ; ERA level adjustments exist
 . . . N Q
 . . . D DISPADJ^RCDPESR8(RCFLIEN,"^TMP("_$J_",""RCERA_ADJ"")")
 . . . I $O(^TMP($J,"RCERA_ADJ",0)) D LSTXCEL W "^** GENERAL ADJUSTMENT DATA EXISTS FOR ERA **"
 . . . S Q=0 F  S Q=$O(^TMP($J,"RCERA_ADJ",Q)) Q:'Q  D LSTXCEL W "^"_$G(^TMP($J,"RCERA_ADJ",Q))
 . . ;
 . . S RCSFIEN=0 F  S RCSFIEN=$O(^RCY(344.4,RCFLIEN,1,RCSFIEN)) Q:'RCSFIEN  S RCSF0=$G(^(RCSFIEN,0)) D  Q:RCSTOP
 . . . N D
 . . . K RCOUT
 . . . S D=" EEOB Seq #: "_$P(RCSF0,U)_$S($D(^RCY(344.4,RCFLIEN,1,"ATB",1,RCSFIEN)):" (REVERSAL)",1:"")_"  EEOB "
 . . . S D=D_$S('$P(RCSF0,U,2):"not on file",1:"on file for "_$P($G(^DGCR(399,+$G(^IBM(361.1,+$P(RCSF0,U,2),0)),0)),U))_"  "_$J(+$P(RCSF0,U,3),"",2)
 . . . D LSTXCEL W "^",D
 . . . Q:$P(RCSF0,U,2)
 . . . D DISP^RCDPESR0("^RCY(344.4,"_RCFLIEN_",1,"_RCSFIEN_",1)","RCDATA",1,"RCOUT",68,1)
 . . . I '$O(RCOUT(0)) D LSTXCEL W "^NO DETAIL FOUND" Q
 . . . S Z=0 F  S Z=$O(RCOUT(Z)) Q:'Z  D  Q:RCSTOP
 . . . . D LSTXCEL W "^*"_RCOUT(Z)
 ;
 ;PRCA*4.5*409 End
 ;
 W !!,$$ENDORPRT^RCDPEARL
 Q
 ;
LSTXCEL ; Display repeat info line before each EEOB detail section.
 ; First detail line does not need it
 I RC1ST W !,RCLN Q
 S RC1ST=1 Q
 ;
PRTQ2 I '$D(ZTQUEUED),'RCSTOP,RCPGNUM,RCTMPND="" D ASK^RCDPEARL(.RCSTOP)
 I $D(ZTQUEUED) S ZTREQ="@"
 I '$D(ZTQUEUED) D ^%ZISC
 K ^TMP($J,"RCEFT_AGED")
 Q
 ;
ZROBAL() ; Get Zero Payment Filter
 ; Returns: 1 for yes, zero for no, -1 on '^' or timeout
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YA",DIR("A")="Include Zero payment amounts? (Y/N): ",DIR("B")="YES"
 D ^DIR
 I $D(DUOUT)!$D(DIRUT)!$D(DTOUT) S Y=-1
 Q Y
 ;
DADJCDE() ; Get Adjustment/Code Filter ;PRCA*4.5*409 Added method
 ; Returns: 1 for yes, zero for no, -1 on '^' or timeout
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YA",DIR("A")="Display Adjustment/Code Information? (Y/N): ",DIR("B")="NO"
 D ^DIR
 I $D(DUOUT)!$D(DIRUT)!$D(DTOUT) S Y=-1
 Q Y
 ;
