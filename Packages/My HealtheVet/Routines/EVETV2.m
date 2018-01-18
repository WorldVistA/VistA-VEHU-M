EVETV2 ;DALOI/KML - Extraction procedures for admissions data to be stored on eVault ; 12/3/02 9:33am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 Q
 ;
 ; field references to the PATIENT MOVEMENT File (#405) supported by IA#
 ; field references to the WARD LOCATION File (#42) supported by IA #
 ; field references to the SCHEDULED ADMISSION FILE (#41.1) supported by IA #
 ;
 ; EVETDFN       = DFN (ien of PATIENT file (#2)
 ; EVSDATE       = FileMan date at which to begin data extraction
 ; EVREQID       = REQUEST ID REPRESENTING MESSAGE IDENTIFIER RECEIVED
 ;                 FROM HEALTH EVET
 ;
GET(EVETDFN,EVSDATE,EVREQID) ;
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVRTN,EVSEQ,EVETERR,EVCNT,EVADM
 S EVRTN="EVETLIS",EVADM=0
 S EVCNT=$O(^TMP("EVETLIS",$J,EVREQID,""),-1)+1
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"START_Admissions")=""
 S EVCNT=EVCNT+1
 D GETHADM,GETFADM
 I EVADM,$D(EVETERR) K EVETERR
 ;I $D(EVETERR) S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"error")=EVETERR,EVCNT=EVCNT+1
 S EVCNT=EVCNT+1
 S ^TMP("EVETLIS",$J,EVREQID,EVCNT,"END_Admissions")=""
 ;
 Q
GETHADM ; return a list of historical admissions
 N EVTIM,EVSTOP,EV405DA,EV41DA,EVETDA,EVETTAG
 ;(x-ref for file 405) ^DGPM("ATID"_TT,DFN,Inverse date_AS,DA)=""
 I '$D(^DGPM("ATID1",EVETDFN)) S EVETERR="No admissions on record" Q
 S EVADM=1  ; admissions exist flag
 S EVSTOP=9999999-EVSDATE,EVTIM=9999999-$$DT^XLFDT
 S EVETTAG="H1",EV405DA=0
 S EVTIM=EVTIM-1 F  S EVTIM=$O(^DGPM("ATID1",EVETDFN,EVTIM)) Q:EVTIM>EVSTOP  Q:EVTIM'>0  D
 . F  S EV405DA=$O(^DGPM("ATID1",EVETDFN,EVTIM,EV405DA)) Q:EV405DA'>0  S EVETDA=EV405DA D GETFLDS
 Q
 ;
 ;
GETFADM ;Get future scheduled admission data
 I '$D(^DGS(41.1,"B",EVETDFN)) S EVETERR="No admissions on record" Q
 S EVADM=1
 S EVETTAG="F1",EV41DA=0
 F  S EV41DA=$O(^DGS(41.1,"B",EVETDFN,EV41DA)) Q:EV41DA'>0  S EVETDA=EV41DA D GETFLDS
 Q
 ;
GETFLDS ;
 N EVETDR,EVETI,EVETSTR,EVETDATA,EVETXML,EVETPROC,EVETDIC,EVETFLG,EVQUIT,EVSET
 S EVQUIT=0,EVSET=0
 S ^TMP(EVRTN,$J,EVREQID,EVCNT,"ien")=EVETDA
 F EVETI=1:1 S EVETSTR=$P($T(@EVETTAG+EVETI),";;",2) Q:EVETSTR="##"  Q:EVQUIT  D
 . Q:'$L(EVETSTR)
 . S EVETXML=$P(EVETSTR,"|"),EVETDIC=$P(EVETSTR,"|",2),EVETDR=$P($P(EVETSTR,"|",3),U),EVETFLG=$P($P(EVETSTR,"|",3),U,2),EVETPROC=$P(EVETSTR,"|",4)
 . Q:EVETXML']""  Q:EVETDR']""
 . S EVETDATA=$$GET1^DIQ(EVETDIC,EVETDA_",",EVETDR,EVETFLG)
 . I EVETPROC]"" X EVETPROC
 . Q:EVQUIT
 . S ^TMP(EVRTN,$J,EVREQID,EVCNT,EVETXML)=EVETDATA
 . S EVSET=1
 S EVCNT=EVCNT+1
 I EVSET=1 S ^TMP(EVRTN,$J,EVREQID,EVCNT,"ien")=EVETDA
 Q
F1DTCK ;check date to be sure in future, convert to export format
 ;I EVETDATA<DT S EVQUIT=1 Q
 S EVETDATA=$$XMLDATE^EVETU1(EVETDATA)
 Q
 ;
 ; H1 tag contains 
H1 ; XML tag|DD file|DD field^FM flag|special processing procedure|desc
 ;;admit_date_time|405|.01^I|S EVETDATA=$$XMLDATE^EVETU1(EVETDATA)||
 ;;provider|405|.08|||
 ;;treating_specialty|405|.09|||
 ;;diagnosis|405|.1|||
 ;;ward|405|.06|||
 ;;hospital_location|405|.05|S EVETDATA=$P($$SITE^VASITE,U,2)|using site value|
 ;;##
 ;
 ;
F1 ; XML tag|DD file|DD field|special processing procedure|desc
 ;;admit_date_time|41.1|2^I|D F1DTCK|quit if date is past|
 ;;date_time_cancelled|41.1|13^I|S EVETDATA=$$XMLDATE^EVETU1(EVETDATA)||
 ;;admitted|41.1|17^I|||
 ;;expected_length_of_stay|41.1|3|||
 ;;diagnosis|41.1|4|||
 ;;provider|41.1|5|||
 ;;surgery|41.1|6|||
 ;;ward|41.1|8|||
 ;;treating_specialty|41.1|9|||
 ;;##
