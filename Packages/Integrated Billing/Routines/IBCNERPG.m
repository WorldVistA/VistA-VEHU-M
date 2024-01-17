IBCNERPG ;BP/YMG - IBCNE EIV INSURANCE UPDATE REPORT COMPILE;16-SEP-2009
 ;;2.0;INTEGRATED BILLING;**416,528,549,595,737,763**;16-SEP-09;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; NOTE:
 ;   IB*2.0*763 is a major re-write of this report.  The comments from the previous patches
 ;   have either been removed or modified to remove the patch number if the comment is relevant.
 ;
 ; Variable array from IBCNERPF:
 ;   IBCNESPC("BEGDT")   = start date for date range
 ;   IBCNESPC("ENDDT")   = end date for date range
 ;   IBCNESPC("IBOUT")   = "R" for Report format or "E" for Excel format
 ;   IBCNESPC("ICODETL") = 1 for displaying Ins Co Detail
 ;   IBCNESPC("INSCO")   = "A" (All ins. cos.) OR "S" (Selected ins. cos.)
 ;   IBCNESPC("PYR",ien) - payer iens for report, if IBCNESPC("PYR")="A", then include all
 ;                       = (1) ^ (2)
 ;     (1) Display insurance company detail - 0 = No / 1 = Yes
 ;     (2) Display all or some insurance companies - A = All companies/
 ;                                                   S = Specified companies
 ;   IBCNESPC("PYR",ien,coien) - payer iens and company ien for report
 ;                             = Count for insurance company
 ;   IBCNESPC("PAT",ien) = patient iens for report, if IBCNESPC("PAT")="A", then include all
 ;   IBCNESPC("TYPE")    = report type: "S" - summary, "D" - detailed
 ;
 ; Data global created for PRINT:
 ;   Summary report:
 ;     ^TMP($J,"IBCNERPF")=Total Count
 ;     ^TMP($J,"IBCNERPF",SORT1)=Payer Count
 ;     ^TMP($J,"IBCNERPF",SORT1,SORT2)=Company Count
 ;     SORT1 - Payer Name or SOI, SORT2 - Company Name
 ;
 ;   Detailed report:
 ;     ^TMP($J,"IBCNERPF",SORT1)=Count 
 ;     ^TMP($J,"IBCNERPF",SORT1,SORT2)=Count 
 ;     ^TMP($J,"IBCNERPF",SORT1,SORT2,SORT3)=Payer Name ^ Insurance Company Name ^ Pat. Name ^ SSN ^
 ;                                         Date Inquiry Sent ^ Date Policy Auto Updated ^ Days old ^ 
 ;                                         Trace Number
 ;                                          Date Inquiry Sent ^ Date Policy Auto Updated@time ^ Trace Number 
 ;                                          
 ;     SORT1 - Payer Name, SORT2 - Date received, SORT3 - Count
 ;
 Q
 ;
EN(IBCNESPC) ; Entry point
 N DATE,BDATE,EDATE,RPDATA,RTYPE,SOI,SOIBA,SORT
 S ALLPYR=$G(IBCNESPC("PYR"))="A"
 S ALLPAT=$G(IBCNESPC("PAT"))="A"
 S BDATE=$G(IBCNESPC("BEGDT"))
 S EDATE=$G(IBCNESPC("ENDDT"))
 I EDATE'="",$P(EDATE,".",2)="" S EDATE=$$FMADD^XLFDT(EDATE,0,23,59,59)
 S RTYPE=$G(IBCNESPC("TYPE"))
 I '$D(ZTQUEUED),$G(IOST)["C-",IBOUT="R" W !!,"Compiling report data ..."
 ; Kill scratch global
 K ^TMP($J,"IBCNERPF")
 S DATE=$O(^IBCN(365,"AUTO",BDATE),-1)
 F  S DATE=$O(^IBCN(365,"AUTO",DATE)) Q:'DATE!(DATE>EDATE)  D  I $G(ZTSTOP) G ENX
 . N PYR
 . S PYR=""
 . ; Loop through Payers
 . S PYR=$O(^IBCN(365,"AUTO",DATE,PYR)) Q:'PYR  D
 .. N PAT
 .. S PAT=""
 .. F  S PAT=$O(^IBCN(365,"AUTO",DATE,PYR,PAT)) Q:'PAT  D  Q:$G(ZTSTOP)
 ... D GETDATA(DATE,PYR,ALLPYR,PAT,RTYPE)
 ; Collect Selected Payers with no data
 I RTYPE="S" D
 . N PYR,PYRNAME,IIEN,INSCOMNM
 . S PYR=""
 . F  S PYR=$O(IBCNESPC("PYR",PYR)) Q:'PYR  D
 .. S PYRNAME=$$GET1^DIQ(365.12,PYR,".01","I")
 .. S:'$D(RPDATA(PYRNAME)) RPDATA(PYRNAME)=0
 .. I $P(IBCNESPC("PYR",PYR),U,2)="A" Q   ;Only report selected insurance companies.
 .. S IIEN=""
 .. F  S IIEN=$O(IBCNESPC("PYR",PYR,IIEN)) Q:IIEN=""  D
 ... S INSCOMNM=$$GET1^DIQ(36,IIEN,".01","I")
 ... S:'$D(RPDATA(PYRNAME,INSCOMNM)) RPDATA(PYRNAME,INSCOMNM)=0
 M ^TMP($J,"IBCNERPF")=RPDATA
ENX ; Exit
 Q
 ;
GETDATA(DATE,PYR,ALLPYR,PAT,RTYPE) ; loop through responses and compile report
 N AUTOUPD,CLNAME,DTINQSNT,DTPOLUPD,FLG,IENS2,IENS312,IENS3651,IIEN,INS,INSCOMNM,NOW
 N PATNAME,PYRNAME,RIEN,SORT1,SORT2,SORT3,SSN,TOTMES,TQ,TRACENUM,TYPE,VDATE
 ;
 S (TOTMES,INS)=0
 F  S INS=$O(^IBCN(365,"AUTO",DATE,PYR,PAT,INS)) Q:'INS  D  Q:$G(ZTSTOP)
 . S RIEN="" F  S RIEN=$O(^IBCN(365,"AUTO",DATE,PYR,PAT,INS,1,RIEN)) Q:'RIEN  D  Q:$G(ZTSTOP)
 .. S TOTMES=TOTMES+1
 .. I '$D(ZTQUEUED),(TOTMES#100=0) W "."
 .. I $D(ZTQUEUED),TOTMES#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 .. ; If summary version of report & selected ins co were chosen, do not consider others
 .. ; If summary version of report & selected ins co were chosen, count for payer only includes
 .. ;   counts for selected ins co
 .. S IENS2=PAT_",",IENS312=INS_","_IENS2
 .. S PYRNAME=$$GET1^DIQ(365.12,PYR_",",.01),PATNAME=$$GET1^DIQ(2,IENS2,.01)
 .. S IIEN=$$GET1^DIQ(2.312,IENS312,.01,"I")
 .. I 'IIEN Q  ; policy no longer on pt
 .. S INSCOMNM=$$GET1^DIQ(36,IIEN,.01)
 .. S IENS3651=$$GET1^DIQ(365,RIEN_",",.05,"I")
 .. S SOI=$$GET1^DIQ(365.1,IENS3651,3.02,"I")
 .. S SOIE=$$GET1^DIQ(365.1,IENS3651,3.02)
 .. ; For summary version of report, include count for insurance company
 .. ; Do not display insurance company detail if user selected to not display such
 .. S TYPE=$G(IBCNESPC("PYR",PYR))
 .. ;
 .. ; Summary Report compile
 .. I RTYPE="S" D  Q
 ... S RPDATA=$G(RPDATA)+1
 ... ; Sort by Source of Information
 ... I IBCNESPC("PS")="S" D  Q
 .... I SOI="" Q
 .... S RPDATA(SOIE)=$G(RPDATA(SOIE))+1,RPDATA(SOIE,PYRNAME)=$G(RPDATA(SOIE,PYRNAME))+1
 ... ; Sort by Payer
 ... I 'ALLPYR,'$D(IBCNESPC("PYR",PYR)) Q  ;Not a selected payer
 ... S RPDATA(PYRNAME)=$G(RPDATA(PYRNAME))+1
 ... ; Compile data for insurance company detail if selected.
 ... I '$G(IBCNESPC("ICODETL")) Q
 ... I (TYPE="S"),'$D(IBCNESPC("PYR",PYR,IIEN)) Q  ; Not a selected insurance company
 ... S RPDATA(PYRNAME,INSCOMNM)=$G(RPDATA(PYRNAME,INSCOMNM))+1
 ... ;
 .. ; Detail Report
 .. S SORT1=PYRNAME
 .. S SSN=$$GET1^DIQ(2,IENS2,.09,"E")
 .. S DTINQSNT=$$FMTE^XLFDT($$GET1^DIQ(365,RIEN_",",".08","I"),"2DZ")
 .. S DTPOLUPD=$$FMTE^XLFDT(DATE,"2SZ")
 .. S SOIBA=$$GET1^DIQ(355.12,SOI_",",.03)
 .. I $L(DTPOLUPD)=8 S DTPOLUPD=DTPOLUPD_"@00:00:00" ; handles 0 seconds 
 .. S TRACENUM=$$GET1^DIQ(365,RIEN_",",".09","I")
 .. S SORT2=DATE
 .. I 'ALLPYR,'$D(IBCNESPC("PYR",PYR)) Q  ;Not a selected payer
 .. I 'ALLPAT,'$D(IBCNESPC("PAT",PAT)) Q  ;Not a selected patient
 .. I IBCNESPC("ICODETL"),(TYPE="S"),'$D(IBCNESPC("PYR",PYR,IIEN)) Q  ; If user chose selected co option, and company was not selected
 .. ;                                               don't print company info
 .. S RPDATA=$G(RPDATA)+1
 .. S RPDATA(SORT1)=$G(RPDATA(SORT1))+1
 .. S (RPDATA(SORT1,SORT2),SORT3)=$G(RPDATA(SORT1,SORT2))+1
 .. S RPDATA(SORT1,SORT2,SORT3)=PYRNAME_U_INSCOMNM_U_PATNAME_U_SSN_U_DTINQSNT_U_DTPOLUPD_U_SOIBA_U_TRACENUM
 Q
 ;
PRINT(IBCNESPC) ; Entry point
 N CRT,DDATA,DLINE,EORMSG,IBPGC,IBOUT,IBPXT,MAXCNT,NONEMSG,NPROC,SSN,SSNLEN,SRT1,SRT2,SRT3,TSTAMP,TYPE,WIDTH,X,Y
 S (IBPGC,IBPXT)=0,IBOUT=IBCNESPC("IBOUT")
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 S EORMSG="*****END OF REPORT*****"
 S NPROC="Not Processed"
 S TSTAMP=$$FMTE^XLFDT($$NOW^XLFDT,1) ; time of report
 S TYPE=$G(IBCNESPC("TYPE")) ; report type
 S IBOUT=$G(IBCNESPC("IBOUT")) ; Output type
 S WIDTH=$S(TYPE="S":79,1:131)
 ; Determine IO parameters
 I "^R^E^"'[(U_$G(IBOUT)_U) S IBOUT="R"
 S MAXCNT=IOSL-6,CRT=0
 S:IOST["C-" MAXCNT=IOSL-3,CRT=1
 ; print data
 S SRT1=""
 D HEADER:IBOUT="R",PHDL:IBOUT="E" I $G(ZTSTOP)!IBPXT Q
 ; If global does not exist - display No Data message
 I '$D(^TMP($J,"IBCNERPF")) D LINE($$FO^IBCNEUT1(NONEMSG,$L(NONEMSG),"L"),IBOUT) G PRINTX
 ; Summary Report
 I TYPE="S" D  G PRINTX
 . D LINE("TOTAL AUTO UPDATED = "_+$G(^TMP($J,"IBCNERPF")),IBOUT)
 . W !
 . F  S SRT1=$O(^TMP($J,"IBCNERPF",SRT1)) Q:SRT1=""!$G(ZTSTOP)!IBPXT  D
 .. I IBOUT="R" D LINE(SRT1_" = "_+$G(^TMP($J,"IBCNERPF",SRT1)),IBOUT)
 .. I IBOUT="E",'$G(IBCNESPC("ICODETL")) D LINE(SRT1_"^"_+$G(^TMP($J,"IBCNERPF",SRT1)),IBOUT)
 .. S SRT2="" F  S SRT2=$O(^TMP($J,"IBCNERPF",SRT1,SRT2)) Q:SRT2=""!$G(ZTSTOP)!IBPXT  D
 ... I '$G(IBCNESPC("ICODETL")) Q  ;No ins co detail
 ... I IBOUT="E" D LINE(SRT1_U_$S(SRT2=0:NPROC,1:SRT2)_U_^TMP($J,"IBCNERPF",SRT1,SRT2),IBOUT) Q
 ... D LINE("       "_SRT2_" = "_+$G(^TMP($J,"IBCNERPF",SRT1,SRT2)),IBOUT)
 . W !
 ;
 ; detailed report
 F  S SRT1=$O(^TMP($J,"IBCNERPF",SRT1)) Q:SRT1=""  D  Q:$G(ZTSTOP)!IBPXT
 . S SRT2="" F  S SRT2=$O(^TMP($J,"IBCNERPF",SRT1,SRT2)) Q:SRT2=""!$G(ZTSTOP)!IBPXT  D
 .. S SRT3="" F  S SRT3=$O(^TMP($J,"IBCNERPF",SRT1,SRT2,SRT3)) Q:SRT3=""!$G(ZTSTOP)!IBPXT  D
 ... S DDATA=$G(^TMP($J,"IBCNERPF",SRT1,SRT2,SRT3)),DLINE="",SSN=$P(DDATA,U,4)
 ... I IBOUT="E" W !,$P(DDATA,U,1,3)_U_$E(SSN,$L(SSN)-3,$L(SSN))_U_$P(DDATA,U,5,8) Q
 ... S $E(DLINE,1,24)=$E($P(DDATA,U),1,24) ;     Payer name
 ... S $E(DLINE,28,43)=$E($P(DDATA,U,2),1,16) ;  Insurance company name
 ... S $E(DLINE,46,60)=$E($P(DDATA,U,3),1,15) ;  Patient name
 ... S SSNLEN=$L(SSN),$E(DLINE,63,66)=$E(SSN,SSNLEN-3,SSNLEN)
 ... S $E(DLINE,69,76)=$E($P(DDATA,U,5),1,8) ;   Date sent
 ... S $E(DLINE,79,86)=$E($P(DDATA,U,6),1,17) ;   Date auto updated
 ... S $E(DLINE,98,104)=$P(DDATA,U,7)
 ... S $E(DLINE,105,114)=$E($P(DDATA,U,8),1,10) ; eIV trace number
 ... D LINE(DLINE,IBOUT)
 . I IBOUT="R" W !
 ;
PRINTX ;
 I 'IBPXT D
 . D LINE($$FO^IBCNEUT1(EORMSG,$L(EORMSG),"L"),IBOUT)
 . I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL
 Q
 ;
EOL ; display "end of page" message and set exit flag
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LIN
 I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 S DIR(0)="E" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S IBPXT=1
 Q
 ;
HEADER ; print header for each page
 N DASHES,DELTA,HDR,LEN,OFFSET,POS,STRING
 ;
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL I IBPXT Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,IBPXT)=1 Q
 S IBPGC=IBPGC+1
 W @IOF,!
 S HDR=$J("",WIDTH)
 S STRING=" Auto Update Report",$E(HDR,1,$L(STRING))=STRING
 S STRING="  Page: "_IBPGC,$E(HDR,WIDTH-$L(STRING)+1,WIDTH)=STRING
 S LEN=$L(TSTAMP)
 S DELTA=(WIDTH#2),POS=(WIDTH\2+DELTA)-(LEN\2)+1
 S $E(HDR,POS,POS+$L(TSTAMP)-1)=TSTAMP
 W HDR W:TYPE="S" !
 S HDR=$$FMTE^XLFDT($G(IBCNESPC("BEGDT")),"5Z")_" - "_$$FMTE^XLFDT($G(IBCNESPC("ENDDT")),"5Z")
 W !?1,"Response Received: ",HDR
 W !?1,$S(TYPE="D":"Detailed",1:"Summary")_" Report: "
 W $S($G(IBCNESPC("PS"))="S":" Source of Information",1:$S(ALLPYR:"All",1:"Selected")_" Payers")
 I TYPE="D" D
 . W "; ",$S($G(IBCNESPC("INSCO"))="S":"Selected",1:"All")
 . W " Insurance Companies; "
 . W $S(ALLPAT:"All",1:"Selected")_" Patients"
 . S STRING="Payer",$E(STRING,28,45)="Insurance Co",$E(STRING,46,62)="Patient Name"
 . S $E(STRING,63,68)="SSN",$E(STRING,69,78)="Dt Sent",$E(STRING,79,88)="Auto Dt"
 . S $E(STRING,98,104)="SOI"
 . S $E(STRING,105,138)="eIV Trace#"
 . W !!,?1,STRING
 S $P(DASHES,"-",WIDTH-2)="" W !,?1,DASHES
 Q
 ;
LINE(LINE,IBOUT) ; Print line of data
 I $Y+1>MAXCNT,IBOUT="R" D HEADER I $G(ZTSTOP)!IBPXT Q
 W ! W:IBOUT="R" ?1 W LINE
 Q
 ;
PHDL ; - Print the header line for the Excel spreadsheet
 ; IB*2.0*549 - Add report header
 N %,HDR,IBHDT,X
 D NOW^%DTC
 S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 W !!,"Auto Update Report",?53,"Run On: ",IBHDT
 S HDR=$$FMTE^XLFDT($G(IBCNESPC("BEGDT")),"5Z")_" - "_$$FMTE^XLFDT($G(IBCNESPC("ENDDT")),"5Z")
 W !?1,"Response Received: ",HDR
 W !?2,$S(TYPE="D":"Detailed",1:"Summary")_" Report: "
 W $S($G(IBCNESPC("PS"))="S":" Source of Information",1:$S(ALLPYR:"All",1:"Selected")_" Payers")
 S IBPGC=1
 I TYPE="S" D  G PHDLX
 . I IBCNESPC("PS")="S" W !!,"SOI^Payer Name^Count" Q
 . W !!,"Payer Name",$S(IBCNESPC("ICODETL"):"^Insurance Co",1:""),"^Count"
 W "; ",$S($G(IBCNESPC("INSCO"))="S":"Selected",1:"All")," Insurance Companies; "
 W $S(ALLPAT:"All",1:"Selected")_" Patients"
 W !!,"Payer^Insurance Co^Patient Name^SSN^Dt Sent^Auto Dt^SOI^eIV Trace#"
PHDLX ;
 Q
