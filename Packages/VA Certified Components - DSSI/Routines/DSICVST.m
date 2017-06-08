DSICVST ;DSS/SGM - COMMON FUNCTIONS FOR VEJDVST* ROUTINES ;12/18/2002 14:57
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;************************************************************************
 ; These routines have been replaced by DSICVT* routines.  Please use those 
 ; routines for appointment calls as they have been changed for the new 
 ; Replacement Scheduling Application (RSA) APIs.  06/07/06 - wlc
 ;************************************************************************
 ; DBIA#  Supported  Description
 ; -----  ---------  -------------------------------------------
 ;  2051      X      FIND1^DIC
 ;  2056      X      GET1^DIQ
 ;  2348  ContSub    SCCOND^PXUTLSCC
 ; 10039      X      direct global read of file 42, field 44
 ; 10040      X      direct global read of file 44, field .01    
 ; 10061      X      IN5^VADPT
 ; 10103      X      $$NOW^XLFDT
 ;
ADM(DFN)        ;  return current admission data
 ;  called from DSICVST2
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
 S X=$$GET^DSICDPT1(+$G(DFN)) I X<1 Q X ;  invalid dfn
 S VAROOT="HOS",VAIP("D")=$$NOW^XLFDT D IN5^VADPT
 I '$G(HOS(13,1)) Q "0^Not currently admitted"
 ;  admission date.time int^ext
 S RET=1,$P(RET,U,2)=$P(HOS(13,1),U,2),$P(RET,U,4)=$P(HOS(13,1),U)
 S X=$G(HOS(5)) ;  current loc
 S $P(RET,U,6)=$P(X,U,2)
 S Z=$$GET1^DIQ(42,+X_",",44,"I",,"ERR") S:'$D(DIERR) $P(RET,U,7)=Z
 S X=HOS(13,4) ;   admission loc
 S $P(RET,U,3)=$P(X,U,2) K DIERR,ERR
 S Z=$$GET1^DIQ(42,+X_",",44,"I",,"ERR") S:'$D(DIERR) $P(RET,U,5)=Z
 Q RET
 ;
LOC(VAL) ;  convert location name (X) to pointer or
 ;  verify ien (in X) is a valid pointer
 ;  kept for backwards compatibility - 9-10-2001
 N X,Y,Z,DIERR,ERR,IEN
 I $G(VAL)="" Q ""
 S IEN=$$FIND1^DIC(44,,"AQX",VAL,"B^C",,"ERR")_","
 I IEN<1!$D(DIERR) Q ""
 K DIERR,ERR S X=$$GET1^DIQ(44,IEN,.01,,,"ERR")
 Q $S('$D(DIERR):+IEN_U_X,1:"")
 ;
SCCOND(RET,DATA) ;  RPC: DSIC GET SC CONDITIONS
 ;  call to get environmental checks
 ;  DATA = DFN ^ appt/visit FM date/time ^ location ^ visit pointer
 ;  return RET = ao^ec^ir^sc^mst^hnc^cv where each piece is either 1 or ""
 N I,X,Y,APPT,DFN,DSISC,LOC,STR,VST
 F I=1:1:4 S @$P("DFN^APPT^LOC^VST",U,I)=$P(DATA,U,I)
 S LOC=$$LOC(LOC),X=$$GET^DSICDPT1(+DFN) I X<1 S RET=X Q
 I 'APPT,'VST S RET="-1^No appointment/visit date" Q
 D SCCOND^PXUTLSCC(DFN,APPT,LOC,VST,.DSISC)
 S STR="AO^EC^IR^SC^MST^HNC^CV",Y=$L(STR,U)
 F I=1:1:Y S X=$P(STR,U,I),$P(RET,U,I)=$E(1,+$G(DSISC(X)))
 Q
