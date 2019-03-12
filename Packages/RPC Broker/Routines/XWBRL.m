XWBRL ;OIFO-Oakland/REM - M2M Link Methods ; 08/28/2013 10:40am
 ;;1.1;RPC BROKER;**28,34,991**;Mar 28, 1997;Build 9
 ;
 QUIT  ; routine XWBRL is not callable at the top
 ;
 ; Change History:
 ;
 ; 2002 08 10 OIFO/REM: XWB*1.1*28 SEQ #25, M2M Broker. Original routine
 ; created.
 ;
 ; 2005 10 26 OIFO/REM: XWB*1.1*34 SEQ #33, M2M Bug Fixes. Made sure that
 ; XWBOS is defined. Modified code to support the new meaning of $X in
 ; Cache 5.x. Removed intervening lines that call WBF. Added code to
 ; include option for GT.M. Added line for XWBTCPM to read by Wally's
 ; non-call back service. in WRITE.
 ;
 ; 2013 08 19-28 VEN/TOAD: XWB*1.1*991 SEQ #46, M2M Security Fixes.
 ; Fix bugs in handling of GT.M. Make values for XWBOS in this routine
 ; match what they're set to in XWBTCPM, and change tests to correspond.
 ; Standardize initialization of locals and log. Change WBF to use
 ; XWBT("BF") for buffer flush. Add init variables to cleanup list.
 ; Adjust test for pre-loaded buffer in READ. Optimize performance
 ; for GT.M on Linus systems by reading one character at a time.
 ; Eliminate unneeded subroutines. Refactor for clarity.
 ; Change History added.
 ; in XWBRL, INIT, OPEN, READ, CHK, WRITE, POST, WBF, CLOSE, FINAL, EOR.
 ;
 ;
 ; ---------------------------------------------------------------------
 ;                    Methods for Read from and to TCP/IP Socket
 ; ---------------------------------------------------------------------
READ(XWBROOT,XWBREAD,XWBTO,XWBFIRST,XWBSTOP) ;
 ;
 ; -- initialize tcp processing variables
 I $G(XWBOS)="" D  ; if we have not already initialized,
 . D INIT^XWBTCPM ; set up locals and start log
 ;
 ; -- initialize subroutine variables
 NEW X,EOT,OUT,STR,LINE,PIECES,DONE,TOFLAG,XWBCNT,XWBLEN
 SET STR="",EOT=$C(4),DONE=0,LINE=0
 ;
 ; -- From XWBTCPM startup, One time thing *p34
 I $G(XWBRBUF)'="" D  ; if we've already read in the first message
 . S STR=XWBRBUF ; preload message
 . S XWBTO=0 ; change time-out (no need to wait, we have it)
 . S XWBFIRST=0 ; the next read is not the first read
 . K XWBRBUF ; clear flag
 ;
 ; -- optimize performance on GT.M systems
 I XWBOS["GT.M" D  ; for GT.M systems
 . S XWBREAD=1 ; always read one character at a time
 ;
 ; -- READ needs work for length checking ; This needs work!!
 FOR  READ XWBX#XWBREAD:XWBTO SET TOFLAG=$T DO CHK DO:'XWBSTOP  QUIT:DONE
 . IF $L(STR)+$L(XWBX)>400 DO ADD(STR) S STR=""
 . SET STR=STR_XWBX
 . FOR  Q:STR'[$C(10)  DO ADD($P(STR,$C(10))) SET STR=$P(STR,$C(10),2,999)
 . IF STR[EOT SET STR=$P(STR,EOT) DO ADD(STR) SET DONE=1 QUIT
 . SET PIECES=$L(STR,">")
 . IF PIECES>1 DO ADD($P(STR,">",1,PIECES-1)_">") SET STR=$P(STR,">",PIECES,999)
 ;
 QUIT 1 ; always return true ; end of READ
 ;
 ;
ADD(TXT) ; -- add new intake line
 SET LINE=LINE+1
 SET @XWBROOT@(LINE)=TXT
 QUIT
 ;
 ;
CHK ; -- check if first read and change timeout and chars to read
 IF 'TOFLAG,XWBFIRST SET XWBSTOP=1,DONE=1 QUIT  ; -- could cause small msg to not process
 SET XWBFIRST=0
 SET XWBREAD=100,XWBTO=2 ;M2M changed XWBTO=2
 ;
 ; -- optimize performance on GT.M systems
 I XWBOS["GT.M" D  ; for GT.M systems
 . S XWBREAD=1 ; always read one character at a time
 ;
 QUIT  ; end of CHK
 ;
 ;
 ; ---------------------------------------------------------------------
 ;                      Methods for Opening and Closing Socket
 ; ---------------------------------------------------------------------
OPEN(XWBPARMS) ; -- Open tcp/ip socket
 NEW I,POP
 SET POP=1
 ;
 ; -- initialize tcp processing variables
 I $G(XWBOS)="" D  ; if we have not already initialized,
 . D INIT^XWBTCPM ; set up locals and start log
 ;
 DO SAVDEV^%ZISUTL("XWBM2M CLIENT") ;M2M changed name
 FOR I=1:1:XWBPARMS("RETRIES") DO CALL^%ZISTCP(XWBPARMS("ADDRESS"),XWBPARMS("PORT")) QUIT:'POP
 ; Device open
 ;
 IF 'POP USE IO QUIT 1
 ; Device not open
 QUIT 0
 ;
CLOSE ; -- close tcp/ip socket
 ; -- tell server to Stop() connection
 ;
 ; -- initialize tcp processing variables
 I $G(XWBOS)="" D  ; if we have not already initialized,
 . D INIT^XWBTCPM ; set up locals and start log
 ;
 DO PRE
 DO WRITE($$XMLHDR^XWBUTL()_"<vistalink type='Gov.VA.Med.Foundations.CloseSocketRequest' ></vistalink>")
 DO POST
 ;
 ; -Read results from server close string.  **M2M
 IF $G(XWBPARMS("CCLOSERESULTS"))="" SET XWBPARMS("CCLOSERESULTS")=$NA(^TMP("XWBM2MRL",$J,"XML"))
 SET XWBROOT=XWBPARMS("CCLOSERESULTS") K @XWBROOT
 SET XWBREAD=20,XWBTO=1,XWBFIRST=0,XWBSTOP=0
 SET XWBCOK=$$READ^XWBRL(XWBROOT,.XWBREAD,.XWBTO,.XWBFIRST,.XWBSTOP)
 ;
 KILL XWBDEBUG,XWBM2M,XWBOS,XWBPARMS,XWBPARMS,XWBRBUF,XWBT,XWBTIME
 DO CLOSE^%ZISTCP
 DO USE^%ZISUTL("XWBM2M CLIENT") ; Change name **M2M
 DO RMDEV^%ZISUTL("XWBM2M CLIENT")
 QUIT
 ;
 ;
 ; ---------------------------------------------------------------------
 ;                          Methods for Writing to TCP/IP Socket
 ; ---------------------------------------------------------------------
PRE ; -- prepare socket for writing
 SET $X=0
 QUIT
 ;
 ;
WRITE(STR) ; -- write a data string to socket
 ; input:
 ;   STR = string to write
 ; throughput:
 ;   if tcp vars not set when WRITE is called, WRITE sets them
 ; output:
 ;   string is written to socket in packets of up to 255 characters
 ;   with buffer flushes in between
 ;
 ; -- initialize tcp processing variables
 I $G(XWBOS)="" D  ; if we have not already initialized,
 . D INIT^XWBTCPM ; set up locals and start log
 ;
 ; send data for DSM (requires buffer flush (!) every 511 chars)
 ; GT.M is the same as DSM.
 ; Use an arbitrary value of 255 as the Write limit.
 ;*p34-modified write to for Cache 5 in case less than 255 char.
 ;
 F  Q:'$L(STR)  D  ; continue until string fully written
 . W $E(STR,1,255) ; write next 255 characters
 . W @XWBT("BF") ; write buffer flush
 . S STR=$E(STR,256,99999) ; remove the written characters
 ;
 QUIT  ; end of WRITE
 ;
 ;
POST ; -- send eot and flush socket buffer
 ; input:
 ;   XWBT("BF") = buffer-flush control character for this implementation
 ; output:
 ;   EOT and buffer flush
 ;
 DO WRITE($C(4)) ; end-of-transmission
 I $X>0 W @XWBT("BF") ; write buffer flush
 ;
 QUIT  ; end of POST
 ;
 ;
EOR ; end of routine XWBRL
