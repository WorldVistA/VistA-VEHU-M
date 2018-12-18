XWBRM ;OIFO-Oakland/REM - M2M Broker Server Request Mgr ; 8/28/2013 10:41am
 ;;1.1;RPC BROKER;**28,45,991**;Mar 28, 1997;Build 9
 ;
 QUIT  ; routine XWBRM is not callable at the top
 ;
 ; Change History:
 ;
 ; 2002 08 10 OIFO/REM: XWB*1.1*28 SEQ #25, M2M Broker. Original routine
 ; created.
 ;
 ; 2004 04 27 OIFO/REM: XWB*1.1*45 SEQ #38, Broker Security Enhancement.
 ; Begin plugging hole caused by CAPRI. in EN.
 ;
 ; 2013 08 16-28 VEN/TOAD: XWB*1.1*991 SEQ #46, M2M Security Fixes.
 ; Log close and error events. Eliminate unused flag XWBM2M; lets new
 ; XWBM2M parameter occupy that name. Refactor EN. Eliminate unfinished
 ; & unused subroutines. Change History added.
 ; in XWBRM, EN, SECCHK, CHKTOKEN, CHKDUZ, SECERR, SECERRS, EOR.
 ;
 ;
 ; ---------------------------------------------------------------------
 ;                             Server Request Manager (SRM)
 ; ---------------------------------------------------------------------
 ;
EN(XWBROOT) ; -- main entry point for SRM
 ; input:
 ;   XWBROOT = name of array where raw message input is stored
 ; output:
 ;   return value = true (1) if it's okay to continue
 ;      false (0) if not
 ;      but the return value is ignored by NXTCALL^XWBVLL
 ;   XWBSTOP = true (1) if the main loop should stop after this
 ;      false (0) if it should continue processing XML messages
 ;
 ; -- parse the xml
 N XWBOPT S XWBOPT="" ; option flags for XML parse
 N XWBDATA ; return array for parsed XML message
 D EN^XWBRMX(XWBROOT,.XWBOPT,.XWBDATA) ; parse the message
 ;
 ; -- allow broker-security-enhancement visitor access from M2M^XUSBSE1
 I $G(XWBDATA("URI"))="XUS GET VISITOR" D  Q 1
 . D EN^XWBRPC(.XWBDATA) ; call the visitor RPC
 . I '$D(DUZ) S XWBSTOP=1 ; only continue loop if IDed user
 ;
 ; -- initialize for XUS SIGNON SETUP
 I $G(XWBDATA("MODE"))="RPCBroker",XWBDATA("URI")="XUS SIGNON SETUP" D
 . S XWBTDEV=""
 . S XWBTIP=""
 . S XWBVER="1.1" ; Broker version
 . S XWBSTOP=0 ; for signon setup, continue main loop afterward
 ;
 ; -- single call processing
 I $G(XWBDATA("MODE"),"single call")="single call" D
 . S XWBSTOP=1 ; for a single call, we will not continue the loop after
 ;
 ; -- check if app defined
 I $G(XWBDATA("APP"))="" D  Q 0
 . D RMERR(1) ; report missing app
 ;
 ; -- process close request
 I $G(XWBDATA("APP"))="CLOSE" D  Q 0
 . D:$G(DUZ) LOGOUT^XUSRB ; logout user and cleanup
 . D RESPONSE^XWBVL() ; send XML response
 . I $G(XWBDEBUG) D  ; if debugging is on
 . . D LOG^XWBDLOG("Close App") ; record close event
 . S XWBSTOP=1 ; end main loop
 ;
 ; -- screen out all non-RPC apps
 I $G(XWBDATA("APP"))'="RPC" Q 0
 ;
 ; -- call app to write to socket
 N XWBMODE S XWBMODE=$G(XWBDATA("MODE")) ; identify M-to-M Broker mode
 D EN^XWBRPC(.XWBDATA) ; call remote procedure & send reply to client
 ;
 QUIT 1 ; end of EN
 ;
 ;
 ; ---------------------------------------------------------------------
 ;                 Request Manager and Security Error Handlers
 ; ---------------------------------------------------------------------
 ;
RMERR(XWBCODE) ; -- send request error message
 NEW XWBDAT,XWBMSG
 SET XWBMSG=$P($TEXT(RMERRS+XWBCODE),";;",2)
 SET XWBDAT("MESSAGE TYPE")="Gov.VA.Med.Foundations.Errors"
 SET XWBDAT("ERRORS",1,"CODE")=1
 SET XWBDAT("ERRORS",1,"ERROR TYPE")="request manager"
 SET XWBDAT("ERRORS",1,"CDATA")=1
 SET XWBDAT("ERRORS",1,"MESSAGE",1)="An Request Manager error occurred: "_XWBMSG
 DO ERROR^XWBUTL(.XWBDAT)
 QUIT
 ;
RMERRS ; -- application errors
 ;;No valid application specified.
 ;
 ;
EOR ; end of routine XWBRM
