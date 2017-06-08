EVETV4 ;DALOI/KML - Extraction procedures for PROGRESS NOTES data to be stored on eVault ; 12/3/02 9:57am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 Q
 ; usage of MAIN^TIULAPIC supported by subscription to IA #2902
 ;
 ; EVETDFN       = DFN (ien of PATIENT file (#2)
 ; EVBDATE       = FileMan date at which to begin data extraction
 ; EVREQID       = REQUEST ID REPRESENTING MESSAGE IDENTIFIER RECEIVED
 ;                 FROM HEALTH EVET
 ; EVTIUDOC      = TIU document class, IEN of the TIU DOCUMENT 
 ;                 DEFINITION file (#8925.1)
 ; EVTIME1,2     = FileMan dates to pass TIU API
 ;
GET(EVETDFN,EVBDATE,EVREQID) ;
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVRTN,EVTMPGBL,EVCNT,EVETI3,EV8925DA,EVETIX,EVTIUDOC,EVCRLF,EVTIME1,EVTIME2
 S EVCRLF=" "_$C(10)_$C(13)
 S EVRTN="EVETLIS"
 S EVTMPGBL="^TMP(EVRTN,$J,EVREQID,EVCNT)"
 S EVCNT=$O(^TMP(EVRTN,$J,EVREQID,""),-1)+1
 S @EVTMPGBL@("START_Progress_Notes")=""
 S EVCNT=EVCNT+1,EVTIME2=9999999-EVBDATE,EVTIME1=9999999-DT
 S EVTIUDOC=3  ; IEN of the PROGRESS NOTES document class definition
 D PROGNTS
 S @EVTMPGBL@("END_Progress_Notes")=""
 Q
 ;
PROGNTS ;
 D MAIN^TIULAPIC(EVETDFN,EVTIUDOC,EVTIME1,EVTIME2,"",1)
 ; available progress note data is built into TMP global by the TIU utilities
 Q:'$D(^TMP("TIU",$J))  ; no record found
 S (EVETI3,EV8925DA)=""
 F  S EVETI3=$O(^TMP("TIU",$J,EVETI3)) Q:EVETI3=""  F  S EV8925DA=$O(^TMP("TIU",$J,EVETI3,EV8925DA)) Q:EV8925DA<1  D BLDTMP
 Q
 ;
BLDTMP ; construct EVET temporary global 
 I $G(^TMP("TIU",$J,EVETI3,EV8925DA,.05,"E"))'="COMPLETED" Q
 S @EVTMPGBL@("ien")=EV8925DA
 S @EVTMPGBL@("document_type")=($G(^TMP("TIU",$J,EVETI3,EV8925DA,.01,"E")))
 S @EVTMPGBL@("status")=($G(^TMP("TIU",$J,EVETI3,EV8925DA,.05,"E")))
 S @EVTMPGBL@("start_date_time")=$$XMLDATE^EVETU1($G(^TMP("TIU",$J,EVETI3,EV8925DA,.07,"I")))
 S @EVTMPGBL@("end_date_time")=$$XMLDATE^EVETU1($G(^TMP("TIU",$J,EVETI3,EV8925DA,.08,"I")))
 S @EVTMPGBL@("dictated_by")=$G(^TMP("TIU",$J,EVETI3,EV8925DA,1202,"E"))
 S @EVTMPGBL@("hospital_location")=$G(^TMP("TIU",$J,EVETI3,EV8925DA,1205,"E"))
 S @EVTMPGBL@("approved_by")=$G(^TMP("TIU",$J,EVETI3,EV8925DA,1209,"E"))
 S @EVTMPGBL@("treating_specialty")=$G(^TMP("TIU",$J,EVETI3,EV8925DA,1402,"E"))
 S EVETIX=0 F  S EVETIX=$O(^TMP("TIU",$J,EVETI3,EV8925DA,"TEXT",EVETIX)) Q:EVETIX<1  S @EVTMPGBL@("notes",EVETIX)=^(EVETIX,0)_EVCRLF
 S EVCNT=EVCNT+1
 ;
 Q
