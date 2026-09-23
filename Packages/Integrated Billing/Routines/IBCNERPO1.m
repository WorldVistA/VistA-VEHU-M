IBCNERPO1 ;AITC/CKB - PATIENT POLICY AUTOLOAD REPORT COMPILE ; 20-JAN-2026
 ;;2.0;INTEGRATED BILLING;**836**;21-MAR-94;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Variable array from IBCNERPO:
 ;   IBCNERPO("BEGDT")   = Start with DATE - start date range
 ;   IBCNERPO("ENDDT")   = Go to DATE - end date range
 ;   IBCNERPO("IBOUT")   = "R" for Report format or "E" for Excel format
 ;   IBCNERPO("TYPE")    = report type: "S" - summary, "D" - detailed
 ;   IBCNERPO("SORT")    = (1)Patient Name - (2)Date Autoloaded
 ;
 ; Data global created for PRINT:
 ;   Summary report:
 ;     ^TMP($J,"IBCNERPO")=Total Count
 ;     ^TMP($J,"IBCNERPO",PTYPE)=Count  /  PTYPE = "A+B" or "A only" or "B only"
 ;
 ;   Detailed report:
 ;     ^TMP($J,"IBCNERPO")=Count 
 ;     ^TMP($J,"IBCNERPO",SORT1)=Patient Name ^ DOB ^ SSN ^ Group Name ^ Group Number ^
 ;                                      Effective Date ^ Autoload Date
 ;
 Q
 ;
EN(IBCNERPO) ; Entry point
 N DATE,BDATE,EDATE,PTYPE,RPCTR,RTYPE,SOI,SOIBA,SORT,TOTMES
 ;
 S BDATE=$G(IBCNERPO("BEGDT"))
 S EDATE=$G(IBCNERPO("ENDDT"))
 I EDATE'="",$P(EDATE,".",2)="" S EDATE=$$FMADD^XLFDT(EDATE,0,23,59,59)
 S RTYPE=$G(IBCNERPO("TYPE"))
 I '$D(ZTQUEUED),$G(IOST)["C-",IBOUT="R" W !!,"Compiling report data ..."
 ; Kill scratch global
 K ^TMP($J,"IBCNERPO")
 K RPDATA
 ;Initialize variables
 I RTYPE="S" N I F I="A+B","A Only","B Only" S RPDATA(I)=0
 ;
 ;Initialize variables
 S (RPCTR,TOTMES)=0
 S DATE=$O(^IBCN(365,"AD",BDATE),-1)
 F  S DATE=$O(^IBCN(365,"AD",DATE)) Q:'DATE!(DATE>EDATE)  D  I $G(ZTSTOP) G ENX
 . N PAT,PYR
 . ; Loop through Payers
 . S PYR="" F  S PYR=$O(^IBCN(365,"AD",DATE,PYR)) Q:'PYR  D
 .. ; Loop through Patients
 .. S PAT="" F  S PAT=$O(^IBCN(365,"AD",DATE,PYR,PAT)) Q:'PAT  D  Q:$G(ZTSTOP)
 ... D GETRESP(DATE,PYR,PAT,RTYPE)
 ; Move report data from RPDATA to scratch global
 M ^TMP($J,"IBCNERPO")=RPDATA
ENX ; Exit
 Q
 ;
GETRESP(DATE,PYR,PAT,RTYPE) ; loop through the responses and compile report
 N AUTOLOAD,ACTIVE,DOB,EFFDT,ELIG,FOUND,GRP,GRPNAME,GRPNUM,ELIG,IBOUT,IENS2,IENS312,IENS3651
 N IIEN,INS,PATNAME,POL,POLCT,POLICY,RIEN,SOI,SORT1,SORT2,TYPE
 ;
 S RIEN="" F  S RIEN=$O(^IBCN(365,"AD",DATE,PYR,PAT,RIEN)) Q:'RIEN  D  Q:$G(ZTSTOP)
 . S TOTMES=TOTMES+1
 . I '$D(ZTQUEUED),(TOTMES#100=0) W "."
 . I $D(ZTQUEUED),TOTMES#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . ;If not a EIV AUTO-LOAD response Quit 
 . I $$GET1^DIQ(365,RIEN_",",.16)'="YES" Q
 . ;
 . S IIEN=$$GET1^DIQ(365,RIEN_",",.12)        ; Insurance Record IEN
 . S IENS3651=$$GET1^DIQ(365,RIEN_",",.05)    ; Transmission Queue IEN
 . S SOI=$$GET1^DIQ(365.1,IENS3651,3.02,"I")
 . ;
 . ;Get list of insurance identified file #365 IIV RESPONSE file - 271 payer response
 . D EBSUMMARY^IBCNEUT2(PAT,RIEN,SOI,.POLICY)
 . I '$O(POLICY(0)) Q            ; if none was returned on payer response (safety valve)
 . I $D(POLICY(1,"Unknown")) Q   ; if none was returned on payer response (safety valve)
 . I $G(POLICY("OHI"))=1 Q       ; indicates Other potential insurance indicated on payer response
 . ;If the Medicare Policy in the Response is missing the Effective Date, policy did not auto-load
 . I $G(POLICY("MISSING_EFFDT"))=1 Q
 . ;Loop through POLICY and gather the Active policy(s)
 . D GETACTIVE
 . ;
 . ;Summary Report 
 . I $D(ACTIVE("Medicare Part A")) S PTYPE="A Only"
 . I $D(ACTIVE("Medicare Part B")) S PTYPE="B Only"
 . I ($D(ACTIVE("Medicare Part A")))&($D(ACTIVE("Medicare Part B"))) S PTYPE="A+B"
 . I RTYPE="S" D  Q
 .. S RPDATA=$G(RPDATA)+1
 .. S RPDATA(PTYPE)=$G(RPDATA(PTYPE))+1
 . ;
 . ;Compile Report
 . ;Loop through ACTIVE for the Detail Report info
 . S POL="" F  S POL=$O(ACTIVE(POL)) Q:POL=""  D
 .. S GRP=$S(POL="Medicare Part A":"PART A",1:"PART B",1:"")
 .. ;Loop thru the patient policy's to get the Insurance IEN for the Active policy
 .. S FOUND=0
 .. S IIEN=0 F  S IIEN=$O(^DPT(PAT,.312,IIEN)) Q:(IIEN="")!(FOUND=1)  D COMPILE
 Q
 ;
COMPILE ; Compile Detail Report
 N REC
 S IENS2=PAT_","
 S IENS312=IIEN_","_IENS2
 S AUTOLOAD=$P($$GET1^DIQ(2.312,IENS312,1.01,"I"),".")
 S GRPNAME=$$GET1^DIQ(2.312,IENS312,20,"E")
 ;Check to see if this is the policy in ACTIVE array
 I AUTOLOAD'=$P(DATE,".")!(GRP'=GRPNAME) Q
 ;Found the policy in the patient's insurance
 S FOUND=1
 S GRPNUM=$$GET1^DIQ(2.312,IENS312,21,"E")
 S PATNAME=$$GET1^DIQ(2,IENS2,.01)
 S DOB=$$GET1^DIQ(2,IENS2,.03,"I")
 S SSN=$$GET1^DIQ(2,IENS2,.09)
 S EFFDT=$$GET1^DIQ(2.312,IENS312,8,"I")
 ;Detail Report 1=Patient Name / 2=Date Autoloaded
 S RPCTR=$G(RPCTR)+1
 S SORT1=PATNAME
 I IBCNERPO("IBOUT")="R" S SORT1=$S(IBCNERPO("SORT")=2:AUTOLOAD,1:PATNAME)
 S REC=PATNAME_U_$$FMTE^XLFDT(DOB,"5Z")_U_SSN_U_GRPNAME_U_GRPNUM_U_$$FMTE^XLFDT(EFFDT,"5Z")_U_$$FMTE^XLFDT(AUTOLOAD,"5Z")
 S RPDATA(SORT1,RPCTR)=REC
 Q
 ;
PRINT(IBCNERPO) ; Entry point
 N CRT,DDATA,DLINE,EORMSG,IBPGC,IBPXT,ICT,MAXCNT,NONEMSG,NPROC,SSN,SSNLEN,SRT1,TSTAMP,WIDTH,X,Y
 ;
 S (IBPGC,IBPXT)=0
 S NONEMSG="*** NO  DATA  FOUND ***"
 S EORMSG="*** END OF REPORT ***"
 S TSTAMP=$$FMTE^XLFDT($$NOW^XLFDT,1) ; time of report
 S TYPE=$G(IBCNERPO("TYPE"))          ; Report type
 S IBOUT=$G(IBCNERPO("IBOUT"))        ; Output type
 S WIDTH=$S(TYPE="S":79,1:131)
 ; Determine IO parameters
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 S MAXCNT=IOSL-6,CRT=0
 S:IOST["C-" MAXCNT=IOSL-3,CRT=1
 ; Print data
 S SRT1=""
 D HEADER:IBOUT="R",EHEADER:IBOUT="E"
 ; If global does not exist - display No Data message for the Detail Report
 I TYPE="D" I '$D(^TMP($J,"IBCNERPO")) D LINE(NONEMSG,IBOUT) W:IBOUT="E" ! G PRINTX
 ;
 ; Summary Report
 I TYPE="S" D  G PRINTX
 . N COUNT,SLINE,TLINE,TOTAL
 . W ! F SRT1="A+B","A Only","B Only" D
 .. S COUNT=$G(^TMP($J,"IBCNERPO",SRT1)) I COUNT="" S COUNT=0
 .. S SLINE=$$FO^IBCNEUT1(" Patients  ("_SRT1_")",38,"L")
 .. S SLINE=SLINE_$$FO^IBCNEUT1(COUNT,20,"R")
 .. D LINE(SLINE,IBOUT)
 . W !
 . S TOTAL=$G(^TMP($J,"IBCNERPO")) I TOTAL="" S TOTAL=0
 . S TLINE=" Patients Autoloaded Medicare (Total) "
 . S TLINE=TLINE_$$FO^IBCNEUT1(TOTAL,20,"R")
 . D LINE(TLINE,IBOUT)
 . W !!
 ;
 ; Detail Report
 S SRT1="" F  S SRT1=$O(^TMP($J,"IBCNERPO",SRT1)) Q:SRT1=""  D  Q:$G(ZTSTOP)!IBPXT
 . S ICT="" F  S ICT=$O(^TMP($J,"IBCNERPO",SRT1,ICT)) Q:ICT=""  D
 .. S DDATA=$G(^TMP($J,"IBCNERPO",SRT1,ICT))
 .. S SSN=$P(DDATA,U,3)
 .. I IBOUT="E" W !,$P(DDATA,U,1,2)_U_$E(SSN,$L(SSN)-3,$L(SSN))_U_$P(DDATA,U,4,7) Q
 .. S DLINE=""
 .. S $E(DLINE,1,35)=$E($P(DDATA,U),1,35)      ; Patient Name
 .. S $E(DLINE,38,48)=$E($P(DDATA,U,2),1,10)   ; DOB
 .. S SSNLEN=$L(SSN),$E(DLINE,51,54)=$E(SSN,SSNLEN-3,SSNLEN)    ; SSN (last 4)
 .. S $E(DLINE,58,78)=$E($P(DDATA,U,4),1,20)   ; Group Name
 .. S $E(DLINE,81,100)=$E($P(DDATA,U,5),1,17)  ; Group Number
 .. S $E(DLINE,102,112)=$E($P(DDATA,U,6),1,10) ; Effective Date
 .. S $E(DLINE,115,125)=$E($P(DDATA,U,7),1,10) ; Autoload Date
 .. D LINE(DLINE,IBOUT)
PRINTX ;
 I 'IBPXT D
 . W !
 . I IBOUT="E" W EORMSG D PAUSE Q
 . D LINE($$FO^IBCNEUT1(EORMSG,$L(EORMSG),"L"),IBOUT)
 . I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL
 Q
 ;
GETACTIVE ; Get the Active policies from the POLICY array
 ;   ACTIVE(GRPNUM)=DFN_U_GRPNUM_U_EFFDT_U_SOI_U_ELIG
 ; Loop through list of insurance (.POLICY) and keep only ACTIVE policies
 ; Only add 'Active' policies to the ACTIVE array
 S POLCT="" F  S POLCT=$O(POLICY(POLCT)) Q:POLCT=""  D
 . S GRPNUM="" F  S GRPNUM=$O(POLICY(POLCT,GRPNUM)) Q:GRPNUM=""  D
 .. I $TR(GRPNUM,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")'["MEDICARE" Q
 .. S ELIG=$P(POLICY(POLCT,GRPNUM),U,5)   ; ELIG='Inactive' or 'Active Coverage'
 .. I $TR(ELIG,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")["INACTIVE" Q
 .. S ACTIVE(GRPNUM)=POLICY(POLCT,GRPNUM)
 Q
 ;
EOL ; display "end of page" message and set exit flag
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LIN
 I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 D PAUSE
 Q
 ;
HEADER ; Print the Report header for each page
 N DASHES,DELTA,HDR,HDRDATE,HDRDTR,HDRPG,OFFSET,SPACES
 ;
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL I IBPXT Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,IBPXT)=1 Q
 W @IOF,!
 S IBPGC=IBPGC+1
 S DASHES="" F I=1:1:132 S DASHES=DASHES_"-"
 S SPACES="" F I=1:1:25 S SPACES=SPACES_" "
 D NOW^%DTC
 S HDRDATE=$$DAT2^IBOUTL($E(%,1,12))
 S HDRDTR=$$FMTE^XLFDT($G(IBCNERPO("BEGDT")),"5Z")_" - "_$$FMTE^XLFDT($G(IBCNERPO("ENDDT")),"5Z")
 ;Summary Report Header
 I TYPE="S" D
 . S HDR="Patient Policy Autoload Report (Summary)     "_HDRDATE
 . W !,HDR,?70,"Page: "_IBPGC
 . W !,"Date Range: ",HDRDTR,!
 ;Detail Report Header 
 I TYPE="D" D
 . S HDR="Patient Policy Autoload Report"_SPACES_HDRDATE
 . W !,HDR,?112,"Page: "_IBPGC
 . W !,"Date Range: ",HDRDTR
 . W !,"Sort By: ",$S(IBCNERPO("SORT")=2:"Date Autoloaded",1:"Patient Name")
 . W !!,"Patient Name",?38,"DOB",?51,"SSN",?58,"Group Name",?81,"Group Number",?102,"Eff Date",?115,"Autoload Date"
 . W !,$E(DASHES,1,35),?38,$E(DASHES,1,10),?51,$E(DASHES,1,4),?58,$E(DASHES,1,10),?81,$E(DASHES,1,12)
 . W ?102,$E(DASHES,1,10),?115,$E(DASHES,1,13)
 Q
 ;
LINE(LINE,IBOUT) ; Print line of data
 I $Y+1>MAXCNT,IBOUT="R" D HEADER I $G(ZTSTOP)!IBPXT Q
 W ! W:IBOUT="R" ?1 W LINE
 Q
 ;
EHEADER ; Print the Excel header
 N %,HDR,IBHDT
 D NOW^%DTC
 S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 W !,"Patient Policy Autoload Report^",IBHDT
 S HDR=$$FMTE^XLFDT($G(IBCNERPO("BEGDT")),"5Z")_" - "_$$FMTE^XLFDT($G(IBCNERPO("ENDDT")),"5Z")
 W !,"Date Range: ",HDR
 W !,"Patient Name^DOB^SSN^Group Name^Group Number^Effective Date^Autoload Date"
EHEADERX ;
 Q
 ;
PAUSE ; Pause for screen output.
 N DIR,DIRUT,DTOUT,DUOUT
 Q:$E(IOST,1,2)'["C-"
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBPXT=1 K DIR,DIRUT,DTOUT,DUOUT
 Q
