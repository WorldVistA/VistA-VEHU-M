EVETLIR ;DALOI/DS - Communications procesor for eVault requests ; 4/22/03 11:26am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 ;;added site parm file access (9/12/02 - lel)
 ;;parsed version for registration only (5/02/02 - lel)
 ;;moved open command to OPENPORT to force wait until open - lel
EN(EVJOB) ;
 ;entry point for calling by reg process
 ;EVJOB - job number of registration.
 ;assumes these variables are set by EVETR1 and passed as part of the ztload command
 ; TMP - array of data for registration
 ;debugging code only
 N EVDEBUG,X,EVIPADR,EVMAX,EVNOENC,EVPORT,EVRUN,EVSBUF,EVTIME
 S EVDEBUG=0
 ;
 S X="ERR^EVETLIR",@^%ZOSF("TRAP")
 N EVSITEN,EVCURT,EVCURTC,EVSD,EVTSITE,EVTSITEN,EVVER,EVPATCH,EVETSNAM
 S IOF="#"
 D ENS^%ZISS,^%ZISC
 D NOW^%DTC S DT=X,U="^"
 ;K ^TMP("EVET_AUD",$J)
 S EVTIME=$P($$NOW^XLFDT,".",2) ; Set time to run
 S EVNOENC=0 ; encrypt flag
 S EVSBUF="",EVMAX=8000 ; Maximum message size
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
 ;S EVSITEN=99996
 I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*PRIOR TO CHKREG"
 D CHKREG ; Check for registration matching EVJOB
 Q
CHKREG  ; Checks for regitration evtries to send
 N EVITEM,EVT,EVRESP,EVDFN,EVDATA,EVICN,EVUSR,FDA,EV2275,EVSN,EVRES
 I '$D(EVTMP) Q
 I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*ENTERING CHKREG AFTER REQUEST FOUND"
 D OPENPORT^EVETLID
 ;S EVJOB=$O(EVTMP("EVETR1",""))
 S EVITEM=$O(EVTMP(""))
 D XMLHEAD("Activate")
 D ENCRYPT("<activation site_number="_$C(34)_EVSITEN_$C(34)_">")
 S EVT=""
 F  S EVT=$O(EVTMP(EVT)) Q:EVT=""  D
 . I EVT="site_number" D
 .. S EVSN=""
 .. F  S EVSN=$O(EVTMP(EVT,EVSN)) Q:EVSN=""  D
 ... S EVDATA=EVTMP(EVT,EVSN)
 ... D ENCRYPT("<"_EVT_">"_EVDATA_"</"_EVT_">")
 ... Q
 . E  D
 .. S EVDATA=EVTMP(EVT)
 .. I EVT="icn" S EVICN=EVDATA
 .. I EVT="user_name" S EVUSR=EVDATA
 .. D ENCRYPT("<"_EVT_">"_EVDATA_"</"_EVT_">")
 . Q
 D ENCRYPT("</activation></eVaultActivate_1>")
 D SENDL(1)
 D ENDCODE^EVETLID1
 ;D AUDIT^EVETAUD(EVUSR,EVICN,$$NOW^XLFDT(),"A",EVRES,"")
 I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*PRIOR TO READT FOR ACTIVATION RESPONSE"
 ;D READT^EVETLI2("activation_response","</eVaultActivateResponse_1>",1)
 D GETRESP^EVETLI4(1,255,$C(3))
 D CLOSE^%ZISTCP
 I '$D(^TMP("EVET_XML_PARSE",$J,1)) Q
 I $D(^TMP("EVET_XML_PARSE",$J,1,"ERROR","result")) S EVDFN=$$GETDFN^MPIF001($P(EVICN,"V")) D ALERT^EVETU1("REGISTER") K ^TMP("EVET_XML_PARSE",$J,1,"ERROR","result") Q
 S EVRESP=$J
 D PARSE("REGERR",$J,1)
 S EVRES=$G(^TMP("EVET_XML_PARSE",$J,1,$J,"result"))
 D AUDIT^EVETAUD(EVUSR,EVICN,$$NOW^XLFDT(),"AR","","")
 S EVDFN=$$GETDFN^MPIF001($P(EVICN,"V"))
 ;places response in file 2275
 I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"* RESPONSE="_EVRES_" EVDFN="_EVDFN
 S EV2275=""
 S EV2275=$O(^EVET(2275,"B",EVDFN,EV2275))
 S FDA(1,2275,EV2275_",",2)=EVRES
 D UPDATE^DIE("","FDA(1)","")
 Q
PARSE(EVXMLT,EVREQ,EVACT) ;--
 ;Parse all XML variables from line label XML out of requst
 N EVTAG,EVVAR,EVLINE,EVTMP2,EVX
 F EVX=1:1 S EVLINE=$T(@(EVXMLT)+EVX) Q:EVLINE=" ;;END"  D
 . S EVTAG=$P(EVLINE,";",3),EVVAR=$P(EVLINE,";",4)
 . S EVTMP2=$G(^TMP("EVET_XML_PARSE",$J,EVACT,EVREQ,EVTAG))
 . S @(EVVAR)=EVTMP2
 . I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*"_EVTAG_","_EVVAR_"="_EVTMP2
 . Q
 Q
XMLHEAD(EVTYPE) ;XML HEADER
 S EVSD=0
 D ENCRYPT("<?xml version="_$C(34)_"1.0"_$C(34)_"?>")
 D ENCRYPT("<eVault"_EVTYPE_"_1 xmlns:dt="_$C(34)_"urn:schemas-microsoft.com:datatypes"_$C(34)_" BuildID="_$C(34)_EVVER_$C(34)_" PatchID="_$C(34)_EVPATCH_$C(34)_">")
 Q
XMLTOFM(EVDATE) ;
 N EVY,EVTT,EVDAT,EVDA
 S EVY=$P(EVDATE,"T",1)
 S EVTT=$P(EVY,"-",2,3)
 S EVDA=EVTT_"/"_$P(EVDATE,"-",1)_"@"_$P(EVDATE,"T",2)
 S EVDAT=$$GETDT(EVDA)
 Q EVDAT
GETDT(EVDATE) ;GMV CONVERT DATE
 ;INPUT VARIABLE:
 ;GMRDATE - DATE/TIME FROM EDIT.TEXT ENTERED BY USER
 ;OUTPUT VARIABLE:
 ;RESULT - CONTAINS INTERNAL AND EXTERNAL DATE/TIME
 N EVDAT D DT^DILF("ETS",EVDATE,.EVDAT)
 I $G(EVDAT)'>0 Q ""
 Q EVDAT
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
 I EVDEBUG=1 S ^TMP("EVET_DEBUG_TR",$O(^TMP("EVET_DEBUG_TR",""),-1)+1)=$H_"*EVST SIZE = "_EVSD
 I EVNOENC=1 D
 . W EVLINE,@IOF
 . Q
 E  D
 . W $$ENCRYP^EVETENC(EVLINE),@IOF
 . Q
 I EVCOPY=1 D
 . S (EVLINE,EVSBUF)=""
 . Q
 Q
ERR ;Error trap
 D ^%ZTER
 D CLOSE^%ZISTCP
 Q
REGERR  ; List of tags for Activate responce
 ;;icn;EVICN;Pat ICN
 ;;site_number;EVSITE;Site num
 ;;result;EVRES;Result
 ;;END
