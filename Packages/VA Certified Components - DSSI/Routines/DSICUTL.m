DSICUTL ;DSS/SGM - VARIOUS UTILITIES ;12/23/2004 07:45
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;  this routine contains various utilities called from DSI
 ;  VEJD routines
 ;  DBIA#  Supported Reference
 ;  -----  ------------------------------
 ;   2198  $$BROKER^XWBLIB
 ;  10104  ^XLFSTR: $$LOW, $$UP
 ;
BROKER(RPC) ; api to determine if in Broker context
 ; RPC - opt - full exact name of RPC
 ;       if RPC is passed, then not only check for broker context, but
 ;       also check to see if this RPC is the one running
 ; Return: 1:Broker context, no RPC check or RPC check failed
 ;         2:Broker context and RPC check is true
 ;         0:Not Broker context
 ;
 N X S X=$$BROKER^XWBLIB I 'X Q 0
 Q 1+$S($G(RPC)="":0,1:$G(XWB(2,"NAME"))=RPC)
 ;
CNVT(INPUT,STR,FLAGS) ;  api to check input string for certain
 ;  characters only.
 ;  INPUT - required - string to be checked to see if it
 ;          contains certain characters
 ;    STR - required - string of characters that represent the
 ;          only valid characters allowed in the INPUT string
 ;  FLAGS - optional - convert INPUT and STR prior to check
 ;          if FLAGS="U" convert any lower case to upper case
 ;          if FLAGS="L" convert any upper case to lower case
 ;  Return INPUT value stripped of any no valid characters
 ;    if all INPUT characters invalid, return <null>
 N I,J,X,Y,Z
 I $G(INPUT)="" Q ""
 I $G(STR)="" Q INPUT
 S FLAGS=$G(FLAGS) S:FLAGS="" FLAGS=" "
 I "Uu"[FLAGS D
 .I INPUT?.E1L.E S INPUT=$$UP^XLFSTR(INPUT)
 .I STR?.E1L.E S STR=$$UP^XLFSTR(STR)
 .Q
 I "Ll"[FLAGS D
 .I INPUT?.E1U.E S INPUT=$$LOW^XLFSTR(INPUT)
 .I STR?.E1U.E S STR=$$LOW^XLFSTR(STR)
 .Q
 S X="" F I=1:1:$L(INPUT) S Y=$E(INPUT,I) S:STR[Y X=X_Y
 Q X
 ;
DATE(SD,ED) ;  validate start and end dates
 ;  called by reference so that changes to SD & ED passed backed
 ;  extrinsic function returns 1 if okay, else -1^message
 ;  SD - optional - FM start date.time - default to 2500101
 ;  ED - optional - FM end date.time -   default to TODAY
 S SD=$G(SD,2500101),ED=$G(ED,DT)
 S:'SD SD=2500101 S:'ED ED=DT
 I ED<SD Q "-1^Start date is later than end date"
 S SD=SD-.000001,ED=$P(ED,".")_".25"
 Q 1
 ;
STRIP(X,STR) ;  strip leading/trailing punctuation characters from X
 ;  STR - opt - string of punctuation characters to not be stripped
 ;        Stop processing string if character is contained in STR
 ;  Return X stripped of those punctuation characters.
 ;  May return "" is X contains all stripable punctuation characters
 Q:$G(X)="" ""
 N A,I,Y,Z,CK S A=$G(STR),STR=""
 I A'="" F I=1:1:$L(A) I $E(A,I)?1P S STR=STR_$E(A,I)
 F  S A=$E(X) Q:$S(X="""":1,A'?1P:1,1:STR[A)  S X=$E(X,2,$L(X))
 F  S A=$E(X,$L(X)) Q:$S(X="""":1,A'?1P:1,1:STR[A)  S X=$E(X,1,$L(X)-1)
 Q X
INPLOC(REC,DFN) ; Return a patient's current location RPC:  DSIC PAT LOC
 N X
 S X=$G(^DPT(DFN,.102)),REC=0
 I X S X=$P($G(^DGPM(X,0)),U,6)
 I X S REC=+$G(^DIC(42,X,44))
 I X S $P(REC,U,2)=$P($G(^DIC(42,X,0)),U,1)
 I X S X=$P($G(^DIC(42,X,0)),U,3)
 S $P(REC,U,3)=X
 Q
