DSICCPT ;DSS/SGM - UTILITIES FOR ACCESSING CODE FILES ;07/09/2004 09:36
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ; DBIA#  Supported
 ; -----  ---------  -------------------------------------------------
 ;  1995      x      ICPTCOD: $$CPT, $$CPTD, $$CODM
 ;  1996      x      ICPTMOD: $$MOD, $$MODP
 ; 10104      x      $$TRIM^XLFSTR
 ;
 ; Comments common to all entry points:
 ; 1. All entry points that return a single string can be called as
 ;    as DO with parameter passing (RPC) or as an extrinsic function
 ; 2. Description of Input Parameters used in this routine
 ;    CODE - required - CPT, HCPCS, or Level III code in either internal
 ;                      or external format.
 ;    CDT - optional - The date for which status of the code is being
 ;                     checked.  The Default value is TODAY
 ;    SRC - optional - Flag to indicate if Level III codes need to be
 ;                     screened out. If SRC=0 or null, Level III codes
 ;                     are not processed as valid input; if SRC>0, Level
 ;                     III codes are accepted.
 ;    DFN - optional - NOT IN USE AT THIS TIME
 ;    FUN - optional - I +$G(FUN) then called as extrinsic function
 ;    MOD - required - MODIFIER, .01 field value or ien
 ;    MFT - optional - format of inputed MODIFIER - default is E
 ;                     I for internal, E for external
 ; 3. If a entry point has a different definition of an input param then
 ;    that will described in that section
 ; 4. On error, all entry points will return -1^error message
 ;
ACTCPT(DSIC,CODE,CDT,SRC,FUN) ; RPC: DSIC CPT ACTIVE/VALIDATE
 ;  this will validate that a CPT code is valid and active
 ;  Return: 1 if code is valid and active
 ;          0 if code is inactive
 S DSIC=$$CPT(,$G(CODE),$G(CDT),$G(SRC),,1)
 I DSIC>-1 S DSIC=$P(DSIC,U,7)
OUT I $G(FUN) Q $S($G(DSIC)'="":DSIC,$G(DSIC(1))'="":DSIC(1),1:-1)
 Q
 ;
CDT ;  this may reset CDT if necessary
 S CDT=$S('$D(CDT):"",CDT?7N.E:$E(CDT,1,7),1:DT)
 Q
 ;
CK() ;  check if code was received
 Q $S($G(CODE)]"":1,1:"-1^No CPT code received")
 ;
CPT(DSIC,CODE,CDT,SRC,DFN,FUN) ; RPC: DSIC CPT GET CODE
 ;  Validate input code and return  data related to CPT code
 ;  Return: p1^p2^p3^p4^p5^p6^p7  where
 ;          p1 = ien of code in ^ICPT 
 ;          p2 = CPT CODE (.01 field) 
 ;          p3 = SHORT NAME (#2 field) 
 ;          p4 = CATEGORY ien (#3 field) 
 ;          p5 = SOURCE code (#6 field) [C:CPT; H:HCPCS; L:VA LOCAL]
 ;          p6 = EFFECTIVE DATE (from  field #60 multiple)
 ;          p7 = STATUS 0:inactive;1:active (from .02 of #60 multiple)
 N X,Y,Z
 S SRC=+$G(SRC),DFN=$G(DFN),FUN=+$G(FUN) D CDT
 S X=$$CK I X<0 S DSIC=X G OUT
 S DSIC=$$CPT^ICPTCOD(CODE,CDT,SRC)
 I DSIC>0 S X=$P(DSIC,U,3),$P(DSIC,U,3)=$$TRIM(X)
 G OUT
 ;
CPTD(DSIC,CODE,CDT,DFN,FUN) ; RPC: DSIC CPT GET DETAIL DESC
 ;  returns the full description of a code, from the "D" node (field 50)
 ;  of the ICPT file
 ;  RETURN:  If +$G(FUN)=0, then DSIC(#) = description text
 ;           If +$G(FUN), then extrinsic function call,
 ;                        do not return DSIC()
 N I,X,Y,Z,DSIX,ROU,VAL
 D CDT S X=$$CK I X<0 S DSIC(1)=X G OUT
 I $G(DFN) S X=$$CPTD^ICPTCOD(CODE,"DSIX",DFN,CDT)
 I '$G(DFN) S X=$$CPTD^ICPTCOD(CODE,"DSIX",,CDT)
 I X<0 S DSIC(1)=X G OUT
 D TRIM(.DSIX) S Z="",(I,Y)=0
 F  S I=$O(DSIX(I)) Q:'I  D  Q:Y>499
 .S X=DSIX(I),Y=$L(Z)+$L(X)+1
 .I Y<501 S Z=Z_X_" "
 .E  S Z=Z_$E(X,1,500-$L(Z))
 .Q
 I 'Y S DSIC(1)="-1^No detailed description found" G OUT
 I Y<511!$G(FUN) S DSIC(1)=Z G OUT
 M DSIC=DSIX
 Q
 ;
CODM(DSIC,CODE,CDT,SRC,DFN) ; RPC: DSIC CPT GET MODIFIER LIST
 ; returns a list of all acceptable modifiers for a selected code
 ; CDT - optional -  Date in Fileman format to check modifier status
 ;       against. If CDT=0 or null, both active and inactive modifiers
 ;       will be included in the output as acceptable modifiers. If CDT
 ;       is passed as a date, only modifiers being active as of this
 ;       date will be included in the output as acceptable modifiers
 ; Returns DSIC(#) = modifier (.01 field) ^ name (.02 field) ^ ien
 N I,X,DSIX
 D CDT S X=$$CK I X<1 S DSIC(1)=X Q
 S X=$$CODM^ICPTCOD(CODE,"DSIX",$G(SRC),$G(CDT))
 I X<0 K DSIC S DSIC(1)=X Q
 S X="",I=0 F  S X=$O(DSIX(X)) Q:X=""  S I=I+1,DSIC(I)=X_U_DSIX(X)
 Q
 ;
FIND(DSIC,VAL,DATE) ; RPC: DSIC CPT FIND
 ;   VAL - req - lookup value
 ;  DATE - opt - FM date for which to CPT must be active
 ;               default to today
 ;  Return global array @DSIC@(#,0)) = ien ^ .01 field ^ 2 field value
 ;         if problems return DSIC(1) = -1^message
 ;  DSIC = $NA(^TMP("DSIC",$J,"DILIST"))
 N X,Y,Z,DSICPT
 S VAL=$G(VAL),DATE=$G(DATE,DT) S:DATE="" DATE=DT
 S Z(1)="FILE^81"
 S Z(2)="FIELDS^.01;2"
 S Z(3)="SCREEN^I $$ACTCPT^DSICCPT(,$P(^(0),U),DATE,,1)"
 S Z(4)="VAL^"_VAL
 D FIND^DSICFM05(.DSIC,.Z)
 Q
 ;
MOD(DSIC,MOD,CDT,FUN) ; RPC: DSIC CPT GET MODIFIER
 ;  returns basic information for MODIFIER
 ;  Return: p1^p2^p3^p4^p5^p6^p7  where
 ;    p1 = ien
 ;    p2 = MODIFER (.01)
 ;    p3 = NAME (.02)
 ;    p4 = CODE (.03) - alternate 5 digit code for CPT modifiers
 ;    p5 = SOURCE (.04) - C:CPT;H:HCPCS;V:VA NATIONAL
 ;    p6 = EFFECTIVE DATE - from multiple field 60
 ;    p7 = STATUS (.02 field from multiple field 60) 0:inactive;1:active
 D CDT S DSIC=$$MOD^ICPTMOD($G(MOD),CDT)
 G OUT
 ;
MODP(DSIC,CODE,MOD,MFT,CDT,FUN) ; RPC: DSIC CPT MOD PAIR
 ;  checks to see if a CPT/MODIFIER pair is acceptable
 ;  Returns
 ;    0 if pair is unacceptable
 ;    -1^error message
 ;    ifn^modifier name (#.02 field)
 N X
 D CDT S X=$$CK I X<1 S DSIC=X G OUT
 S DSIC=$$MODP^ICPTMOD(CODE,$G(MOD),$G(MFT),CDT)
 G OUT
 ;
TRIM(DSI) ;  this will trim off any leading and trailing spaces
 ;  DSI is passed by reference
 I $G(DSI)]"" Q $$TRIM^XLFSTR(DSI,"LR"," ")
 N DSIX S DSIX=""
 F  S DSIX=$O(DSI(DSIX)) Q:DSIX=""  S DSI(DSIX)=$$TRIM^XLFSTR(DSI(DSIX),"LR"," ")
 Q
