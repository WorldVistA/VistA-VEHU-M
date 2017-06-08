ZSLOTZU ;SF/GFT,MVB,JLI - TIE ALL TERMINALS TO THIS ROUTINE!! ;4/27/93  09:02 ;
 ;;7.1;KERNEL;;May 11, 1993
 ;FOR VAX-DSM V5 & V6
 ;++++ Modified ZU for SlotMaster ++++
 ;I '$D(X) X ^%ZOSF("PROGMODE") I 'Y,$ZC(%GETJPI,$J,"CPUTIM")<400 D  
 .S %=$ZC(%GETJPI,$J,"LOGINTIM"),%ZH0="0,,"_%_",,,,0,0" S:$E($ZV,10,12)>5.1 %=$E(%,13,23) S XRT0=+$H_","_($P(%,":")*3600+($P(%,":",2)*60)+$P(%,":",3)),XRTL=$ZU(0),XRTN=$T(+0) D T1^%ZOSV
 ;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 NEW ZIO,ZTIME D LOG  ; Save for ZSLOT0 - the calling routine
 ;----------------------------------------------------------------------
 S X=$ZC(%DISABLCTRL,$C(25)) U $I:NOCENABLE
 I $D(^XMB(1,1,"XUCP")),^("XUCP")="Y" D LOGRSRC^%ZOSV("DSMIN")
 ;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 S $ZT="ERR^ZSLOTZU" G ^XUS  ; changed error trap
 ;----------------------------------------------------------------------
 ;
ERR S $ZT="" L  ;Come here on error
 I $G(IO)]"",$D(IO(1,IO)),$E($G(IOST))="P" U IO W @$S($D(IOF):IOF,1:"#")
 I $ZE["<<HALT>>" G CONT
 I $ZE["<<PROG>>" Q
 I $D(IO)=11 U IO(0) W !!,"RECORDING THAT AN ERROR OCCURRED ---",!!?10,$ZE,!!?15,"Sorry 'bout that",!!,*7
 S %ZTERLGR=$ZR,%ZT("^XUTL(""XQ"",$J)")="" D ^%ZTER K %ZT S XUERF="" ; Capture symbol table first!
 I $D(%ZTERROR),$P(%ZTERROR,"^",2)="F" H  ; Halt immediately for disaster type FATAL errors
 U $I:NOCENABLE D PROGMODE^%ZOSV I Y U $I:CENABLE Q
 ;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 S $ZT="HALT^ZSLOTZU" G:$ZE["-CTRAP" CTRLC I $D(^XUTL("XQ",$J,"ZTSK"))!($I="") K ^XMB(3.7,DUZ,100,$I) D C^XUS H  ; changed error trap
 ;----------------------------------------------------------------------
 I ($D(DUZ)#2),DUZ'>0 K DUZ
 G:'($D(DUZ)#2) REST^XQ12 ;S XQM=$S(($D(^VA(200,DUZ,201))#2):+^(201),1:"") G:XQM>0 ^XQ G REST^XQ
CTRLC I $D(IO)=11 U IO(0) C:IO'=IO(0) IO S IO=IO(0)
 W:$ZE["-CTRAP" !,"--Interrupt Acknowledged",!
CTRLC2 S XQY=^XUTL("XQ",$J,"T")-1,^("T")=XQY G:'XQY H^XUS S XQY=^(XQY),XQY0=$P(XQY,"^",2,99) G:$P(XQY0,"^",4)'="M" CTRLC2 S XQPSM=$P(XQY,"^",1),XQY=+XQPSM,XQPSM=$P(XQPSM,XQY,2,3) G:'XQY H^XUS
 ;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 S $ZT="ERR^ZSLOTZU" G M1^XQ  ; changed error trap
 ;----------------------------------------------------------------------
 ;
HALT K ^XUTL("XQ",$J) K:$D(DUZ)#2 ^XMB(3.7,DUZ,100,$I)
 ;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ;S %=$ZC(%GETDVI,$I,"TT_DIALUP") I %!$D(XQXFLG("HALT")) HALT  ; commented out line
 ;----------------------------------------------------------------------
 ZTRAP "<<HALT>>" ;Unwind stack
CONT ;
 I $D(^XMB(1,1,"XUCP")),^("XUCP")="Y" D LOGRSRC^%ZOSV("DSMOUT")
 S X="Waiting "_($J#1000000) D SETENV^%ZOSV ;Change VMS name
 ;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ;U $I:NOCENABLE R !,"Enter return to continue: ",X:600 S:'$T X="^" G:X'="^" ^ZU  ; commented out line
 ;----------------------------------------------------------------------
 I $D(^XMB(1,1,"XUCP")),^("XUCP")="Y" D LOGRSRC^%ZOSV("DSMHALT")
 ;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 ZQUIT  ; Trap up - added line
 ;----------------------------------------------------------------------
 HALT
LOG ;Define some necessary Logical Names - added code lines
 ;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 S %=$ZC(%CRELOG,"SYS$INPUT",$I,"SUPERVISOR")
 S %=$ZC(%CRELOG,"SYS$OUTPUT",$I,"SUPERVISOR")
 S %=$ZC(%CRELOG,"SYS$COMMAND",$I,"SUPERVISOR")
 QUIT
 ;----------------------------------------------------------------------
