IBYSENV ; ALB/TMP - PATCH IB*2*91 ENVIRONMENT CHECK ; 11-01-97
 ;;2.0;INTEGRATED BILLING;**91**;21-MAR-94
 ;
EN Q:$G(XPDENV)'=1
 N CNT,L2,P,REQCHK,Z
 ;
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,1:0) W !!,*7,">> DUZ and DUZ(0) must be defined as an active user",! S XPDQUIT=2
 ;
 ;Check for existence of prerequisite non-KIDS IB patches 4,15,19,23,27,
 ;                                            31,32,33,36,39,40,41,43,54
 S CNT=0
 F Z=1:1 S REQCHK=$P($T(PTCHREQ+Z),";;",2) Q:REQCHK=""  D
 . S L2=$TR($P($T(@("+2^"_$P(REQCHK,U))),";",5),"*",",")
 . F P=2:1:$L(REQCHK,U) I L2'[(","_$P(REQCHK,U,P)_",") D NOPTCH($P(REQCHK,U,P),.CNT)
 I CNT W !!,"Please install th",$S(CNT>1:"ese patches",1:"is patch")," first and then restart this install.",! S XPDQUIT=2
 Q
 ;
NOPTCH(PATCH,CNT) ; Writes patch not installed messsage
 ;PATCH = patch number not found
 ;CNT = # of patches missing ... passed by reference ... running count
 W !!,*7,"PATCH #: IB*2.0*",PATCH," does not appear to be installed on your system and is",!,"  required before this patch can be installed."
 S CNT=$G(CNT)+1
 Q
 ;
PTCHREQ ;
 ;;IBCD2^4
 ;;IBTRPR01^23
 ;;IBCOPV^27
 ;;IBTUBO^31^32
 ;;IBAMTV1^15^33
 ;;IBCONS2^19^36^54
 ;;IBJTRA1^39
 ;;IBTRE20^40
 ;;IBCU71^41
 ;;IBCU82^43
 ;;
