EVETV9 ;DALOI/KML - Extraction procedures for PROBLEM LIST data to be stored on eVault ; 12/3/02 9:58am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;
 Q
 ;
 ; usage of LIST^GMPLUTL2 supported by subscription to IA #2741
 ;
 ; EVETDFN       = DFN (ien of PATIENT file (#2)
 ; EVBDATE       = FileMan date at which to begin data extraction
 ; EVREQID       = REQUEST ID REPRESENTING MESSAGE IDENTIFIER RECEIVED
 ;                 FROM HEALTH EVET
 ;
GET(EVETDFN,EVBDATE,EVREQID) ;
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 N EVRTN,EVTMPGBL,EVCNT,EVETX,EVCX,EVTIME1,EVTIME2
 K EVPL,EVPLDET
 S EVRTN="EVETLIS"
 S EVTMPGBL="^TMP(EVRTN,$J,EVREQID,EVCNT)"
 S EVCNT=$O(^TMP(EVRTN,$J,EVREQID,""),-1)+1
 S @EVTMPGBL@("START_Problem_List")=""
 S EVCNT=EVCNT+1,EVTIME2=9999999-EVBDATE,EVTIME1=9999999-DT
 D PROBLST
 S @EVTMPGBL@("END_Problem_List")=""
 Q
 ;
PROBLST ; LIST(.array,dfn,status,comments)
 ;  definitions =
 ;       array  =  output
 ;                 array(0)=number of problems 
 ;                 array(#)="IEN^status^description^icd^onset^
 ;                           last modified^SC^exposure^*^$"
 ;                 array(#,C#) = comment lines
 ;       dfn    = patient ien (file 2)
 ;       status = A for active; I for inactive; "OTHER" for both
 ;       comments = 1 for comments; 0,null or undefined for no comments
 D LIST^GMPLUTL2(.EVPL,EVETDFN,"OTHER",1)
 Q:EVPL(0)=0  ; no records found
 S EVETX=0 F  S EVETX=$O(EVPL(EVETX)) Q:EVETX<1  K EVPLDET("EXPOSURE") D DETAIL^GMPLUTL2($P(EVPL(EVETX),U),.EVPLDET),BLDTMP
 ; get IEN from EVPL string and call API for more detail on PROBLEM LIST record; build temporay global for each record of the patient problem list 
 Q
 ;
BLDTMP ; construct EVET temporary global
 Q:$P(EVPL(EVETX),U,6)<EVBDATE  ; records having an earlier date than that passed to VISTA extract process are not to be sent back to Health eVet dB. 
 S @EVTMPGBL@("ien")=$P(EVPL(EVETX),U)
 S @EVTMPGBL@("status")=$P(EVPL(EVETX),U,2)
 S @EVTMPGBL@("problem_desc")=$G(EVPLDET("NARRATIVE"))
 S @EVTMPGBL@("provider")=$G(EVPLDET("PROVIDER"))
 ;S @EVTMPGBL@("remarks")=$S($P(EVGMPL(EVETX),U,7)="SC":"Service Connected",$P(EVGMPL(EVETX),U,7)="NSC":"Not Service Connected",1:"")
 S @EVTMPGBL@("remarks")=$S($G(EVPLDET("SC"))="NO":"Not Service Connected",EVPLDET("SC")="YES":"Service Connected",1:"")
 S @EVTMPGBL@("clinic")=$G(EVPLDET("CLINIC"))
 S @EVTMPGBL@("onset")=$$XMLDATE^EVETU1($P(EVPL(EVETX),U,5))
 S @EVTMPGBL@("last_modified")=$$XMLDATE^EVETU1($P(EVPL(EVETX),U,6))
 S EVCX=0 F  S EVCX=$O(EVPLDET("COMMENT",EVCX)) Q:EVCX<1  S @EVTMPGBL@("notes",EVCX)=$P(EVPLDET("COMMENT",EVCX),U,3)
 ;debug lines follow
 ;I $D(EVPLDET("EXPOSURE"))'=0 W !,EVPLDET("EXPOSURE"),"*",$P(EVPL(EVETX),U)
 ;I $D(EVPLDET("EXPOSURE",1))'=0 W "1",EVPLDET("EXPOSURE",1)
 ;I $D(EVPLDET("EXPOSURE",2))'=0 W "2",EVPLDET("EXPOSURE",2)
 ;I $D(EVPLDET("EXPOSURE",3))'=0 W "3",EVPLDET("EXPOSURE",3)
 ;
 S EVCX=0 F  S EVCX=$O(EVPLDET("EXPOSURE",EVCX)) Q:EVCX<1  S @EVTMPGBL@("exposure",EVCX)=EVPLDET("EXPOSURE",EVCX)_" "
 S EVCNT=EVCNT+1
 Q
