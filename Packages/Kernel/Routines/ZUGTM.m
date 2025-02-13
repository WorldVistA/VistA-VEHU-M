ZU ;SF/JLI,RWF - For GT.M, TIE ALL TERMINALS TO THIS ROUTINE!! ;2017-01-09  3:51 PM
 ;;8.0;KERNEL;**275,419,10001**;Jul 10, 1995;Build 5
 ; Submitted to OSEHRA in 2017 by Sam Habiel for OSEHRA
 ; Original Routine authored by Department of Veterans Affairs
 ; EP JOBEXAM rewritten by Sam Habiel 2016.
 ;
 ;The env var ZINTRRUPT should be set to catch all interrupts.
EN ;See that escape processing is off, Conflict with Screenman
 U $P:(NOCENABLE:NOESCAPE)
 N $ESTACK,$ETRAP S $ETRAP="D ERR^ZU Q:$QUIT -9 Q"
 S $ZINTERRUPT="I $$JOBEXAM^ZU($ZPOSITION)"
 D:+$G(^%ZTSCH("LOGRSRC")) LOGRSRC^%ZOSV("$LOGIN$")
 D COUNT^XUSCNT(1)
 G ^XUS
 ;
 ;
ERR ;Come here on error
 ; handle stack overflow errors specifically
 I $P($ZS,",",3)["STACKCRIT"!("STACKOFLOW"[$P($ZS,",",3)) S $ET="Q:$ST>"_($ST-8)_"  G ERR2^ZU" Q
 ;
ERR2 ;
 S $ETRAP="D UNWIND^ZU" L  ;Backup Trap
 U $P:NOCENABLE
 Q:$ECODE["<PROG>"
 I $P($ZS,",",2,3)["^XUS1A:2, %GTM-E-IOWRITERR" G HALT
 ;
 D ^%ZTER K %ZT ; Capture symbol table first!
 ;
 I $G(IO)]"",$D(IO(1,IO)),$E($G(IOST))="P" D
 . U IO
 . W @$S($D(IOF):IOF,1:"#")
 I $G(IO(0))]"" D
 . U IO(0)
 . W !!,"RECORDING THAT AN ERROR OCCURRED ---"
 . W !!?15,"Sorry 'bout that"
 . W !,*7
 . W !?10,"$STACK=",$STACK,"  $ECODE=",$ECODE
 . W !?10,"$ZSTATUS=",$ZSTATUS
 ;
 ;
 I $G(DUZ)'>0 G HALT
 S $ET="D HALT^ZU"
 ;
 I $P($ZS,",",3)'["-CTRLC" S XUERF="" G ^XUSCLEAN ;419
CTRLC U $P
 W !,"--Interrupt Acknowledged",!
 D KILL1^XUSCLEAN ;Clean up symbol table
 S $ECODE=",<<POP>>,"
 Q
 ;
UNWIND ;Unwind the stack
 Q:$ESTACK>1  G CTRLC2:$ECODE["<<POP>>"
 S $ECODE=""
 Q
 ;
CTRLC2 S $ECODE="" G:$G(^XUTL("XQ",$J,"T"))<2 ^XUSCLEAN
 S ^XUTL("XQ",$J,"T")=1,XQY=$G(^(1)),XQY0=$P(XQY,"^",2,99)
 G:$P(XQY0,"^",4)'="M" HALT
 S XQPSM=$P(XQY,"^",1),XQY=+XQPSM,XQPSM=$P(XQPSM,XQY,2,3)
 G:'XQY ^XUSCLEAN
 S $ECODE="",$ETRAP="D ERR^ZU Q:$QUIT 0 Q"
 U $P:NOESCAPE
 G M1^XQ
 ;
HALT I $D(^XUTL("XQ",$J)) D:$G(DUZ)>0 BYE^XUSCLEAN
 D COUNT^XUSCNT(-1)
 D:+$G(^%ZTSCH("LOGRSRC")) LOGRSRC^%ZOSV("$LOGOUT$")
 HALT
 ;
JOBEXAM(%ZPOS) ;
 I $T(NTRUPT^ZSY)]"" D NTRUPT^ZSY Q 1  ; Lloyd's ZSY
 I $T(JOBEXAM^ZSY)]"" Q $$JOBEXAM^ZSY(%ZPOS)  ; FOIA improved by Sam
 ;
 ; This is the default code in case no ZSY is installed.
 S ^XUTL("XUSYS",$J,0)=$H,^XUTL("XUSYS",$J,"INTERRUPT")=$G(%ZPOS)
 S ^XUTL("XUSYS",$J,"ZMODE")=$ZMODE ; SMH - INTERACTIVE or OTHER
 I %ZPOS'["GTM$DMOD" S ^XUTL("XUSYS",$J,"codeline")=$T(@%ZPOS)
 K ^XUTL("XUSYS",$J,"JE")
 ZSHOW "*":^XUTL("XUSYS",$J,"JE")
 I $G(^XUTL("XUSYS",$J,"CMD"))="HALT" D H2^XUSCLEAN G HALT^ZU
 Q 1
 ;
