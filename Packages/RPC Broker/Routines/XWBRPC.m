XWBRPC ;OIFO-Oakland/REM - M2M Broker Server MRH ; 8/28/2013 10:42am
 ;;1.1;RPC BROKER;**28,34,991**;Mar 28, 1997;Build 9
 ;
 QUIT  ; routine XWBRPC is not callable at the top
 ;
 ; ---------------------------------------------------------------------
 ;                   RPC Server: Message Request Handler (MRH)
 ; ---------------------------------------------------------------------
 ;
 ; Change History:
 ;
 ; 2002 08 10 OIFO/REM: XWB*1.1*28 SEQ #25, M2M Broker. Original routine
 ; created. 
 ;
 ; 2005 10 26 OIFO/REM: XWB*1.1*34 SEQ #33, M2M Bug Fixes. Added
 ; $$CHARCHK^XWBUTL before writing to WRITE^XWBRL to escape CR. Removed
 ; $C(13). CR were not being stripped out in result. in PROCESS.
 ;
 ; 2013 08 16-28 VEN/TOAD: XWB*1.1*991 SEQ #46, M2M Security Fixes. LOG
 ; eliminated. Calls to LOG replaced with calls to LOG^XWBDLOG.
 ; Overhauled ERROR to make it extensible and easier to call; reduced
 ; from three parameters to two. Added ERRORS to calculate error
 ; messages from codes. Simplified calls to ERROR to eliminating
 ; old third parameter (error message). Refactored EN and added call
 ; to CHKPRMIT. Added CHKPRMIT based on subroutine in XWBSEC. Move
 ; ERROR and ERRORS right after EN. Shift most "free" RPCs into a new
 ; list of RPCs that are free but require signon first. Add a special
 ; category for XUS GET VISITOR - free but must *not* have signed on
 ; yet. Annotated. Change History added.
 ; in XWBRPC, EN, ERROR, ERRORS, CHKPRMIT, FREERPCS, FALWAYS, FBEFORE,
 ; FBROKER, FSIGNON, FVISTAL, EOR.
 ;
 ; TO DO
 ;
 ; In a future Kernel patch, add XUS GET VISITOR to the XUS SIGNON
 ; broker-context option, so its special handling can be removed from
 ; CHKPRMIT, and so BEFORE can be deleted.
 ;
 ;
EN(XWBDATA) ; -- handle parsed messages request (check & run RPC)
 ; input:
 ;   XWBDATA = parsed XML message
 ; output:
 ;   log & transmit successful RPC results
 ;   or log & transmit error condition
 ;
 ; to do: build/call common broker api for RPC lookup. See XWBBRK.
 ;
 S U="^" ; I'm skeptical that this line is needed
 ;
 ; 1. check remote procedure name
 ;
 N RPCURI S RPCURI=$G(XWBDATA("URI")) ; get RPC name
 I RPCURI="" D  Q  ; missing RPC name
 . D ERROR(1,"NONE") ; No Remote Procedure Specified
 ;
 ; 2. find remote procedure
 ;
 N RPCIEN S RPCIEN=$O(^XWB(8994,"B",RPCURI,"")) ; index on Name (.01)
 I RPCIEN'>0 D  Q  ; if name is not in Name index
 . D ERROR(2,RPCURI) ; Remote Procedure Unknown
 . D ERROR^XWBM2MC(7) ;Write error in TMP **M2M
 ;
 ; 3. check remote procedure record
 ;
 N RPC0 S RPC0=$G(^XWB(8994,RPCIEN,0)) ; Remote Procedure (8994) header
 I RPC0="" D  Q  ; if header node is empty
 . D ERROR(3,RPCURI) ; Remote Procedure Blank
 ;
 ; 4. get essential remote procedure fields
 ;
 S RPCURI=$P(RPC0,U) ; Name (.01) fld
 N TAG S TAG=$P(RPC0,U,2) ; Tag (.02) fld
 N ROU S ROU=$P(RPC0,U,3) ; Routine (.03) fld
 S XWBPTYPE=$P(RPC0,U,4) ; Return Value Type (.04) fld
 N RPCINACT S RPCINACT=$P(RPC0,U,6) ; Inactive (.06) fld
 S XWBWRAP=$P(RPC0,U,8) ; Word Wrap On (.08) fld
 ;
 ; 5. ensure remote procedure is active
 ;
 ; 1 = Inactive, 2 = Local Inactive (Active Remotely)
 I RPCINACT=1!(RPCINACT=2) D  Q  ; if inactive
 . D ERROR(4,RPCURI) ; Remote Procedure Inactive
 ;
 ; 6. check whether user has permission to run this remote procedure
 ;
 N XWBNOPE S XWBNOPE=$$CHKPRMIT(RPCURI) ; check permissions
 I XWBNOPE'="" D  Q  ; if no permission
 . D ERROR(XWBNOPE,RPCURI) ; log & transmit error
 K XWBNOPE ; otherwise, we have permission, so clear the local
 ;
 ; 7. build & log method signature
 ;
 N METHSIG S METHSIG=TAG_"^"_ROU_"(.XWBR"_$G(XWBDATA("PARAMS"))_")"
 I $G(XWBDEBUG)>1 D  ; if debug=2 or 3, "verbose" or "very verbose"
 . D LOG^XWBDLOG("Method Signature = "_METHSIG)
 ;
 ; 8. run method (remote procedure)
 ;
 ; note: See that the NULL device is current
 N XWBR ; results from remote procedure
 D @METHSIG ; call RPC
 ;
 ; 9. log results
 ;
 I $G(XWBDEBUG)>2 D  ; if debug=3, "very verbose"
 . D LOG^XWBDLOG("Response Sent","XWBR")
 ;
 ; 10. transmit results to client via socket
 ;
 D USE^%ZISUTL("XWBM2M SERVER") ; use socket
 U IO ;**M2M use server IO ; I'm unclear why USE^%ZISUTL isn't enough
 D SEND(.XWBR) ; transmit results
 ;
 ; 11. clean up after remote procedure
 ;
 D CLEAN ; clear parameters (why nothing else?)
 ;
 QUIT  ; end of EN
 ;
 ;
ERROR(ERROR,RPCURI) ; -- send rpc application error
 ; input:
 ;   ERROR = error, either numeric code or text message.
 ;      See ERRORS below for values & meanings.
 ;   RPCURI = name (URI) of remote procedure
 ;      if the code is for an error message that includes the RPC name
 ;      then RPCURI is required; otherwise it's optional
 ; output:
 ;   XML error message is transmitted to the client via the socket
 ;   error is logged if debugging is on
 ;
 ; -- build error message from code
 ;
 N CODE,MSG
 I ERROR D  ; if ERROR is a numeric code, calculate the message
 . S CODE=ERROR ; since there's a numeric code, save it
 . N MSGREC S MSGREC=$T(ERRORS+ERROR)
 . S MSG=$P(MSGREC,";",4) ; first part of error message
 . N MSGP2 S MSGP2=$P(MSGREC,";",5) ; second part of error message
 . Q:MSGP2=""  ; if no second part, we're done building error message
 . S MSG=MSG_RPCURI_MSGP2 ; otherwise, build the rest of the message
 E  D  ; if it's a string, then it is the message
 . S CODE=0 ; since there's no code, create a placeholder
 . S MSG=ERROR
 ;
 ; -- log error if debugging is on
 ;
 I $G(XWBDEBUG) D  ; log read error if debugging is on
 . N XWBENAME ; name of error
 . I XWBDEBUG=1 D  ; if debug=1, "on"
 . . S XWBENAME="Error"
 . E  D  ; if debug=2 or 3, "verbose" or "very verbose"
 . . S XWBENAME="Error: "_MSG
 . D LOG^XWBDLOG(XWBENAME) ; log the error
 ;
 ; -- build & transmit error message to client
 ;
 D PRE^XWBRL
 D WRITE^XWBRL($$XMLHDR^XWBUTL())
 D WRITE^XWBRL("<vistalink type=""VA.RPC.Error"" >")
 D WRITE^XWBRL("<errors>")
 D WRITE^XWBRL("<error code="""_CODE_""" uri="""_$G(RPCURI)_""" >")
 D WRITE^XWBRL("<msg>"_$G(MSG)_"</msg>")
 D WRITE^XWBRL("</error>")
 D WRITE^XWBRL("</errors>")
 D WRITE^XWBRL("</vistalink>")
 D POST^XWBRL ; send eot and flush buffer
 ;
 ; -- clean up message handler environment
 ;
 D CLEAN
 ;
 QUIT  ; end of ERROR
 ;
 ;
ERRORS ; error messages for each error code (1-5 picked by code)
 ;;1;No Remote Procedure Specified.
 ;;2;Remote Procedure Unknown: ';' cannot be found.
 ;;3;Remote Procedure Blank: ';' contains no information.
 ;;4;Remote Procedure Inactive: ';' cannot be run at this time.
 ;;5;Application context has not been created.
 ;;6;No such option in the "B" cross reference of the Option File.
 ;;7;No such option in the Option File.
 ;;8;This option is not a Client/Server-type option.
 ;;9;Option out of order with message: |msg|.
 ;;10;Option locked, |user| does not hold the key.
 ;;11;Reverse lock, |user| holds the key.
 ;;12;This option is time restricted.
 ;;13;User |user| does not have access to option |option|
 ;;14;No RPC subfile defined for the option |option|.
 ;;15;No remote procedure calls registered for the option |option|.
 ;;16;No RPC by that name in the "B" cross-reference of the Remote Procedure File.
 ;;17;No such procedure in the Remote Procedure File.
 ;;18;The remote procedure |rpc| is not registered to the option |option|.
 ;;19;Remote procedure is locked.
 ;;20;Remote procedure request failed rules test.
 ;;21;Your menus are being rebuilt.  Please try again later.
 ;
 ;
CLEAN ; -- clean up message handler environment
 NEW POS
 ; -- kill parameters
 SET POS=0
 FOR  S POS=$O(XWBDATA("PARAMS",POS)) Q:'POS  K @XWBDATA("PARAMS",POS)
 Q
 ;
 ;
CHKPRMIT(XWBRP) ; check whether remote procedure may be run
 ; input:
 ;   XWBRP = remote procedure to check
 ; output = "" if user has permission, error code if not
 ;
 ; 1. default to allowing RPC to be run (no error code)
 ;
 ; 2. if we've identified the user and it's a programmer, run anything
 ;
 I $$KCHK^XUSRB("XUPROGMODE") Q "" ; user holds the XUPROGMODE key?
 ;
 ; 3. until user is identified, require signon context
 ;
 I '$G(DUZ) D  ; if we don't have a user
 . S DUZ=0 ; set to no user
 . S XQY0="XUS SIGNON" ; set to signon context
 ;
 ; 4. allow free RPCs, which can be called from any context
 ;
 N FREE S FREE=1 ; default to free
 D
 . N FIND S FIND=U_XWBRP_U ; encapsulated RPC name
 . I $P($T(FALWAYS),";;",2,999)[FIND D  Q  ; RPCs that are always free
 . I $P($T(FBEFORE),";;",2,999)[FIND D  Q  ; RPCs free before signon
 . . I DUZ S FREE=0 ; not free after signon
 . I 'DUZ S FREE=0 Q  ; remaining free RPCs are not free before signon
 . Q:$P($T(FBROKER),";;",2,999)[FIND  ; free broker RPCs
 . Q:$P($T(FSIGNON),";;",2,999)[FIND  ; free signon RPCs
 . Q:$P($T(FVISTAL),";;",2,999)[FIND  ; free vistalink RPCs
 . S FREE=0 ; all other RPCs require security checks
 I FREE Q "" ; everyone has permission to run free RPCs
 ;
 ; 5. in signon context, only allow XUS and XWB remote procedures
 ;
 I $G(XQY0)="" Q 5
 I XQY0="XUS SIGNON","^XUS^XWB^"'[(U_$E(XWBRP,1,3)_U) Q 5
 ; 5 = Application context has not been created.
 ;
 ; 6. otherwise, screen remote procedure by context and user
 ;
 ; note: XQCS allows all users access to the XUS SIGNON context.
 ; Also to any context in the XUCOMMAND menu.
 ;
 N XWBALLOW S XWBALLOW=$$CHK^XQCS(DUZ,$P(XQY0,U),XWBRP) ; do the check
 I XWBALLOW Q "" ; if access is allowed
 ;
 QUIT XWBALLOW ; end of CHKPRMIT ; if not allowed, return error message
 ;
 ;
FREERPCS ; list of RPCs always allowed
 ;
FALWAYS ;;^XWB IM HERE^XUS KAAJEE LOGOUT^
FBEFORE ;;^XUS GET VISITOR^
FBROKER ;;^XWB CREATE CONTEXT^XWB RPC LIST^XWB IS RPC AVAILABLE^
FSIGNON ;;^XUS GET USER INFO^XUS GET TOKEN^XUS SET VISITOR^
FVISTAL ;;^XUS KAAJEE GET USER INFO^
 ;
 ;
SEND(XWBR) ; -- stream rpc data to client
 NEW XWBFMT,XWBFILL
 SET XWBFMT=$$GETFMT()
 ; -- prepare socket for writing
 DO PRE^XWBRL
 ; -- initialize
 DO WRITE^XWBRL($$XMLHDR^XWBUTL())
 ;DO DOCTYPE
 DO WRITE^XWBRL("<vistalink type=""Gov.VA.Med.RPC.Response"" ><results type="""_XWBFMT_""" ><![CDATA[")
 ; -- results
 DO PROCESS
 ; -- finalize
 DO WRITE^XWBRL("]]></results></vistalink>")
 ; -- send eot and flush buffer
 DO POST^XWBRL
 ;
 QUIT
 ;
DOCTYPE ;
 DO WRITE^XWBRL("<!DOCTYPE vistalink [<!ELEMENT vistalink (results) ><!ELEMENT results (#PCDATA)><!ATTLIST vistalink type CDATA ""Gov.VA.Med.RPC.Response"" ><!ATTLIST results type (array|string) >]>")
 QUIT
 ;
GETFMT() ; -- determine response format type
 IF XWBPTYPE=1!(XWBPTYPE=5)!(XWBPTYPE=6) QUIT "string"
 IF XWBPTYPE=2 QUIT "array"
 ;
 QUIT $S(XWBWRAP:"array",1:"string")
 ;
PROCESS ; -- send the real results
 NEW I,T,DEL,V
 ;
 ;*p34-Remove $C(13). CR were not being stripped out in results to escape CR.
 ;S DEL=$S(XWBMODE="RPCBroker":$C(13,10),1:$C(10))
 S DEL=$S(XWBMODE="RPCBroker":$C(10),1:$C(10))
 ;
 ;*p34-When write XWBR, go thru $$CHARCHK^XWBUTL first.
 ; -- single value
 IF XWBPTYPE=1 SET XWBR=$G(XWBR) DO WRITE^XWBRL($$CHARCHK^XWBUTL($G(XWBR))) QUIT
 ; -- table delimited by CR+LF - ARRAY
 IF XWBPTYPE=2 DO  QUIT
 . SET I="" FOR  SET I=$O(XWBR(I)) QUIT:I=""  DO WRITE^XWBRL($$CHARCHK^XWBUTL($G(XWBR(I)))),WRITE^XWBRL(DEL)
 ; -- word processing
 IF XWBPTYPE=3 DO  QUIT
 . SET I="" FOR  SET I=$O(XWBR(I)) QUIT:I=""  DO WRITE^XWBRL($$CHARCHK^XWBUTL($G(XWBR(I)))) DO:XWBWRAP WRITE^XWBRL(DEL)
 ; -- global array
 IF XWBPTYPE=4 DO  QUIT
 . SET I=$G(XWBR) QUIT:I=""  SET T=$E(I,1,$L(I)-1)
 . I $D(@I)>10 S V=@I D WRITE^XWBRL($$CHARCHK^XWBUTL($G(V)))
 . FOR  SET I=$Q(@I) QUIT:I=""!(I'[T)  S V=@I D WRITE^XWBRL($$CHARCHK^XWBUTL($G(V))) D:XWBWRAP&(V'=DEL) WRITE^XWBRL(DEL)
 . IF $D(@XWBR) KILL @XWBR
 ; -- global instance
 IF XWBPTYPE=5 S XWBR=$G(@XWBR) D WRITE^XWBRL($$CHARCHK^XWBUTL($G(XWBR))) QUIT
 ; -- variable length records only good up to 255 char)
 IF XWBPTYPE=6 SET I="" FOR  SET I=$O(XWBR(I)) QUIT:I=""  DO WRITE^XWBRL($C($L(XWBR(I)))),WRITE^XWBRL(XWBR(I))
 QUIT
 ;
 ;
 ; ---------------------------------------------------------------------
 ;             RPC Server: Request Message XML SAX Parser Callbacks
 ; ---------------------------------------------------------------------
ELEST(ELE,ATR) ; -- element start event handler
 IF ELE="vistalink" KILL XWBSESS,XWBPARAM,XWBPN,XWBPTYPE QUIT
 ;
 IF ELE="rpc" SET XWBDATA("URI")=$$ESC^XWBRMX($G(ATR("uri"),"##Unkown RPC##")) QUIT
 ;
 IF ELE="param" DO  QUIT
 . SET XWBPARAM=1
 . SET XWBPN="XWBP"_ATR("position")
 . SET XWBDATA("PARAMS",ATR("position"))=XWBPN
 . SET XWBPTYPE=ATR("type")
 . S XWBCHRST="" ;To accumulate char
 ;
 IF ELE="index" DO  QUIT
 . ;SET @XWBPN@($$ESC^XWBRMX(ATR("name")))=$$ESC^XWBRMX(ATR("value"))
 . S XWBPN("name")=$$ESC^XWBRMX(ATR("name")) ;rwf
 . S XWBCHRST=""
 ;
 QUIT
 ;
ELEND(ELE) ; -- element end event handler
 IF ELE="vistalink" KILL XWBPOS,XWBSESS,XWBPARAM,XWBPN,XWBPTYPE,XWBCHRST QUIT
 ;
 IF ELE="params" DO  QUIT
 . NEW POS,PARAMS
 . SET PARAMS="",POS=0
 . FOR  SET POS=$O(XWBDATA("PARAMS",POS)) Q:'POS  SET PARAMS=PARAMS_",."_XWBDATA("PARAMS",POS)
 . SET XWBDATA("PARAMS")=PARAMS
 ;
 IF ELE="param" D  Q
 . I $G(XWBDEBUG)>2,$D(XWBPN),$D(@XWBPN) D  ; if debug=3, "very verbose"
 . . D LOG^XWBDLOG("Param: "_XWBPN,$NA(@XWBPN))
 . KILL XWBPARAM,XWBCHRST
 ;
 QUIT
 ;
 ;This can be called more than once for one TEXT string.
CHR(TEXT) ; -- character value event handler <tag>TEXT</tag)
 ;
 IF $G(XWBPARAM) DO
 . ;What to do if string gets too long?
 . ;IF XWBPTYPE="string" SET XWBCHRST=XWBCHRST_$$ESC^XWBRMX(TEXT),@XWBPN=XWBCHRST QUIT
 . IF XWBPTYPE="string" SET XWBCHRST=XWBCHRST_TEXT,@XWBPN=XWBCHRST  QUIT
 . ;IF XWBPTYPE="ref" SET @XWBPN=$G(@$$ESC^XWBRMX(TEXT)) QUIT
 . IF XWBPTYPE="ref" SET XWBCHRST=XWBCHRST_TEXT,@XWBPN=@XWBCHRST QUIT
 . I XWBPTYPE="array" S XWBCHRST=XWBCHRST_TEXT,@XWBPN@(XWBPN("name"))=XWBCHRST Q  ;rwf
 QUIT
 ;
 ; ---------------------------------------------------------------------
 ;            Parse Results of Successful Legacy RPC Request
 ; ---------------------------------------------------------------------
 ;
 ; [Public/Supported Method]
PARSE(XWBPARMS,XWBY) ; -- parse legacy rpc results ; uses SAX parser
 NEW XWBCHK,XWBOPT,XWBTYPE,XWBCNT
 ;
 ;**M2M Result will go here.
 I XWBY="" D
 .IF $G(XWBY)="" SET XWBY=$NA(^TMP("XWBM2MRPC",$J,"RESULTS"))
 .SET XWBYX=XWBY
 .KILL @XWBYX
 ;
 DO SET
 SET XWBOPT=""
 DO EN^MXMLPRSE(XWBPARMS("RESULTS"),.XWBCBK,.XWBOPT)
 Q
 ;
SET ; -- set the event interface entry points ;
 SET XWBCBK("STARTELEMENT")="RESELEST^XWBRPC"
 SET XWBCBK("ENDELEMENT")="RESELEND^XWBRPC"
 SET XWBCBK("CHARACTERS")="RESCHR^XWBRPC"
 QUIT
 ;
RESELEST(ELE,ATR) ; -- element start event handler
 IF ELE="results" SET XWBTYPE=$G(ATR("type")),XWBCNT=0
 QUIT
 ;
RESELEND(ELE) ; -- element end event handler
 KILL XWBCNT,XWBTYPE
 QUIT
 ;
RESCHR(TEXT) ; -- character value event handler
 QUIT:$G(XWBTYPE)=""
 QUIT:'$L(TEXT)  ; -- Sometimes sends in empty string
 ;
 IF XWBCNT=0,TEXT=$C(10) QUIT  ; -- bug in parser? always starts with $C(10)
 ;
 IF XWBTYPE="string" DO  QUIT
 . SET XWBCNT=XWBCNT+1
 . SET @XWBY@(XWBCNT)=TEXT
 ;
 IF XWBTYPE="array" DO
 . SET XWBCNT=XWBCNT+1
 . SET @XWBY@(XWBCNT)=$P(TEXT,$C(10))
 QUIT
 ;
PARSEX(XWBPARMS,XWBY) ; -- parse legacy rpc results ; uses DOM parser
 NEW XWBDOM
 SET XWBDOM=$$EN^MXMLDOM(XWBPARMS("RESULTS"),"")
 DO TEXT^MXMLDOM(XWBDOM,2,XWBY)
 DO DELETE^MXMLDOM(XWBDOM)
 QUIT
 ;
 ;
 ; -------------------------------------------------------------------
 ;                   Response Format Documentation
 ; -------------------------------------------------------------------
 ;
 ;
 ; [ Sample XML produced by a successful call of EN^XWBRPC(.XWBPARMS).
 ;   SEND^XWBRPC does the actual work to produce response.             ]
 ;
 ; <?xml version="1.0" encoding="utf-8" ?>
 ; <vistalink type="Gov.VA.Med.RPC.Response" >
 ;     <results type="array" >
 ;         <![CDATA[4261;;2961001.08^2^274^166^105^^2961001.1123^1^^9^2^8^10^^^^^^^10G1-ALN
 ;         4270;;2961002.08^2^274^166^112^^^1^^9^2^8^10^^^^^^^10G8-ALN
 ;         4274;;2961003.08^2^274^166^116^^^1^^9^2^8^10^^^^^^^10GD-ALN
 ;         4340;;2961117.08^2^274^166^182^^2961118.1425^1^^9^2^8^10^^^^^^^10K0-ALN
 ;         4342;;2961108.13^2^108^207^183^^2961118.1546^1^^9^2^8^10^^^^^^^10K2-ALN
 ;         6394;;3000607.084^2^165^68^6479^^3000622.13^1^^9^1^8^10^^^^^^^197M-ALN]]>
 ;     </results>
 ; </vistalink>
 ;
 ; -------------------------------------------------------------------
 ;
 ; [ Sample XML produced by a unsuccessful call of EN^XWBRPC(.XWBPARMS).
 ;   ERROR^XWBRPC does the actual work to produce response.             ]
 ;
 ; <?xml version="1.0" encoding="utf-8" ?>
 ; <vistalink type="Gov.VA..Med.RPC.Error" >
 ;    <errors>
 ;       <error code="2" uri="XWB BAD NAME" >
 ;           <msg>
 ;              Remote Procedure Unknown: 'XWB BAD NAME' cannot be found.
 ;           </msg>
 ;       </error>
 ;    </errors>
 ; </vistalink>
 ;
 ; -------------------------------------------------------------------
 ;
 ;
EOR ; end of routine XWBRPC
