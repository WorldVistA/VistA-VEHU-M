EVETV6 ;DALOI/KML - Extraction procedures for DISCHARGE SUMMARY data to be stored on eVault ; 12/3/02 9:58am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ; LEL - extract COMPLETED reports only ; 11/1/02
 ;
 Q
 ;
 ; usage of MAIN^TIULAPIC supported by subscription to IA #2902
 ;
 ; EVETDFN       = DFN (ien of PATIENT file (#2)
 ; EVBDATE       = FileMan date at which to begin data extraction
 ; EVREQID       = REQUEST ID REPRESENTING MESSAGE IDENTIFIER RECEIVED
 ;                 FROM HEALTH EVET
 ; EVTIME        = FileMan date to pass TIU API
 ;
GET(EVETDFN,EVBDATE,EVREQID) ;
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVRTN,EVTMPGBL,EVCNT,EVETI3,EV8925DA,EVETIX,EVCRLF,EVTIME1,EVTIME2
 S EVCRLF=" "_$C(10)_$C(13)  ;space added to prevent crlf-crlf problems
 S EVRTN="EVETLIS"
 S EVTMPGBL="^TMP(EVRTN,$J,EVREQID,EVCNT)"
 S EVCNT=$O(^TMP(EVRTN,$J,EVREQID,""),-1)+1
 S @EVTMPGBL@("START_Discharge_Summaries")=""
 S EVCNT=EVCNT+1,EVTIME2=9999999-EVBDATE,EVTIME1=9999999-DT
 D DSCSUM
 S @EVTMPGBL@("END_Discharge_Summaries")=""
 Q
 ;
DSCSUM ;
 D MAIN^TIULAPIC(EVETDFN,244,EVTIME1,EVTIME2,"",1)
 ; available discharge summary data is built into TMP global by the TIU utilities
 Q:'$D(^TMP("TIU",$J))  ; no record found
 S (EVETI3,EV8925DA)=""
 F  S EVETI3=$O(^TMP("TIU",$J,EVETI3)) Q:EVETI3=""  F  S EV8925DA=$O(^TMP("TIU",$J,EVETI3,EV8925DA)) Q:EV8925DA<1  D BLDTMP
 Q
 ;
BLDTMP ; construct EVET temporary global 
 ; extract completed reports only
 I $G(^TMP("TIU",$J,EVETI3,EV8925DA,.05,"E"))'="COMPLETED" Q
 S @EVTMPGBL@("ien")=EV8925DA
 S @EVTMPGBL@("start_date_time")=$$XMLDATE^EVETU1($G(^TMP("TIU",$J,EVETI3,EV8925DA,.07,"I")))
 S @EVTMPGBL@("end_date_time")=$$XMLDATE^EVETU1($G(^TMP("TIU",$J,EVETI3,EV8925DA,.08,"I")))
 S @EVTMPGBL@("dictated_by")=$G(^TMP("TIU",$J,EVETI3,EV8925DA,1202,"E"))
 S @EVTMPGBL@("clinic")=$G(^TMP("TIU",$J,EVETI3,EV8925DA,1203,"E"))
 S @EVTMPGBL@("hospital_location")=$G(^TMP("TIU",$J,EVETI3,EV8925DA,1205,"E"))
 S @EVTMPGBL@("approved_by")=$G(^TMP("TIU",$J,EVETI3,EV8925DA,1209,"E"))
 S @EVTMPGBL@("treating_specialty")=$G(^TMP("TIU",$J,EVETI3,EV8925DA,1402,"E"))
 S EVETIX=0 F  S EVETIX=$O(^TMP("TIU",$J,EVETI3,EV8925DA,"TEXT",EVETIX)) Q:EVETIX<1  S @EVTMPGBL@("notes",EVETIX)=^(EVETIX,0)_EVCRLF
 S EVCNT=EVCNT+1
 Q
