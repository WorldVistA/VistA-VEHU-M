EVETV3 ;DALOI/KML - Extraction procedures for appointment data to be stored on eVault ; 9/26/03 7:10am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 Q
 ; use of SDA^VADPT supported by IA# 10061
 ; EVETDFN       = DFN (ien of PATIENT file (#2)
 ; EVBDATE       = FileMan date at which to begin data extraction
 ; EVREQID       = REQUEST ID REPRESENTING MESSAGE IDENTIFIER RECEIVED
 ;                 FROM HEALTH EVET
 ;
 ;
GET(EVETDFN,EVBDATE,EVREQID) ; return appts for a patient between beginning and end dates for all clinics
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVRTN,VASD,EVNUM,EVINT,EVEXT,DFN,EVCNT,EVTMPGBL,EVEDATE
 S EVNUM=0
 S EVRTN="EVETLIS"
 S EVTMPGBL="^TMP(EVRTN,$J,EVREQID,EVCNT)"
 S EVCNT=$O(^TMP(EVRTN,$J,EVREQID,""),-1)+1
 S @EVTMPGBL@("START_Appointments")=""
 S EVCNT=EVCNT+1
 S:EVBDATE']"" EVBDATE="T-60"  ;default start date across all clinics TODAY - 60 days
 S EVEDATE="T+3650" ;default end date across all clinics is today +10 years
 ;CONVERT DATES INTO FILEMAN DATE/TIME
 D DT^DILF("T",EVBDATE,.EVBDATE,"","")
 D DT^DILF("T",EVEDATE,.EVEDATE,"","")
 I (EVBDATE=-1)!(EVEDATE=-1) Q  ;S Y(1)="^Error in date range." Q 
 S VASD("F")=EVBDATE
 S VASD("T")=$P(EVEDATE,".")_.5  ;ADD 1/2 DAY TO END DATE
 D APPTS
 S @EVTMPGBL@("END_Appointments")=""
 Q
 ;
APPTS ;
 S DFN=EVETDFN D SDA^VADPT
 ;I VAERR S EVETERR="Record not found in PATIENT file",@EVTMPGBL@("error")=EVETERR,EVCNT=EVCNT+1 Q
 ;I '$D(^UTILITY("VASD",$J)) S EVETERR="No Appointments found",@EVTMPGBL@("error")=EVETERR,EVCNT=EVCNT+1 Q
 F  S EVNUM=$O(^UTILITY("VASD",$J,EVNUM)) Q:'EVNUM  D
 . S EVINT="",EVEXT=""
 . S:$D(^UTILITY("VASD",$J,EVNUM,"I"))'=0 EVINT=^UTILITY("VASD",$J,EVNUM,"I")
 . S:$D(^UTILITY("VASD",$J,EVNUM,"E"))'=0 EVEXT=^UTILITY("VASD",$J,EVNUM,"E")
 . S @EVTMPGBL@("appt_date_time")=$$XMLDATE^EVETU1($P(EVINT,U))
 . S @EVTMPGBL@("clinic")=$P(EVEXT,U,2)
 . S @EVTMPGBL@("status")=$P(EVEXT,U,3)
 . S @EVTMPGBL@("appt_type")=$P(EVEXT,U,4)
 . S @EVTMPGBL@("ien")=$P(EVINT,U)
 . S EVCNT=EVCNT+1
 Q
