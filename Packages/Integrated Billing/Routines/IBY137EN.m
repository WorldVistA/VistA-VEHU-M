IBY137EN ;ALB/TMP - PATCH IB*2.0*51 ENVIRONMENT CHECK ;20-AUG-96
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-94
 ;
 Q:$G(XPDENV)'=1
 N CNT,PATCH,Z,Z0
 ;
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,1:0) W !!,*7,">> DUZ and DUZ(0) must be defined as an active user",! S XPDQUIT=2
 ;
 ;Check for existence of prerequisite IB patch 46
 ;
 I $P($T(+2^IBCNSC),"**",2)'["46" D NOPTCH(46,.CNT)
 ;
 I $G(CNT) W !!,"Please install th",$S(CNT>1:"ese patches",1:"is patch")," first and then restart this install.",! S XPDQUIT=2
 ;
 Q
 ;
NOPTCH(PATCH,CNT) ; Writes patch not installed messsage
 ;PATCH = patch number not found
 ;CNT = # of patches missing ... passed by reference ... running count
 W !!,*7,"PATCH #: IB*2.0*",PATCH," does not appear to be installed on your system and is",!,"  required before this patch can be installed."
 S CNT=$G(CNT)+1
 Q
 ;
