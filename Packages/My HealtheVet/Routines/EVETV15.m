EVETV15 ;;DALOI/DS - Extraction procedures for MICROBIOLOGY data to be stored on eVault ; 12/3/02 10:00am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 ; usage of GMTSLRME supported by subscription to IA# ????
 ; usage of MICRO^ORWLRR supported by subscription to IA# ????
 ;
GET(EVETDFN,EVSDAT,EVREQID) ;
 ; Microbiology extract
 ; EVETDFN - Pat DFN
 ; EVDSDAT - Start date of extract
 ; EVREQID - Request id
 ;debug requirement due to data inconsistency
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 S DUZ("AG")=""
 N LRDFN,EVCNT,EVX,EVTMP,IX,EVACCNO,GMTS1,GMTS2
 S LRDFN=$G(^DPT(EVETDFN,"LR"))
 I LRDFN="" D  Q
 . S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"START_Lab_Microbiology")=""
 . S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"END_Lab_Microbiology")=""
 . Q
 S GMTS2=(9999999-EVSDAT)+0.000001
 S GMTS1=(9999999-$$NOW^XLFDT())-0.000001
 S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"START_Lab_Microbiology")=""
 S EVCNT=EVCNT+1
 S EVX=GMTS1
 F  S EVX=$O(^LR(LRDFN,"MI",EVX)) Q:(EVX="")!(EVX>GMTS2)  D
 . S IX=EVX
 . D ^GMTSLRME  ;retrieve values for one report
 . S EVTMP=$G(^TMP("LRM",$J,0))
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"ien")=LRDFN_EVX
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"collection_date")=$$XMLDATE^EVETU1(9999999-EVX)
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"sample")=$P(EVTMP,"^",6)
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"specimen")=$P(EVTMP,"^",3)
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"case_num")=$P(EVTMP,"^",2)
 . S EVACCNO=$P(EVTMP,"^",2)
 . D GETTEXT  ;retrieve formatted report data
 . S EVCNT=EVCNT+1
 . Q
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"END_Lab_Microbiology")=""
 Q
GETTEXT ;retrieve text for the report using MICRO^ORWLRR
 ;EVX is the transaction date/time. .000001 offset to bracket the
 ;target time.
 N EVN,EVI,V1,EVD1,EVD2,CRLF
 S CRLF=" "_$C(10)_$C(13)
 S EVD1=9999999-EVX-0.000001,EVD2=9999999-EVX+0.000001
 S EVN="",V1=""
 D MICRO^ORWLRR(.V1,EVETDFN,EVD2,EVD1)
 ;locate correct report in list of reports
 F EVI=1:1 D  Q:EVN'=""
 . I ^TMP("LR7OGX",$J,"OUTPUT",EVI)[EVACCNO S EVN=EVI-2 Q
 . Q
 ;extract report lines
 F  S EVN=$O(^TMP("LR7OGX",$J,"OUTPUT",EVN)) Q:EVN=""  D
 . I $E(^TMP("LR7OGX",$J,"OUTPUT",EVN),1,2)="==" S EVN=999999 Q
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"report",EVN)=^TMP("LR7OGX",$J,"OUTPUT",EVN)_CRLF
 . Q
 Q
