RCDPENER ;AITC/CJE - NEGATIVE ERA LINE REPORT ;Dec 20, 2014@18:42
 ;;4.5;Accounts Receivable;**424**;Mar 20, 1995;Build 11
 ;Per VA Directive 6402, this routine should not be modified.
 ;Read ^DGCR(399) via Private IA 3820
 ;Read ^DG(40.8) via Controlled IA 417
 ;Read ^IBM(361.1) via Private IA 4051
 ;Use DIVISION^VAUTOMA via Controlled IA 664
RPT ; entry point for Negative ERA Line Report [RCDPE NEGATIVE ERA LINE REPORT]
 N POP,RCDISP,RCDIV,RCDIVS,RCDTRNG,RCJOB,RCLAIM,RCPAGE,RCPAR,RCPARRAY,RCPAY,RCPROG,RCRANGE
 N RCSORT,RCWHICH,STANAM,STANUM,X,Y
 S (RCDTRNG,RCPAGE)=0,RCPROG="RCDPENER",RCJOB=$J    ; Initialize page and start point
 S RCDIV=$$STADIV^RCDPEAPP(.RCDIVS) Q:RCDIV=-1      ; Select Filter/Sort by Division
 ;
 S RCLAIM=$$RTYPE^RCDPEU1() Q:RCLAIM=-1             ; Tricare filter to Med/Pharm/Both
 S RCWHICH=$$NMORTIN^RCDPEAPP() Q:RCWHICH=-1        ; Filter by Payer Name or TIN
 ;
 S RCPAR("SELC")=$$PAYRNG^RCDPEU1(0,1,RCWHICH)      ; Selected or Range of Payers
 Q:RCPAR("SELC")=-1                                 ; '^' or timeout
 S RCPAY=RCPAR("SELC")
 ;
 I RCPAR("SELC")'="A" D  Q:XX=-1                    ; Since we don't want all payers 
 . S RCPAR("TYPE")=RCLAIM
 . S RCPAR("SRCH")=$S(RCWHICH=2:"T",1:"N")          ; prompt for payers we do want
 . S RCPAR("FILE")=344.4
 . S RCPAR("DICA")="Select Insurance Company"_$S(RCWHICH=1:" NAME: ",1:" TIN: ")
 . S XX=$$SELPAY^RCDPEU1(.RCPAR)
 ;
 S RCSORT=$$SORTT^RCDPEAPP() Q:RCSORT=-1            ; Select Sort
 S RCRANGE=$$DTRNG() Q:RCRANGE=0                    ; Select Date Range for Report
 S RCDISP=$$DISPTY^RCDPEAPP() Q:RCDISP=-1           ; Output to Excel?
 I RCDISP D INFO^RCDPEM6                            ; Display capture information for Excel
 ;
 I 'RCDISP W !,"This report requires 132 column display."
 S %ZIS="QM" D ^%ZIS Q:POP                          ; Select output device
 ;
 ; Option to queue
 I 'RCDISP,$D(IO("Q")) D  Q
 . N ZTDESC,ZTQUEUED,ZTRTN,ZTSAVE,ZTSK
 . S ZTRTN="REPORT^RCDPENER"
 . S ZTDESC="EDI LOCKBOX NEGATIVE ERA LINE REPORT"
 . S ZTSAVE("RC*")="" ;**FA** ,ZTSAVE("VAUTD")=""
 . S ZTSAVE("^TMP(""RCDPEU1"",$J,")="" ;
 . D ^%ZTLOAD
 . I $D(ZTSK) W !!,"Task number "_ZTSK_" was queued."
 . E  W !!,"Unable to queue this job."
 . K IO("Q")
 . D HOME^%ZIS
 ;
 D REPORT                                           ; Compile and print report
 Q
REPORT ; Compile and print report
 ; Input:   RCDISP  - 0 - Output to paper or screen, 1 - Output to Excel
 ;          RCDIV   - 1 - All divisions, 2 - Selected divisions
 ;          RCDIVS()- Array of selected divisions if RCDIV=2
 ;          RCRANGE - 1^Start Date^End Date
 ;          RCJOB   - $J
 ;          RCLAIM  - "M" - Medical Claims, "P" - Pharmacy Claims, "B" - Both
 ;          RCPAGE  - Initialized to 0
 ;          RCPARRAY- Array of selected payers 
 ;          RCPROG  - "RCDPENER"
 ;          RCSORT  - 0 - Sort by Payer Name, 1 - Sort by Payer TIN
 ;          RCWHICH - 1 - Filter by Payer Name, 2 - Filter by Payer TIN
 ;          ^TMP("RCDPEU1",$J) - Selected payerers (see SELPAY^RCDPEU1 for details)
 ;
 N GLOB,GTOTAL,ZTREQ
 K ^TMP(RCPROG,$J),^TMP("RCDPEAPP2",$J)
 S GLOB=$NA(^TMP(RCPROG,$J))
 D COMPILE^RCDPENE1                         ; Scan ERA file for entries in date range
 D DISP                                     ; Display the Report
 ;
 ; Clear ^TMP global
 K ^TMP(RCPROG,$J),^TMP("RCSELPAY",RCJOB),^TMP("RCDPEAPP2",$J),^TMP("RCDPEU1",$J)
 Q
 ;
DISP ; Format the display for screen/printer or MS Excel
 ; Input:   GLOB    - ^TMP("RCDPENER",$J) (See SAVE^RCDPENE1 for field order)
 ;          RCDISP  - 1 - Output to Excel, 0 otherwise
 ;          RCDIV   - 1 - All Divisions selected
 ;          RCDIVS  - Array of selected Divisions (if all not selected)
 ;          RCPARRAY- Array of selected Payers
 ;          RCPAY   - 1 - All Payers selected
 N DIVS,LINE1,LINE2,PAYERS,RCDATA,RCHDRDT,RCSTOP,SPACES,SUB,SUB1,SUB2,SUB3
 S RCHDRDT=$$FMTE^XLFDT($$NOW^XLFDT,"2SZ")       ; Date/time for header
 S LINE1=$TR($J("",131)," ","-"),LINE2=$TR(LINE1,"-","=")
 U IO
 ;
 ; Report by division or 'ALL'
 D LINED^RCDPEAPP(RCDIV,.RCDIVS,.DIVS)                   ; Format Division filter
 D LINEP^RCDPEAPP(RCPAY,.RCPARRAY,RCWHICH,.PAYERS)       ; Format Payer filter
 S SPACES="                    "
 S SUB="",RCSTOP=0
 I RCDISP D HDR(.DIVS,.PAYERS)                           ; Single header for Excel
 F  S SUB=$O(@GLOB@(SUB)) Q:SUB=""  D  Q:RCSTOP  ;
 . I 'RCDISP D
 . . D HDR(.DIVS,.PAYERS)                        ; Display Header
 . . W !,"DIVISION: ",SUB
 . S SUB1=""                                    ; Division
 . F  S SUB1=$O(@GLOB@(SUB,SUB1)) Q:SUB1=""  D  Q:RCSTOP
 . . S SUB2=""
 . . F  S SUB2=$O(@GLOB@(SUB,SUB1,SUB2)) Q:SUB2=""  D  Q:RCSTOP
 . . . ;
 . . . ; Display payer sub-header
 . . . I 'RCDISP D HDRP^RCDPEAPP(SUB1_"/"_SUB2)
 . . . S SUB3=""
 . . . F  S SUB3=$O(@GLOB@(SUB,SUB1,SUB2,SUB3)) Q:SUB3=""  D  Q:RCSTOP
 . . . . S RCDATA=@GLOB@(SUB,SUB1,SUB2,SUB3)
 . . . . I 'RCDISP D  Q:RCSTOP
 . . . . . I $Y>(IOSL-6) D HDR(.DIVS,.PAYERS) Q:RCSTOP
 . . . . . W !,$P(RCDATA,U,4)                          ; Patient Name
 . . . . . W ?30,$P(RCDATA,U,5)                        ; ERA#
 . . . . . W ?37,$P(RCDATA,U,6)                        ; Date Received
 . . . . . W ?48,$E($P(RCDATA,U,7),1,12)               ; Bill #
 . . . . . W ?57,$J($P(RCDATA,U,12),8)_"  "            ; Date of Service
 . . . . . W $J($P(RCDATA,U,8),11,2)_"      "         ; Paid Amount
 . . . . . W $E($E($P(RCDATA,U,10),1,11)_SPACES,1,13)  ; Claim Status
 . . . . . W $J($P(RCDATA,U,9),15,2)                   ; Claim Balance
 . . . . . W !,?3,"Trace #: ",$P(RCDATA,U,11)          ; Trace #
 . . . . . ;
 . . . . I RCDISP D
 . . . . . I $L(RCDATA)>255 D  ;
 . . . . . . N RCPAY,RCTIN
 . . . . . . S RCPAY=$P(RCDATA,"^",3)
 . . . . . . S RCTIN=$P(RCPAY,"/",$S(RCSORT=0:2,1:1))
 . . . . . . S RCPAY=$P(RCPAY,"/",$S(RCSORT=0:1,1:2))
 . . . . . . S RCPAY=$E(RCPAY,1,$L(RCPAY)-($L(RCDATA)-255))
 . . . . . . S RCPAY=$S(RCSORT=0:RCPAY_"/"_RCTIN,1:RCTIN_"/"_RCPAY)
 . . . . . . S $P(RCDATA,"^",3)=RCPAY
 . . . . . W !,RCDATA
 . . . ;
 ;
 I '$D(@GLOB) D  ;
 . I 'RCDISP D HDR(.DIVS,.PAYERS)
 . W !!,"*** NO DATA FOUND FOR THIS DATE RANGE AND FILTER CONDITIONS ***",!!
 ;
 I 'RCSTOP D ASK^RCDPEAPP(.RCSTOP)
 ;
 ; Close device
 I '$D(ZTQUEUED) D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
HDR(DIVS,PAYERS) ; Print the report header
 ; Input:   DIVS()      - Array of selected Division lines for Header
 ;          PAYERS()    - Array of selected Payer lines for Header
 ;          RCDISP      - 1 - Output to Excel, 0 otherwise
 ;          RCHDRDT     - External Print Date/Tim
 ;          RCPAGE      - Current Page number
 ;          RCRANGE     - Selected Date Range
 ;          RCSORT      - 0 - Sort by Payer Name, 1 - Sort by Payer TIN
 ;          RCSTOP      - 1 if display aborted
 ; Output:  RCPAGE      - Updated Page Number
 ;          RCSTOP      - 1 if display aborted
 N END,LN,MSG,START,XX,Y
 Q:RCSTOP
 I RCDISP D  Q          ; Output to Excel
 . S XX="STATION^STATION NUMBER^PAYER^PATIENT NAME/SSN^ERA#^DT REC'D"
 . S XX=XX_"^BILL#^AMT PAID^CLAIM BALANCE^CLAIM STATUS^TRACE#^DOS"
 . W !,XX
 S START=$$FMTE^XLFDT($P(RCRANGE,U,2),"2DZ")
 S END=$$FMTE^XLFDT($P(RCRANGE,U,3),"2DZ")
 I RCPAGE D ASK^RCDPEAPP(.RCSTOP) Q:RCSTOP
 S RCPAGE=RCPAGE+1
 W @IOF
 S MSG(1)="EDI LOCKBOX NEGATIVE ERA LINE REPORT"
 S MSG(1)=MSG(1)_$J("",47)_"Print Date: "_RCHDRDT_"    Page: "_RCPAGE
 ;
 S LN=2,XX=""
 F  D  Q:XX=""                              ; Display Division filters
 . S XX=$O(DIVS(XX))
 . Q:XX=""
 . S MSG(LN)=DIVS(XX),LN=LN+1
 ;
 S MSG(LN)="CLAIM TYPE: "
 S MSG(LN)=MSG(LN)_$S(RCLAIM="P":"PHARMACY",RCLAIM="M":"MEDICAL",RCLAIM="T":"TRICARE",1:"ALL")
 S MSG(LN)=MSG(LN)_$J("",55-$L(MSG(LN)))_"SORTED BY: "_$S(RCSORT=0:"PAYER NAME",1:"PAYER TIN")
 S LN=LN+1
 S MSG(LN)=$S(RCWHICH=2:"TINS",1:"PAYERS")_" : "_$S(RCPAY="S":"SELECTED",RCPAY="R":"RANGE",1:"ALL")
 S LN=LN+1
 S MSG(LN)="RESULTS FOR ERA FILED DATE RANGE: "_START_" - "_END
 S LN=LN+1,MSG(LN)=LINE2
 S LN=LN+1
 S MSG(LN)="PATIENT NAME/SSN               ERA#   DT REC'D   BILL#     DOS          AMOUNT      BILL STATUS  CURRENT BALANCE"
 S LN=LN+1,MSG(LN)=LINE2
 D EN^DDIOL(.MSG)
 Q
 ;
DTRNG() ; Get the date range for the report
 ; Input:   None
 ; Returns: 0 - User ^ or timed out
 ;          1^Start Date^End Date
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RCEND,RNGFLG,RCSTART,X,Y
 D DATES(.RCSTART,.RCEND)
 Q:RCSTART=-1 0
 Q:RCSTART "1^"_RCSTART_"^"_RCEND
 Q:'RCSTART "0^^"
 Q 0
 ;
DATES(BDATE,EDATE) ; Get a date range.
 ; Input:   None
 ; Output:  BDATE   - Internal Begin date
 ;          EDATE   - Internal End date
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S (BDATE,EDATE)=0
 S DIR("?")="Enter the earliest ERA file date date to include on the report"
 S DIR(0)="DAO^:"_DT_":APE",DIR("A")="Start Date: "
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S BDATE=Y
 S DIR("?")="Enter the latest ERA file date date to include on the report"
 S DIR("B")=Y(0)
 S DIR(0)="DAO^"_BDATE_":"_DT_":APE",DIR("A")="End Date: "
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!(Y="") S BDATE=-1 Q
 S EDATE=Y
 Q 
