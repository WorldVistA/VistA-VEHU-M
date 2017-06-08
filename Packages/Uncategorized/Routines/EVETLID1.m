EVETLID1 ;DALOI/DS - Communications procesor for eVault requests ; 2/9/04 10:11am
 ;;1.0;HEALTH EVET;**1,2**;Nov 05, 2002
 Q
OPTWO ;
 N EVRESEND,EVEOD,EVREQ2,EVRESU,EVRSND,EVUSERN
 ;debug only code
 I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*ENTERING OPTWO FOR REQUEST: "_EVREQ
 S EVCURT=""
 S EVEND=0,EVEOD=0,EVRSND=0,EVFAIL=0
 S EVSTART=$P($H,",",2)  ;time stamp for start of submission
 F  Q:EVEND=1  D
 . I $D(^TMP("EVETLIS",$J))=0 S EVEND=1 Q
 . D OPENPORT^EVETLID
 . I EVFAIL>0 S EVEND=1
 . ;debug only code
 . I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*OPTWO PORT OPEN"
 . S EVSTARTD=$$NOW^XLFDT
 . D XMLHEAD("Update")
 . D SENDTCP
 . D ENCRYPT("</eVaultUpdate_1>")
 . D SENDL^EVETLID(1)
 . D ENDCODE
 . ;if value at req level, dummy. delete to end loop
 . I $G(^TMP("EVETLIS",$J,EVREQ))=1 K ^TMP("EVETLIS",$J,EVREQ)
 . ; Read response, check for errors & resend if needed
 . S EVOK=0
 . F  D  Q:EVOK=1
 . . S EVRESEND=""
 . . K ^TMP("EVETREQ",$J)
 . . ;D READT^EVETLI2("update_response","</eVaultUpdateResponse_1>",2)
 . . D GETRESP^EVETLI4(2,255,$C(3))
 . . I $D(^TMP("EVET_XML_PARSE",$J,2,"ERROR","result"))!'$D(^TMP("EVET_XML_PARSE",$J,2)) D  Q
 . . . D ALERT^EVETU1("TRANSMIT")
 . . . K ^TMP("EVET_XML_PARSE",$J,2,"ERROR","result")
 . . . S EVOK=1,EVEND=1
 . . . Q
 . . S EVREQ2=""
 . . F  S EVREQ2=$O(^TMP("EVET_XML_PARSE",$J,2,EVREQ2)) Q:EVREQ2=""  D  Q:EVRESEND=1
 . . . D PARSE("ERROR",EVREQ2,2)
 . . . I EVRESU="Ok" S EVOK=1 D DEVSNT ; Delete items if result = ok
 . . . D AUDIT^EVETAUD("",EVUSERN,$$NOW^XLFDT(),"UR",EVRESU,EVREQ2)
 . . . ; Now act on errors ***** needs discusion ******
 . . . I EVRESU["Error" D
 . . . . S EVRESEND=1
 . . . . D CLOSE^%ZISTCP
 . . . . D OPENPORT^EVETLID
 . . . . D RESENDL^EVETLID  ;resend block of data
 . . . .; following line of code to be used in test environment only
 . . . . I EVRSND>3 D AUDIT^EVETAUD("",EVUSERN,$$NOW^XLFDT(),"UR",EVRESU,EVREQ2) S EVEND=1 Q
 . . . . S EVRSND=EVRSND+1
 . . . . Q
 . . . Q
 . . Q
 . ;reinitialize last sent buffer information
 . S EVLBUF=0
 . K ^TMP("EVET_EVLBUF",$J)
 . D CLOSE^%ZISTCP
 . ;H 4
 . ;I EVRSND>0 H 20
 . Q 
 D CLOSE^%ZISTCP
 Q
SENDTCP ;Send responce
 ;debug code only
 I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*ENTERING SENDTCP FOR $J="_$J
 N EVNAME,EVTIME,EVTY,EVFIELD,EVTAG,EVDATA,EVENDT,EVNOENT,EVWPLINE,EVWP,EVTSIT,EVTICN,EVIEN,EVEDAT
 S EVTREQ="",EVENDT=0,EVNOENT=""
 F  S EVTREQ=$O(^TMP("EVETLIS",$J,EVTREQ)) Q:EVTREQ=""!(EVENDT=1)  D
 .I EVTLOG D
 .. K ^TMP("EVTLOG",$J,EVTREQ)
 .. M ^TMP("EVTLOG",$J,EVTREQ)=^TMP("EVETLIS",$J,EVTREQ)
 .. S ^TMP("EVTLOG",$J)=DT
 .. S ^TMP("EVTLOG",$J,EVTREQ)=^TMP("EVET_XML_PARSE",$J,0,EVTREQ,"user_name")
 . S EVEDAT=^TMP("EVET_LISTENER_REQESTS",$J,EVTREQ)
 . S EVTICN=$P(EVEDAT,"^",1),EVTSIT=$P(EVEDAT,"^",2)
 . D ENCRYPT("<update><request_id>"_EVTREQ_"</request_id><icn>"_EVTICN_"</icn>")
 . D ENCRYPT("<extract_date>"_$$XMLDATE^EVETU1($$NOW^XLFDT())_"</extract_date><site_number>"_EVSITEN_"</site_number>")
 . D ENCRYPT("<site_name>"_EVETSNAM_"</site_name><extract_data>")
 . I (EVCURT'="")&(EVEOD=1) D ENCRYPT("<"_EVCURT_">") S EVCURTC(EVCURT)=0
 . S EVTYPE=""
 . F  S EVTYPE=$O(^TMP("EVETLIS",$J,EVTREQ,EVTYPE)) Q:EVTYPE=""!(EVENDT=1)  D
 . . S EVTAG=""
 . . I $O(^TMP("EVETLIS",$J,EVTREQ,EVTYPE,""))'="" D
 . . . S EVIEN=$G(^TMP("EVETLIS",$J,EVTREQ,EVTYPE,"ien"))
 . . . Q:EVIEN=""
 . . . S ^TMP("EVET_SENT",$J,EVTREQ,EVTYPE)=""
 . . . D ENCRYPT("<extract_entity IEN="""_EVIEN_""">")
 . . . Q
 . . F  S EVTAG=$O(^TMP("EVETLIS",$J,EVTREQ,EVTYPE,EVTAG)) Q:EVTAG=""!(EVENDT=1)  D
 . . . S EVNOENT=0
 . . . S EVDATA=$G(^TMP("EVETLIS",$J,EVTREQ,EVTYPE,EVTAG))
 . . . Q:EVTAG="ien"
 . . . I EVTAG["START" D
 . . . . I (EVCURT'="")&(EVCURT'=$P(EVTAG,"_",2,3)) D
 . . . . . ;if there is a previous unclosed tag, close it 
 . . . . . ;I EVCURTC(EVCURT)'=1 D ENCRYPT("</"_EVCURT_">") S EVCURTC(EVCURT)=1 S:EVDEBUG=1 ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*CLOSING "_EVCURT_"at next start tag"
 . . . . . Q
 . . . . D ENCRYPT("<"_$P(EVTAG,"_",2,3)_">")
 . . . . S ^TMP("EVET_SENT",$J,EVTREQ,EVTYPE)=""
 . . . . S EVCURT=$P(EVTAG,"_",2,3),EVCURTC(EVCURT)=0
 . . . . S EVNOENT=1
 . . . . Q
 . . . I EVTAG["END" D
 . . . . D ENCRYPT("</"_$P(EVTAG,"_",2,3)_">")
 . . . . S ^TMP("EVET_SENT",$J,EVTREQ,EVTYPE)=""
 . . . . S EVCURTC($P(EVTAG,"_",2,3))=1
 . . . . S EVNOENT=1
 . . . . Q
 . . . I EVNOENT=1 Q
 . . . ; Write XML tag and data
 . . . S EVDATA=$$CHA^EVETLID(EVDATA)
 . . . I $O(^TMP("EVETLIS",$J,EVTREQ,EVTYPE,EVTAG,""))="" D
 . . . . D ENCRYPT("<"_EVTAG_">"_EVDATA_"</"_EVTAG_">")
 . . . I EVTAG="error" S EVNOENT=1 Q
 . . . ; Check for WP fields and send each line individually
 . . . I $O(^TMP("EVETLIS",$J,EVTREQ,EVTYPE,EVTAG,""))'="" D
 . . . . S EVWP=""
 . . . . D ENCRYPT("<"_EVTAG_">")
 . . . . F  S EVWP=$O(^TMP("EVETLIS",$J,EVTREQ,EVTYPE,EVTAG,EVWP)) Q:EVWP=""  D
 . . . . . S EVWPLINE=^TMP("EVETLIS",$J,EVTREQ,EVTYPE,EVTAG,EVWP)
 . . . . . S EVWPLINE=$$CHA^EVETLID(EVWPLINE)
 . . . . . D ENCRYPT(EVWPLINE)
 . . . . . Q
 . . . . D ENCRYPT("</"_EVTAG_">")
 . . . . Q
 . . . Q
 . . I EVNOENT=1 Q
 . . D ENCRYPT("</extract_entity>")
 . .; I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*Prior to EVSD>EVMAX check. EVSD = "_EVSD_" EVMAX="_EVMAX
 . .; I EVSD>EVMAX D
 . .; . I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)="EVSD="_EVSD
 . .; . S EVENDT=1,EVEOD=1,EVCURTC(EVCURT)=1
 . .; . D ENCRYPT("</"_EVCURT_">")
 . .; . D ENCRYPT("</extract_data></update>")
 . .; . Q
 . . Q
 . Q:EVENDT=1
 . D ENCRYPT("</extract_data></update>")
 . ;S EVEND=1
 . D SUM^EVETLID  ;save transfer audit data for EVTREQ
 . Q
 Q
 Q
DEVSNT ; Del sent items
 N EVFS,EVSS
 S EVFS="" F  S EVFS=$O(^TMP("EVET_SENT",$J,EVFS)) Q:EVFS=""  D
 . S EVSS="" F  S EVSS=$O(^TMP("EVET_SENT",$J,EVFS,EVSS)) Q:EVSS=""  D
 . . K ^TMP("EVETLIS",$J,EVFS,EVSS)
 . . Q
 . Q
 K ^TMP("EVET_SENT")
 Q
ALL(EVDFN,EVTYPE) ;
 ; Runs all extracts for a patient
 ; Monster runs from 1/1/1800 (to get all data)
 ;debug only code
 I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*ALL,EVTYPE="_EVTYPE
 N EVMDAT,EVX,EVLINE,HVX
 S HVX=1,EVRTN=""
 S EVMDAT="1900-01-01T01:00:00"
 I EVFROMD="" S EVFROMD=EVMDAT
 ;debug code
 I EVDEBUG>0 S EVFROMD="1900-01-01T01:00:00"
 F EVX=1:1 S EVLINE=$T(EXTRACT+EVX) Q:EVLINE=" ;;END"  D
 . S EVEXT=$P(EVLINE,";",4)
 . I EVTYPE="Monster" S EVRTN="GET"_EVEXT_"("_EVDFN_","_$$XMLTOFM^EVETLID(EVMDAT)_","_EVREQ_")"
 . I EVTYPE="All" S EVRTN="GET"_EVEXT_"("_EVDFN_","_$$XMLTOFM^EVETLID(EVFROMD)_","_EVREQ_")"
 .;debug code
 . I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*PROCESS"_EVX_"-"_EVRTN
 .;Now do extract
 . D @(EVRTN)
 . Q
 Q
PARSE(EVXMLT,EVREQ,EVACT) ;
 ; Parses all XML variables from line label XML out of request
 N EVTAG,EVVAR,EVLINE
 F EVX=1:1 S EVLINE=$T(@(EVXMLT)+EVX) Q:EVLINE=" ;;END"  D
 . S EVTAG=$P(EVLINE,";",3),EVVAR=$P(EVLINE,";",4)
 . S EVTMP2=$G(^TMP("EVET_XML_PARSE",$J,EVACT,EVREQ,EVTAG))
 . S @(EVVAR)=EVTMP2
 . I EVDEBUG=1 S ^TMP("EVET_DEBUG_PR",$O(^TMP("EVET_DEBUG_PR",""),-1)+1)=$H_"*"_EVTAG_","_EVVAR_"="_EVTMP2
 . Q
 ;update_requested requires different handling due to large field size
 S EVTAG="update_requested"
 S EVREQU="",EVNDX=""
 F  S EVNDX=$O(^TMP("EVET_XML_PARSE",$J,EVACT,EVREQ,EVTAG,EVNDX)) Q:EVNDX=""  D
 . S EVREQU(EVNDX)=^TMP("EVET_XML_PARSE",$J,EVACT,EVREQ,EVTAG,EVNDX)
 . Q
 I EVDEBUG=1 S EVFROMD="1900-01-01T01:00:00"
 Q
FINDEX(EVEXT) ;
 ; Finds Extract Routine to call
 N EVX,EVRTN,EVLINE
 S EVX=1,EVRTN=""
 F EVX=1:1 S EVLINE=$T(EXTRACT+EVX) Q:EVLINE=" ;;END"  D
 . I $P(EVLINE,";",3)=EVEXT S EVRTN=$P(EVLINE,";",4)
 . Q
 Q EVRTN
SENDREQ ; Sends requests for extracts to HealthEVet server.
 D AUDIT^EVETAUD("","",$$NOW^XLFDT(),"EP","","")
 D XMLHEAD("Request")
 D ENCRYPT("<site_number>"_EVSITEN_"</site_number>")
 D ENCRYPT("</eVaultRequest_1>")
 D SENDL^EVETLID(1)
 D ENDCODE
 Q
ENDCODE ; Write end codes
 ;W $C(13),$C(10),$C(13),$C(10),@IOF
 W $C(3),@IOF
 Q
XMLHEAD(EVTYPE) ;XML HEADER
 S EVSD=0
 D ENCRYPT("<?xml version="_$C(34)_"1.0"_$C(34)_"?>")
 D ENCRYPT("<eVault"_EVTYPE_"_1 xmlns:dt="_$C(34)_"urn:schemas-microsoft.com:datatypes"_$C(34)_" BuildID="_$C(34)_EVVER_$C(34)_" PatchID="_$C(34)_EVPATCH_$C(34)_">")
 Q
ENCRYPT(EVSTR) ;
 ;debug code
 ;N CNTR
 ;end debug code
 ;S EVSBUF=EVSBUF_EVSTR
 ;I $L(EVSBUF)>253 D
 ;. S EVLINE=$E(EVSBUF,1,253)
 ;. S EVSBUF=$E(EVSBUF,254,$L(EVSBUF))
 ;. D SENDL^EVETLID(0)
 ;. Q
 ;Q
 ;
 F  D  Q:EVSTR=""
 . S EVSBUF=EVSBUF_$E(EVSTR,1,253)
 . S EVSTR=$E(EVSTR,254,9999)
 . I $L(EVSBUF)>253 D
 . . S EVLINE=$E(EVSBUF,1,253)
 . . S EVSBUF=$E(EVSBUF,254,$L(EVSBUF))
 . . D SENDL^EVETLID(0)
 Q
 ;
EXTRACT ;List of extarct and routine
 ;;Radiology_Reports;^EVETV7;Radiology
 ;;Physicals;^EVETV8;Vitals
 ;;Admissions;^EVETV2;Admissions data
 ;;Appointments;^EVETV3;Appointments
 ;;Personal_Information;^EVETV1;Demographics
 ;;Prescriptions;^EVETV5;Pharmacy
 ;;Discharge_Summaries;^EVETV6;Discharge summary
 ;;Progress_Notes;^EVETV4;Progress Notes
 ;;Problem_List;^EVETV9;Problem List
 ;;Allergies;^EVETV14;Allergy data
 ;;Lab_Pathology;^EVETV10;Lab Pathology extracts
 ;;Lab_Cytology;^EVETV12;Lab Cytology extracts
 ;;Lab_Microbiology;^EVETV15;Lab Microbiology extracts
 ;;Lab_Microscopy;^EVETV16;Lab Microscopy extracts
 ;;ECG;^EVETV17;ECG extracts
 ;;Reminders;^EVETV18;clinical reminders extracts
 ;;Lab_Chem;^EVETV11;Lab Chemistry extracts
 ;;Copay;^EVETV19;Copay extracts
 ;;END
 ;*** no longer used
 ;;Lab Report;^EVETV13;Lab extracts
 ;
XML ; List of XML tags, the variable it will be set in to and the description
 ;;user_name;EVUSERN; Evault user name
 ;;icn;EVUICN; Evault User ICN
 ;;site_number;EVSITE; Site
 ;;last_update_date;EVFROMD; Date to run request from (min 3 months)
 ;;request_date;EVRDAT; Date of evault request
 ;;END
 ;;update_requested;EVREQU; Evault request see line label EXTRACT for list
 ;
ERROR ; List of tags for the Update Reponse message
 ;;icn;EVUSERN; Evault user ICN
 ;;site_number;EVSITE; Site number
 ;;result;EVRESU;Error reults
 ;;END
