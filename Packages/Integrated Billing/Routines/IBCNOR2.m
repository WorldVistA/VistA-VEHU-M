IBCNOR2 ;AITC/TAZ - IBCN BUFFER DAILY REPORT ;15-AUG-2023
 ;;2.0;INTEGRATED BILLING;**771,778**;16-SEP-09;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Variables:
 ;   IBCNSPC("IBOUT")   = "R" for Report format or "E" for Excel format
 ;   IBCNSPC("TYPE")    = report type: "S" - summary, "D" - detailed
 ;
 Q
 ;
DBR ; Send Daily Buffer Report Email
 N LOCALTIME,CURRTIME,MTIME,MSG,MGRP
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 ;
 I $$GET1^DIQ(350.9,"1,",54.02,"E")="" G DBRX  ;No email address to receive the report.
 ;
 S LOCALTIME=$$GET1^DIQ(350.9,"1,",51.03,"I")
 I 'LOCALTIME G DBRX            ; MM message time is not defined
 ;
 S CURRTIME=$P($H,",",2)        ; current $H time
 S MTIME=DT_"."_LOCALTIME       ; build a FileMan date/time
 S MTIME=$$FMTH^XLFDT(MTIME)    ; convert to $H format
 S MTIME=$P(MTIME,",",2)        ; $H time of MM message
 ;
 ; If the current time is after the MailMan message time, then schedule the message for tomorrow at that time.
 ; Otherwise, schedule it for later today.
 S ZTDTH=$S(CURRTIME>MTIME:$H+1,1:+$H)_","_MTIME
 ;
 ; Set up the other TaskManager variables
 S ZTRTN="EMAIL^IBCNOR2"
 S ZTDESC="Daily Buffer Report Message"
 S ZTIO=""
 D ^%ZTLOAD            ; Call TaskManager
 ;
DBRX ; Exit
 Q
 ;
EMAIL ;Email a summary version of the report to a select email group
 N EMAIL,IBOUT,MSG,SITE,TYPE,XMSUBJ,XMTO
 S EMAIL=$$GET1^DIQ(350.9,"1,",54.02,"E") I EMAIL="" G EMAILX
 K ^TMP($J,"IBCNOR2")
 S IBOUT="R",TYPE="S"
 ;
 D SNAPSHOT I $G(ZTSTOP) G PROCESSX
 ;
 D PRINT
 ;
 S SITE=$$SITE^VASITE
 S XMSUBJ=$P(SITE,U,2)_" (#"_$P(SITE,U,3)_") Daily Buffer Report"
 S XMTO(EMAIL)=""
 D MSG^IBCNEUT5(,XMSUBJ,"MSG(",,.XMTO) ;  Send a MailMan Message
 ;
EMAILX ; Exit
 Q
 ;
EN ; entry point
 N IBCNSPC,STOP,TYPE
 ;
 S STOP=0
 W @IOF
 W !,"This report displays data from the Process Insurance Buffer option, otherwise"
 W !,"known as ""the Buffer"". It is real time data that is constantly changing;"
 W !,"therefore, the numbers and dates reflected in this report are never the same"
 W !,"minute to minute, hour by hour, or day by day. This report output is only"
 W !,"accurate to the exact date and time it is produced. The Insurance Company"
 W !,"section of this report is based on free text fields and may not be reflective"
 W !,"of actual category counts due to spelling errors in the free text Insurance"
 W !,"Company field."
 ;
 ; Report Type - Summary or Detailed
TYPE ;Type of Report
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^S:Summary;D:Detailed"
 S DIR("A")="Run a (S)ummary or (D)etailed Report: "
 S DIR("B")="Summary"
 D ^DIR
 I $D(DIRUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) G EXIT
 S (TYPE,IBCNSPC("TYPE"))=Y
 ;
IBOUT ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR
 I $D(DIRUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) G EXIT
 S IBCNSPC("IBOUT")=Y
 I Y="E" D
 . W !!,"For CSV output, turn logging or capture on now. To avoid undesired wrapping"
 . W !,"of the data saved to the file, please enter "_$S(TYPE="S":"0;132;99999",1:"0;80;99999")_" at the ""DEVICE:"""
 . W !,"prompt.",!
 ;
 ; Select the output device
DEVICE ; Device Handler and possible TaskManager calls
 ;
 ; Output params:
 ;  STOP = Flag to stop routine
 ;
 ; Init vars
 N POP,ZTDESC,ZTRTN,ZTSAVE
 ;
 S ZTRTN="PROCESS^IBCNOR2(.IBCNSPC)"
 S ZTDESC="IBCN Daily Buffer Report"
 S ZTSAVE("IBCNSPC(")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 ;
EXIT ;
 Q
 ;
PROCESS(IBCNSPC) ; 
 ; Entry point called from EN^XUTMDEVQ in either direct or queued mode.
 ; Input params:
 ;  IBCNSPC = Array passed by ref of the report params
 ;
 ; Init scratch globals
 N CRT,DATE,IBOUT,TYPE,ZTQUEUED,ZTREQ,ZTSTOP
 K ^TMP($J,"IBCNOR2")
 S IBOUT=$G(IBCNSPC("IBOUT"))
 S TYPE=$G(IBCNSPC("TYPE"))
 I IOST["C-" S CRT=1
 ;
 D SNAPSHOT I $G(ZTSTOP) G PROCESSX
 ;
 ;
 I TYPE="D" D  I $G(ZTSTOP) G PROCESSX
 . D INIT I $G(ZTSTOP) Q
 . D COMPILE I $G(ZTSTOP) Q
 ;
 D PRINT
 ;
PROCESSX ; exit
 ; Kill scratch globals
 K ^TMP($J,"IBCNOR2")
 ;
 ; Purge task record
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
SNAPSHOT ;Grab a snapshot of the data right now.
 N BACKLOG,BCNT,CNT,DATE,IEN,OLDEST,WBACKLOG,WCNT
 S BACKLOG=$$BACKLOG(DT,0)
 S WBACKLOG=$$BACKLOG($$FMADD^XLFDT(DT,-7),1)
 S DATE="",(BCNT,CNT,WCNT)=0,CRT=+$G(CRT)
 I CRT W !,"Building Snapshot..."
 F  S DATE=$O(^IBA(355.33,"AEST","E",DATE)) Q:'DATE  D
 . ;I CNT<1 S ^TMP($J,"IBCNOR2","SUM","OLDEST DATE")=DATE  ;IB*778/DTG moved to avoid bad records.
 . ;
 . S IEN=""
 . F  S IEN=$O(^IBA(355.33,"AEST","E",DATE,IEN)) Q:'IEN  D
 .. ;
 .. I '$D(^IBA(355.33,IEN,0)) Q  ; IB*778/DTG if node 0 for IEN not there, go back
 .. I CNT<1 S ^TMP($J,"IBCNOR2","SUM","OLDEST DATE")=DATE  ;IB*778
 .. ;
 .. N IBARY,IBY,IENS,DFN
 .. S IENS=IEN_",",CNT=CNT+1 I CRT,'(CNT#100) W "."
 .. I DATE<BACKLOG S BCNT=BCNT+1
 .. I DATE<WBACKLOG S WCNT=WCNT+1
 .. D GETS^DIQ(355.33,IENS,".01;.03;.04;20.01;60.01","EI","IBARY")
 .. M ^TMP($J,"IBCNOR2","DATA")=IBARY(355.33)
 .. S DFN=IBARY(355.33,IENS,60.01,"I")
 .. S IBY="" D FLAGS^IBCNBLL(DFN,.IBY)
 .. S ^TMP($J,"IBCNOR2","DATA",IENS,"FLAGS")=$TR(IBY," ")
 S ^TMP($J,"IBCNOR2","SUM","TOTAL ENTRIES")=CNT
 S ^TMP($J,"IBCNOR2","SUM","BACKLOG")=BCNT
 S ^TMP($J,"IBCNOR2","SUM","WBACKLOG")=WCNT
 ;
 ; IB*778/DTG change for oldest date check
 ; S OLDEST=$G(^TMP($J,"IBCNOR2","SUM","OLDEST DATE")) S ^TMP($J,"IBCNOR2","SUM","AGE")=$S(OLDEST:$$FMDIFF^XLFDT(DT,OLDEST),1:0)
 S OLDEST=$S(CNT<1:"",1:$G(^TMP($J,"IBCNOR2","SUM","OLDEST DATE")))
 S ^TMP($J,"IBCNOR2","SUM","AGE")=$S(OLDEST:$$FMDIFF^XLFDT(DT,OLDEST),1:0)
 ;
 Q
 ;
BACKLOG(DATE,WED) ;Calculate Backlog Date to T-6 business days so that T-7 inclusive shows on the report.
 N BACKLOG,DOW
 S DOW=$E($$DOW^XLFDT(DATE),1,2)
 I DOW="Su" S BACKLOG=$$FMADD^XLFDT(DATE,$S(WED:+4,1:-10)) G BACKLOGX
 I DOW="Mo" S BACKLOG=$$FMADD^XLFDT(DATE,$S(WED:+3,1:-10)) G BACKLOGX
 I DOW="Tu" S BACKLOG=$$FMADD^XLFDT(DATE,$S(WED:+2,1:-8)) G BACKLOGX
 I DOW="We" S BACKLOG=$$FMADD^XLFDT(DATE,$S(WED:+1,1:-8)) G BACKLOGX
 I DOW="Th" S BACKLOG=$$FMADD^XLFDT(DATE,$S(WED:-0,1:-8)) G BACKLOGX
 I DOW="Fr" S BACKLOG=$$FMADD^XLFDT(DATE,$S(WED:-1,1:-8)) G BACKLOGX
 I DOW="Sa" S BACKLOG=$$FMADD^XLFDT(DATE,$S(WED:-2,1:-9)) G BACKLOGX
BACKLOGX ;Exit Backlog Date calculation
 Q BACKLOG
 ;
INIT ;Initialize the ^TMP global
 ;Initialize the Report Global Array
 N CAT,CATS,LINE,PCE
 F LINE=1:1 S CATS=$P($T(CATNDT+LINE),";;",2) Q:CATS=""  D
 . F PCE=1:1 S CAT=$P(CATS,U,PCE) Q:CAT=""  D
 .. S ^TMP($J,"IBCNOR2","DET",CAT)=0
 F LINE=1:1 S CATS=$P($T(CATWDT+LINE),";;",2) Q:CATS=""  D
 . F PCE=1:1 S CAT=$P(CATS,U,PCE) Q:CAT=""  D
 .. S ^TMP($J,"IBCNOR2","DET",CAT)=0
 .. S ^TMP($J,"IBCNOR2","DET",CAT,"DATE")=""
 .. I CAT'="MEDICARE" Q
 F LINE=1:1 S CATS=$P($T(TOTALS+LINE),";;",2) Q:CATS=""  D
 . F PCE=1:1 S CAT=$P(CATS,U,PCE) Q:CAT=""  D
 .. S ^TMP($J,"IBCNOR2","TOT",CAT)=0
 ;
INITX ;Exit
 Q
 ;
COMPILE ; Compile the report
 N CNT,IEN,INSCO,TOT
 S (CNT,IEN)=0
 I CRT W !,"Compiling Data..."
 F CNT=1:1 S IEN=$O(^TMP($J,"IBCNOR2","DATA",IEN)) Q:'IEN  D
 . I CRT,'(CNT#100) W "."
 . N ARRAY
 . M ARRAY=^TMP($J,"IBCNOR2","DATA",IEN)
 . D UPDATE("TOT","MCCF vs. non-MCCF")
 . S INSCO=$$UP^XLFSTR($G(ARRAY(20.01,"E")))
 . D  ;Process Insurance Company
 .. D UPDATE("TOT","Insurance Company Category")
 .. I INSCO["TRICARE" D UPDATE("DET","TRICARE"),UPDATE("DET","Non-MCCF") Q
 .. I INSCO["CHAMPVA" D UPDATE("DET","CHAMPVA"),UPDATE("DET","Non-MCCF") Q
 .. D UPDATE("DET","MCCF")
 .. I INSCO["MEDICARE" D  Q
 ... D UPDATE("DET","MEDICARE")
 ... I INSCO="MEDICARE PART D (WNR)" D UPDATE("DET","MEDICARE PART D (WNR)")
 .. I INSCO="NO INSURANCE" D UPDATE("DET","NO INSURANCE") Q
 .. I INSCO="PATIENT REFUSED" D UPDATE("DET","PATIENT REFUSED") Q
 .. I INSCO="CMS MBI ONLY" D UPDATE("DET","CMS MBI ONLY") Q
 .. D UPDATE("DET","ALL OTHER")
 . D  ;Process Patient Status
 .. D UPDATE("TOT","Patient Status")
 .. N FLAG,FLAGS,POS
 .. S FLAGS=$G(ARRAY("FLAGS"))
 .. I FLAGS="" D UPDATE("DET","blank")
 .. F POS=1:1:$L(FLAGS) S FLAG=$E(FLAGS,POS) D
 ... I FLAG="i" D UPDATE("DET","i ACTIVE INSURANCE") Q
 ... I FLAG="I" D UPDATE("DET","I INPATIENT") Q
 ... I FLAG="E" D UPDATE("DET","E DECEASED") Q
 ... I FLAG="Y" D UPDATE("DET","Y COPAY REQUIRED") Q
 ... I FLAG="H" D UPDATE("DET","H CHARGES ON HOLD") Q
 . D  ;Process Source of Informtion
 .. D UPDATE("TOT","Source of Information")
 .. N SOI
 .. S SOI=$G(ARRAY(.03,"E"))
 .. I '$D(^TMP($J,"IBCNOR2","SOI",SOI)) D
 ... S ^TMP($J,"IBCNOR2","SOI",SOI)=0
 ... S ^TMP($J,"IBCNOR2","SOI",SOI,"DATE")=""
 .. D UPDATE("SOI",SOI) Q
 ;
COMPILEX ; Exit Compile
 Q
 ;
UPDATE(LVL,NODE) ;Increase a node
 N TOT
 I LVL="" G UPDATEX
 I NODE="" G UPDATEX
 S TOT=^TMP($J,"IBCNOR2",LVL,NODE)+1,^TMP($J,"IBCNOR2",LVL,NODE)=TOT
 D OLDDATE(LVL,NODE,ARRAY(.01,"I"))
UPDATEX ;Exit
 Q
 ;
OLDDATE(LVL,NODE,DATE) ; Calculate the oldest date for the categories tracked.
 N GDATE
 I '$D(^TMP($J,"IBCNOR2",LVL,NODE,"DATE")) G OLDDATEX  ;Not calculating
 S GDATE=^TMP($J,"IBCNOR2",LVL,NODE,"DATE")
 I 'GDATE S GDATE=DATE
 I GDATE,(DATE<GDATE) S GDATE=DATE
 S ^TMP($J,"IBCNOR2",LVL,NODE,"DATE")=GDATE
 ;
OLDDATEX ; Exit oldest date calculation
 Q
 ;
PRINT ; Print the report
 N CRT,EORMSG,IBPGC,IBPXT,MAXCNT,PL,SLINE,SOI,TSTAMP
 S EORMSG="*****END OF REPORT*****"
 S TSTAMP=$$FMTE^XLFDT($$NOW^XLFDT,1) ; time of report
 S PL=IOSL-6,(CRT,IBPGC,IBPXT)=0
 S:IOST["C-" PL=IOSL-3,CRT=1
 S $P(SLINE,"=",14)="",$P(LINE,"=",79)="",TAB=$S(IBOUT="E":"^",1:"?"_53)
 D HDR I IBPXT G PRINTX
 I IBOUT="E",TYPE="S" D  G PRINTX
 . S DLINE="OLDEST DATE^AGE OF OLDEST^TOTAL NUMBER OF ENTRIES^*TOTAL T-7 BACKLOG^TOTAL WEDNESDAY BACKLOG" D WRTLNX
 . S DATA=$G(^TMP($J,"IBCNOR2","SUM","OLDEST DATE")) S DLINE=$S(DATA:$$FMTDT(DATA),1:"")
 . S DATA=$FN(^TMP($J,"IBCNOR2","SUM","AGE"),",") S DLINE=DLINE_U_DATA
 . S DATA=$FN(^TMP($J,"IBCNOR2","SUM","TOTAL ENTRIES"),",") S DLINE=DLINE_U_DATA
 . S DATA=$FN(^TMP($J,"IBCNOR2","SUM","BACKLOG"),",") S DLINE=DLINE_U_DATA
 . S DATA=$FN(^TMP($J,"IBCNOR2","SUM","WBACKLOG"),",") S DLINE=DLINE_U_DATA
 . D WRTLNX
 D WRTLN("Oldest Date","OLDEST DATE","D","SUM") I IBPXT G PRINTX
 D WRTLN("Age of Oldest","AGE","N","SUM") I IBPXT G PRINTX
 D WRTLN("Total Number of Entries","TOTAL ENTRIES","N","SUM") I IBPXT G PRINTX
 D WRTLN("*Total T-7 Backlog","BACKLOG","N","SUM") I IBPXT G PRINTX
 D WRTLN("Total Wednesday Backlog","WBACKLOG","N","SUM") I IBPXT G PRINTX
 I TYPE="S" G PRINTX
 D WRTLN("Total MCCF vs. non-MCCF","MCCF vs. non-MCCF","N","TOT") I IBPXT G PRINTX
 D WRTLN("  MCCF","MCCF","N","DET") I IBPXT G PRINTX
 D WRTLN("  Non-MCCF","Non-MCCF","N","DET") I IBPXT G PRINTX
 D WRTLN("Total Number of Entries by Insurance Company Category","Insurance Company Category","N","TOT") I IBPXT G PRINTX
 D WRTLN("  TRICARE","TRICARE","N","DET") I IBPXT G PRINTX
 D WRTLN("  CHAMPVA","CHAMPVA","N","DET") I IBPXT G PRINTX
 D WRTLN("  MEDICARE","MEDICARE","N","DET") I IBPXT G PRINTX
 D WRTLN("    MEDICARE PART D (WNR)","MEDICARE PART D (WNR)","N","DET") I IBPXT G PRINTX
 D WRTLN("  CMS MBI ONLY","CMS MBI ONLY","N","DET") I IBPXT G PRINTX
 D WRTLN("  NO INSURANCE","NO INSURANCE","N","DET") I IBPXT G PRINTX
 D WRTLN("  PATIENT REFUSED","PATIENT REFUSED","N","DET") I IBPXT G PRINTX
 D WRTLN("  All OTHER","ALL OTHER","N","DET") I IBPXT G PRINTX
 D WRTLN("Total Number of Entries by Patient Status","Patient Status","N","TOT") I IBPXT G PRINTX
 D WRTLN("  i ACTIVE INSURANCE","i ACTIVE INSURANCE","N","DET") I IBPXT G PRINTX
 D WRTLN("  I INPATIENT","I INPATIENT","N","DET") I IBPXT G PRINTX
 D WRTLN("  E DECEASED","E DECEASED","N","DET") I IBPXT G PRINTX
 D WRTLN("  Y CO-PAY REQUIRED","Y COPAY REQUIRED","N","DET") I IBPXT G PRINTX
 D WRTLN("  H CHARGES ON HOLD","H CHARGES ON HOLD","N","DET") I IBPXT G PRINTX
 D WRTLN("  blank","blank","N","DET") I IBPXT G PRINTX
 D WRTLN("Total Number of Entries by Source of Information","Source of Information","N","TOT") I IBPXT G PRINTX
 S SOI=""
 F  S SOI=$O(^TMP($J,"IBCNOR2","SOI",SOI)) Q:SOI=""  D  I IBPXT Q
 . D WRTLN("  "_SOI,SOI,"N","SOI")
 ;
PRINTX ; Exit Print
 I 'IBPXT D EOP(1)
 Q
 ;
FMTDT(DATE) ;Format the date
 I $L(DATE) S DATE=$TR($$FMTE^XLFDT(DATE,"5FD")," ","0")
FMTDTX ;Exit
 Q DATE
 ;
WRTLN(TITLE,NODE,DTYPE,LEVEL) ;Write the line
 N DATA,DATE,DLINE,NUM,TAB,TAB1
 S TAB=$S(TITLE["PART D":35,LEVEL="TOT":55,1:30)
 S TAB1=$S(TITLE["PART D":50,1:45)
 I $Y+1>PL,IBOUT="R",'$D(EMAIL) D HDR I $G(ZTSTOP)!IBPXT Q
 I LEVEL="DET" D  G WRTLNX
 . S DATA=$G(^TMP($J,"IBCNOR2","DET",NODE))
 . S DATA=$FN(+DATA,",") I IBOUT="R" S DATA=$$RJ^XLFSTR(DATA,7)
 . S DLINE=TITLE
 . I IBOUT="E" S DLINE=DLINE_"^"_DATA
 . I IBOUT="R" S $E(DLINE,TAB)=DATA
 . S DATA=$G(^TMP($J,"IBCNOR2","DET",NODE,"DATE"))
 . I DATA]"" D
 .. S DATA=$$FMTDT(DATA)
 .. I IBOUT="E" D  Q
 ... D WRTLNX
 ... S DLINE=TITLE_" OLDEST^"_DATA
 .. S $E(DLINE,TAB1)=DATA
 I LEVEL="SOI" D  G WRTLNX
 . S DATA=$G(^TMP($J,"IBCNOR2","SOI",NODE))
 . S DATA=$FN(+DATA,",") I IBOUT="R" S DATA=$$RJ^XLFSTR(DATA,7)
 . S DLINE=TITLE
 . I IBOUT="E" S DLINE=DLINE_"^"_DATA
 . I IBOUT="R" S $E(DLINE,TAB)=DATA
 . S DATA=$G(^TMP($J,"IBCNOR2","SOI",NODE,"DATE"))
 . I DATA]"" D
 .. S DATA=$$FMTDT(DATA)
 .. I IBOUT="E" D  Q
 ... D WRTLNX
 ... S DLINE=TITLE_" OLDEST^"_DATA
 .. S $E(DLINE,TAB1)=DATA
 I LEVEL="SUM" D  G WRTLNX
 . S DATA=$G(^TMP($J,"IBCNOR2","SUM",NODE))
 . I DTYPE="D" S DATA=$$FMTDT(DATA)
 . I DTYPE="N" S DATA=$FN(+DATA,",") I IBOUT="R" S DATA=$$RJ^XLFSTR(DATA,7)
 . S DLINE=TITLE
 . I IBOUT="E" S DLINE=DLINE_"^"_DATA
 . I IBOUT="R" S $E(DLINE,TAB)=DATA
 I LEVEL="TOT" D  G WRTLNX
 . S DLINE="" D WRTLNX
 . S DATA=$G(^TMP($J,"IBCNOR2","TOT",NODE))
 . I NODE="Patient Status" S DATA="N/A"
 . I NODE'="Patient Status" S DATA=$FN(+DATA,",")
 . I IBOUT="R" S DATA=$$RJ^XLFSTR(DATA,7)
 . S DLINE=TITLE
 . I IBOUT="E" S DLINE=DLINE_"^"_DATA
 . I IBOUT="R" S $E(DLINE,TAB)=DATA
 . D WRTLNX
 . S DLINE=$S(IBOUT="R":" ",1:"")_SLINE
WRTLNX ;Exit
 I $D(EMAIL) S CNT=$G(MSG)+1,MSG=CNT,MSG(CNT)=DLINE Q
 W !,DLINE
 Q
 ;
HDR ;Print Header
 N STRING,TAB
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,IBPXT)=1 G HDRX
 I CRT,(IBPGC>0),'$D(ZTQUEUED) D EOP(0) I IBPXT G HDRX
 S IBPGC=IBPGC+1
 I '$D(EMAIL) W @IOF
 S STRING=TSTAMP I IBOUT="R" S STRING=STRING_"  Page: "_IBPGC
 S TAB=$S(IBOUT="E":24,1:80-($L(STRING)+3))
 S DLINE="Daily Buffer Report",$E(DLINE,TAB)=STRING D WRTLNX
 S DLINE=$S(TYPE="S":"Summary",1:"Detail") D WRTLNX
 S DLINE="*Entries > 7 weekdays, where T=1 if weekday. Otherwise, T= previous Friday." D WRTLNX
 I IBOUT="E" G HDRX
 S DLINE=LINE D WRTLNX
 S DLINE="" D WRTLNX
 ;
HDRX ; Header Exit
 Q
 ;
EOP(END) ; display "end of page" message and set exit flag
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LIN
 I END D
 . S DLINE="" D WRTLNX
 . S DLINE="*****END OF REPORT*****" D WRTLNX
 I 'CRT!$D(EMAIL) G EOPQ
 I PL<51 F LIN=1:1:(PL-$Y)-1 W !
 W !
 S DIR(0)="E" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S IBPXT=1
EOPQ ;
 Q
 ;
CATNDT ; Report categories with no oldest date
 ;;MCCF^Non-MCCF^i ACTIVE INSURANCE^I INPATIENT^E DECEASED^Y COPAY REQUIRED^
 ;;H CHARGES ON HOLD^blank^
 ;;
CATWDT ; Report categories with oldest date
 ;;TRICARE^CHAMPVA^MEDICARE^MEDICARE PART D (WNR)^CMS MBI ONLY^NO INSURANCE^
 ;;PATIENT REFUSED^ALL OTHER^
 ;;
TOTALS ;Category Totals
 ;;MCCF vs. non-MCCF^Insurance Company Category^Patient Status^Source of Information^
 ;;
