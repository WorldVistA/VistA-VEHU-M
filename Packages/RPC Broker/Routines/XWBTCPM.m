XWBTCPM ;ISF/RWF - BROKER TCP/IP PROCESS HANDLER ; 8/28/2013 10:43am
 ;;1.1;RPC BROKER;**35,43,49,53,991**;Mar 28, 1997;Build 9
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;Based on: XWBTCPC & XWBTCPL, Modified by ISF/RWF
 ;Changed to be started by TCPIP service or %ZISTCPS
 ;
 ; Change History:
 ;
 ; 2005 01 20 OIFO/RWF: XWB*1.1*35 SEQ #30, NON-callback server. Original
 ; routine created. 
 ;
 ; 2006 05 15 OIFO/RWF: XWB*1.1*43 SEQ #36, New broker long timeout fix.
 ; The original Broker and the new Broker had different timeout checks
 ; resulting in records remaining in a locked state long after client
 ; termination. Decreasing the BROKER ACTIVITY TIMEOUT caused problems
 ; with Imaging. The new broker was changed to use the same timeout check
 ; as the original broker, allowing the BROKER ACTIVITY TIMEOUT value to
 ; be changed back to its pre XWB*1.1*35 value of (180 was the
 ; recommended value). Also folded entry point for the new M-to-M Broker
 ; into this main broker entry point, to eliminate the need for a
 ; separate port, entry point, and VMS or Unix service. Also added
 ; GTMLNUX entry point to support running the Broker on GT.M on Linux
 ; using an xinetd service. in CONNTYPE, NEW, SETTIME, GTMLNUX.
 ;
 ; 2009 03 31 OIFO/JLI: XWB*1.1*49 SEQ #40, Improve Support for Linux.
 ; $$OS^XWBTCPM was changed to return "GT.M" under GTM. Revised to make
 ; Broker work with xinetd on Linux with Cache. in OS and passim.
 ;
 ; 2013 08 19-28 VEN/TOAD: XWB*1.1*991 SEQ #46, M2M Security Fixes.
 ; Load new parameter XWBM2M into new local variable XWBM2M to control
 ; whether the M-to-M Broker is suppressed. Changed call to M2M to
 ; honor the new XWBM2M parameter. Improved support for GT.M on Linux
 ; by preventing an error loop that generates ZINTRECURSEIO errors at
 ; WBF+3^XWBRW. Annotated & refactored CONNTYPE and INIT for clarity.
 ; Change History added. in XWBTCPM, CONNTYPE, ETRAP, INIT, EOR.
 ;
 ;
DSM ;DSM called from ucx, % passed in with device.
 D ESET
 ;Open the device
 S XWBTDEV=% X "O XWBTDEV:(TCPDEV):60" ;Special UCX/DSM open
 ;Go find the connection type
 U XWBTDEV
 G CONNTYPE
 ;
CACHEVMS ;Cache'/VMS tcpip entry point, called from XWBTCP_START.COM file
 D ESET
 S XWBTDEV=$S($ZV["VMS":"SYS$NET",1:$P) ;Support for both VMS/TCPIP and Linux/xinetd
 ; **Cache'/VMS specific code**
 O XWBTDEV::5
 X "U XWBTDEV:(::""-M"")" ;Packet mode like DSM
 G CONNTYPE
 ;
NT ;entry from ZISTCPS
 ;JOB LISTEN^%ZISTCPS("port","NT^XWBTCPM","stop code")
 D ESET
 S XWBTDEV=IO
 G CONNTYPE
 ;
GTMUCX(%) ;From ucx ZFOO
 ;If called from LISTEN^%ZISTCP(PORT,"GTM^XWBTCPM") S XWBTDEV=IO
 D ESET
 ;GTM specific code
 S @("$ZINTERRUPT=""I $$JOBEXAM^ZU($ZPOSITION)""")
 S XWBTDEV=% X "O %:(RECORDSIZE=512)"
 G CONNTYPE
 ;
GTMLNX ;From Linux xinetd script
 D ESET
 ;GTM specific code
 S @("$ZINTERRUPT=""I $$JOBEXAM^ZU($ZPOSITION)""")
 S XWBTDEV=$P X "U XWBTDEV:(nowrap:nodelimiter:ioerror=""TRAP"")"
 S %="",@("%=$ZTRNLNM(""REMOTE_HOST"")") S:$L(%) IO("GTM-IP")=%
 G CONNTYPE
 ;
ESET ;Set inital error trap
 S U="^",$ETRAP="D ^%ZTER H" ;Set up the error trap
 S X="",@("$ZT=X") ;Clear old trap
 Q
 ;
 ;
 ;Find the type of connection and jump to the processing routine.
CONNTYPE ;
 ; input:
 ;   error trap is set
 ;   any interrupts are set
 ;   socket to client is opened and used
 ;   XWBTDEV = the socket port
 ;
 N SOCK,TYPE,XWBAPVER,XWBCLMAN,XWBDEBUG,XWBENVL,XWBLOG,XWBM2M,XWBOS
 N XWBPTYPE,XWBSHARE,XWBT,XWBTBUF,XWBTIP,XWBTSKT,XWBVER,XWBWRAP
 D INIT ; set up common variables
 ;
 S XWB=$$BREAD^XWBRW(5,XWBTIME) ; read in the first message
 D LOG("MSG format is "_XWB_" type "_$S(XWB="[XWB]":"NEW",XWB="{XWB}":"OLD",XWB="<?xml":"M2M",XWB="~BSE~":"BSE",XWB="~EAC~":"EAC",XWB="~SVR~":"SVR",1:"Unk")) ; ID type
 ;
 I XWB["[XWB]" G NEW ; new Broker
 ;
 I XWB["{XWB}" G OLD^XWBTCPM1 ; old Broker
 ;
 I XWB["<?xml",XWBM2M G M2M ; M-to-M Broker, if allowed
 ;
 I $L($T(OTH^XWBTCPM2)) D  ; if it's a special supported message type
 . D OTH^XWBTCPM2 ; process it
 E  D  ; otherwise we don't support this message type
 . D LOG("Prefix not known: "_XWB) ; so just log it
 ;
 QUIT  ; end of CONNTYPE
 ;
 ;
NEWJOB() ;Check if OK to start a new job, Return 1 if OK, 0 if not OK.
 N X,Y,J,XWBVOL
 D GETENV^%ZOSV S XWBVOL=$P(Y,"^",2)
 S X=$O(^XTV(8989.3,1,4,"B",XWBVOL,0)),J=$S(X>0:^XTV(8989.3,1,4,X,0),1:"ROU^y^1")
 I $G(^%ZIS(14.5,"LOGON",XWBVOL)) Q 0 ;Check INHIBIT LOGONS?
 I $D(^%ZOSF("ACTJ")) X ^("ACTJ") I $P(J,U,3),($P(J,U,3)'>Y) Q 0
 Q 1
 ;
M2M ;M2M Broker
 S XWBRBUF=XWB_XWBRBUF,(IO,IO(0))=XWBTDEV G SPAWN^XWBVLL
 Q
 ;
NEW ;New broker
 S U="^",DUZ=0,DUZ(0)="",XWBVER=1.108
 D SETTIME(1) ;Setup for sign-on timeout
 U XWBTDEV D
 . N XWB,ERR,NATIP,I
 . S ERR=$$PRSP^XWBPRS
 . S ERR=$$PRSM^XWBPRS
 . S MSG=$G(XWB(4,"CMD")) ;Build connect msg.
 . S I="" F  S I=$O(XWB(5,"P",I)) Q:I=""  S MSG=MSG_U_XWB(5,"P",I)
 . ;Get the peer and save that IP.
 . S NATIP=$$GETPEER^%ZOSV S:'$L(NATIP) NATIP=$P(MSG,"^",2)
 . I NATIP'=$P(MSG,"^",2) S $P(MSG,"^",2)=NATIP
 . Q
 S X=$$NEWJOB() D:'X LOG("No New Connects")
 I ($P(MSG,U)'="TCPConnect")!('X) D QSND^XWBRW("reject"),LOG("reject: "_MSG) Q
 D QSND^XWBRW("accept"),LOG("accept") ;Ack
 S IO("IP")=$P(MSG,U,2),XWBTSKT=$P(MSG,U,3),XWBCLMAN=$P(MSG,U,4)
 S XWBTIP=$G(IO("IP"))
 ;start RUM for Broker Handler XWB*1.1*5
 D LOGRSRC^%ZOSV("$BROKER HANDLER$",2,1)
 ;GTM
 I $G(XWBT("PCNT")) D
 . S X=$NA(^XUTL("XUSYS",$J,1)) L +@X:0
 . D COUNT^XUSCNT(1),SETLOCK^XUSCNT(X)
 ;We don't use a callback
 K XWB,CON,LEN,MSG ;Clean up
 ;Attempt to share license, Must have TCP port open first.
 U XWBTDEV ;D SHARELIC^%ZOSV(1)
 ;setup null device "NULL"
 S %ZIS="0H",IOP="NULL" D ^%ZIS S XWBNULL=IO I POP S XWBERROR="No NULL device" D LOG(XWBERROR),EXIT Q
 D SAVDEV^%ZISUTL("XWBNULL")
 ;change process name
 D CHPRN("ip"_$P(XWBTIP,".",3,4)_":"_XWBTDEV)
 ;
RESTART ;The error trap returns to here
 N $ESTACK S $ETRAP="D ETRAP^XWBTCPM(0)"
 S DT=$$DT^XLFDT,DTIME=30
 U XWBTDEV D MAIN
 D LOG("Exit: "_XWBTBUF)
 ;Turn off the error trap for the exit
 S $ETRAP=""
 D EXIT ;Logout
 K XWBR,XWBARY
 ;stop RUM for handler XWB*1.1*5
 D LOGRSRC^%ZOSV("$BROKER HANDLER$",2,2)
 D USE^%ZISUTL("XWBNULL"),CLOSE^%ZISUTL("XWBNULL")
 ;Close in the calling script
 K SOCK,TYPE,XWBSND,XWBTYPE,XWBRBUF
 Q
 ;
MAIN ; -- main message processing loop. debug at MAIN+1
 F  D  Q:XWBTBUF="#BYE#"
 . ;Setup
 . S XWBAPVER=0,XWBTBUF="",XWBTCMD="",XWBRBUF=""
 . K XWBR,XWBARY,XWBPRT
 . ; -- read client request
 . S XR=$$BREAD^XWBRW(1,XWBTIME,1)
 . I '$L(XR) D LOG("Timeout: "_XWBTIME) S XWBTBUF="#BYE#" Q
 . S XR=XR_$$BREAD^XWBRW(4)
 . I XR="#BYE#" D  Q  ;Check for exit
 . . D QSND^XWBRW("#BYE#"),LOG("BYE CMD") S XWBTBUF="#BYE#"
 . . Q
 . S TYPE=(XR="[XWB]")  ;check HDR
 . I 'TYPE D LOG("Bad Header: "_XR) Q
 . D CALLP^XWBPRS(.XWBR,$G(XWBDEBUG)) ;Read the NEW Msg parameters and call RPC
 . IF XWBTCMD="#BYE#" D  Q
 . . D QSND^XWBRW("#BYE#"),LOG("BYE CMD") S XWBTBUF=XWBTCMD
 . . Q
 . U XWBTDEV
 . S XWBPTYPE=$S('$D(XWBPTYPE):1,XWBPTYPE<1:1,XWBPTYPE>6:1,1:XWBPTYPE)
 . ;I $G(XWBPRT) D RETURN^XWBPRS2 Q  ;New msg return
 . I '$G(XWBPRT) D SND^XWBRW ;Return data,flush buffer
 Q  ;End Of Main
 ;
 ;
ETRAP(EXIT) ; -- on trapped error, send error info to client
 N XWBERC,XWBERR
 ;Change trapping during trap.
 S $ETRAP="D ^%ZTER,ETRAP^XWBTCPM(1)"
 S XWBERC=$E($$EC^%ZOSV,1,200),XWBERR="M  ERROR="_XWBERC_$C(13,10)_"LAST REF="_$$LGR^%ZOSV
 I $EC["U411" S XWBERROR="U411",XWBSEC="",XWBERR="Data Transfer Error to Server"
 D ^%ZTER ;%ZTER clears $ZE and $ZCODE
 D LOG("In ETRAP: "_XWBERC) ;Log
 I (XWBERC["READ")!(XWBERC["WRITE")!(XWBERC["SYSTEM-F")!(XWBERC["IOEOF")!(XWBERC["ZINTRECURSEIO") D EXIT X "HALT "
 U XWBTDEV
 I $G(XWBT("PCNT")) L +^XUTL("XUSYS",$J,0):99
 E  L  ;Clear Locks
 ;
 I EXIT D EXIT X "HALT "
 D ESND^XWBRW($C(24)_XWBERR_$C(4))
 S $ETRAP="Q:($ESTACK&'$QUIT)  Q:$ESTACK -9 S $ECODE="""" D CLEANP^XWBTCPM G RESTART^XWBTCPM",$ECODE=",U99,"
 Q
 ;
CLEANP ;Clean up the partion
 N XWBTDEV,XWBNULL D KILL^XUSCLEAN
 Q
 ;
STYPE(X,WRAP) ;For backward compatability only
 I $D(WRAP) Q $$RTRNFMT^XWBLIB($G(X),WRAP)
 Q $$RTRNFMT^XWBLIB(X)
 ;
BREAD(L,T) ;read tcp buffer, L is length
 Q $$BREAD^XWBRW(L,$G(T))
 ;
CHPRN(N) ;change process name
 ;Change process name to N
 D SETNM^%ZOSV($E(N,1,15))
 Q
 ;
SETTIME(%) ;Set the Read timeout 0=RPC, 1=sign-on
 ; Increased timeout period (%=1) during signon from 90 to 180 for accessibility reasons
 S XWBTIME=$S($G(%):180,$G(XWBVER)>1.1:$$BAT^XUPARAM,1:36000),XWBTIME(1)=5 ; (*p35)
 Q
TIMEOUT ;Do this on MAIN  loop timeout
 I $G(DUZ)>0 D QSND^XWBRW("#BYE#") Q
 ;Sign-on timeout
 S XWBR(0)=0,XWBR(1)=1,XWBR(2)="",XWBR(3)="TIME-OUT",XWBPTYPE=2
 D SND^XWBRW
 Q
 ;
OS() ;Return the OS
 Q $S(^%ZOSF("OS")["OpenM":"OpenM",^%ZOSF("OS")["GT.M":"GT.M",^("OS")["DSM":"DSM",1:"UNK")
 ;
 ;
INIT ; Setup common variables for all brokers types
 S U="^"
 S XWBDEBUG=$$GET^XPAR("SYS","XWBDEBUG") ; enable or disable debug log
 S XWBM2M=$$GET^XPAR("ALL","XWBM2M") ; enable or disable M-to-M Broker
 S XWBOS=$$OS ; MUMPS implementation ("operating system")
 S XWBRBUF=""
 S XWBT("BF")=$S(XWBOS="GT.M":"#",1:"!") ; buffer flush
 S XWBT("PCNT")=0 ; count processes? default to false
 I XWBOS="GT.M",$L($T(^XUSCNT)) D  ; for GT.M systems
 . S XWBT("PCNT")=1 ; set flag to count processes
 S XWBTIME=10 ; default time-out (overridden for new & old broker)
 ;
 D LOGSTART^XWBDLOG("XWBTCPM") ; start broker log
 ;
 QUIT  ; end of INIT
 ;
 ;
DEBUG ;Entry point for debug, Build a server to get the connect
 ;Cache sample;ZB SERV+1^XWBTCPM:"L+" ZB ETRAP+1^XWBTCPM:"B"
 W !,"Before running this entry point set your debugger to stop at"
 W !,"the place you want to debug. Some spots to use:"
 W !,"'SERV+1^XWBTCPM', 'MAIN+1^XWBTCPM' or 'CAPI+1^XWBPRS.'",!
 W !,"or location of your choice.",!
 W !,"IP Socket to Listen on: " R SOCK:300,! Q:'$T!(SOCK["^")
 ;Use %ZISTCP to do a single server
 D LISTEN^%ZISTCP(SOCK,"SERV^XWBTCPM")
 U $P W !,"Done"
 Q
SERV ;Callback from the server
 S XWBTDEV=IO,XWBTIME(1)=3600 D INIT
 S XWBDEBUG=1,MSG=$$BREAD^XWBRW(5,60) ;R MSG#5
 D NEW
 S IO("C")=1 ;Cause the Listenr to stop
 Q
 ;
EXIT ;Close out
 I $G(DUZ) D LOGOUT^XUSRB
 I $G(XWBT("PCNT")) D COUNT^XUSCNT(-1)
 Q
 ;
LOG(MSG) ;Record Debug Info
 D:$G(XWBDEBUG) LOG^XWBDLOG(MSG)
 Q
 ;
 ;
EOR ; end of routine XWBTCPM
