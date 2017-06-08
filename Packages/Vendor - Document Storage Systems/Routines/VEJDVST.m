VEJDVST ;DSS/SGM - COMMON FUNCTIONS FOR VEJDVST* ROUTINES ;01/29/2002 09:07
 ;;2.11;VEJDCERT RPCS;;Mar 06, 2002
 Q
 ;
ADM(DFN)        ;  return current admission data
 ;  DBIA10039 - supported IA to reference field 44, file 42
 ;  return 1^p2^p3^p4^p5^p6^p7 where
 ;    p2 = external admission date.time
 ;    p3 = external admission location
 ;    p4 = internal admission date.time
 ;    p5 = internal admit ptr to 44
 ;    p6 = external current location
 ;    p7 = internal current ptr to 44
 ;    if invalid dfn return -1^error message
 ;    if not an inpatient, return 0^Not currently admitted
 ;
 N X,Y,Z,AWARD,CWARD,DIERR,ERR,HOS,RET,VAERR,VAIP,VAROOT
 S X=$$DFN(+$G(DFN)) I X]"" S RET="-1^"_X ;  invalid dfn
 E  D
 .S VAROOT="HOS",VAIP("D")=$$NOW^XLFDT D IN5^VADPT
 .I '$G(HOS(13,1)) S RET="0^Not currently admitted" Q
 .;  admission date.time int^ext
 .S RET=1,$P(RET,U,2)=$P(HOS(13,1),U,2),$P(RET,U,4)=$P(HOS(13,1),U)
 .S X=$G(HOS(5)) ;  current loc
 .S $P(RET,U,6)=$P(X,U,2)
 .S Z=$$GET1^DIQ(42,+X_",",44,"I",,"ERR") S:'$D(DIERR) $P(RET,U,7)=Z
 .S X=HOS(13,4) ;   admission loc
 .S $P(RET,U,3)=$P(X,U,2) K DIERR,ERR
 .S Z=$$GET1^DIQ(42,+X_",",44,"I",,"ERR") S:'$D(DIERR) $P(RET,U,7)=Z
 .Q
 Q RET
 ;
DFN(R) ;  check for valid patient file pointer R
 ;  return "" if a valid pointer, else return error message
 ;  I $$DFN(X)]"" then error
 N T S T=$D(^DPT(+$G(R),0))#2,T=$S(T:"",1:"-1^Invalid patient DFN") Q T
 ;
GET(FILE,VAL,FLD,INDX)  ;  do lookup on file
 ; FILE - required - file# to do lookup on
 ;  VAL - can be ien to that file, or a .01 field value for that file
 ;        if FILE=40.7, then VAL is either `ien or stop code number
 ;  FLD - optional - return value for that field [default = .01]
 ; INDX - optional - index name for file to do lookup on [default="B"]
 ;
 ;  return values
 ;    0     - value passed in VAL not found
 ;   <null> - error occurred
 ;    ien^[field value] - if lookup is successful
 ;
 N X,Y,Z,DIERR,ERR,IEN,NAME,RTN,VEJD,VIEN
 S FILE=$G(FILE),VAL=$G(VAL),FLD=$G(FLD,.01),INDX=$G(INDX,"B")
 I FILE=""!(VAL="") S RTN="" Q 0
 S IEN=$S(VAL?1"`".E:$P(VAL,"`",2),VAL=+VAL:VAL,1:0)
 S NAME=$S(IEN:"",1:VAL),VEJD=$S(IEN:"`"_IEN,1:NAME)
 S VIEN=$$FIND1^DIC(FILE,,"QX",VEJD,INDX,,"ERR")
 I 0[VIEN!$D(DIERR) S RTN=$S($D(DIERR):"",1:VIEN)
 E  I IEN S NAME=$$GET1^DIQ(FILE,IEN_",",FLD,,,"ERR")
 I '$D(RTN) S RTN=$S($D(DIERR):"",1:VIEN_U_NAME)
 Q RTN
 ;
GETM(RET,ARR,FILE,FLD,INDX)     ;  get multiple lookup values
 ;  FILE - required - file# to do lookup on
 ;   FLD - optional - return value for that field [default = .01]
 ;ARR(#) - data where data can be .01 field value or ien to that file
 ;         if the lookup value can be numeric, then if passing the ien,
 ;         then pass `ien, e.g., file 40.7 [stop codes] and passing
 ;         3-digit stop code I need to distinguish between field value 
 ;         and ien
 ;  INDX - optional - index name for file to do lookup on [default="B"]
 ;
 ;  return RET(ien)=name where name = value of entry's FLD value
 ;    if no values found, return RET(1)=0
 ;    if errors encountered, return RET(1)=""
 ;
 N X,Y,Z,VERR,INC
 S INC=-1,FLD=$G(FLD,.01),INDX=$G(INDX,"B")
 F  S INC=$O(ARR(INC)) Q:INC=""  I ARR(INC)]"" D
 .S Z=$$GET(FILE,ARR(INC),FLD,INDX)
 .I 0[Z S VERR=1+$G(VERR),VERR(VERR)=Z_U_ARR(INC)
 .E  S RET(+Z)=$P(Z,U,2)
 .Q
 I '$D(RET),'$D(VERR) S RET(1)=0
 I '$D(RET) S X=$P($G(VERR(1)),U),RET(1)=X
 Q
 ;
LOC(X) ;  convert location name (X) to pointer or
 ;  verify ien (in X) is a valid pointer
 ;  kept for backwards compatibility - 9-10-2001
 ;  DBIA10040 - supported IA for read of field .01, file 44
 ;  DBIA908 - IA for read of field .01, file 44
 N RET S RET=$$GET(44,$G(X)) S:+RET RET=+RET
 Q RET
 ;
SCCOND(RET,DATA) ;  RPC call to get environmental checks
 ;  DBIA2028 - direct read of ^AUPNVSIT
 ;  DBIA2348 - SCCOND^PXUTLSCC
 ;  DATA = DFN ^ appt/visit FM date/time ^ location ^ visit pointer
 ;  return RET = ao^ec^ir^sc^mst^hnc where each piece is either 1 or ""
 N I,X,Y,DFN,APPT,LOC,VST,VEJDSC
 F I=1:1:4 S @$P("DFN^APPT^LOC^VST",U,I)=$P(DATA,U,I)
 S LOC=$$LOC(LOC),X=$$DFN(+DFN)
 I $L(X) S RET="-1^"_X Q
 S X=+$G(^AUPNVSIT(+$G(VST),0)) S:'$G(APPT) APPT=X
 I 'APPT S RET="-1^No appointment/visit date" Q
 D SCCOND^PXUTLSCC(DFN,APPT,LOC,VST,.VEJDSC)
 F I=1:1:6 S X=$P("AO^EC^IR^SC^MST^HNC",U,I),$P(RET,U,I)=$E(1,+$G(VEJDSC(X)))
 Q
