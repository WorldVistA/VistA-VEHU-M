EVETV8 ;DALOI/DS - Extraction procedures for VITALS data to be stored on eVault ; 12/3/02 9:58am
 ;;1.0;HEALTH EVET;**1**;Nov 05, 2002
 Q
 ;
 ; EVETDFN      = DFN (ien of PATIENT file (#2)
 ; EVBDATE      = FileMan date at which to begin data extraction
 ; EVREQID      = REQUEST ID REPRESENTING MESSAGE IDENTIFIER RECEIVED
 ;                FROM HEALTH EVET
 ;
GET(EVDFN,HVSD,EVREQ) ;
 S X="ETRAP^EVETU1",@^%ZOSF("TRAP")
 ;D EN6^GMVDCRPC(.EVPATH,EVDFN,3,"~ALL~",HVSD,$$NOW^XLFDT(),"C",1)
 N DFN,GMRVSTR,EVCAT,EVIEN,EVX,EVCNT,EVTEMP,HVDAT
 S DFN=EVDFN
 S GMRVSTR="AG;AUD;BP;CG;CVP;FH;FT;HC;HE;HT;P;PN;PO2;R;T;TON;VC;VU;WT"
 S GMRVSTR(0)=HVSD_"^"_$$NOW^XLFDT()_"^99999^1"
 D EN1^GMRVUT0
 ; Now convert output
 S HVDAT=1,EVCNT=1,EVCAT="",EVIEN=""
 ;S RTN=$T(+0)
 S EVCNT=$O(^TMP("EVETLIS",$J,EVREQ,""),-1)+1
 S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"START_Physicals")=""
 S EVCNT=EVCNT+1
 F  S HVDAT=$O(^UTILITY($J,"GMRVD",HVDAT)) Q:HVDAT=""  D
 . F  S EVCAT=$O(^UTILITY($J,"GMRVD",HVDAT,EVCAT)) Q:EVCAT=""  D
 . . F  S EVIEN=$O(^UTILITY($J,"GMRVD",HVDAT,EVCAT,EVIEN)) Q:EVIEN=""  D
 . . . S EVTEMP=$G(^UTILITY($J,"GMRVD",HVDAT,EVCAT,EVIEN))
 . . . Q:EVTEMP=""
 . . . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"ien")=EVIEN
 . . . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"date_time_taken")=$$XMLDATE^EVETU1($P(EVTEMP,"^",1))
 . . . S EVX=$P(EVTEMP,"^",3)
 . . . S EVX=$G(^GMRD(120.51,EVX,0))
 . . . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"vital_type")=$P(EVX,"^",1)
 . . . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"date_time_entered")=$$XMLDATE^EVETU1($P(EVTEMP,"^",4))
 . . . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"measurment")=$P(EVTEMP,"^",8)
 . . . S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"qualifiers")=$TR($P(EVTEMP,"^",11)," ;",",")
 . . . S EVCNT=EVCNT+1
 . . . Q
 . . Q
 . Q
 S ^TMP("EVETLIS",$J,EVREQ,EVCNT,"END_Physicals")=""
 K ^UTILITY($J,"GMRVD")
 Q
