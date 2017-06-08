EVETV12 ;;DALOI/DS - Extraction procedures for CYTOLOGY data to be stored on eVault ; 12/3/02 9:59am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 ;usage of GMTSLRPE supported by subscription to IA# 2770
 ;
GET(EVETDFN,EVSDAT,EVREQID) ;
 ; Lab Cytology Extract
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVX,EVCNT,LRDFN,GMTS1,GMTS2,EVCRLF,MAX,EVTMP
 S EVCRLF=" "_$C(10)_$C(13)
 S LRDFN=$G(^DPT(EVETDFN,"LR"))
 I LRDFN="" D  Q
 . S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"START_Lab_Cytology")=""
 . S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"END_Lab_Cytology")=""
 . Q
 S MAX=99999
 S GMTS2=9999999-EVSDAT
 S GMTS1=9999999-$$NOW^XLFDT()
 D ^GMTSLRPE
 S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"START_Lab_Cytology")=""
 S EVCNT=EVCNT+1
 S EVX=""
 F  S EVX=$O(^TMP("LRCY",$J,EVX)) Q:EVX=""  D
 . S EVTMP=$G(^TMP("LRCY",$J,EVX,0))
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"ien")=$TR(EVTMP,"&<>","")
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"date_time_spec_taken")=$$XMLDATE^EVETU1(9999999-EVX)
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"accession_number")=$P(EVTMP,"^",2)
 . D GETWP("specimen_text","1")
 . D GETWP("brief_clin_history","AH")
 . D GETWP("gross_description_text","G")
 . D GETWP("micro_exam_text","MI")
 . D GETWP2("supplemental_report_text","SR")
 . D GETWP("cytology_diagnosis","NDX")
 . S EVCNT=EVCNT+1
 . Q
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"END_Lab_Cytology")=""
 Q
GETWP(EVTY,EVNUM) ;
 N EVN
 S EVN=0
 F  S EVN=$O(^TMP("LRCY",$J,EVX,EVNUM,EVN)) Q:EVN=""  D
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,EVTY,EVN)=^TMP("LRCY",$J,EVX,EVNUM,EVN)_EVCRLF
 Q
 ;
GETWP2(EVTY,EVNUM) ;retrieve text at i,j node
 N EVN,EVNOUT,EVN2
 S EVN=0,EVNOUT=0
 F  S EVN=$O(^TMP("LRCY",$J,EVX,EVNUM,EVN)) Q:EVN=""  D
 . S EVN2=0
 . F  S EVN2=$O(^TMP("LRCY",$J,EVX,EVNUM,EVN,EVN2)) Q:EVN2=""  D
 . . S EVNOUT=EVNOUT+1
 . . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,EVTY,EVNOUT)=^TMP("LRCY",$J,EVX,EVNUM,EVN,EVN2)_EVCRLF
 . . Q
 . Q
 Q
