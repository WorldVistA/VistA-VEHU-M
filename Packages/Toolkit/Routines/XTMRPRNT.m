XTMRPRNT ;ISC-SF.SEA/JLI - ROUTINE LISTER ;06/11/08  08:31
 ;;7.3;TOOLKIT;**101**;Apr 25, 1995;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
ENTRY ;
 N DIF,I,IOP,ROU,X,XCNP
 ; ZEXCEPT: IOM - SYSTEM VARIABLE
 N OLDIOM S OLDIOM=IOM
 X ^%ZOSF("RSEL") Q:$O(^UTILITY($J,""))=""
 R !,"ENTER RETURN TO START: ",X:300 Q:'$T
 S IOP=";255;" D ^%ZIS Q:POP
 S ROU=0
 F  S ROU=$O(^UTILITY($J,ROU)) Q:ROU=""  D
 . W !,"ZR"
 . K ^TMP($J,0)
 . S X=ROU,XCNP=0,DIF="^TMP($J,0," X ^%ZOSF("LOAD")
 . F I=0:0 S I=$O(^TMP($J,0,I)) Q:I'>0  D
 . . S X=^TMP($J,0,I,0)
 . . S X=$P(X," ")_$C(9)_$P(X," ",2,999)
 . . W !,X
 . W !,"ZS ",ROU
 W !
 S IOP=";"_OLDIOM_";" D ^%ZIS ; restore original margin
 Q
