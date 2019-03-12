XWBVLL ;OIFO-Oakland/REM - M2M Broker Listener ; 8/28/2013 10:45am
 ;;1.1;RPC BROKER;**28,41,34,991**;Mar 28, 1997;Build 9
 ;
 QUIT  ; routine XWBVLL is not callable at the top
 ;
 ; Change History:
 ;
 ; 2002 08 10 OIFO/REM: XWB*1.1*28 SEQ #25, M2M Broker. Original routine
 ; created. 
 ;
 ; 2004 04 27 OIFO/REM: XWB*1.1*41 SEQ #29, M2M Infinite Loop. Fixed
 ; infinite loop bug in SYSERR. Created new Cache/VMS tcpip entry point,
 ; called from XWBSERVER_START.COM file. in SYSERR, CACHEVMS.
 ;
 ; 2005 10 26 OIFO/REM: XWB*1.1*34 SEQ #33, M2M Bug Fixes. Added
 ; "BrokerM2M" in message type. Removed the quotes (") after 'M:'. Added
 ; new entry point to job off the listener for Cache: STRT^XWBVLL(PORT).
 ; Cleared locks when error occurs. Halt for read/write errors.
 ; in SYSERR, SYSERRS, STRT.
 ;
 ; 2013 08 16-28 VEN/TOAD: XWB*1.1*991 SEQ #46, M2M Security Fixes.
 ; Replaced non-standard error logging. Log errors. Apply logging
 ; levels. Fix init of variables & log. Annotated. Change History added.
 ; in XWBVLL, SPAWN, NXTCALL, SYSERR, EOR.
 ;
 ;
START(SOCKET) ;Entry point for Cache/NT
 ;May be called directly to start the listener.
 ;SOCKET -is the port# to start the listener on.
 I ^%ZOSF("OS")'["OpenM" Q  ;Quits if not a Cache OS.
 D LISTEN^%ZISTCPS(SOCKET,"SPAWN^XWBVLL")
 Q
 ;
UCX ;DMS/VMS UCX entry point, called from XWBSERVER_START.COM file,
 ;listener,  % = <input variable>
 ;IF $G(%)="" DO ^%ZTER QUIT
 SET (IO,IO(0))="SYS$NET"
 ; **VMS specific code, need to share device**
 OPEN IO:(TCPDEV):60 ELSE  SET ^TMP("XWB DSM CONNECT FAILURE",$H)="" QUIT
 USE IO
 DO SPAWN
 QUIT
 ;
STRT(PORT) ;*p34-This entry is called from option "XWB M2M CACHE LISTENER" and jobs off the listener for Cache/NT.  Will call START.
 ;PORT -is the port# to start the listener on.
 J START^XWBVLL(PORT)::5 ;Used in place of TaskMan
 Q
 ;
CACHEVMS ;Cache/VMS tcpip entry point, called from XWBSERVER_START.COM fLle *p41*
 SET (IO,IO(0))="SYS$NET"
 ; **CACHE/VMS specific code**
 OPEN IO::60 ELSE  SET ^TMP("XWB DSM CONNECT FAILURE",$H)="" QUIT
 X "U IO:(::""-M"")" ;Packet mode like DSM
 DO SPAWN
 QUIT
 ;
SPAWN ; -- spawned process
 NEW XWBSTOP
 SET XWBSTOP=0
 ;
 ; -- initialize tcp processing variables
 I $G(XWBOS)="" D  ; if we have not already initialized,
 . D INIT^XWBTCPM ; set up locals and start log
 ;
 ; -- set error trap
 NEW $ESTACK,$ETRAP S $ETRAP="D ^%ZTER HALT"
 ;
 ; -- change job name if possible
 ;DO SETNM^%ZOSV("XWBSERVER: Server") ;**M2M - comment out for now
 DO SAVDEV^%ZISUTL("XWBM2M SERVER") ;**M2M save off server IO
 ;
 ; -- loop until told to stop
 FOR  DO NXTCALL QUIT:XWBSTOP
 ;
 ; -- final/clean tcp processing variables
 D RMDEV^%ZISUTL("XWBM2M SERVER") ;**M2M remove server IO
 Q
 ;
NXTCALL ; -- do next call
 NEW U,DTIME,DT,X,XWBROOT,XWBREAD,XWBTO,XWBFIRST,XWBOK,XWBRL,BUG
 ;
 ; -- set error trap
 NEW $ESTACK,$ETRAP S $ETRAP="D SYSERR^XWBVLL"
 ;
 ; -- setup environment variables
 SET U="^",DTIME=900,DT=$$DT^XLFDT()
 SET XWBREAD=20,XWBTO=36000,XWBFIRST=1
 ;
 ; -- setup intake global - root is request data
 SET XWBROOT=$NA(^TMP("XWBVLL",$J))
 KILL @XWBROOT
 ;
 ; -- set parameters for RawLink
 SET XWBRL("TIME OUT")=36000
 SET XWBRL("READ CHARACTERS")=20
 SET XWBRL("FIRST READ")=1
 SET XWBRL("STORE")=XWBROOT
 SET XWBRL("STOP FLAG")=XWBSTOP
 ;
 ; -- read from socket
 SET XWBOK=$$READ^XWBRL(XWBROOT,.XWBREAD,.XWBTO,.XWBFIRST,.XWBSTOP)
 ;
 ; -- log request
 I $G(XWBDEBUG)>1 D  ; if debug="verbose" or "very verbose"
 . D LOG^XWBDLOG("Request Received",$NA(^TMP("XWBVLL",$J)))
 ;
 IF 'XWBOK GOTO NXTCALLQ
 ;
 ; -- call request manager
 SET XWBOK=$$EN^XWBRM(XWBROOT)
 ;
NXTCALLQ ; -- exit
 ;
 QUIT
 ;
 ; ---------------------------------------------------------------------
 ;                                System Error Handler
 ; ---------------------------------------------------------------------
SYSERR ; -- log & send system error message
 ;p41-don't new $Etrap, it was causing infinite loop.
 ;p34-added "BrokerM2M" in message type in SYSERR.
 ;   -halt for read/write errors
 ;
 N XWBDAT,XWBMSG ;,$ETRAP ;*p41
 S $ETRAP="D ^%ZTER HALT" ;If we get an error in the error handler just Halt
 ;
 S XWBMSG=$$EC^%ZOSV ;Get the error code
 D ^%ZTER ;Save off the error
 ;
 S XWBDAT("MESSAGE TYPE")="Gov.VA.Med.BrokerM2M.Errors" ;*34
 S XWBDAT("ERRORS",1,"CODE")=1
 S XWBDAT("ERRORS",1,"ERROR TYPE")="system"
 S XWBDAT("ERRORS",1,"CDATA")=1
 S XWBDAT("ERRORS",1,"MESSAGE",1)=$P($TEXT(SYSERRS+1),";;",2)_XWBMSG
 ;
 ;*p34-will halt for read/write errors
 I XWBMSG["<READ>" D:$G(XWBDEBUG)  HALT
 . ; log read error if debugging is on
 . N XWBENAME ; name of error
 . I XWBDEBUG=1 D  ; if debug=1, "on"
 . . S XWBENAME="Error"
 . E  D  ; if debug=2 or 3, "verbose" or "very verbose"
 . . S XWBENAME="Error: "_$G(XWBDAT("ERRORS",1,"MESSAGE",1))
 . N XWBARRAY ; error array, usually empty & not passed
 . N XWBANAME S XWBANAME="" ; name of error array to pass
 . I XWBDEBUG=3 D  ; if debug="very verbose"
 . . M XWBARRAY=XWBDAT ; include the whole error type message
 . . S XWBANAME="XWBARRAY" ; set name to pass
 . D LOG^XWBDLOG(XWBENAME,XWBANAME) ; log the error
 ;
 D ERROR^XWBUTL(.XWBDAT) ; transmit XML error message to client
 ;
 D UNWIND^%ZTER ;Return to NXTCALL loop
 L  ;Clear locks *p34
 ;
 QUIT  ; end of SYSERR
 ;
 ;
SYSERRS ; -- application errors
 ;*p34-removed the quotes (") after 'M:'
 ;;A system error occurred in M:
 ;
 ;
EOR ; end of routine XWBVLL
