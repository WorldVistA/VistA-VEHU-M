EVETV16 ;BP/LEL - Extraction procedures for MICROSCOPY data to be stored on eVault ; 12/3/02 10:00am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 ;usage of GMTSLREE supported by subscription to IA# 2770
 ;
GET(EVETDFN,EVSDAT,EVREQID) ;
 ; Lab Microscopy Extract
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVX,EVCNT,LRDFN,GMTS1,GMTS2,EVCRLF,EVTMP,MAX
 S EVCRLF=" "_$C(10)_$C(13)
 S LRDFN=$G(^DPT(EVETDFN,"LR"))
 I LRDFN="" D  Q
 . S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"START_Lab_Microscopy")=""
 . S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"END_Lab_Microscopy")=""
 . Q
 S MAX=99999
 S GMTS2=9999999-EVSDAT
 S GMTS1=9999999-$$NOW^XLFDT()
 D ^GMTSLREE
 S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"START_Lab_Microscopy")=""
 S EVCNT=EVCNT+1
 S EVX=""
 F  S EVX=$O(^TMP("LREM",$J,EVX)) Q:EVX=""  D
 . S EVTMP=$G(^TMP("LREM",$J,EVX,0))
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"ien")=$TR(EVTMP,"&<>","")
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"collection_date")=$$XMLDATE^EVETU1(9999999-EVX)
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"case_num")=$P(EVTMP,"^",2)
 . D GETWP("site_specimen",".1")
 . D GETWP("gross_description","1")
 . D GETWP("microscopic_exam","1.1")
 . S EVCNT=EVCNT+1
 . Q
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"END_Lab_Microscopy")=""
 Q
GETWP(EVTY,EVNUM) ;
 N EVN
 S EVN=0
 Q:$D(^TMP("LREM",$J,EVX,EVNUM))=0
 F  S EVN=$O(^TMP("LREM",$J,EVX,EVNUM,EVN)) Q:EVN=""  D
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,EVTY,EVN)=^TMP("LREM",$J,EVX,EVNUM,EVN)_EVCRLF
 Q
