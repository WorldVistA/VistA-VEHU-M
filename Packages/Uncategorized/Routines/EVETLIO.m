EVETLIO ;DALOI/LEL - Communications procesor for other registration requests ; 1/20/03 12:23pm
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;;added site parm file access (9/12/02 - lel)
 ;debugging code only
 N EVDEBUG,EVETSNAM,EVIPADR,EVNOENC,EVPORT,EVRUN,EVSBUF,EVSITEN,EVTIME
 S EVDEBUG=0
 ;
 S X="ERR^EVETLIO",@^%ZOSF("TRAP")
 N EVCURT,EVCURTC,EVFAIL,EVSD,EVTXCNT,EVSTART,EVSTARTD,EVREQCNT,EVLBUF
 N EVETACT,EVOK,EVEXTM,EVPROCST,EVMSGTY,EVSRCDT,EVTSITE,EVTSITEN,EVVER,EVPATCH
 S EVTXCNT=0,EVFAIL=0,EVREQCNT=0,EVLBUF=0,EVMSGTY=3,EVSRCDT=""
 S IOF="#"
 D ENS^%ZISS,^%ZISC
 D NOW^%DTC S DT=X,U="^"
 ;K ^TMP("EVET_AUD",$J)
 S EVPROCST=$$NOW^XLFDT
 S EVTIME=$P($$NOW^XLFDT,".",2) ; Set time to run
 S EVNOENC=0 ; encrypt flag
 S EVSBUF=""
 S EVRUN=$P($$NOW^XLFDT,".",2)
 ; get version and patch values
 D VER^EVETU1(.EVVER,.EVPATCH)
 ; get site specific values
 S (EVIPADR,EVPORT,EVTSITE,EVTSITEN)=""
 D SITEPRMS^EVETU1(.EVIPADR,.EVPORT,.EVTSITE,.EVTSITEN)
 ;S EVPORT=5700
 ;S EVIPADR="10.2.29.60"
 S EVETSNAM=$P($$SITE^VASITE,U,2)
 S EVSITEN=$P($$SITE^VASITE,U,1)
 I EVTSITE="Y" S EVSITEN=EVTSITEN Q:EVSITEN=""
 D GETDNLD    ;get last download date from 2276.999
 D START
 D SVDNLD    ;save last download date in 2276.999
 ;D RECEVENT
 K ^TMP("EVET_XML_PARSE",$J)
EVQUIT Q
 ;
RECEVENT ;record start and stop time in 2276.3 file
 N FDA,EVNDX
 S EVNDX=$P(^EVET(2276.3,0),"^",3)+1
 S FDA(1,2276.3,"+1,",.01)=EVNDX
 S FDA(1,2276.3,"+1,",.02)=$J
 S FDA(1,2276.3,"+1,",.03)=EVPROCST
 S FDA(1,2276.3,"+1,",.04)=$$NOW^XLFDT
 D UPDATE^DIE("","FDA(1)","")
 Q
GETDNLD ;get the last download date from 2276.999 "SYS" entry
 N EVETDA
 S EVETDA=$O(^EVET(2276.999,"B","SYS",""))
 S EVSRCDT=$$GET1^DIQ(2276.999,EVETDA_",",.06,"I")
 I $D(EVSRCDT)'="" S EVSRCDT=$$XMLDATE^EVETU1(EVSRCDT)
 Q
SVDNLD ;save the current date as download date in 2276.999 "SYS" entry
 N FDA,EVNDX
 S EVNDX=$O(^EVET(2276.999,"B","SYS",""))
 S FDA(1,2276.999,EVNDX_",",.06)=$$NOW^XLFDT
 D FILE^DIE("","FDA(1)")
 Q
START ;Starts transmission
 ;debug only code
 N EVEND,EVNON,EVETLDT,X,EVCNT,EVUICN,EVUSERN,EVRDAT,EVSENT
 S (EVSENT,EVEND,EVCNT,EVNON)=0
 D OPENPORT^EVETLID
 Q:EVFAIL>0  ;failure connecting to server, quit
 ;debug only code
 I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*START-PORT OPEN"
 D SENDREQ
 S (EVLINE,EVSBUF)=""
 K ^TMP("EVETREQ",$J)
 ;D READT^EVETLI2("registration","</eVaultRegisteredListResponse_1>",EVMSGTY)
 D GETRESP^EVETLI4(EVMSGTY,255,$C(3))
 D CLOSE^%ZISTCP
 S EVREQ=""
 I '$D(^TMP("EVET_XML_PARSE",$J,EVMSGTY)) Q
 F  S EVREQ=$O(^TMP("EVET_XML_PARSE",$J,3,EVREQ)) Q:EVREQ=""  D
 . S EVSTART=$P($H,",",2)
 . S EVREQCNT=EVREQCNT+1  ;count # of requests
 . D PARSE("XML",EVREQ,EVMSGTY)
 . I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*EVUICN="_EVUICN
 . I $D(EVUICN)'=1 Q
 . S EVDFN=$$GETDFN^MPIF001($P(EVUICN,"V"))
 . D PUTDATA
 . Q
 Q
PARSE(EVXMLT,EVREQ,EVACT) ;
 ; Parses all XML variables from line label XML out of request
 N EVTAG,EVVAR,EVLINE,EVX,EVTMP2
 F EVX=1:1 S EVLINE=$T(@(EVXMLT)+EVX) Q:EVLINE=" ;;END"  D
 . S EVTAG=$P(EVLINE,";",3),EVVAR=$P(EVLINE,";",4)
 . S EVTMP2=$G(^TMP("EVET_XML_PARSE",$J,EVACT,EVREQ,EVTAG))
 . S @(EVVAR)=EVTMP2
 . I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*"_EVTAG_","_EVVAR_"="_EVTMP2
 . Q
 Q
SENDREQ ; Sends requests for registrations to HealthEVet server.
 D AUDIT^EVETAUD("","",$$NOW^XLFDT(),"EQ","","")
 D XMLHEAD("RegisteredList")
 D ENCRYPT("<site_number>"_EVSITEN_"</site_number>")
 D ENCRYPT("<registered_since_date>"_EVSRCDT_"</registered_since_date>")
 D ENCRYPT("</eVaultRegisteredList_1>")
 D SENDL(1)
 D ENDCODE^EVETLID1
 Q
XMLHEAD(EVTYPE) ;XML HEADER
 S EVSD=0
 D ENCRYPT("<?xml version="_$C(34)_"1.0"_$C(34)_"?>")
 D ENCRYPT("<eVault"_EVTYPE_"_1 xmlns:dt="_$C(34)_"urn:schemas-microsoft.com:datatypes"_$C(34)_" BuildID="_$C(34)_EVVER_$C(34)_" PatchID="_$C(34)_EVPATCH_$C(34)_">")
 Q
ENCRYPT(EVSTR) ;
 ;debug code
 N CNTR
 ;end debug code
 S EVSBUF=EVSBUF_EVSTR
 I $L(EVSBUF)>253 D
 . S EVLINE=$E(EVSBUF,1,253)
 . S EVSBUF=$E(EVSBUF,254,$L(EVSBUF))
 . D SENDL(0)
 . Q
 Q
SENDL(EVCOPY) ;
 I $G(EVLINE)=""!(EVCOPY=1) S EVLINE=EVSBUF
 S EVSD=EVSD+$L(EVLINE)
 ;debug code only
 S EVLBUF=EVLBUF+1,^TMP("EVET_EVLBUF",$J,EVLBUF)=EVLINE ;save code block
 I EVNOENC=1 D
 . W EVLINE,@IOF
 . S EVTXCNT=EVTXCNT+$L(EVLINE)
 . Q
 E  D
 . W $$ENCRYP^EVETENC(EVLINE),@IOF
 . S EVTXCNT=EVTXCNT+$L(EVLINE)
 . Q
 I EVCOPY=1 D
 . S (EVLINE,EVSBUF)=""
 . Q
 Q
PUTDATA ;put retrieved reg data into file or updates existing record
 N EV2275,NEWREC,EVDFN,EVREC,EVUPDT,FDA,EVRDATV,X,Y
 I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*ENTERING DATA FOR "_EVUICN
 I '$D(EVUICN) Q    ;no icn to process
 S EVDFN=$$GETDFN^MPIF001($P(EVUICN,"V",1))
 I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*PUTDATA EVDFN="_EVDFN
 I $P(EVDFN,"^",1)=-1 Q  ;invalid icn
 S NEWREC=1
 I $D(^EVET(2275,"B",EVDFN))'=0 D
 . S NEWREC=0
 . S EV2275="",EV2275=$O(^EVET(2275,"B",EVDFN,EV2275))
 . Q
 I NEWREC=0 D  Q
 . I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*UPDATE REC FOR "_EVDFN
 . S EVUPDT=0
 . K ^TMP("DILIST",$J),^TMP("DIERR",$J)
 . D FIND^DIC(2275,"","@;.03I;.08I;","AP",EV2275,"","","","")
 . I $D(^TMP("DIERR",$J))'=0 Q   ;error found can not process
 . S EVREC=^TMP("DILIST",$J,1,0)
 . I $P(EVREC,"^",2)'="Y" S FDA(1,2275,EV2275_",",.03)="Y",EVUPDT=1
 . I $P(EVREC,"^",3)="" S FDA(1,2275,EV2275_",",.08)="N",EVUPDT=1
 . I EVUPDT=1 D UPDATE^DIE("","FDA(1)","")
 . Q
 I NEWREC=1 D
 . I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*NEWREC FOR "_EVDFN
 . S X=$P(EVRDAT," ",1)  ;remove time from date
 . D ^%DT S EVRDATV=Y
 . S EV2275=$P(^EVET(2275,0),"^",3)+1
 . S FDA(1,2275,"+1,",.01)=EVDFN
 . S FDA(1,2275,"+1,",.02)=EVRDATV
 . S FDA(1,2275,"+1,",.03)="Y"
 . S FDA(1,2275,"+1,",.04)=EVUSERN
 . S FDA(1,2275,"+1,",.05)="AUTO.123"
 . S FDA(1,2275,"+1,",.08)="Y"
 . D UPDATE^DIE("","FDA(1)","")
 Q
ERR ;Error trap
 D ^%ZTER
 D CLOSE^%ZISTCP
 Q
XML ; List of XML tags, the variable it will be set in to and the description
 ;;user_name;EVUSERN; Evault user name
 ;;icn;EVUICN; Evault User ICN
 ;;site_number;EVSITE; Site
 ;;site_registration_date;EVRDAT; Date of evault request
 ;;END
 ;
ERROR ; List of tags for the Update Reponse message
 ;;icn;EVUSERN; Evault user ICN
 ;;site_number;EVSITE; Site number
 ;;result;EVRESU;Error reults
 ;;END
