ZOSFONT ;SFISC/AC - SETS UP ^%ZOSF for Cache for NT/VMS ;09/29/09  15:35
 ;;8.0;KERNEL;**34,104,365,661,718**;JUL 10, 1995;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;For Cache versions 2011 and above
 S %Y=1
INIT ;
 N ZO F I="MGR","PROD","VOL" S:$D(^%ZOSF(I)) ZO(I)=^%ZOSF(I)
 F I=1:2 S Z=$P($T(Z+I),";;",2) Q:Z=""  S X=$P($T(Z+1+I),";;",2,99) S ^%ZOSF(Z)=$S($D(ZO(Z)):ZO(Z),1:X)
 ;
 G:'$G(%Y) OS
MGR W !,"NAME OF MANAGER'S NAMESPACE: "_^%ZOSF("MGR")_"// " R X:$S($G(DTIME):DTIME,1:9999) I X]"" X ^("UCICHECK") G MGR:0[Y S ^%ZOSF("MGR")=X
PROD W !,"PRODUCTION (SIGN-ON) NAMESPACE: "_^%ZOSF("PROD")_"// " R X:$S($G(DTIME):DTIME,1:9999) I X]"" X ^("UCICHECK") G PROD:0[Y S ^%ZOSF("PROD")=Y
VOL W !,"NAME OF THIS CONFIGURATION: "_^%ZOSF("VOL")_"//" R X:$S($G(DTIME):DTIME,1:9999) I X]"" S:X?1.22U ^%ZOSF("VOL")=X I X'?1.22U W "MUST BE 1-22 uppercase characters." G VOL
 ;
OS S $P(^%ZOSF("OS"),"^",1)="OpenM-NT" S:'$P(^%ZOSF("OS"),"^",2) $P(^%ZOSF("OS"),"^",2)=18
 W !!,"ALL SET UP",!!
 Q
 ;
NOASK ;Setup %ZOSF without terminal interaction
 S %Y=0
 G INIT
 ;
ONE(X) ;update a single global node
 Q:X=""
 F I=1:2 S Z=$P($T(Z+I),";;",2) Q:Z=""  I Z=X S Y=$P($T(Z+1+I),";;",2,99),^%ZOSF(X)=Y Q
 Q
Z ;;
 ;;ACTJ;;Active Jobs
 ;;S Y=$$ACTJ^%ZOSV()
 ;;AVJ;;Available Jobs
 ;;S Y=$$AVJ^%ZOSV()
 ;;BRK;;Enable Break
 ;;U $I:("":"+B")
 ;;DEL;;Delete Routine
 ;;X "ZR  ZS @X"
 ;;EOFF;;Echo off
 ;;U $I:("":"+S")
 ;;EON;;Echo On
 ;;U $I:("":"-S")
 ;;EOT;;End of Tape
 ;;S Y=$ZA\1024#2
 ;;ERRTN;;Error Routine
 ;;^%ZTER
 ;;ETRP;;obsolete
 ;;Q
 ;;GD;;Global Directory
 ;;D ^%GD
 ;;GSEL;;Select Globals
 ;;K ^CacheTempJ($J),^UTILITY($J) D ^%SYS.GSET M ^UTILITY($J)=^CacheTempJ($J) K ^CacheTempJ($J)
 ;;JOBPARAM;;Local Job
 ;;D JOBPAR^%ZOSV
 ;;LABOFF;;Special Lab Echo off
 ;;U IO:("":"+S+I-T":$C(13,27))
 ;;LOAD;;Load Routine
 ;;N %,%N S %N=0 X "ZL @X F XCNP=XCNP+1:1 S %N=%N+1,%=$T(+%N) Q:$L(%)=0  S @(DIF_XCNP_"",0)"")=%"
 ;;LPC;;Longitudinal Parity Check
 ;;S Y=$ZC(X)
 ;;MAXSIZ;;Set Partition Size
 ;;S $ZS=X+X
 ;;MGR
 ;;%SYS
 ;;MAGTAPE;;Sets magtape functions into %MT
 ;;S %MT("BS")="*-1",%MT("FS")="*-2",%MT("WTM")="*-3",%MT("WB")="*-4",%MT("REW")="*-5",%MT("RB")="*-6",%MT("REL")="*-7",%MT("WHL")="*-8",%MT("WEL")="*-9"
 ;;MTBOT;;Begining of Tape
 ;;S Y=$ZA\32#2
 ;;MTONLINE;;Magtape Online
 ;;S Y=$ZA\64#2
 ;;MTWPROT;;Magtape Write Protected
 ;;S Y=$ZA\4#2
 ;;MTERR;;Magtape Error
 ;;S Y=$ZA\32768#2
 ;;NBRK;;No break
 ;;U $I:("":"-B")
 ;;NO-PASSALL;;Set terminal to normal text mode
 ;;U $I:("":"-I+T")
 ;;NO-TYPE-AHEAD;;Turn off Type Ahead
 ;;U $I:("":"+F":$C(13,27))
 ;;PASSALL;;Set terminal to pass all codes
 ;;U $I:("":"+I-T")
 ;;PRIINQ;;Priority in current queue
 ;;N %PRIO D ^%PRIO S Y=$S('%PRIO:5,%PRIO>0:8,1:3)
 ;;PRIORITY;;set priority to X (1=low, 10=high)
 ;;D @($S(X>7:"NORMAL",X>3:"NORMAL",1:"LOW")_"^%PRIO") ;Don't do HIGH
 ;;PROGMODE;;Checks Programmer Mode
 ;;S Y=$ZJOB#2
 ;;PROD
 ;;VAH
 ;;RD;;Routine Directory
 ;;D ^%RD
 ;;RESJOB;;Kill job on local node
 ;;N OLD S OLD=$ZNSPACE ZNSPACE "%SYS" D ^RESJOB ZNSPACE OLD Q
 ;;RM;;Set Right Margin for terminal
 ;;I $G(IOT)["TRM" U $I:X
 ;;RSEL;;Routine Select
 ;;K ^UTILITY($J) D KERNEL^%RSET K %ST ;Special entry point for VA
 ;;RSUM;;Returns Checksum of Routine
 ;;N %,%1,%3 ZL @X S Y=0 F %=1,3:1 S %1=$T(+%),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*%2+Y
 ;;RSUM1;;Returns new Checksum of Routine
 ;;N %,%1,%3 ZL @X S Y=0 F %=1,3:1 S %1=$T(+%),%3=$F(%1," ") Q:'%3  S %3=$S($E(%1,%3)'=";":$L(%1),$E(%1,%3+1)=";":$L(%1),1:%3-2) F %2=1:1:%3 S Y=$A(%1,%2)*(%2+%)+Y
 ;;SS;;System Status
 ;;D ^%SS
 ;;SAVE;;Save Routine
 ;;N XCS S XCS="F XCM=1:1 S XCN=$O(@(DIE_XCN_"")"")) Q:+XCN'=XCN  S %=^(XCN,0) Q:$E(%,1)=""$""  I $E(%,1)'="";"" ZI %" X "ZR  X XCS ZS @X"
 ;;SIZE;;Routine size in Bytes
 ;;S Y=0 F I=1:1 S %=$T(+I) Q:%=""  S Y=Y+$L(%)+2
 ;;TEST;;Routine exist
 ;;I X?1(1"%",1A).15AN,$D(^$ROUTINE(X))
 ;;TMK;;Magtape Mark
 ;;S Y=$ZA\4#2
 ;;TRAP;;Sets Error Trap;S X="^%ET",@^%ZOSF("TRAP"); User $ETRAP
 ;;$ZT=X
 ;;TRMOFF;;Terminators off
 ;;U $I:("":"-I-T":$C(13,27))
 ;;TRMON;;Terminators on
 ;;U $I:("":"+I+T")
 ;;TRMRD;;Read Terminator
 ;;S Y=$A($ZB),Y=$S(Y<32:Y,Y=127:Y,1:0)
 ;;TYPE-AHEAD;;Allows Type-ahead
 ;;U $I:("":"-F":$C(13,27))
 ;;UCI;;Current UCI
 ;;D UCI^%ZOSV
 ;;UCICHECK;;UCI Valid
 ;;S Y=$$UCICHECK^%ZOSV(X)
 ;;UPPERCASE;;Convert Lower case to Upper case
 ;;S Y=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;;XY;;Set $X & $Y
 ;;S $X=DX,$Y=DY
 ;;VOL;;VOLUME SET NAME
 ;;ROU
 ;;ZD;;$H to external
 ;;S Y=$ZD(X)
