DSICDPT1 ;DSS/SGM - VARIOUS RPCS TO THE VADPT API ;03/07/2006 00:36
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;As of 3/1/2006 this routine should not be directly invoked.
 ;See routine DSICDPT
 ;
DEM(RET,DFN,SSN,PERM,DSICONF,DSIFLG) ; get all patient demographics
 ;You must pass either DFN or SSN
 ;Input    Description
 ;-------  --------------------------------------------------
 ;PERM     if 1, then return permanent address
 ;         else return whatever ADD^VADPT returns {default}
 ;DSICONF  p1^p2 - flag to return confidential address
 ;         p1 - req - confidential address category
 ;          p1 is a string of one or more numerics, e.g, 134
 ;             1 = Eligibility/Enrollment
 ;             2 = Appointment/Scheduling
 ;             3 = Co-payments/Veterans Billing
 ;             4 = Medical Records
 ;             5 = All Others
 ;          p2 - opt - FM date to determine if confidential date is
 ;               effective.  Default value is TODAY
 ;DSIFLG   if DISFLG=1, return internal^external values if appropriate
 ;         default is 0, to return single external value
 ;         Example, for a STATE field,
 ;           if 0 then return abbrev (or name if abbrev is null)
 ;           if 1 return IFN-file-5^name^abbrev
 ;    In definition of RET(), if DSIFLG=1 then return items in [...]
 ; On error return -1^error message
 ;Else return:
 ; DSICDAT()  Description
 ; ---------  ------------------------------------------
 ;     1      patient name
 ;     2      ssn;dashed ssn;
 ;     3      dob int;ext
 ;     4      age
 ;     5      sex
 ;     6      date of death int;ext
 ;     7      race
 ;     8      religion
 ;     9      marital status
 ;    10      employment status
 ;    11      1st st add
 ;    12      2nd st add
 ;    13      3rd st add
 ;    14      city
 ;    15      state abbr [or ien^state name^state abbr]
 ;    16      zip (9 or 5) [or internal zip^external zip]
 ;    17      county [or multiple ien^county name]
 ;    18      home phone
 ;    19      work phone
 ;    20      LastName^FirstName^Middle^Suffix/Title
 ; ---- ret(21) - ret(28) all refer to confidential address  ----
 ;    21      confidential address category bitmap
 ;[Default value of "00000".  This is a 5 char string of 0s and 1s
 ; where each bit refers to whether or not the particular category
 ; is active or not as of the date in the DSICONF param.  Only those
 ; categories requested in DSICONF param will have a bit value of 1]
 ;    22      street address 1
 ;    23      street address 2
 ;    24      street address 3
 ;    25      city
 ;    26      state abbr [or ien^state name^state abbr]
 ;    27      zip (9 or 5) [or internal zip^external zip]
 ;    28      county [or multiple ien^county name]
 ; -------------------------------------------------------------
 ;    29      primary elig ^ other elig ^ other elig ^ ...
 ;    30      1 if patient is a veteran, else 0
 ;    31      code^name of current means test status
 ;  
 N I,J,X,Y,Z,DIERR,DSI,DSIERM
 I $G(DFN)>0 S X=$$GET(DFN) I +X=-1 S RET(1)=X Q
 I $G(DFN)'>0 D  Q:$D(RET)
 .I $G(SSN)="" S RET(1)=$$ERR(1) Q
 .S X=$$GET(SSN,1) S:X>0 DFN=+X S:X'>0 RET(1)=$$ERR(2)
 .Q
 ;get patient demographics [VADM(n)]
 D DEM^VADPT
 ;get address data [VAPA(n)]
 S:$G(PERM)>0 VAPA("P")=""
 S DSICONF=$G(DSICONF),DSIFLG=+$G(DSIFLG)
 I DSICONF'="",$$PATCH^XPDUTL("DG*5.3*489") D
 .S Y="",X=$P(DSICONF,U) I X'="" F I=1:1:5 S:X[I Y=Y_I
 .Q:Y=""  S X=$P(DSICONF,U,2) S:X'?7N X=DT
 .S DSICONF=Y_U_X
 .S VAPA("CD")=X
 .Q
 D ADD^VADPT
 S VAOA("A")=5 D OAD^VADPT ;get other address info VAOA(n) - employer=5
 D OPD^VADPT ;get other patient data [VAPD(n)]
 D ELIG^VADPT ;get elibility info [VAEL(n)]
 D NAMECOM(.DSIERM,$G(VADM(1)))
 S RET(20)=$S(+DSIERM'=-1:DSIERM,1:"")
 S RET(1)=$G(VADM(1))
 S RET(2)=$TR($G(VADM(2)),U,";")
 S X=$P($G(VADM(3)),U)
 S RET(3)=$S(X:X_";"_$$FMTE^XLFDT(X,"5PZ"),1:"")
 S RET(4)=$G(VADM(4))
 S RET(5)=$P($G(VADM(5)),U)
 S X=$P($G(VADM(6)),U)
 S RET(6)=$S(X:X_";"_$$FMTE^XLFDT(X,"5PZ"),1:"")
 S RET(7)=$P($G(VADM(8)),U,2)
 S RET(8)=$P($G(VADM(9)),U,2)
 S RET(9)=$P($G(VADM(10)),U,2)
 S RET(10)=$P($G(VAPD(7)),U,2)
 S RET(11)=$G(VAPA(1))
 S RET(12)=$G(VAPA(2))
 S RET(13)=$G(VAPA(3))
 S RET(14)=$G(VAPA(4))
 S RET(15)=$$STATE($G(VAPA(5)),DSIFLG)
 S X=$G(VAPA(11)),RET(16)=$S(DSIFLG:X,1:$P(X,U,2))
 S X=$G(VAPA(7)),RET(17)=$S(DSIFLG:X,1:$P(X,U,2))
 S RET(18)=$G(VAPA(8))
 S RET(19)=$G(VAOA(8))
 F I=21:1:28 S RET(I)=""
 I DSICONF'="",+$G(VAPA(12)) D
 .S X="00000",Z=$P(DSICONF,U)
 .F I=1:1:5 I $P($G(VAPA(22,I)),U,3)="Y",Z[I S $E(X,I)=1
 .Q:X="00000"  S RET(21)=X
 .F I=13,14,15,16 S RET(I+9)=VAPA(I)
 .S RET(26)=$$STATE(VAPA(17),DSIFLG)
 .S X=VAPA(18),RET(27)=$S(DSIFLG:X,1:$P(X,U,2))
 .S X=VAPA(19),RET(28)=$S(DSIFLG:X,1:$P(X,U,2))
 .Q
 S RET(29)=$P($G(VAEL(1)),U,2)
 F I=0:0 S I=$O(VAEL(1,I)) Q:'I  S RET(29)=RET(29)_U_$P(VAEL(1,I),U,2)
 S RET(30)=$G(VAEL(4))
 S RET(31)=$G(VAEL(9))
 D KVA^VADPT
 Q
 ;
NAMECOM(RET,VNAME) ;  RPC: DSIC XUTIL NAME COMPONENT
 ;return name components for standard VistA name
 ;Return: RET = LastName^FirstName^Middle^Suffix/Title
 ;        on error - return -1^error message
 N X I $G(VNAME)="" S RET=$$ERR(3) Q
 D STDNAME^XLFNAME(.VNAME,"CF") S RET=""
 F X="FAMILY","GIVEN","MIDDLE","SUFFIX" S RET=RET_$G(VNAME(X))_U
 Q
 ;---------- private subroutines ----------
ERR(A) ;
 I A=1 S A="No patient DFN or SSN received"
 I A=2 S A="SSN "_SSN_" not found in the Patient file"
 I A=3 S A="No name received"
 I A=4 S A="No lookup value received"
 I A=5 S A="No match found for lookup value: "_PAT
 I A=6 S A="Bad data detected, "_$NA(^DPT(DFN,0))_" does not exist"
 Q "-1^"_A
 ;
GET(X,TYPE) ; validate input value
 ;Return DFN^name^ssn;dashed-ssn  OR  on error return -1^error message
 ;   X - req - lookup value
 ;TYPE - opt - Boolean, default=0 - 1:lookup value is SSN
 ;  0 & (X is 9 digit) - first check for DFN value, then SSN
 N Y,Z,DFN,PAT S PAT=$G(X),TYPE=$G(TYPE)
 I PAT="" Q $$ERR(4)
 I 'TYPE,PAT=+PAT,$D(^DPT(PAT,0)) S DFN=PAT
 I '$D(DFN) D
 .N DIERR,DSIERR S Z=0
 .I PAT?9N.1"P" S Z=$$FIND1^DIC(2,,"QX",PAT,"SSN",,"DSIERR")
 .I '$D(DIERR),Z>0 S DFN=Z Q
 .K DIERR S Z=$$FIND1^DIC(2,,"QMX",PAT,,,"DSIERR")
 .I '$D(DIERR),Z>0 S DFN=Z
 .Q
 I '$D(DFN) Q $$ERR(5)
 S Z=$G(^DPT(DFN,0)) I Z="" Q $$ERR(6)
 S Y=$P(Z,U,9) I Y]"" S Y=Y_";"_$E(Y,1,3)_"-"_$E(Y,4,5)_"-"_$E(Y,6,99)
 Q DFN_U_$P(Z,U)_U_Y
 ;
STATE(X,DSIFLG) ;  return state data
 ;X - req - +X=ien to file 5
 ;    if $P(X,U,2)'="" then it must be the .01 value from file 5
 ;DSIFLG - opt - default=0 - Boolean
 ;         1:return state's ien^name^abbreviation
 ;         0:return state abbreviation, if abbrev="", return state name
 N Z,DSIEN,DSIERR,DSINM
 S X=$G(X),DSIEN=+X,DSINM=$P(X,U,2),DSIFLG=+$G(DSIFLG)
 I DSIEN<1 Q ""
 I DSINM="" S DSINM=$$GET1^DIQ(5,DSIEN,.01,,,"DSIERR")
 S Z=$$GET1^DIQ(5,DSIEN,1,,,"DSIERR") ; state abbr
 I 'DSIFLG S X=$S(Z'="":Z,1:DSINM)
 E  S Z=DSIEN_U_DSINM_U_Z
 Q Z
