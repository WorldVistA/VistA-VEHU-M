DSICVST0 ;DSS/SGM - VISIT UTILITIES ;11/15/2002 11:58
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;************************************************************************
 ; These routines have been replaced by DSICVT* routines.  Please use those 
 ; routines for appointment calls as they have been changed for the new 
 ; Replacement Scheduling Application (RSA) APIs.  06/07/06 - wlc
 ;************************************************************************
 ;  This module is called from various routines to perform common
 ;  functionality.   Usually called from DSICVST* routines
 ;
 ;Notes: dgr := direct global read
 ; DBIA#  Supported
 ; -----  ---------  --------------------------------------------------
 ;   557  ContSub    dgr file 40.7, fields .01;1;2, and "C" index
 ;  1482  ContSub    dgr file 44, fields .01;8
 ;  1906  ContSub    $$LOOKUP^VSIT
 ;  2051      x      $$FIND1^DIC
 ;  2056      x      GETS^DIQ
 ;  2439  ContSub    Fileman read file 44, field 3.5
 ; 10040      x      dgr file 44, field .01
 ; 10104      x      $$UP^XLFSTR
 ;
CK1(FT,VAL,FLAG)   ;  check to see if entry should be screened out
 ;  called from DSICVST1
 ;  expects local arrays ZSCR from SCR below
 ;  called from various DSICVST* routines
 ;  FT   - optional - code indicating which file VAL belongs to
 ;         "C" - default - VAL is ien to file 44 [hosp loc]
 ;         "D" - VAL is ien to file 40.8 [med ctr div]
 ;        "SI" - VAL is ien to file 40.7 [stop code]
 ;        "SC" - VAL is 3-digit stop code
 ;  VAL - required - see definition of FT
 ;  FLAG - optional - if FLAG[C do not perform clinic screen
 ;                    if FLAG[D do not perform division screen
 ;                    If FLAG[S do not perform stop code screen
 ;
 ;  RETURN: boolean -  0 if loc excluded, else return 1
 N I,X,Y,Z,DIERR,ERR,DSIC
 S FLAG=$G(FLAG),FT=$G(FT,"C") S:FT?.E1L.E FT=$$UP^XLFSTR(FT)
 I $G(VAL)="" Q 0
 I '$D(ZSCR) Q 1
 I "^C^D^SI^SC^"'[(U_FT_U) Q 0
 I FT="D" Q $S(FLAG["D":1,'$D(ZSCR("D")):1,1:$D(ZSCR("D",VAL))#2)
 I FT="SI" Q $S(FLAG["S":1,'$D(ZSCR("S")):1,1:$D(ZSCR("S",VAL))#2)
 I FT="SC" S Z=1 D:FLAG'["S"&$D(ZSCR("S"))  Q Z
 .N DIERR,ERR S X=$$FIND1^DIC(40.7,,"QX",VAL,"C",,"ERR")
 .S Z=$S($D(DIERR):0,X<1:1,1:$D(ZSCR("S",X))#2)
 .Q
 I FLAG'["C",$D(ZSCR("C",VAL))#2 Q 1
 S VAL=VAL_"," D GETS^DIQ(44,VAL,"3.5;8","I","DSIC","ERR")
 I $D(DIERR) Q 0
 S Y=$G(DSIC(44,VAL,3.5,"I"))
 I Y,FLAG'["D",$D(ZSCR("D",Y))#2 Q 1
 S Y=$G(DSIC(44,VAL,8,"I"))
 I Y,FLAG'["S",$D(ZSCR("S",Y))#2 Q 1
 Q 0
 ;
DIV(QLOC) ;  return medical center division (#40.8) pointer for
 ;  LOC = hospital location ien (#44)
 ;  return -1 if failed
 I $G(QLOC)<1 Q -1
 N Z,DIERR,ERR
 S Z=$$GET1^DIQ(44,QLOC_",",3.5,"I",,"ERR") S:Z<1 Z=-1
 Q Z
 ;
SCR(INP,RET) ;  screen out entries based upon clinic, stop codes, divisions
 ;  called from DSICVST1,DSICVST2
 ;  INP - required - passed by reference
 ;  expects INP(...) array to be defined an in this format
 ;  It KILLs INP when finished to free up symbol stack space
 ;     INP(#) = code ^ value   where
 ;              code = C [hospital location file 44]
 ;                     D [medical center division file 40.8]
 ;                     S [clinic stop file 40.7]
 ;             value = .01 name value or ien for C or D codes
 ;                   = 3-digit stop code, not ien to 40.7
 ;  RETURNS: RET - passed by reference
 ;     Sets RET(...) array as follows
 ;     NOTE: RET is not killed so that subsequent calls may add to it
 ;     RET(code,ien) = value   where
 ;         code = C,D,S from above
 ;          ien = pointer to appropriate file
 ;        value = .01 field for C or D, 3-digit stop code for S
 ;
 N X,Y,Z,CODE,DIERR,ERR,FILE,IEN,SUB,TMP,VAL
 S SUB="" F  S SUB=$O(INP(SUB)) Q:SUB=""  S VAL=INP(SUB) D
 .S CODE=$E(VAL),VAL=$P(VAL,U,2) Q:CODE=""  Q:VAL=""
 .S:CODE?1L CODE=$$UP^XLFSTR(CODE) Q:"CDS"'[CODE
 .S FILE=$S(CODE="C":44,CODE="D":40.8,1:40.7)
 .K DIERR,ERR I "CD"[CODE D  Q
 ..S X=$$FIND1^DIC(FILE,,"AOM",VAL,,,"ERR")
 ..Q:$D(DIERR)  Q:X'>0  S IEN=X_","  Q:$D(RET(CODE,X))
 ..S X=$$GET1^DIQ(FILE,IEN,.01,,,"ERR") Q:$D(DIERR)
 ..S RET(CODE,+IEN)=X
 ..Q
 .S X=$$FIND1^DIC(FILE,,"QX",VAL,"C",,"ERR")
 .I '$D(DIERR),X>0 S RET(CODE,X)=VAL
 .Q
 K INP
 Q
 ;
VALL(DSIV,IEN,FMT,SUB,FUN,WITHIEN) ; RPC: 
 ;  get all visit info from VSIT API
 ;      IEN - required - pointer to VISIT file or Visit ID
 ;      FMT - optional - I, E, or B [B is default]
 ;  WITHIEN - optional - 1 or 0 [default is 1]
 ;            if 1 return @retv@(visitien,fld)
 ;            if 0 return @retv@(fld)
 ;            if CALL from RPC then WITHIEN ignored and set to 0
 ;      SUB - optional - if $g(SUB)]"" return that subscript only
 ;                       else return all VISIT data in RETV
 ;      FUN - optional - 0 or 1 [default 0]
 ;                       if FUN = 1 then extrinsic function
 ;                       else RPC
 ; RETURN:
 ;    Format of @DSIV@() = value [dependent upon FMT]
 ;                    if FMT="I" value = internal
 ;                    if FMT="E" value = external
 ;                    if FMT="B" value = internal ^ external
 ;
 ;    If extrinsic function call [i.e., I '$G(FUN)]
 ;    1. then on error, QUIT -1
 ;    2. I $G(SUB)="" then QUIT IEN
 ;    3. I $G(SUB) QUIT p1^p2^p3...  where
 ;       pn = int val or ext val or (int val ^ ext val) - see FMT
 ;       a. it is the responsibility of the calling program to make
 ;          sure that maximum string length is not exceeded
 ;       b. @DSIV@() will still be set - see WITHIEN
 ;    
 ;    If RPC case, then return
 ;    @DSIV@(1) = -1 if problems encountered
 ;    @DSIV@(#) = field# ^ internal value ^ external value
 ;      where # = 1,2,3,4,5,...
 ;      internal/external values will be present depending upon FMT
 ;
 ;Field# Value        Description
 ;.01     VDT  VISIT/ADMIT DATE&TIME (date) 
 ;.02     CDT  DATE VISIT CREATED (date) 
 ;.03     TYP  TYPE (set) 
 ;.05     PAT  PATIENT NAME (pointer PATIENT file #9000001)
 ;.06     INS  LOC. OF ENCOUNTER (pointer LOCATION file 
 ;             #9999999.06) (IHS file DINUMed to INSTITUTION  file #4) 
 ;.07     SVC  SERVICE CATEGORY (set) 
 ;.08     DSS  DSS ID (pointer to CLINIC STOP file) 
 ;.09     CTR  DEPENDENT ENTRY COUNTER (number) 
 ;.11     DEL  DELETE FLAG (set) 
 ;.12     LNK  PARENT VISIT LINK (pointer VISIT file #9000010) 
 ;.13     MDT  DATE LAST MODIFIED (date) 
 ;.18     COD  CHECK OUT DATE&TIME (date) 
 ;.21     ELG  ELIGIBILITY (pointer ELIGIBILITY CODE file #8) 
 ;.22     LOC  HOSPITAL LOCATION (pointer HOSPITAL LOCATION file #44) 
 ;.23     USR  CREATED BY USER (pointer NEW PERSON file #200) 
 ;.24     OPT  OPTION USED TO CREATE (pointer OPTION file #19) 
 ;.25     PRO  PROTOCOL (pointer PROTOCOL file #101) 
 ;2101    OUT  OUTSIDE LOCATION (free text) 
 ;80001   SC   SERVICE CONNECTED (set) 
 ;80002   AO   AGENT ORANGE EXPOSURE (set) 
 ;80003   IR   IONIZING RADIATION EXPOSURE (set) 
 ;80004   EC   PERSIAN GULF EXPOSURE (set) 
 ;80005   MST   MILITARY SEXUAL TRAUMA (set) 
 ;80006   HNC   HEAD AND NECK CANCER (set) 
 ;15001   VID  VISIT ID (free text) 
 ;15002   IO   PATIENT STATUS IN/OUT (set) 
 ;15003   PRI  ENCOUNTER TYPE (set) 
 ;81101   COM  COMMENTS 
 ;81202   PKG  PACKAGE (pointer PACKAGE file #9.4) 
 ;81203   SOR  DATA SOURCE (pointer PCE DATA SOURCE file (#839.7)
 ;
 N I,X,Y,Z,RET,VAL,VIEN,VSIT
 S FUN=$G(FUN),FMT=$G(FMT,"B"),IEN=$G(IEN)
 S WITHIEN=+$G(WITHIEN) S:'FUN WITHIEN=0
 I 'IEN S @DSIV@(1)="-1^No VISIT lookup value received" Q:FUN -1  Q
 ;  lookup^vsit returns VSIT()
 S VIEN=$$LOOKUP^VSIT(IEN,FMT,WITHIEN)
 S X="-1^Problems encountered trying to retrieve VISIT: "_IEN
 I VIEN<1!'$D(VSIT) S @DSIV@(1)=X Q:FUN X Q
 ;  return values for extrinsic function
 I FUN M DSIV=VSIT D  Q RET
 .I $G(SUB)="" S RET=IEN Q
 .S RET="" F I=1:1 S X=$P(SUB,U,I) Q:X=""  D
 ..S Y=$S(WITHIEN:$G(VSIT(IEN,X)),1:$G(VSIT(X)))
 ..I FMT="E" S Y=$P(Y,U,2)
 ..I $L(RET)+$L(Y)<501 S RET=RET_U_Y
 ..Q
 .Q
 ;  return values for RPC call
 K Z I $G(SUB)'="" F I=1:1 S X=$P(SUB,U,I) Q:X=""  S Z(X)=""
 ;  return specific data requested
 S Y=0 F I=0:0 S I=$O(VSIT(I)) Q:'I  I $G(SUB)=""!$D(Z(I)) S Y=Y+1,DSIV(Y)=I_U_VSIT(I)
 Q
