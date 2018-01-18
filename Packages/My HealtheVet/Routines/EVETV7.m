EVETV7 ;DALOI/DS - Extraction procedures for RADIOLOGY data to be stored on eVAult ; 12/3/02 9:58am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;; - Modified to pass report date -- 12/26/01 lel
 Q
 ;
 ; usage of EN1^RAO7PC1 supported by IA #2043 
 ;
 ; EVETDFN       = DFN (ien of PATIENT file (#2)
 ; EVBDATE       = FileMan date at which to begin data extraction
 ; EVREQID       = REQUEST ID REPRESENTING MESSAGE IDENTIFIER RECEIVED
 ;                 FROM HEALTH EVET
 ;
GET(EVDFN,HVSD,EVREQ)  ;
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVCRLF,EVCNT2,EVWPTX,TMPDT,EVCNT,EVTEMP,EVRIEN,HVDAT
 S EVCNT2=0
 S EVCRLF=" "_$C(10)_$C(13)  ;provides line feeds within text blocks
 D EN1^RAO7PC1(EVDFN,HVSD,$$NOW^XLFDT(),9999)
 ; Now convert output
 S HVDAT=""
 S EVCNT=$O(^TMP("EVETLIS",$J,EVREQ,""),-1)+1
 S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"START_Radiology_Reports")=""
 S EVCNT=EVCNT+1
 F  S HVDAT=$O(^TMP($J,"RAE1",EVDFN,HVDAT)) Q:HVDAT=""  D
 . S TMPDT=9999999-$P(HVDAT,"-",1)
 . S EVTEMP=$G(^TMP($J,"RAE1",EVDFN,HVDAT))
 . S EVRIEN=$P(EVTEMP,"^",5)
 . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"ien")=EVDFN_HVDAT
 . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"report_date")=$$XMLDATE^EVETU1(TMPDT)
 . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"procedure")=$P(EVTEMP,"^",1)
 . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"case_num")=$P(EVTEMP,"^",2)
 . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"report_status")=$P(EVTEMP,"^",3)
 . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"exam_status")=$P(EVTEMP,"^",7)
 . I EVRIEN'="" D
 .. S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"resident_radiologist")=$$GET1^DIQ(74,EVRIEN_",",112)
 .. S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"staff_radiologist")=$$GET1^DIQ(74,EVRIEN_",",115)
 .. D GETWP(300)
 .. S EVCNT2=0
 .. S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"report",1)=""
 .. F EVWPTY=400,300,200 D GETWPRP(EVWPTY,"report")
 .. Q
 . S EVCNT=EVCNT+1
 . Q
 S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"END_Radiology_Reports")=""
 ;K ^TMP($J,"RAE1",PATDFN)
 Q
GETWP(EVF) ;Gets WP Field
 N EVT,EVWP,EVX
 S EVX=$$GET1^DIQ(74,EVRIEN_",",300,"","EVWP")
 ;create blank first line in case there is no report
 S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"report_impression",1)=EVCRLF
 S EVT="" F  S EVT=$O(EVWP(EVT)) Q:EVT=""  D
 . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"report_impression",EVT)=EVWP(EVT)_EVCRLF
 . Q
 Q
GETWPRP(EVWPTY,EVWPTX) ;extracts sections for full report text
 N EVCAT,EVT,EVWP,EVX
 S EVCAT=$S(EVWPTY=200:"REPORT TEXT:",EVWPTY=300:"IMPRESSION:",EVWPTY=400:"CLINICAL HISTORY:",1:"REPORT TEXT:")
 S EVX=$$GET1^DIQ(74,EVRIEN_",",EVWPTY,"","EVWP")
 I $D(EVWP)'=0 S EVCNT2=EVCNT2+1,^TMP("EVETLIS",$J,EVREQ,EVCNT,EVWPTX,EVCNT2)=EVCAT_EVCRLF
 S EVT="" F  S EVT=$O(EVWP(EVT)) Q:EVT=""  D
 . Q:EVWP(EVT)=""     ;do not write blank lines
 . S EVCNT2=EVCNT2+1
 . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,EVWPTX,EVCNT2)=EVWP(EVT)_EVCRLF
 . Q
 Q
