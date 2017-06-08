DENTVRF0 ;DSS/SGM - UTILITIES FOR FILING DATA ;11/19/2003 21:36
 ;;1.2;DENTAL;**31,37,47**;Aug 10, 2001
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;  this routine is invoked from DENTVRF* routines
 ;
 ; DBIA#  SUPPORTED
 ; -----  ---------  ---------------------------------------
 ;  2053      x      UPDATE^DIE
 ; 10035      x      direct global read file 2, field .01
 ; 10103      x      $$FMTE^XLFDT
 ;
CHART(DFN,DATE,ADD) ;  return the TP chart number and last time for date
 ;  DFN - required - pointer to the patient file
 ; DATE - optional - fileman date - default to today
 ;  ADD - optional - boolean flag (1/0) indicating that a new chart
 ;        num should be created for that date if it does not exist.
 ;        If added, then Last Time is returned as <null>
 ;  RETURN: chart num ^ last time counter
 ;  On error return -1^error message
 N I,X,Y,Z,X0,X1,CHART,IEN
 S X=$$DFN($G(DFN),1) I X<1 Q X
 S ADD=$G(ADD),DATE=$P($G(DATE),".") S:'DATE DATE=DT
 S X=$G(^DENT(220,DFN,11,DATE,0))
 I ADD,X="" D
 .S X=$$LOCK I X<1 Q
 .N DENIEN,DENTER,DENTX,DIERR
 .S X=$O(^DENT(220,DFN,11,"B","A"),-1) S:X<60 X=59 S CHART=1+X
 .S DENTX(220.071,"+1,"_DFN_",",.01)=CHART
 .S DENIEN(1)=DATE
 .D UPDATE^DIE(,"DENTX","DENIEN","DENTER"),UNLOCK
 .I '$D(DENTER) S X=CHART_U
 .E  S X="-1^"_$$MSG^DSICFM01("VE",,,,"DENTER")
 .Q
 I X="" S X="-1^No chart number found for date: "_$$FMTE^XLFDT(DT)
 Q X
 ;
DFN(DFN,ADD) ;  verify valid patient pointer
 ; DFN - pointer to the patient file
 ; ADD - boolean flag to indicate whether or not the DFN should be added
 ;       to file 220
 ; RETURN: -1^message, 1 if found, 2 if newly added
 N X,Y,Z
 I $G(DFN)<1 Q "-1^No DFN value received"
 I '$D(^DPT(DFN,0)) Q "-1^"_DFN_" is not a valid pointer"
 I '$G(ADD),'$D(^DENT(220,DFN,0)) Q "-1^Patient not a registered dental patient" Q
 I '$D(^DENT(220,DFN,0)) D
 .L +^DENT(220,0):5 E  S X="-1^Unable to lock file 220, try again" Q
 .S $P(^(0),U,4)=1+$P(^DENT(220,0),U,4),$P(^(0),U,3)=DFN
 .S ^DENT(220,DFN,0)=DFN,^DENT(220,"B",DFN,DFN)=""
 .L -^DENT(220,0) S X=2
 .Q
 Q $G(X,1)
 ;
LOCK() ;  lock TP CHART NUM multiple zeroth node
 ;  expects DFN to be defined
 I $G(DFN)<1 Q "-1^No DFN value received to lock multiple"
 L +^DENT(220,DFN,11,0):5 I  Q 1
 Q "-1^Unable to lock TP CHART NUM multiple for DFN: "_DFN
 ;
UNLOCK L -^DENT(220,+$G(DFN),11,0) Q
 ;
QUAD(Q) ;  for quadrant, return first tooth for that quadrant
 ;  return tooth number or -1
 N X,Y,Z
 S X=$S(Q="UR":1,Q="UL":2,Q="LL":3,Q="LR":4,1:-1)
 S Y=$O(^DENT(228.4,IDX1,X,0))
 Q $S(Y>0:Y,1:-1)
 ;
SPEC(X) ;  convert X=ptf specialty pointer (#42.4) to dental bedsection ptr
 ;  return pointer to dental bedsection or <null>
 ;  following lines are the pointer values for file 42.4
 ;  Dent Bedsection n maps to PTF Specialties on line S0+n
S0 ;;^37^80^81^85^86^87^88^96^
 ;;^1^2^3^4^5^6^7^8^9^14^15^16^17^24^31^98^99^
 ;;^50^51^52^53^54^55^56^57^58^59^60^61^62^65^
 ;;^33^70^79^89^91^93^94^
 ;;^25^26^28^38^39^71^75^76^77^92^
 ;;^32^40^83^95^
 ;;^10^18^19^34^
 ;;^20^35^41^
 ;;^72^
 ;;^27^29^73^74^84^90^
 ;;^22^23^
 ;;^11^
 ;;^21^36^
 ;;^
 ;;^12^
 ;;^63^
 N I,Y,Z
 S Z="",X=$G(X) I X<1!(X>99)!(X'?1.2N) Q Z
 F I=1:1:15 S Y=$T(S0+I) I Y[(U_X_U) S Z=I Q
 Q Z
 ;
SURF(X) ;  put surfaces in treatment plan seq
 ;  X - required - surfaces string
 N A,I,Z S X=$G(X),Z="",A="MFBLDIO" F I=1:1:7 I X[$E(A,I) S Z=Z_$E(A,I)
 Q Z
 ;
UPDTIM(DFN,DATE,TIME) ;  update last time counter in file 220
 ;  If appropriate, update the last time counter
 ;  TIME (COUNTER) - optional - time counter field from file 228.2
 ;                   if not passed, then increment LAST TIME
 ;   DFN - required - pointer to the patient file
 ;  DATE - required - fileman date
 ;  RETURN: 1^time counter if updated, else -1^message
 N X,Y,Z,TIMEX
 I $G(DATE)'?7N.E Q "-1^Invalid Fileman date received: "_$G(DATE)
 S X=$$DFN($G(DFN),1) I X<1 Q X
 S DATE=$P(DATE,".")
 S X=$$LOCK I X<1 Q "-1^Unable to lock file 220 TP Chart Num multiple"
 S X=$G(^DENT(220,DFN,11,DATE,0))
 S TIMEX=$P(X,U,2) S:TIMEX<1000 TIMEX=990
 I X="" D UNLOCK Q "-1^No TP CHART NUM exists for date: "_DATE
 S Y=0 I $G(TIME)<1000 S (Y,TIME)=TIMEX+10
 E  I TIME>TIMEX S Y=TIME
 I Y>0 S $P(^DENT(220,DFN,11,DATE,0),U,2)=Y
 D UNLOCK
 Q 1_U_TIME
 ;
TRANID(F) ;  create new record stub for file=F [228.1, 228.2]
 ;  return record ien or -1
 N X,Y,Z,IEN,TRANID
 I $G(DUZ)<.5 Q -1
 I '$G(DATE) N DATE S DATE=$E($$NOW^XLFDT,1,12)
 L +^DENT(F,0):2 E  D MSG(1,F) Q -1
 S TRANID=1+$O(^DENT(F,"B","A"),-1)
 S IEN=1+$O(^DENT(F,"A"),-1)
 I F=228.1 S X=TRANID_U_U_+DATE_U_DUZ
 I F=228.2 S X=TRANID,Y=+DATE_U_DUZ
 S ^DENT(F,IEN,0)=X S:$D(Y) ^(1)=Y
 S ^DENT(F,"B",TRANID,IEN)=""
 S Z=$P(^DENT(F,0),U,3,4),$P(^(0),U,3,4)=IEN_U_(1+$P(Z,U,2))
 L -^DENT(F,0)
 Q IEN
 ;
MSG(X,Y) ;  error messages
 ;;Try again, unable to lock file 
 ;;Try again, unable to lock newly created record in file 
 I +X=X S X=$P($T(MSG+X),";",3)_$G(Y)
 S Y=1+$O(RET("A"),-1),RET(Y)=X
 Q
