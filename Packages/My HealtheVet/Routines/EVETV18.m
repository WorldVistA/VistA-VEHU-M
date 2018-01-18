EVETV18 ;BP/LEL - Extraction procedures for REMINDER data to be stored on eVault ; 12/17/02 12:49pm
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 ;usage of PXRH supported by subscription to IA# ???
 ;
GET(EVETDFN,EVSDAT,EVREQID) ;
 ; Clinical Reminder Extract
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVX,EVCNT,EVCRLF,EVTODAY,EVTMP
 K ^TMP("PXRHM",$J)
 S EVTODAY=$P($$NOW^XLFDT,".",1)
 S EVCRLF=" "_$C(10)_$C(13)
 S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"START_Reminders")=""
 S EVCNT=EVCNT+1
 S EVX=0
 D EXTLOOP
 D BLDXML
 K ^TMP("PXRHM",$J)
 Q
EXTLOOP S EVX=$O(^PXD(811.9,EVX)) Q:EVX=""  Q:$E(EVX)?1A  D:$G(^PXD(811.9,EVX,31))'="" MAIN^PXRM(EVETDFN,EVX,5) G EXTLOOP
 ;
BLDXML ;create xml for each reminder to be sent
 N EVSTAT,EVSUBJ,EVDTD,EVDTL
 S EVX=0
 F  S EVX=$O(^TMP("PXRHM",$J,EVX)) Q:EVX=""  D
 . S EVSUBJ=""
 . S EVSUBJ=$O(^TMP("PXRHM",$J,EVX,EVSUBJ))
 . Q:EVSUBJ=""
 . S EVTMP=^TMP("PXRHM",$J,EVX,EVSUBJ),EVSTAT=$P(EVTMP,"^",1)
 . S EVDTD=$P(EVTMP,"^",2),EVDTL=$P(EVTMP,"^",3)
 . ;identify reminders not to send
 . Q:(EVSTAT="")!(EVSTAT="N/A")
 . Q:(EVSTAT="DONE")&($P(EVTMP,"^",2)="")
 . Q:(EVSTAT="RESOLVED")&($P(EVTMP,"^",2)="")
 . ;change txt date values to real dates
 . I EVDTD="DUE NOW" S EVDTD=EVTODAY
 . I EVDTL="unknown" S EVDTL=""
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"ien")=EVX
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"due_date")=$P($$XMLDATE^EVETU1(EVDTD),"T",1)
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"last_date_done")=$$XMLDATE^EVETU1(EVDTL)
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"subject")=EVSUBJ
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"status")=EVSTAT
 . D GETWP("notes","TXT")
 . S EVCNT=EVCNT+1
 . Q
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"END_Reminders")=""
 Q
GETWP(EVTY,EVNUM) ;
 N EVN
 S EVN=0
 F  S EVN=$O(^TMP("PXRHM",$J,EVX,EVSUBJ,EVNUM,EVN)) Q:EVN=""  D
 . ;do not write first line if blank (a space)
 . Q:(EVN=1)&(^TMP("PXRHM",$J,EVX,EVSUBJ,EVNUM,EVN)=" ")
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,EVTY,EVN)=^TMP("PXRHM",$J,EVX,EVSUBJ,EVNUM,EVN)_EVCRLF
 Q
