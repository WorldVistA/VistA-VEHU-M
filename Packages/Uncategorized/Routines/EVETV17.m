EVETV17 ;BP/LEL - Extraction procedure for ECG data to be stored on evalt; 2/1/02 - lel ; 12/3/02 10:01am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 Q
 ;
 ;usage of MCARUTL2 supported by IA #
 ;
 ; EVETDFN       = DFN (ien of PATIENT file (#2)
 ; EVBDATE       = FileMan date at which to begin data extraction
 ; EVREQID       = REQUEST ID REPRESENTING MESSAGE IDENTIFIER RECEIVED
 ;                 FROM HEALTH EVET
 ;
GET(EVDFN,HVSD,EVREQ) ;
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVCNT,EVLIST,EVNDX,EVSUB,EVCRLF
 S EVCRLF=" "_$C(10)_$C(13)
 ; Procedure code for ECG = 2
 S EVSUB=2
 D SUB^MCARUTL2(.EVLIST,EVDFN,EVSUB,HVSD,$$NOW^XLFDT())
 S EVCNT=$O(^TMP("EVETLIS",$J,EVREQ,""),-1)+1
 S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"START_ECG")=""
 S EVCNT=EVCNT+1
 ;for each ECG in EVLIST generate entries
 S EVNDX=0
 F  S EVNDX=$O(EVLIST(EVNDX)) Q:EVNDX=""  D GETONE
 S EVCNT=EVCNT+1
 S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"END_ECG")=""
 Q
 ;
GETONE ;process one entry in EVLIST
 N EVETI,EVETSTR,EVETXML,EVETDIC,EVETDA,EVETDR,EVETFLG,EVETPROC,EVETTAG,EVSET,EVFILE,EVETDATA
 I $D(EVLIST(EVNDX))=0 Q
 S EVETDA=$P(EVLIST(EVNDX),"^",5)
 ;EVFILE contains the file location for data
 S EVFILE=$P($P(EVLIST(EVNDX),"^",4),"(",2)
 S EVETTAG="F1",EVSET=0
 ;quit if report is not confirmed
 S EVETDIC=691.5,EVETDR=11,EVETFLG=""
 S EVETDATA=$$GET1^DIQ(EVETDIC,EVETDA_",",EVETDR,EVETFLG)
 I EVETDATA'="CONFIRMED" Q
 ;
 F EVETI=1:1 S EVETSTR=$P($T(@EVETTAG+EVETI),";;",2) Q:EVETSTR="##"  D
 . Q:'$L(EVETSTR)
 . S EVETXML=$P(EVETSTR,"|"),EVETDIC=$P(EVETSTR,"|",2),EVETDR=$P($P(EVETSTR,"|",3),U),EVETFLG=$P($P(EVETSTR,"|",3),U,2),EVETPROC=$P(EVETSTR,"|",4)
 . Q:EVETXML']""  Q:EVETDR']""
 . S EVETDATA=$$GET1^DIQ(EVETDIC,EVETDA_",",EVETDR,EVETFLG)
 . I EVETPROC]"" X EVETPROC
 . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,EVETXML)=EVETDATA
 . S EVSET=1
 D GETWP(20)
 I EVSET=1 S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"ien")=EVETDA
 S EVCNT=EVCNT+1
 Q
 ;
GETWP(EVF) ;Gets WP Field
 N EVT,EVWP,EVX
 S EVX=$$GET1^DIQ(EVFILE,EVETDA_",",EVF,"","EVWP")
 S EVT="" F  S EVT=$O(EVWP(EVT)) Q:EVT=""  D
 . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"diagnosis",EVT)=EVWP(EVT)_EVCRLF
 . Q
 Q
 ;
F1 ; XML tag|DD file|DD field|special processing procedure|desc
 ;;date_time_test|691.5|.01^I|S EVETDATA=$$XMLDATE^EVETU1(EVETDATA)||
 ;;heart_rate|691.5|3|||
 ;;pr_interval|691.5|4|||
 ;;qrs_duration|691.5|5|||
 ;;qt|691.5|6|||
 ;;qtc|691.5|7|||
 ;;p_axis|691.5|8|||
 ;;r_axis|691.5|9|||
 ;;t_axis|691.5|10|||
 ;;##
 ;
 ;
