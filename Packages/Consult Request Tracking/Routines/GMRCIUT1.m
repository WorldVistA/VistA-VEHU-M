GMRCIUT1 ;SLC/JFR - UTILITIES FOR INTER-FACILITY CONSULTS ; Jul 31, 2024@05:39:44
 ;;3.0;CONSULT/REQUEST TRACKING;**189**;DEC 27, 1997;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q  ;don't start at the top
 ;
CHKPROXY(GMRCDA,GMRCDFN,STA,DONOTLOG) ;
 ;
 ;  GMRCDA   = Consult, pointer to #123
 ;  GMRCDFN  = Patient, pointer to #2
 ;  STA      = Routing station number
 ;  DONOTLOG = Flag to prevent logging in IFC Message Log (#123.6).  1=DO NOT LOG. [OPTIONAL]
 ;
 ;  Checks success/failure of proxy add.  Returns 1 if all is OK and IFC can be sent, 0^REASON if not.
 ;
 ;pull patient Correlation list
 ;
 N DGKEY,DGOUT,CNT,IDS,CERNERID,CONSULTDFN,RTNCODE,EDIPI ;
 ;
 S DGKEY=GMRCDFN_U_"PI"_U_"USVHA"_U_$P($$SITE^VASITE,"^",3)
 D TFL^VAFCTFU2(.DGOUT,DGKEY)
 ; 
 S CONSULTDFN="",CERNERID="" ;
 S CNT=0 F  S CNT=$O(DGOUT(CNT)) Q:'CNT  S IDS=$G(DGOUT(CNT)) D  ;
 .I $P(IDS,"^",4)="200CRNR" I $P(IDS,"^",2)="PI" S CERNERID=IDS ;
 .I $P(IDS,"^",4)=STA I $P(IDS,"^",2)="PI" I $P(IDS,"^",5)="A"!($P(IDS,"^",5)="C") S CONSULTDFN=IDS ;
 ;
 ;  Destination site is converted.
 ;
 I $$CRNRSITE^VAFCCRNR(STA)=1 D  Q RTNCODE ;
 . I CERNERID'="",CONSULTDFN'="" S RTNCODE=1 Q  ;
 . ;
 . I CERNERID="" S RTNCODE="0^CERNER INCOMPLETE" Q  ;
 . ;
 . I CONSULTDFN="" D  Q  ;
 .. ;
 .. ;  Call proxy add for converted VistA.
 .. ;
 .. S EDIPI=$$EDIPI^GMRCIUTL(GMRCDFN) ;
 .. S RTNCODE=$$ADD^DGPROSAD(EDIPI_"~USDOD~NI~200DOD",STA) ;  ICR 7421
 .. I RTNCODE<0 D  ;  Proxy add failed.
 ... I '$G(DONOTLOG) D LOGMSG^GMRCIUTL(GMRCDA,1,"",205) ;
 ... D FAILPRXY("",EDIPI,GMRCDA,"","","",STA,$P(RTNCODE,U,2)) ; P189 WTC 6/24/24
 ... S RTNCODE="0^CONVERTED VISTA INCOMPLETE" ;
 .. Q:$G(DONOTLOG)  ;
 .. ;
 .. ;  Suppress 201 error if IFC already has a 203 error in the message log.  wtc 11.22.23 p189
 .. ;
 .. N ACTIEN,SUPPRESS,LOGIEN S SUPPRESS=0,ACTIEN=0 F  S ACTIEN=$O(^GMR(123.6,"AC",GMRCDA,ACTIEN)) Q:'ACTIEN  D  Q:SUPPRESS  ;
 ... S LOGIEN=0 F  S LOGIEN=$O(^GMR(123.6,"AC",GMRCDA,ACTIEN,1,LOGIEN)) Q:'LOGIEN  I $P($G(^GMR(123.6,LOGIEN,0)),U,8)=203 S SUPPRESS=1 Q  ;
 .. ;
 .. I 'SUPPRESS D LOGMSG^GMRCIUTL(GMRCDA,1,"",201) ;
 ;
 ;  Destination site is non-converted.
 ;
 I $$CRNRSITE^VAFCCRNR(STA)'=1 D  Q RTNCODE ;
 . I CONSULTDFN'="" S RTNCODE=1 Q  ;
 . ;
 . S RTNCODE="0^NON-CONVERTED VISTA INCOMPLETE" ;
 . D LOGMSG^GMRCIUTL(GMRCDA,1,"",201) ;
 ;
 Q "0^UNKNOWN" ;
 ;
FAILPRXY(MSGID,EDIPI,GMRCDA,CRNRORDR,ORDRDESC,ORDRDATE,STA,REASON) ;
 ;
 ;  Send MailMan message when proxy add fails.
 ;
 ;  MSGID    = HL7 Message ID (MSH-10) [OPTIONAL]
 ;  EDIPI    = Patient's EDIPI [OPTIONAL]
 ;  GMRCDA   = Consult IEN (pointer to #123) [OPTIONAL]
 ;  CRNRORDR = Cerner order number [OPTIONAL]
 ;  ORDRDESC = Ordering description [OPTIONAL]
 ;  ORDRDATE = Ordering date in HL7 format [OPTIONAL]
 ;  STA      = Station where proxy add attempted [OPTIONAL]
 ;  REASON   = Proxy add failure reason [REQUIRED]
 ;
 Q:$G(REASON)=""  ;
 ;
 N XMSUB,XMDUZ,XMTEXT,XMY,GRPIEN,MEM,GRP,N ;
 S GRP="IFC PATIENT ERROR MESSAGES" ;
 S XMSUB="Failed IFC transaction: Proxy Add Failed",XMTEXT="XMTEXT(" ;
 S N=0 ;
 I $G(MSGID)'="" S N=N+1,XMTEXT(N)="Message ID: "_MSGID ;
 I $G(EDIPI)'="" S N=N+1,XMTEXT(N)="EDIPI: "_EDIPI ;
 I $G(GMRCDA)'="" S N=N+1,XMTEXT(N)="Consult Number: "_GMRCDA ;
 I $G(CRNRORDR)'="" S N=N+1,XMTEXT(N)="Cerner Order Number: "_CRNRORDR ;
 I $G(ORDRDESC)'="" S N=N+1,XMTEXT(N)="Order Description: "_ORDRDESC ;
 I $G(ORDRDATE)'="" S N=N+1,XMTEXT(N)="Order Date: "_$$FMTE^XLFDT($$HL7TFM^XLFDT(ORDRDATE)) ;
 I $G(STA)'="" S N=N+1,XMTEXT(N)="Station where proxy add attempted: "_STA ;
 S N=N+1,XMTEXT(N)="Failure Reason: "_REASON ;
 S GRPIEN=$O(^XMB(3.8,"B",GRP,"")) Q:'GRPIEN
 ;Set up XMY for MEMBERS
 S MEM=0 F  S MEM=$O(^XMB(3.8,GRPIEN,1,MEM)) Q:'MEM  S XMY($P(^XMB(3.8,GRPIEN,1,MEM,0),U))=""
 ;Set up XMY for MEMBERS REMOTE
 S MEM=0 F  S MEM=$O(^XMB(3.8,GRPIEN,6,MEM)) Q:'MEM  S XMY($P(^XMB(3.8,GRPIEN,6,MEM,0),U))=""
 Q:'$D(XMY)
 S XMDUZ=GRP
 D XMZ^XMA2 ; call Create Message Module
 D EN1^XMD
 Q  ;
 ;
ROUTE(GMRCDA)  ; determine correct routing for IFC msg  <<<<<<<<<============OLD CODE FROM GMRCIEVT.  NOT USED.
 ; Input:
 ; GMRCDA = ien from file 123
 ;
 ; Output:
 ; the logical link to send the message to in format
 ; "GMRC IFC SUBSC^VHAHIN^STATION"
 ;need to understanding their queuing
 N SITE,GMRCLINK,STA
 N DGKEY,DGOUT,CNT,IDS,CERNERID,CONSULTDFN,GMRCDFN,MPIDATA,RETURN,PATARR,X
 S (RETURN,CERNERID,CONSULTDFN)=""
 S SITE=$P(^GMR(123,GMRCDA,0),U,23) I 'SITE Q "" ;no ROUTING FACILITY
 S STA=$$STA^XUAF4(SITE) I '$L(STA) Q "" ;can't find station num for that site
 ;
 D LINK^HLUTIL3(STA,.GMRCLINK,"I")
 ;
 ;WCJ; if no patient - should not happen
 S GMRCDFN=$P(^GMR(123,GMRCDA,0),U,2) I 'GMRCDFN Q ""
 ;
 ;pull patient Correlation list
 S DGKEY=GMRCDFN_U_"PI"_U_"USVHA"_U_$P($$SITE^VASITE,"^",3)
 D TFL^VAFCTFU2(.DGOUT,DGKEY)
 ;
 S CNT=0 F  S CNT=$O(DGOUT(CNT)) Q:'CNT  S IDS=$G(DGOUT(CNT)) D
 .I $P(IDS,"^",4)="200CRNR" I $P(IDS,"^",2)="PI" S CERNERID=IDS
 .I $P(IDS,"^",4)=STA I $P(IDS,"^",2)="PI" I $P(IDS,"^",5)="A"!($P(IDS,"^",5)="C") S CONSULTDFN=IDS
 ;
 ;is consulting site known in the list and if site is Cerner enabled but not known
 I CONSULTDFN'="" D
 . ; if consulting site is known and it is NOT a Cerner enabled site
 . I $P(CONSULTDFN,"^",5)'="C" D  Q
 .. S GMRCLINK=$O(GMRCLINK(0)) I 'GMRCLINK Q  ; no link for that site
 .. S GMRCLINK=GMRCLINK(GMRCLINK) I '$L(GMRCLINK) Q  ;no link name
 .. S RETURN="GMRC IFC SUBSC^"_GMRCLINK_U_STA Q  ;MKN GMRC*3*154 added STA to RETURN
 . ;
 . ; if consulting site is known and it is a Cerner enabled site but patient unknown to Cerner
 . I $P(CONSULTDFN,"^",5)="C",(CERNERID="") S RETURN=$$GETLINK(STA) Q
 . ; if consulting site is known and it is a Cerner enabled site
 . I $P(CONSULTDFN,"^",5)="C",(CERNERID'="") D
 .. ; if Cerner enabled site AND Cerner knows patient set route to VDIF regional router
 .. S RETURN=$$GETLINK(STA) ;MKN GMRC*3*154 added STA to RETURN
 I CONSULTDFN="" D
 . ;
 . ;  If patient not found on converted VistA, call proxy add.  p189 wtc 4/13/2023
 . ;
 . I CERNERID'="" N RTNCODE D  Q:RTNCODE>0  ; WTC 9.8.23
 .. ;
 .. ;  Call proxy add.  If successful, get link name.  Otherwise, allow 201 error to be generated.
 .. ;
 .. N EDIPI ;
 .. S EDIPI=$$EDIPI^GMRCIUTL($$GET1^DIQ(123,GMRCDA,.02,"I")) ;
 .. S RTNCODE=$$ADD^DGPROSAD(EDIPI_"~USDOD~NI~200DOD",STA) ;  ICR 7421
 .. Q:RTNCODE<0  ;  Proxy add failed.  wtc 4/13/2023, 9/26/23
 .. S RETURN=$$GETLINK(STA) ;
 . ;
 . ;  Suppress 201 error if IFC already has a 203 error in the message log.  wtc 11.22.23 p189
 . ;
 . N ACTIEN,SUPPRESS,LOGIEN S SUPPRESS=0,ACTIEN=0 F  S ACTIEN=$O(^GMR(123.6,"AC",GMRCDA,ACTIEN)) Q:'ACTIEN  D  Q:SUPPRESS  ;
 .. S LOGIEN=0 F  S LOGIEN=$O(^GMR(123.6,"AC",GMRCDA,ACTIEN,1,LOGIEN)) Q:'LOGIEN  I $P($G(^GMR(123.6,LOGIEN,0)),U,8)=203 S SUPPRESS=1 Q  ;
 . ;
 . I 'SUPPRESS D LOGMSG^GMRCIUTL(GMRCDA,1,"",201)
 . S RETURN=""
 ;
 Q RETURN
 ;
GETLINK(STA) ;  <<<<<<<<<============OLD CODE FROM GMRCIEVT
 N GMRCLINK
 D LINK^HLUTIL3(STA,.GMRCLINK,"I")
 S GMRCLINK(1)=$$GET^XPAR("SYS","GMRC IFC REGIONAL ROUTER",1)
 S GMRCLINK=$O(GMRCLINK(0)) I 'GMRCLINK Q "" ; no link for that site
 S GMRCLINK=GMRCLINK(GMRCLINK) I '$L(GMRCLINK) Q "" ;no link name
 Q "GMRC IFC SUBSC^"_GMRCLINK(1)_U_STA
 ;
