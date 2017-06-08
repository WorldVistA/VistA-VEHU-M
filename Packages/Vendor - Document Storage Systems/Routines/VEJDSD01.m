VEJDSD01 ;DSS/SGM - VARIOUS SCHEDULING OPTIONS ;10/13/2005 08:36
 ;;3.5;VEJD DSS CORE RPCS;;Jan 03, 2006
 ;Copyright 1995-2006, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA#  Supported References
 ;-----  -------------------------------------------
 ;  557  Direct glb read of some fields in file 40.7
 ; 2051  $$FIND1^DIC
 ; 2056  GETS^DIQ
 ; 2569  GETOE^SDOERPC
 ;10035  Direct global read of some fields in file 2
 ;10103  ^XLFDT: $$FMADD, $$FMTE
 ;10104  $$UP^XLFSTR
 ;       CURRENT^SDAMU
 ;       Accessing ^SC()
 ;                 ^DPT(DFN,"S")
 ;                 File 44 - fields .01;3;3.5;8;2505;2506
 ;
APPL(VEJD,SDT,EDT,DATA) ; RPC: VEJDSD GET SCHEDULED APPTS
 ;This gets all the active scheduled appts for one or more clinics
 ;    SDT - opt - start date - default = today
 ;    EDT - opt -   end date - default = today + 6 days
 ; DATA() - req - passed by reference where DATA(n) = code ^ value
 ;    CODE  VALUE
 ;    ----  -------------------------------------------------------
 ;      C   clinic lookup value [name, or IFN, or any lookup value]
 ;           -- only exact matches on lookup name accepted            
 ;      S   3-digit stop code
 ;     FI   1 or 0 - default is 0
 ;            if 1, then filter out appts that are checked in
 ;     FO   1 OR 0 - default is 0
 ;            if 1, then filter out appts that are checked out
 ;
 ;Return @VEJD@(n) = visit-ifn^date.time^loc^patient^ssn^divison
 ;    where for p2-p6 will be internal;external
 ;    data will be sorted by location name then date.time
 ;
 N I,J,K,X,Y,Z,ASSN,CLIN,CNT,D0,D1,DATE,DFN,LIST,SSN,STOP,TMP
 N VEJI,VEJO,VEJDFI,VEJDFO
 S VEJD=$NA(^TMP("VEJD",$J)) K @VEJD
 I $O(DATA(""))="" S @VEJD@(1)=$$ERR(1) Q
 S:'$G(SDT) SDT=DT S SDT=SDT-.000001
 S:'$G(EDT) EDT=$$FMADD^XLFDT(DT,60) S EDT=EDT+.5
 S (VEJDFO,VEJDFI)=0
 ; check data() for valid inputs
 S I="" F  S I=$O(DATA(I)) Q:I=""  S Z=DATA(I) D
 .S X=$P(Z,U),Y=$P(Z,U,2) Q:X=""!(Y="")
 .I X?.E1L.E S X=$$UP^XLFSTR(X)
 .I $E(X)="S" S STOP(Y)="" Q
 .I X="FO",Y>0 S VEJDFO=1
 .I X="FI",Y>0 S VEJDFI=1
 .Q:'$E(X)="C"
 .K TMP D LOC(.TMP,Y)
 .I TMP>0 S LIST(+TMP)=$P(TMP,U)_";"_$P(TMP,U,2)_U_$P(TMP,U,5)
 .Q
 I $D(STOP) K TMP D CLST(.TMP,.STOP) I $D(TMP) D
 .S X="TMP" F  S X=$Q(@X) Q:X=""  S Y=@X I '$D(LIST(+Y)) D
 ..S LIST(+Y)=$P(Y,U)_";"_$P(Y,U,2)_U_$P(Y,U,5)
 ..Q
 .Q
 S (I,CNT)=0 F  S I=$O(LIST(I)) Q:'I  D
 .S J=SDT,CLIN=LIST(I),CLIN(0)=$P($P(CLIN,U),";",2)_"~"_(+CLIN)_"~"
 .F  S J=$O(^SC(I,"S",J)) Q:J>EDT!'J  S K=0 D
 ..S DATE=J_";"_$$FMTE^XLFDT(J,"5PZ")
 ..F  S K=$O(^SC(I,"S",J,1,K)) Q:'K  D
 ...S DFN=+^SC(I,"S",J,1,K,0),Z=$G(^("C"))
 ...S VEJI=Z>0,VEJO=$P(Z,U,3)>0
 ...I +$G(^DPT(DFN,"S",J,0))'=I Q
 ...;9/13/2005 - SGM - check for filters
 ...I VEJDFO,VEJO Q  ;      ck'd out
 ...I VEJDFI,VEJI+VEJO Q  ; ck'd in
 ...S D0=DFN,D1=J N I,J,K,LIST D CURRENT^SDAMU
 ...I X["CANCEL"!(X["NO-SHOW") Q
 ...S Y=$$GET^DSICDPT1(DFN),Z=(+Y)_";"_$P(Y,U,2)_U_$P(Y,U,3)
 ...S TMP=$$GV(D0,D1)_U_DATE_U_$P(CLIN,U)_U_Z_U_$P(CLIN,U,2)
 ...S CNT=CNT+1,@VEJD@(CLIN(0),+DATE,CNT)=TMP
 ...Q
 ..Q
 .Q
 I '$D(@VEJD) S @VEJD@(1)=$$ERR(2)
 Q
 ;
CLST(VEJDX,STOP) ;  RPC: VEJDSD GET LOC BY STOP CODE
 ; get list of all HOSPITAL LOCATIONS with certain stop codes
 ; STOP - req - array of 3-digit stop codes STOP(n)=3-digit stop
 ; Return:  @VEJDX@(n) = ifn ^ p2 ^ p3 ^ p4 ^ p5  where
 ;   p2 = name   p3 = 3-digit stop code  p4 = ifn;institution name
 ;   p5 = ifn;medical center division
 N I,J,X,Y,Z,CODE,RTN
 I '$D(STOP) S VEJDX(1)=$$ERR(3) Q
 S Y="" F  S Y=$O(STOP(Y)) Q:Y=""  S X=$$ACT(,Y) I X]"" D
 .F I=1:1 S Z=$P(X,";",I) Q:Z=""  S CODE(+Z)=$P(Z,U,3)
 .Q
 F I=0:0 S I=$O(^SC(I)) Q:'I  S X=^(I,0),Y=+$P(X,U,7) I $D(CODE(Y)) D
 .K RTN D LOC(.RTN,I)
 .I +RTN>0 S Z=CODE(Y)_"~"_$P(RTN,U,2)_"~"_$J(I,6),VEJDX(Z)=RTN
 .Q
 I '$D(VEJDX) S VEJDX(1)=$$ERR(4)
 Q
 ;
GETSTOP(VEJDS) ;  RPC: VEJDSD GET STOP CODES
 ;This will return a list of all active stop codes and their names
 ;Return VEJDS() = ifn ^ stop code name ^ 3-digit stop code
 N I,X,Y,Z,CODE
 F I=0:0 S I=$O(^DIC(40.7,I)) Q:'I  S X=$$ACT(I) I X]"" D
 .F Y=1:1 S Z=$P(X,";",Y) Q:Z=""  S CODE=$P(Z,U,3),VEJDS(CODE_"~"_I)=Z
 .Q
 Q
 ;
LOC(VEJDL,VAL) ;  RPC: VEJDSD GET LOCATION
 ; lookup location in file 44
 ; VAL - req - lookup value, name or ifn in file 44
 ; return VEJDL = ifn ^ p2 ^ p3 ^ p4 ^ p5 ^ p6 where
 ;   p2 = name   p3 = 3-digit stop code  p4 = ifn;institution name
 ;   p5 = ifn;medical center division    p6 = active flag [1/0]
 ; on error return -1^error message
 N I,X,Y,Z,ACT,CODE,DIERR,DIV,IENS,INST,NAME,VEJD,VEJDERR
 I $G(VAL)="" S VEJDL=$$ERR(1) Q
 I VAL=+VAL,$D(^SC(VAL,0)) S IENS=VAL_","
 E  D  Q:$D(VEJDL)
 .S X=$$FIND1^DIC(44,,"AMX",VAL,,,"VEJDERR")
 .I $D(DIERR) S VEJDL=$$ERR(0) Q
 .I X<1 S VEJDL=$$ERR(5) Q
 .S IENS=X_","
 .Q
 D GETS^DIQ(44,IENS,".01;3;3.5;8;2505;2506","IE","VEJD","VEJDERR")
 I '$D(VEJD) S VEJDL=$$ERR(0) Q
 S NAME=$G(VEJD(44,IENS,.01,"E"))
 S INST=$G(VEJD(44,IENS,3,"I"))_";"_$G(VEJD(44,IENS,3,"E"))
 S DIV=$G(VEJD(44,IENS,3.5,"I"))_";"_$G(VEJD(44,IENS,3.5,"E"))
 S CODE="",X=$G(VEJD(44,IENS,8,"I"))
 I X S X=$$GET1^DIQ(40.7,X_",",1,,"VEJDERR") I X]"" S CODE=X
 S ACT=$S('$G(VEJD(44,IENS,2505,"I")):1,1:$G(VEJD(44,IENS,2506,"I"))'<DT)
 S VEJDL=(+IENS)_U_NAME_U_CODE_U_INST_U_DIV_U_ACT
 Q
 ;
PAT(VEJDP,DFN,SDT,EDT) ; RPC: VEJDSD GET PAT SCHED APPTS
 ;This will get all the appointments for a patient for a date range
 ; DFN - req - patient file pointer
 ; SDT - req - start date.time in Fileman format
 ; EDT - req -   end date.time in Fileman format
 ;Return VEJDP(n) = visit-ifn^date.time^loc^patient^ssn^divison
 ;    where for p2-p6 will be internal;external
 ;    data will be sorted by location name then date.time
 ;
 N I,J,X,Y,Z,ASSN,CNT,DATE,IDX,LOC,MCD,PAT,RTN,STR,TMP,TMPG
 S VEJDP=$NA(^TMP("VEJDSD",$J)) K @VEJDP
 S X=$$ERRCK I X]"" S @VEJDP@(1)="-1^"_X Q
 S X=DFN_U_SDT_U_EDT_"^^2" D VSIT^DSICVST2(.RTN,X)
 I '$D(@RTN) S @VEJDP@(1)=$$ERR(6) Q
 S X=@RTN@(1) I +X=-1 S @VEJDP@(1)=X Q
 K ^TMP($J) S X=$$GET^DSICDPT1(DFN)
 S ASSN=$P(X,U,3),PAT=$TR($P(X,U,1,2),U,";"),(CNT,IDX)=0
 F  S IDX=$O(@RTN@(IDX)) Q:'IDX  S STR=@RTN@(IDX) D
 .S LOC=$P(STR,U,6),X=$G(^TMP($J,LOC))
 .I X="" D LOC(.TMP,LOC) S X=TMP,^TMP($J,LOC)=X
 .S Y=$P(STR,U,5),DATE=Y_";"_$$FMTE^XLFDT(Y,"5PZ")
 .S MCD=$P(X,U,5),LOC=$TR($P(X,U,1,2),U,";")
 .S Z=$P(STR,U,2)_U_DATE_U_LOC_U_PAT_U_ASSN_U_MCD
 .S CNT=CNT+1,@VEJDP@(CNT)=Z
 .Q
 I '$D(@VEJDP) S @VEJDP@(1)=$$ERR(6)
 K @RTN,^TMP($J)
 Q
 ;
 ;--------------------  subroutines  ---------------------------
ACT(A,B) ;  return ien^name^3-digit stop code;ien^name^3-digit stop;...
 ;  for active stop codes only.   Return <null> if none found
 ;  A = ien to file 40.7   B = 3 digit stop code
 N X,Y,Z,HAVE,IEN,RTN S RTN=""
 I $G(A)>0 S X=$G(^DIC(40.7,A,0)) D
 .I $P(X,U,3),$P(X,U,3)'>DT Q
 .I '$D(HAVE(A)) S RTN=RTN_A_U_$P(X,U,1,2)_";",HAVE(A)=""
 .Q
 I $G(B)]"" F Y=0:0 S Y=$O(^DIC(40.7,"C",B,Y)) Q:'Y  D
 .S X=$G(^DIC(40.7,Y,0)) Q:X=""  I $P(X,U,3),$P(X,U,3)'>DT Q
 .I '$D(HAVE(Y)) S RTN=RTN_Y_U_$P(X,U,1,2)_";",HAVE(Y)=""
 .Q
 Q RTN
 ;
ERR(A) ;
 I A=0 S A=$$MSG^DSICFM01("VE",,,,"VEJDERR")
 I A=1 S A="No lookup data received"
 I A=2 S A="No appointments found for input criteria"
 I A=3 S A="No stop codes received"
 I A=4 S A="No clinics found matching for these stop codes"
 I A=5 S A="Did not find hospital location: "_VAL
 I A=6 S A="No data found"
 Q "-1^"_A
 ;
ERRCK() ;  this will check for the variables DFN, SDT, EDT being defined
 ;  If everything is okay, return <null>
 ;  Else return error message
 N ERM S ERM=""
 I '$G(DFN) S ERM="No patient DFN received"
 E  I '$D(^DPT(DFN,0)) S ERM="Patient record "_DFN_" does not exist"
 I '$G(SDT) S:ERM]"" ERM=ERM_", " S ERM=ERM_"No start date received"
 I '$G(EDT) S:ERM]"" ERM=ERM_", " S ERM=ERM_"No end date received"
 I $G(SDT),$G(EDT),SDT>EDT D
 .S:ERM]"" ERM=ERM_", "
 .S ERM=ERM_"Starting date is greater than ending date"
 .Q
 Q ERM
 ;
GV(DFN,DATE) ;  get VISIT for a scheduled appointment
 ;  return <null> if none found
 N V,VEJD S V=$P($G(^DPT(+$G(DFN),"S",+$G(DATE),0)),U,20)
 I V D GETOE^SDOERPC(.VEJD,V) S:$P(VEJD,U,5) V=$P(VEJD,U,5)
 Q V
