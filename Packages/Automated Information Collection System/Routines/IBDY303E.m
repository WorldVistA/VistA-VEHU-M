IBDY303E ;ALB/TMP - ENVIRONMENT CHECK FOR PATCH IBD*3*3 ; 23-JUN-97
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**3**;APR 24, 1997
 ;
EN ; Make sure patch 1 is installed first
 Q:$G(XPDENV)'=1
 N CNT,PATCH,Z,Z0
 ;
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,1:0) W !!,*7,">> DUZ and DUZ(0) must be defined as an active user",! S XPDQUIT=2
 ;
 ;Check for existence of prerequisite IBD patch 1
 ;
 I $T(+2^IBDF18E1)'["**1" D NOPTCH(1,.CNT)
 ;
 I $G(CNT) W !!,"Please install th",$S(CNT>1:"ese patches",1:"is patch")," first and then restart this install.",! S XPDQUIT=2
 Q
 ;
NOPTCH(PATCH,CNT) ; Writes patch not installed messsage
 ;PATCH = patch number not found
 ;CNT = # of patches missing ... passed by reference ... running count
 W !!,*7,"PATCH #: IBD*3.0*",PATCH," does not appear to be installed on your system and is",!,"  required before this patch can be installed."
 S CNT=$G(CNT)+1
 Q
 ;
