ESP118E ;ALB/REV - Environment check for ES*1.0*18; 4/28/97
 ;;1.0;POLICE & SECURITY;**18**;Mar 31, 1994
 ;
 ;  This is an environment check for the presence of 
 ;  patch ES*1*14
 ;
EN ;
 N ESRT,ESROUT,ESCOMM,ES2CHECK,ES2LINE
 D ESRT
 I $D(XPDABORT) W !,">>> ES*1*18 Aborted in Environment Checker" Q
 W !!,">>> Environment is OK"
 Q
 ;
ESRT S ESRT=$P($T(ROUTINE+1),";;",2)
 S ESROUT=$P(ESRT,U,1)
 S ESCOMM="S ES2LINE=$P($T(+2"_U_ESROUT_"),"";;"",2)"
 X ESCOMM
 S ES2CHECK=$P(ESRT,U,2,99)
 IF '$L(ES2LINE) D  Q
 .W "Missing POLICE & SECURITY routine ESPJOU1"
 .S XPDABORT=2
 IF $P(ES2LINE,";",1)>$P(ES2CHECK,U,1) D  Q
 .W !?10,"Version of ",$P(ES2LINE,";",2)," is greater than standard - No patch checks done"
 IF $P(ES2LINE,";",1)<$P(ES2CHECK,U,1) D  Q
 .W !?10,"Version of ",$P(ES2LINE,";",2)," is less than required"
 .S XPDABORT=2
 IF $P(ES2LINE,";",3)'[$P(ES2CHECK,U,3) D  Q
 .W !?10,"Missing Patch  ES*1*14"
 .S XPDABORT=2
 Q
 ;
ROUTINE ;
 ;;ESPJOU1^1.0^POLICE & SECURITY^14^Mar 31, 1994
