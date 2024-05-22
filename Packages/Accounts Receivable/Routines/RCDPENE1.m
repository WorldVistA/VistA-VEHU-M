RCDPENE1 ;AITC/CJE - NEGATIVE ERA LINE REPORT ;Dec 20, 2014@18:42
 ;;4.5;Accounts Receivable;**424**;Mar 20, 1995;Build 11
 ;Per VA Directive 6402, this routine should not be modified.
 Q
COMPILE ; Generate the Auto Posting report ^TMP array
 ; Input:   GLOB    - "^TMP("RCDPENER",$J)"
 ;          RCDISP  - 0 - Output to paper or screen, 1 - Output to Excel
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
 ;          ^TMP("RCSELPAY",RCJOB) - Selected Payer Names or TINs
 ;
 ; Output:   ^TMP("RCDPENER",$J) Contains report details in ^ delimited format
 ;           (See SAVE subroutine for details)
 ;
 N AMT,APDATE,CNT,END,ERAIEN,IEN,OKAY,RCECME,RCRZ,STA,STNAM,STNUM
 S APDATE=$$FMADD^XLFDT($P(RCRANGE,U,2),-1)
 S APDATE=APDATE+.24 ; File date has time stamp, prevent it from including date/time before selected range
 S END=$P(RCRANGE,U,3),CNT=0
 ;
 ; Scan AC index for ERA within date range of ERA created dates
 F  S APDATE=$O(^RCY(344.4,"AFD",APDATE)) Q:'APDATE  Q:(APDATE\1)>END  D
 . S ERAIEN=""
 . F  S ERAIEN=$O(^RCY(344.4,"AFD",APDATE,ERAIEN)) Q:'ERAIEN  D
 . . ;
 . . ; Check division - Note return values are set to UNKNOWN if not available
 . . D ERASTA^RCDPEAPQ(ERAIEN,.STA,.STNUM,.STNAM)
 . . I RCDIV=2,'$D(RCDIVS(STA)) Q
 . . ;
 . . ; PRCA*4.5*304 - Check if we include this ERA in report
 . . I RCPAY="A",RCLAIM'="A" D  Q:'OKAY
 . . . S OKAY=$$ISTYPE^RCDPEU1(344.4,ERAIEN,RCLAIM)
 . . ;
 . . ; Check Payer Name
 . . I RCPAY'="A" D  Q:'OKAY
 . . . S OKAY=$$ISSEL^RCDPEU1(344.4,ERAIEN)
 . . ;
 . . ; If it does not already exist for this ERA, build X-ref of ERA detail lines to the lines in the worklist
 . . I '$D(^TMP("RCDPEAPP2",$J,ERAIEN)) D BUILD^RCDPEAPQ(ERAIEN)
 . . ;
 . . ; Scan index for negative lines within the ERA and save to ^TMP if there is one
 . . S RCRZ=0 I ERAIEN=92933
 . . F  S RCRZ=$O(^RCY(344.4,ERAIEN,1,RCRZ)) Q:'RCRZ  D  ;
 . . . S AMT=$$GET1^DIQ(344.41,RCRZ_","_ERAIEN_",",.03,"I")
 . . . I AMT<0 D SAVE(ERAIEN,RCRZ,RCSORT)     ; Save negative claim line detail to ^TMP global
 Q
SAVE(ERAIEN,RCRZ,RCSORT) ; EP - Save to ^TMP global
 ; Input:   ERAIEN  - Internal IEN into file 344.4
 ;          RCRZ    - Internal IEN into sub-file 344.41
 ;          STNAM   - Division Name (Primary Sort)
 ;          STNUM   - Station Number
 ;          ^TMP("RCDPEAPP2",$J,ERAIEN,RCRZ) - Array of detail lines
 ; Output:   ^TMP("RCDPENER",$J) Contains report details in ^ delimited format
 ;
 ; 1  - Station Name (STNAM)
 ; 2  - Station Number (STNUM)
 ; 3  - Payer Name (PAYNAM)
 ; 4  - Patient Name (PTNAM)
 ; 5  - ERA # (ERANUM)
 ; 6  - ERA Date (ERADATE)
 ; 7  - Claim # (BILL)
 ; 8  - Amount Paid (TOTPAMT)
 ; 9  - Claim Balance (TOTBAL)
 ; 10 - Claim Status (STATUS)
 ; 11 - Trace # (TRACE)
 ; 12 - Date of Service (DOS)
 ;
 N BALANCE,BAMT,BILL,CLAIMIEN,COLLECT,DATE,DOS,EOBIEN,ERADATE,ERANUM ; PRCA*4.5*345
 N PAMT,PAYIX1,PAYIX2,PAYNAM,PTNAM,RECEIPT,SEQ,SEQ1,SEQ2,STATUS,STIX
 N TIN,TOTBAL,TOTBAMT,TOTPAMT,TRACE,XX
 S PAYNAM=$$GET1^DIQ(344.4,ERAIEN,.06,"E")          ; Payer Name from ERA Record
 S TIN=$$GET1^DIQ(344.4,ERAIEN,.03,"E")             ; Payer TIN from ERA Record
 S:RCSORT=0 PAYIX1=PAYNAM,PAYIX2=TIN
 S:RCSORT=1 PAYIX1=TIN,PAYIX2=PAYNAM
 S:PAYNAM="" PAYNAM="UNKNOWN"
 S STIX=STNAM_"/"_STNUM
 ;
 S TRACE=$$GET1^DIQ(344.4,ERAIEN,.02,"E")         ; Trace Number
 S PTNAM=$$PNM4^RCDPEWL1(ERAIEN,RCRZ)             ; Patient name from claim file #399
 S ERANUM=$$GET1^DIQ(344.4,ERAIEN,.01,"E")        ; ERA Number
 S ERADATE=$$GET1^DIQ(344.4,ERAIEN,.07,"I")       ; Date received (file date/time)
 S ERADATE=$$FMTE^XLFDT(ERADATE,"2DZ")
 S XX=$$GET1^DIQ(344.41,RCRZ_","_ERAIEN,.25,"I")  ; Receipt IEN
 ;
 S (TOTBAMT,TOTBAL,COLLECT,CLAIMIEN,TOTPAMT)=0,DOS="UNKNOWN",BILL="",STATUS=""
 S EOBIEN=$$GET1^DIQ(344.41,RCRZ_","_ERAIEN,.02,"I")              ; IEN for 361.1
 I EOBIEN D  ;
 . S CLAIMIEN=$$GET1^DIQ(361.1,EOBIEN,.01,"I")                    ; IEN for 399
 . S DOS=$$GET1^DIQ(361.1,EOBIEN,1.1,"I")                         ; Date of Service
 . S DOS=$$FMTE^XLFDT(DOS,"2DZ")
 . S BILL=$$EXTERNAL^DILFD(344.41,.02,,EOBIEN)                    ; Bill Number
 . ; Get Billed Amount from AR (Original Balance)
 . I CLAIMIEN D
 . . S TOTBAMT=$J(+$$GET1^DIQ(430,CLAIMIEN,3,"I"),0,2)            ; Original Amount
 . . S TOTBAL=$J(+$$GET1^DIQ(430,CLAIMIEN,71,"I"),0,2)            ; Principal Balance
 . . S STATUS=$$GET1^DIQ(430,CLAIMIEN,8,"E")                      ; Claim Status
 S TOTPAMT=$J($$GET1^DIQ(344.41,RCRZ_","_ERAIEN,.03,"I"),0,2)     ; Amount Paid on Claim
 ; Balance from AR (Principal Balance)
 ;
 S PTNAM=$S('CLAIMIEN:"",1:$$PNM4^RCDPEWL1(ERAIEN,RCRZ))
 S:TOTBAMT COLLECT=$J(TOTPAMT/TOTBAMT*100,0,2)_"%"
 S CNT=CNT+1
 S XX=STNAM_U_STNUM_U_PAYNAM_U_PTNAM_U_ERANUM_U_ERADATE
 S XX=XX_U_BILL_U_TOTPAMT_U_TOTBAL_U_STATUS_U_TRACE_U_DOS
 S @GLOB@(STIX,PAYIX1,PAYIX2,CNT)=XX
 ;
 Q
