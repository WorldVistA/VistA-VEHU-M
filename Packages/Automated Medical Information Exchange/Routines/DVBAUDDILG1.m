DVBAUDDILG1 ;ALB/CP - UTL Reusable FM DIALOG Calls #1 ; 10/10/18 2:06pm
 ;;2.7;AMIE;**256**;;Build 19
 ; Per VHA Directive 6402 this routine should not be modified
 ;        MSG^DIALOG ; IA # 2050
 ;      CLEAN^DILF   ; IA # 2054
 Q
 ;
DIERR(DVBWIDTH,DVBLMAR,DVBMSGROOT,DVBFROMRTN,DVBNOPAUSE) ; Display DBS error messages.
 ;
 ;
 S DVBQUIT=0 ; Initialize output flag DVBQUIT to successful (0).
 S DVBFROMRTN=$G(DVBFROMRTN)
 ;
 ; Check for required input parameters
 ;
 I '$G(DVBWIDTH)!('$G(DVBLMAR)) D  Q
 . I $E(IOST,1,2)="C-" D  ; Output message only to a display screen.
 . . N DVBERRMSG
 . . S DVBERRMSG="One or more required input parameters are missing "
 . . D CENTER^DVBAUDPRT1(DVBERRMSG,2,IOM,1)
 . . I DVBFROMRTN]"" D  ;
 . . . S DVBERRMSG="in calling routine "_DVBFROMRTN
 . . . D CENTER^DVBAUDPRT1(DVBERRMSG,1,IOM,1)
 . . S DVBERRMSG="to the DIERR^DVBAUDOAU API call"
 . . D CENTER^DVBAUDPRT1(DVBERRMSG,1,IOM,1)
 . . Q:$G(DVBNOPAUSE)  I $E(IOST,1,2)="C-" D CONTINUE^DVBAUDPRT1(2,"R")
 . S DVBQUIT=1 ; Set return flag to unsuccessful
 ;
 Q:'$G(DIERR)  ; Quit if no database server error message detected.
 ;
 I $E(IOST,1,2)="C-" D  ; Output message only to a display screen.
 . ; ZEXCEPT: AR
 . W !
 . I $G(DVBMSGROOT)]"" D MSG^DIALOG("WE",,DVBWIDTH,DVBLMAR,DVBMSGROOT)
 . I $G(DVBMSGROOT)']"" D MSG^DIALOG("WE","",DVBWIDTH,DVBLMAR)
 . I $G(DVBIENS)]"" W !,?DVBLMAR,"For IENS: ",DVBIENS D  ;
 . . Q:'$G(DVBFILE)  W " file #",DVBFILE
 . I $G(DVB2IENS)]"" W !,?DVBLMAR,"For IENS: ",DVB2IENS D  ;
 . . Q:'$G(DVBFILE)  W " file #",DVBFILE
 . I DVBFROMRTN]"" W !,?DVBLMAR,"Error generated from "_DVBFROMRTN_"."
 . Q:$G(DVBNOPAUSE)  I $E(IOST,1,2)="C-" D CONTINUE^DVBAUDPRT1(2,"R")
 D CLEAN^DILF ; Kills standard ^TMP DBS global and local variables.
 I $G(DVBMSGROOT)]"" K @DVBMSGROOT ; Cleanup local message array
 S DVBQUIT=1 ; Set return flag to unsuccessful
 ;
 K DVB2IENS
 Q  ; DIERR
