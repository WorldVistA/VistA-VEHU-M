DVBARSBD ;ALB/RPM - CAPRI 2507 REQUEST STATUS BY DT RANGE REPORT ; 01/24/12
 ;;2.7;AMIE;**179,185,189,190,192,193**;Apr 10, 1995;Build 84
 ;
 Q  ;NO DIRECT ENTRY
 ;
REQSTAT(DVBSDAT,DVBEDAT,DVBRSTAT,DVBDELIM,DVBNODT) ;entry for request status by dt range
 ;
 ;  Input:
 ;    DVBSDAT - start date (FM format)
 ;    DVBEDAT - end date (FM format)
 ;    DVBRSTAT - request status (internal format)
 ;    DVBDELIM - return delimited results (0=no;1=yes)
 ;    DVBNODT - ignore date range (0=no;1=yes)
 ;
 N EXSTAT  ;request status (external format)
 N EXSDAT  ;start date (external format: MM/DD/YYYY)
 N EXEDAT  ;end date (external format: MM/DD/YYYY)
 N DVBARS  ;request status conversion results
 N DVBERR  ;FM error msg
 N DVBCNT  ;returned record count
 ;GRE- 193 ;Request Status conversion Report changes ;
 N RRIENINC ; re-route ien counter
 N RRDATE  ;re-route date
 N RRTOSITE  ;re-route to site
 N RRFRMSITE ; re-route from site;
 N RRSTATINC ; re-route status counter
 N RRSTATDTE ; re-route status date
 N RRSTAT    ; re-route status
 N DVBLINE  ;header separator
 ;GRE ; end Request Status conversion Report changes ;
 K ^TMP("DVBREQ",$J),^TMP("DVBREQN",$J)
 S EXSDAT=$$FMTE^XLFDT(DVBSDAT,"5DZ")
 S EXEDAT=$$FMTE^XLFDT(DVBEDAT,"5DZ")
 S (RRDATE,RRFRMSITE,RRTOSITE,RRSTATDTE,RRSTAT)="",(RRIENINC,RRSTATINC)=0
 S $P(DVBLINE,"-",131)=""
 I DVBRSTAT="RN" S DVBRSTAT="NR"
 I DVBRSTAT="A" S EXSTAT="ALL"
 E  D
 . D CHK^DIE(396.3,17,"E",DVBRSTAT,.DVBARS,"DVBERR")
 . S EXSTAT=$G(DVBARS(0))
 S DVBCNT=1
 S DVBAD=$S(DVBDELIM=1:",",1:0)
 ;
 ;collect records matching search criteria
 I DVBNODT D
 . S EXSDAT="NO START DATE"
 . S EXEDAT="NO END DATE"
 . I DVBDELIM D DELIMHDR(EXSDAT,EXEDAT,EXSTAT)
 . D GETRECSN(DVBRSTAT,.DVBCNT)
 E  D
 . I DVBDELIM D DELIMHDR(EXSDAT,EXEDAT,EXSTAT)
 . D GETRECS(DVBSDAT,DVBEDAT,DVBRSTAT,.DVBCNT)
D I 'DVBCNT D
 . W "NO DATA FOUND"
 E  D
 . I 'DVBDELIM D PLAINHDR(EXSDAT,EXEDAT,EXSTAT),PLAIN  ;plain text format
 . I DVBDELIM D DELIM  ;comma delimited format
 ;
END ;Clean up local variables
 K DIWF,DIWL,DIWR,DVBAD,DVBAX,DVBAY,DVBCNRS,DVBEXAM,DVBIEN4,DVBI2,DVBX,DVBXCNT,LINE,X
 K DVBAD,DVBAX,DVBAY,DVBCT,DVBCTN,DVBCTW,DVBIEN4,DVBI2,DIWF,DIWL,DIWR,DVBX,DVBSC,DVBSCC,DVBSCN,DVBSCW,DVBSCWA,DVBXCNT,LINE,X
 K DVBSCNS,DVBAA,^TMP("DVBREQ",$J),^TMP("DVBREQH",$J)
 K DVBREQH,DVBREQL2,DVBREQL3,DVBI22,MSG,RCC,RCR,RRFRMSITE
 Q
 ;
GETRECS(SDAT,EDAT,RSTAT,CNT) ;collect 2507 REQUEST record matches, when DVBNODT=0 means not ignoring the date range
 ;This procedure collects all 2507 REQUEST records that have a
 ;DATE STATUS LAST CHANGED within the start and end dates and have
 ;a REQUEST STATUS that matches the input request status parameter.
 ;
 ;  Input:
 ;    SDAT - start date (FM format)
 ;    EDAT - end date (FM format)
 ;    RSTAT - request status (internal format)
 ;    CNT - record count (passed by reference)
 ;
 N CHGDAT  ;change date
 N DVBIEN  ;2507 REQUEST IEN
 N DVBSTAT ;2507 REQUEST STATUS
 N FLD     ;field array in external format
 S CHGDAT=SDAT-1
 S DVBIEN=0,CNT=0 F  S CHGDAT=$O(^DVB(396.3,"AH",CHGDAT)) Q:'CHGDAT!(CHGDAT>EDAT)  D
 . F  S DVBIEN=$O(^DVB(396.3,"AH",CHGDAT,DVBIEN)) Q:'DVBIEN  D
 . . ;AJF; Request Status Conversion
 . . S DVBSTAT=$$RSTAT^DVBCUTL8($P(^DVB(396.3,DVBIEN,0),U,18))
 . . I RSTAT="A"!(DVBSTAT=RSTAT) D
 . . . K FLD
 . . . I $$SETFLDS(DVBIEN,.FLD) D
 . . . . S CNT=CNT+1,DVBXCNT=1
 . . . . I $G(DVBAD)'="," S ^TMP("DVBREQX",$J,CNT)=FLD("IEN")_U_FLD("SS")_U_FLD("NM")_U_FLD("REQDT")_U_FLD("RELDT")_U_FLD("PRTDT")_U_FLD("RS")_U_FLD("CANDT")_U_FLD("RO")_U_FLD("CANRS",DVBXCNT)_U_FLD("CANCOM",DVBXCNT) D
 . . . . . S ^TMP("DVBREQ",$J,CNT,DVBIEN)=FLD("IEN")_U_FLD("SS")_U_FLD("NM")_U_FLD("REQDT")_U_FLD("RELDT")_U_FLD("PRTDT")_U_FLD("RS")_U_FLD("CANDT")_U_FLD("RO")_U_FLD("CANRS",DVBXCNT)_U_FLD("CANCOM",DVBXCNT)_U
 . . . . . S ^TMP("DVBREQ",$J,CNT,DVBIEN)=^TMP("DVBREQ",$J,CNT,DVBIEN)_FLD("DVBCTW")_U_FLD("DVBSCWA")_U_RRDATE_U_RRTOSITE_U_RRFRMSITE
 . . . . . S CNT=CNT+1,DVBXCNT=DVBXCNT+1
 . . . . I $G(DVBAD)="," D
 . . . . . S (RCC,RCR)=""
 . . . . . D:$D(FLD("IEN4",1)) CANFLD
 . . . . . S FLD("CANRS")=RCR,FLD("CANCOM")=RCC
 . . . . . S FLD("RRLOC")=$TR(FLD("RRLOC"),",",""),FLD("RRSTE")=$TR(FLD("RRSTE"),",","")
 . . . . . S ^TMP("DVBREQ",$J,CNT,DVBIEN)=FLD("SS")_DVBAD_""""_FLD("NM")_""""_DVBAD_FLD("REQDT")_DVBAD_FLD("RELDT")_DVBAD_""""_FLD("PRTDT")_""""_DVBAD
 . . . . . S ^TMP("DVBREQ",$J,CNT,DVBIEN)=^TMP("DVBREQ",$J,CNT,DVBIEN)_""""_FLD("RS")_""""_DVBAD_FLD("CANDT")_DVBAD_""""_FLD("RO")_""""_DVBAD
 . . . . . S ^TMP("DVBREQ",$J,CNT,DVBIEN)=^TMP("DVBREQ",$J,CNT,DVBIEN)_""""_FLD("CANRS")_""""_DVBAD_FLD("CANCOM")_DVBAD_""""_FLD("DVBCTW")_""""_DVBAD
 . . . . . S ^TMP("DVBREQ",$J,CNT,DVBIEN)=^TMP("DVBREQ",$J,CNT,DVBIEN)_""""_FLD("DVBSCWA")_""""_DVBAD_FLD("RRDTE")_DVBAD_""""_FLD("RRLOC")_""""_DVBAD
 . . . . . S ^TMP("DVBREQ",$J,CNT,DVBIEN)=^TMP("DVBREQ",$J,CNT,DVBIEN)_""""_FLD("RRSTE")_""""_DVBAD
 . . . . . S CNT=CNT+1
 Q
CANFLD ;
 N RS1,RC1,RRCR,RRCC
 S DVBX=0
 F  S DVBX=$O(FLD("IEN4",DVBX)) Q:'DVBX  D
 . S RS1=FLD("CANRS",DVBX),RC1=FLD("CANCOM",DVBX)
 . S RS1=$E(RS1,1,50),RC1=$E(RC1,1,50)
 . I RS1'="",'$D(RRCR(RS1)) S RRCR(RS1)=""
 . I RC1'="",'$D(RRCC(RC1)) S RRCC(RC1)=""
 S (RCR,RS1)="" F  S RS1=$O(RRCR(RS1)) Q:RS1=""  S RCR=$S(RCR="":RS1,1:RCR_"^"_RS1)
 S (RCC,RC1)="" F  S RC1=$O(RRCC(RC1)) Q:RC1=""  S RCC=$S(RCC="":RC1,1:RCC_"^"_RC1)
 S RCC=$TR(RCC,",","")
 I $L(RCR)>40 S RCR="*"_$E(RCR,1,40)
 I $L(RCC)>40 S RCC="*"_$E(RCC,1,40)
 Q
 ;
SETFLDS(DVBIEN,DVBFLDS) ;build field array in external format
 ;This function formats the collected record data in external format
 ;and returns the results TRUE and an array on success.  Otherwise,
 ;the function returns FALSE.
 ;
 ;  Integration Reference #10061 - DEM^VADPT
 ;
 ;  Input:
 ;    DVBIEN - 2507 REQUEST IEN
 ;    DVBFLDS - field array passed by reference
 ;
 ;  Output:
 ;    DVBFLDS("IEN") - 2507 REQUEST IEN
 ;    DVBFLDS("NM") - patient name
 ;    DVBFLDS("SS") - social security number
 ;    DVBFLDS("RS") - request status
 ;    DVBFLDS("REQDT") - request date
 ;    DVBFLDS("RELDT") - release date
 ;    DVBFLDS("PRTDT") - print date
 ;    DVBFLDS("CANDT") - canceled date
 ;    DVBFLDS("RO") - regional office
 ;    DVBFLDS("IREQDT") - request date in internal FM format
 ;    DVBFLDS("EXAM") - added with patch DVB*2.7*189; HOLDS THE 2507 EXAM name   
 ;    DVBFLDS("CANRS") - added with patch DVB*2.7*189; HOLDS THE 2507 EXAM CANCELLATION REASON name
 ;    DVBFLDS("CANCOM") - added with patch DVB*2.7*189; HOLDS THE 2507 EXAM CANCELLATION COMMENTS name
 ;GRE add re-route fields
 ;    DVBFLDS("RRDATE") - added with patch DVBA*2.7*193 holds the 2507 Re-Route Date
 ;    DVBFLDS("RRSITE") - added with patch DVBA*2.7*193 holds the 2507 Re-Route Site
 ;    DVBFLDS("RRLOC")  - added with patch DVBA*2.7*193 holds the 2507 Re-Route Location
 ;    Function Result - return 1 on success; otherwise returns 0
 ;
 N DFN  ;PATIENT file IEN used in VADPT call
 N DVBDAT  ;2507 REQUEST data field array
 N DVBIENS  ;FM IENS value
 N DVBRSLT  ;function result
 N VADM  ;VADPT return array
 N DVBIEN4 ;the IEN FROM 2507 EXAM FILE 396.4
 N DVBALAST ;number of lines in the wp cancellation comments
 N DVBAI  ;for loop index
 N DVBAX ;
 K DVBFLDS
 S (RRDATE,RRFRMSITE,RRTOSITE)=""
 S DVBRSLT=0
 S DVBIENS=+$G(DVBIEN)_","
 D GETS^DIQ(396.3,DVBIENS,".01;1;2;13;15;17;19","IE","DVBDAT","")
 S DFN=$G(DVBDAT(396.3,DVBIENS,.01,"I"))
 D DEM^VADPT
 I $G(VADM(1))'="" D  ;only return record when name is resolved
 . S DVBFLDS("IEN")=DVBIEN
 . S DVBFLDS("NM")=$G(VADM(1))
 . S DVBFLDS("SS")=$S(DVBDELIM:$P($G(VADM(2)),U,2),1:$P($G(VADM(2)),U,1))
 . S DVBFLDS("RS")=$G(DVBDAT(396.3,DVBIENS,17,"E"))
 . S DVBFLDS("REQDT")=$$FMTE^XLFDT($G(DVBDAT(396.3,DVBIENS,1,"I")),"5DZ")
 . S DVBFLDS("RELDT")=$$FMTE^XLFDT($G(DVBDAT(396.3,DVBIENS,13,"I")),"5DZ")
 . S DVBFLDS("PRTDT")=$$FMTE^XLFDT($G(DVBDAT(396.3,DVBIENS,15,"I")),"5DZ")
 . S DVBFLDS("CANDT")=$$FMTE^XLFDT($G(DVBDAT(396.3,DVBIENS,19,"I")),"5DZ")
 . S DVBFLDS("RO")=$G(DVBDAT(396.3,DVBIENS,2,"E"))
 . D CLAIMTYP,SPEC,GETRRDAT
 . S DVBFLDS("DVBCTW")=DVBCTW
 . S DVBFLDS("DVBSCWA")=DVBSCWA
 . S DVBFLDS("RRDTE")=RRDATE
 . S DVBFLDS("RRSTE")=RRFRMSITE
 . S DVBFLDS("RRLOC")=RRTOSITE
 . S DVBXCNT=1
 . S (DVBFLDS("CANRS",DVBXCNT),DVBFLDS("CANCOM",DVBXCNT),DVBFLDS("IEN4"))=""
 . S DVBIEN4=0 F  S DVBIEN4=$O(^DVB(396.4,"C",DVBIEN,DVBIEN4)) Q:'DVBIEN4  D
 . . I $D(^DVB(396.4,DVBIEN4,"CAN")) D
 . . . S DVBAY=($P($P(^DVB(396.4,DVBIEN4,"CAN"),"^",1),".",1)) I DVBAY>(DVBSDAT-1)&DVBAY<(DVBEDAT+1) D
 . . . . S DVBFLDS("CANRS",DVBXCNT)=$$GET1^DIQ(396.4,DVBIEN4,52)
 . . . . I $D(^DVB(396.4,DVBIEN4,5)) D
 . . . . . S DVBFLDS("IEN4",DVBXCNT)=DVBIEN4
 . . . . . K WP S DVBAX=$$GET1^DIQ(396.4,DVBIEN4,53,"Z","WP") ; this puts the wordprocessing field into an array 'WP(#,0)=' next it gets put into one entry of the DVBFLDS ARRAY so we can handle any comma's that aren't delimiters
 . . . . . ;DVBALAST gets the number of WP lines to loop through in the for loop
 . . . . . S DVBALAST=$P(^DVB(396.4,DVBIEN4,5,0),U,3) S DVBAI="",DVBFLDS("CANCOM",DVBXCNT)=WP(1,0)
 . . . . . F DVBAI=1:1:DVBALAST S DVBFLDS("CANCOM",DVBXCNT)=DVBFLDS("CANCOM",DVBXCNT)_" "_WP(DVBAI,0) Q:$L(DVBFLDS("CANCOM",DVBXCNT))>150
 . . . . . ;S DVBALAST=$P(^DVB(396.4,DVBIEN4,5,0),U,3) S DVBAI="" F DVBAI=1:1:DVBALAST S DVBFLDS("CANCOM",DVBAI)=WP(DVBAI,0)
 . . . . . S DVBXCNT=DVBXCNT+1
 . S DVBFLDS("IREQDT")=$G(DVBDAT(396.3,DVBIENS,1,"I"))
 . S DVBRSLT=1
 Q DVBRSLT
 ;
DELIMHDR(EXSDAT,EXEDAT,EXSTAT) ;output delimited format header
 ;  Input:
 ;    EXSDAT - start date (external format)
 ;    EXEDAT - end date (external format)
 ;    EXSTAT - request status (external format)
 ; GRE ; added re-route status information to the report
 S ^TMP("DVBREQH",$J,DVBCNT)="Request Status by Date Range Report",DVBCNT=DVBCNT+1
 S ^TMP("DVBREQH",$J,DVBCNT)="Date Range: "_EXSDAT_" - "_EXEDAT,DVBCNT=DVBCNT+1
 S ^TMP("DVBREQH",$J,DVBCNT)=""""_"Request Status: "_EXSTAT_""""_$C(13),DVBCNT=DVBCNT+1
 S ^TMP("DVBREQH",$J,DVBCNT)="SSN"_DVBAD_"PatientName"_DVBAD_"RequestDT"_DVBAD_"DTReleased"_DVBAD_"DTPrinted"_DVBAD_"RequestStatus"_DVBAD_"DtCanceled"_DVBAD_"Station"_DVBAD_"Cancellation Reason"_DVBAD_"Cancellation Comments"_DVBAD
 S ^TMP("DVBREQH",$J,DVBCNT)=^TMP("DVBREQH",$J,DVBCNT)_"Claim Type"_DVBAD_"Special Consideration(s)"_DVBAD_"Re-Route Date"_DVBAD_"Re-Route To Site"_DVBAD_"Re-Route From Site",DVBCNT=DVBCNT+1
 Q
 ;
DELIM ;output delimited format
 ;
 N DVBI     ;generic counter
 N DVBREQ   ;request record
 ;
 U IO
 S DVBI=0 F  S DVBI=$O(^TMP("DVBREQH",$J,DVBI)) Q:'DVBI  D
 . S DVBREQH=^TMP("DVBREQH",$J,DVBI)
 . W !,DVBREQH
 S DVBI2=0 F  S DVBI2=$O(^TMP("DVBREQ",$J,DVBI2)) Q:'DVBI2  D
 . S DVBIEN=0 F  S DVBIEN=$O(^TMP("DVBREQ",$J,DVBI2,DVBIEN)) Q:'DVBIEN  D
 . . S DVBREQL2=^TMP("DVBREQ",$J,DVBI2,DVBIEN)
 . . W !,DVBREQL2
 . . S DVBI22=0 F  S DVBI22=$O(^TMP("DVBREQ",$J,DVBI2,DVBIEN,DVBI22)) Q:'DVBI22  D
 . . . S DVBREQL3=^TMP("DVBREQ",$J,DVBI2,DVBIEN,DVBI22)
 . . . W !,DVBREQL3
 ;
 Q
 ;
PLAINHDR(EXSDAT,EXEDAT,EXSTAT)  ;output plain text header
 ;Populate the header information.
 ;CAUTION:  The CAPRI GUI pulls this information to populate the header
 ;for each page when creating a printed report.  Do not modify the
 ;content or line count of the header information without validating
 ;against the CAPRI GUI interface.
 ;
 ;CAPRI GUI to populate 
 ;  Input:
 ;    EXSDAT - start date (external format)
 ;    EXEDAT - end date (external format)
 ;    EXSTAT - request status (external format)
 ;
 ; N DVBLINE  ;header separator
 ;
 U IO
 ;S $P(DVBLINE,"-",131)=""
 W !,"Date Range: "_EXSDAT_" - "_EXEDAT
 W !,"Request Status: ",EXSTAT
 W !,"-----------------------------------------------------------------------------------------------"
 Q
 ;
PLAIN ;output plain text format
 ;Output formatted text format.  The patient name and station nameC
 ;are truncated at 20 characters to maintain 132 character report.
 ;
 N DVBI     ;generic counter
 N DVBREQ   ;request record
 U IO
 S DVBI=0
 F  S DVBI=$O(^TMP("DVBREQ",$J,DVBI)) Q:'DVBI  D
 . S DVBIEN=0 F  S DVBIEN=$O(^TMP("DVBREQ",$J,DVBI,DVBIEN)) Q:'DVBIEN  D
 . . S DVBREQ=^TMP("DVBREQ",$J,DVBI,DVBIEN)
  . . D GETRRDAT
 . . W !,DVBLINE
 . . W !,"SSN:",?14,$P(DVBREQ,U,2)
 . . W !,"PATIENT NAME:",?14,$E($P(DVBREQ,U,3),1,20)
 . . W !,"REQUEST DT:",?14,$P(DVBREQ,U,4)
 . . W !,"DT RELEASED:",?14,$P(DVBREQ,U,5)
 . . W !,"DT PRINTED:",?14,$P(DVBREQ,U,6)
 . . W !,"STATUS:",?14,$P(DVBREQ,U,7)
 . . W !,"DT CANCELED:",?14,$P(DVBREQ,U,8)
 . . D CLAIMTYP,SPEC
 . . W !,"CLAIM TYPE: ",DVBCTW
 . . W !,"SPECIAL CONSIDERATION(S):",DVBSCWA
 . . W !,"RE-ROUTE DATE:",RRDATE
 . . W !,"RE-ROUTE FROM SITE:",RRFRMSITE
 . . W !,"RE-ROUTE TO SITE:",RRTOSITE
 . . S DVBIEN4=0 F  S DVBIEN4=$O(^DVB(396.4,"C",DVBIEN,DVBIEN4)) Q:'DVBIEN4  D
 . . . I $D(^DVB(396.4,DVBIEN4,"CAN")) D
 . . . . S DVBAY=($P($P(^DVB(396.4,DVBIEN4,"CAN"),"^",1),".",1)) I DVBAY>(DVBSDAT-1)&DVBAY<(DVBEDAT+1) D
 . . . . . S DVBCNRS=$$GET1^DIQ(396.4,DVBIEN4,52) D
 . . . . . I DVBCNRS'="" D  W !,"CANCELLATION REASON:",?14,DVBCNRS
 . . . . . .;W !,"CANCELLATION REASON:",?14,DVBCNRS
 . . . . . I $D(^DVB(396.4,DVBIEN4,5)) D
 . . . . . . K ^UTILITY($J,"W")
 . . . . . . W !,"CANCELLATION COMMENTS:",?14 F LINE=0:0 S LINE=$O(^DVB(396.4,DVBIEN4,5,LINE)) Q:LINE=""  S X=^(LINE,0),DIWL=5,DIWR=75,DIWF="NW" D ^DIWP
 Q 
 ;
GETRECSN(RSTAT,DVBCNT) ;collect 2507 REQUEST status matches and ignore date range
 ;This procedure collects all 2507 REQUEST records that have a REQUEST STATUS
 ;that matches the input request status parameter regardless of the LAST
 ;STATUS CHANGE DATE range.  The procedure uses the "AF" index which sorts
 ;by REQUEST STATUS and REGIONAL OFFICE.
 ;
 ;  Input:
 ;    RSTAT - request status (internal format)
 ;    DVBCNT - record count (passed by reference)
 ;
 ;
 N DVBIEN  ;2507 REQUEST IEN
 N FLD     ;field array in external format
 N DVBRO   ;regional office
 S DVBRO=0,DVBCNT=0 F  S DVBRO=$O(^DVB(396.3,"AF",RSTAT,DVBRO)) Q:'DVBRO  D
 . S DVBIEN=0
 . F  S DVBIEN=$O(^DVB(396.3,"AF",RSTAT,DVBRO,DVBIEN)) Q:'DVBIEN  D
 . . K FLD
 . . I $$SETFLDS(DVBIEN,.FLD) D
 . . . S DVBXCNT=1
 . . . I $G(DVBAD)'="," D
 . . . . S ^TMP("DVBREQ",$J,DVBCNT,DVBIEN)=FLD("IEN")_U_FLD("SS")_U_FLD("NM")_U_FLD("REQDT")_U_FLD("RELDT")_U_FLD("PRTDT")_U_FLD("RS")_U_FLD("CANDT")_U_FLD("RO")_U_FLD("CANRS",DVBXCNT)_U_FLD("CANCOM",DVBXCNT)_U
 . . . . S ^TMP("DVBREQ",$J,DVBCNT,DVBIEN)=^TMP("DVBREQ",$J,DVBCNT,DVBIEN)_FLD("DVBCTW")_U_FLD("DVBSCWA")
 . . . . S DVBCNT=DVBCNT+1,DVBXCNT=DVBXCNT+1
 . . . I $G(DVBAD)="," D
 . . . . S (RCC,RCR)=""
 . . . . D:$D(FLD("IEN4",1)) CANFLD
 . . . . S FLD("CANRS")=RCR,FLD("CANCOM")=RCC
 . . . . S FLD("RRLOC")=$TR(FLD("RRLOC"),",",""),FLD("RRSTE")=$TR(FLD("RRSTE"),",","")
 . . . . S ^TMP("DVBREQ",$J,DVBCNT,DVBIEN)=FLD("SS")_DVBAD_""""_FLD("NM")_""""_DVBAD_FLD("REQDT")_DVBAD_FLD("RELDT")_DVBAD_""""_FLD("PRTDT")_""""_DVBAD
 . . . . S ^TMP("DVBREQ",$J,DVBCNT,DVBIEN)=^TMP("DVBREQ",$J,DVBCNT,DVBIEN)_""""_FLD("RS")_""""_DVBAD_FLD("CANDT")_DVBAD_""""_FLD("RO")_""""_DVBAD
 . . . . S ^TMP("DVBREQ",$J,DVBCNT,DVBIEN)=^TMP("DVBREQ",$J,DVBCNT,DVBIEN)_""""_FLD("CANRS")_""""_DVBAD_FLD("CANCOM")_DVBAD_""""_FLD("DVBCTW")_""""_DVBAD
 . . . . S ^TMP("DVBREQ",$J,DVBCNT,DVBIEN)=^TMP("DVBREQ",$J,DVBCNT,DVBIEN)_""""_FLD("DVBSCWA")_""""_DVBAD_FLD("RRDTE")_DVBAD_""""_FLD("RRSTE")_""""_DVBAD
 . . . . S ^TMP("DVBREQ",$J,DVBCNT,DVBIEN)=^TMP("DVBREQ",$J,DVBCNT,DVBIEN)_""""_FLD("RRLOC")_""""_DVBAD
 . . . . S DVBCNT=DVBCNT+1
 ;load output global with sorted list
 S CHGDAT="",CNT=0  ;use "" because value could be zero ("0")
 F  S CHGDAT=$O(^TMP("DVBREQN",$J,CHGDAT)) Q:(CHGDAT="")  D
 . S DVBIEN=0
 . F  S DVBIEN=$O(^TMP("DVBREQN",$J,CHGDAT,DVBIEN)) Q:'DVBIEN  D
 . . S CNT=CNT+1
 . . S ^TMP("DVBREQ",$J,CNT)=^TMP("DVBREQN",$J,CHGDAT,DVBIEN)
 Q
 ;
CLAIMTYP ;THE CLAIM TYPE OF A 2507 REQUEST
 S DVBCTW=""
 Q:'$D(^DVB(396.3,DVBIEN,9,0))
 ;DVBIEN is the 2507 REQUEST FILE IEN
 ;DVBCTW is the string /name of the CLAIM TYPE
 D GETS^DIQ(396.3,DVBIEN_",","9.1*","E","MSG","ERR")
 S DVBCTW=$G(MSG("396.32","1,"_DVBIEN_",",".01","E"))
 Q
 ;
SPEC ;SPECIAL CONSIDERATION(S) FOR A 2507 REQUEST
 K DVBSCW
 S DVBSCWA=""
 N DVBX
 ;DVBIEN is the 2507 REQUEST FILE IEN
 ;DVBSC is a the SPECIAL CONSIDERATION entry for the 2507 REQUEST
 ;DVBSCN is the pointer number to the SPECIAL CONSIDERATION file 396.25
 ;DVBSCW is the string /name of the SPECIAL CONSIDERATION
 Q:'$D(^DVB(396.3,DVBIEN,8,0))
 S DVBAA=$P(^DVB(396.3,DVBIEN,8,0),U,4)
 S (DVBSC,DVBCNT)=0 F  S DVBSC=$O(^DVB(396.3,DVBIEN,8,DVBSC)) Q:'DVBSC  D
 .S DVBSCN=$P(^DVB(396.3,DVBIEN,8,DVBSC,0),U,1)
 .S DVBSCW(DVBSC)=$G(^DVB(396.25,DVBSCN,0))
 .S DVBCNT=DVBCNT+1
 .I (DVBCNT'=DVBAA) S:$D(DVBSCW(DVBSC)) DVBSCW(DVBSC)=DVBSCW(DVBSC)_","
 S DVBX="" F  S DVBX=$O(DVBSCW(DVBX)) Q:'DVBX  S DVBSCWA=DVBSCWA_DVBSCW(DVBX)
 Q
 ;
GETRRDAT ;GRE Input=IEN , get re-route date, to and from site and re-route status
 S (RRDATE,RRTOSITE,RRFRMSITE,RRSTATDTE)=""
 Q:'$D(^DVB(396.3,DVBIEN,6,0)) 
  ; quit if no re-route data found
 K RRIENINC,RRSTATINC,RRSTAT,RRDATE,RRTOSITE,RRFRMSITE,RRSTATDTE
 S (RRIENINC,RRSTATINC)=0
 F  S RRIENINC=$O(^DVB(396.3,DVBIEN,6,RRIENINC)) Q:RRIENINC="B"  D
 . S RRFRMSITE=$$EXTERNAL^DILFD(396.34,.02,,$P(^DVB(396.3,DVBIEN,6,RRIENINC,0),U,4))
 . S RRDATE=$$FMTE^XLFDT($P(^DVB(396.3,DVBIEN,6,RRIENINC,0),U,1),"5DZ")
 . S RRTOSITE=$$EXTERNAL^DILFD(396.34,.02,,$P(^DVB(396.3,DVBIEN,6,RRIENINC,0),U,7))
 . S RRSTATINC=0
 . F  S RRSTATINC=$O(^DVB(396.3,DVBIEN,6,RRIENINC,RRSTATINC)) Q:RRSTATINC=""  D
 . . Q:'$D(^DVB(396.3,DVBIEN,6,RRIENINC,RRSTATINC,0))
 . . S RRSTATDTE=$$FMTE^XLFDT($P(^DVB(396.3,DVBIEN,6,RRIENINC,RRSTATINC,0),U,1),"5DZ")
 . . S RRSTAT=$$EXTERNAL^DILFD(396.341,1,,$P(^DVB(396.3,DVBIEN,6,RRIENINC,RRSTATINC,0),U,2))
 Q
 ;
