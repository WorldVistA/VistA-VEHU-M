EVETV10 ;;DALOI/DS - Extraction procedures for SURGICAL PATHOLOGY data to be sto ; 12/3/02 9:59am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 ; usage of GMTSLRAE supported by subscription to IA# 2771
 ;
GET(EVETDFN,EVSDAT,EVREQID) ;
 ; Surgical Pathology extract
 ; EVETDFN - Pat DFN
 ; EVDSDAT - Start date of extract
 ; EVREQID - Request id
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N MAX,LRDFN,EVCNT,EVX,EVTMP,EVDT,X,Y,CRLF,GMTS1,GMTS2
 S CRLF=" "_$C(10)_$C(13)
 S LRDFN=$G(^DPT(EVETDFN,"LR"))
 I LRDFN="" D  Q
 . S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"START_Lab_Pathology")=""
 . S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"END_Lab_Pathology")=""
 . Q
 S MAX=99999
 S GMTS2=(9999999-EVSDAT)
 S GMTS1=(9999999-$$NOW^XLFDT())
 D ^GMTSLRAE
 S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"START_Lab_Pathology")=""
 S EVCNT=EVCNT+1
 S EVX=""
 F  S EVX=$O(^TMP("LRA",$J,EVX)) Q:EVX=""  D
 . S EVTMP=$G(^TMP("LRA",$J,EVX,0))
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"ien")=$TR(LRDFN_$P(EVTMP,"^",2),"$<>","")
 . S X=$P(EVTMP,"^",1)  ;NON STANDARD VA DATE IN MM/DD/YYYY FORMAT
 . D ^%DT ;CONVERT TO INTERNAL FORMAT USES X RETURNS Y
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"date_time_spec_taken")=$$XMLDATE^EVETU1(Y)
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"accession_number")=$P(EVTMP,"^",2)
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"specimen")=$G(^TMP("LRA",$J,EVX,.1))
 . D GETWP("brief_clin_hist",".2")
 . D GETWP("gross_desc",1)
 . D GETWP("microscopic_exam",1.1)
 . D GETWP2("supplementary_report_text",1.2)
 . D GETWP("frozen_section",1.3)
 . D GETWP("surgical_path_dx",1.4)
 . S EVCNT=EVCNT+1
 . Q
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"END_Lab_Pathology")=""
 Q
GETWP(EVTY,EVNUM) ;
 N EVN
 S EVN=0
 ;check for data at i,j level before processing
 S EVN=$O(^TMP("LRA",$J,EVX,EVNUM,EVN)) Q:EVN<1
 I $D(^TMP("LRA",$J,EVX,EVNUM,EVN))=10 D GETWP2(EVTY,EVNUM) Q
 ;if not i,j level, process at i level only
 S EVN=0
 F  S EVN=$O(^TMP("LRA",$J,EVX,EVNUM,EVN)) Q:EVN<1  D
 . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,EVTY,EVN)=^TMP("LRA",$J,EVX,EVNUM,EVN)_CRLF
 Q
GETWP2(EVTY,EVNUM) ;retrieve text at i,j node
 N EVN,EVNOUT,EVN2
 S EVN=0,EVNOUT=0
 F  S EVN=$O(^TMP("LRA",$J,EVX,EVNUM,EVN)) Q:EVN=""  D
 . S EVN2=0
 . F  S EVN2=$O(^TMP("LRA",$J,EVX,EVNUM,EVN,EVN2)) Q:EVN2=""  D
 . . S EVNOUT=EVNOUT+1
 . . S ^TMP("EVETLIS",$J,EVREQID,EVCNT,EVTY,EVNOUT)=^TMP("LRA",$J,EVX,EVNUM,EVN,EVN2)_CRLF
 . . Q
 . Q
 Q
