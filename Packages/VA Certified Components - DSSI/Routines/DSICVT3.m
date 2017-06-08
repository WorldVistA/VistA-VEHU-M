DSICVT3 ;DSS/WLC - ADDT'L CALLS FOR APPT RPC ROUTINES ;06/06/2006 14:57
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ;DBIA#  Supported References
 ;-----  ----------------------------------------------
 ;10103  ^XLFDT, $$FMADD
 ; 4433  SDAPI^SDAMA301
 ; 1905  SELECTED^VSIT (controlled subscription)
 ; 2051  $$FIND1^DIC
 ; 2056  $$GET1^DIQ,GETS^DIQ
 ;
VS(RETX,DFN,BEG,END,ZLOC,CAT,SCR) ;  RPC: DSIC GETS VISITS ONLY
 ; this get VISITs only
 ; Child visits are excluded: I $P(^AUPNVSIT(ien,0),U,12)
 ;
 ; RETX = $name of global root that stores data [^TMP("DSIC",$J,"VSIT")]
 ; DFN  = required - pointer to file 2
 ; BEG  = optional - Fileman beginning date/time - default 2500101
 ; END  = optional - Fileman ending date/time - default DT+.25
 ; ZLOC = optional - used to screen selected locations
 ;                   passed by reference where ZLOC(ien)=""
 ;                   ien is pointer to file 44
 ;                   kept for backward comptibility, use SCR instead
 ; CAT  = optional - default 0 - if 1 then return historical visits
 ; SCR - optional - added 7/3/2002 - sgm
 ;       passed by reference
 ;       format:  SCR(sub) = code ^ value   where
 ;           code = C for hospital location #44
 ;                  D for medical center division #40.8
 ;                  S for 3-digit stop code from file 40.7 (not ien)
 ;          value = for codes C,D - any unique lookup value or ien
 ;                  for code S - 3-digit stop code (not ien to 40.7)
 ;
 ;  return @RETX@(#) = V ^ ptr to 9000010 ^ ext date.time ^ ext loc ^
 ;                    int date.time ^ int loc
 ;                    if errors, then return -1^error message
 ;
 ; Documentation Notes
 ; ===================
 ; SELECTED^VSIT returns ^TMP("VSIT",$J,visitien,#) = p1^p2^p3^p4^p5^p6
 ;   p1 = visit date.time
 ;   p2 = file 44 ien ; ext loc name  or
 ;        if serv cat = "H" then file 9999999.06 ien ; ext name
 ;   p3 = service category - internal .07 field value
 ;   p4 = service connected - external 80001 field value
 ;   p5 = patient status in/out - field 15002 set of codes
 ;   p6 = clinic stop ien (#40.7) ; external name
 ;
 ; v1.01 - screen out child visits
 ;
 N I,X,Y,Z,CNT,LOC,NSERVCAT,ROOT,ST,STOP,TYPE,VIEN,XLOC,XSC
 N:'$D(ZSCR) ZSCR
 S RETX=$NA(^TMP("DSIC",$J,"VSIT")) K @RETX,^TMP("VSIT",$J)
 S X=$$GET^DSICDPT1(+$G(DFN)) I X<1 S @RETX@(1)=X Q
 S:'$G(BEG) BEG=2500101 S:'$G(END) END=DT+.5
 S CAT=$G(CAT),NSERVCAT=$S(+$G(CAT):"",1:"EDNCX"),CNT=0
 S X=$O(SCR("~"),-1)_"~"
 I $D(ZLOC) F I=0:0 S I=$O(ZLOC(I)) Q:'I  S SCR(X_I)="C^"_I
 K ZLOC D:$D(SCR) SCR(.SCR,.ZSCR)
 D SELECTED^VSIT(DFN,BEG,END,,,,,NSERVCAT)
 S ROOT=$NA(^TMP("VSIT",$J,0)),STOP=$P(ROOT,",",1,2)
 F  S ROOT=$Q(@ROOT) Q:ROOT'[STOP  S X=@ROOT D
 .S LOC="",VIEN=$QS(ROOT,3),TYPE=$P(X,U,3)
 .;
 .;  excluded child visits
 .I $$VALL^DSICVT2(,VIEN,"I",.12,1) Q
 .;
 .S XLOC=+$P(X,U,2),XSC=+$P(X,U,6)
 .S:TYPE'="H" LOC=$P($P(X,U,2),";",2)
 .;
 .;  check for screening logic
 .I TYPE'="H",$D(ZSCR("C")),'$D(ZSCR("C",XLOC)) Q
 .I $D(ZSCR("S")),'$D(ZSCR("S",XSC)) Q
 .S Y=$P(X,U),CAT=$S(TYPE="H":"A",1:"V") S:XLOC=0 XLOC=""
 .S X=CAT_U_VIEN_U_$$FMTE^XLFDT(Y)_U_LOC_U_Y_U_XLOC
 .S Y=(9999999.999999-Y)_"~"_VIEN
 .S ^TMP("DSIC",$J,"VSIT",Y)=X
 .Q
 I '$O(@RETX@(0)) S @RETX@(1)="-1^No visits found"
 Q
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
GETSTOP(VEJDS) ;  RPC: VEJDSD GET STOP CODES
 ;This will return a list of all active stop codes and their names
 ;Return VEJDS() = ifn ^ stop code name ^ 3-digit stop code
 N I,X,Y,Z,CODE
 F I=0:0 S I=$O(^DIC(40.7,I)) Q:'I  S X=$$ACT(I) I X]"" D
 .F Y=1:1 S Z=$P(X,";",Y) Q:Z=""  S CODE=$P(Z,U,3),VEJDS(CODE_"~"_I)=Z
 .Q
 Q
 ;
SCR(INP,RET) ;  screen out entries based upon clinic, stop codes, divisions
 ;  INP - required - passed by reference
 ;  expects INP(...) array to be defined an in this format
 ;  It KILLs INP when finished to free up symbol stack space
 ;     INP(#) = code ^ value   where
 ;              code = C [hospital location file 44]
 ;                     D [medical center division file 40.8]
 ;                     S [clinic stop file 40.7]
 ;             value = .01 name value
 ;
 ;  RETURNS: RET - passed by reference
 ;     Sets RET(...) array as follows
 ;     NOTE: RET is not killed so that subsequent calls may add to it
 ;     RET(code,ien) = value   where
 ;         code = C,D,S from above
 ;          ien = pointer to appropriate file
 ;
 N X,Y,Z,CODE,DIERR,ERR,FILE,FLG,IEN,INDEX,SUB,TMP,VAL
 S SUB="" F  S SUB=$O(INP(SUB)) Q:SUB=""  S VAL=INP(SUB) D
 . S CODE=$E(VAL),VAL=$P(VAL,U,2) Q:CODE=""  Q:VAL=""
 . S:CODE?1L CODE=$$UP^XLFSTR(CODE) Q:"CDS"'[CODE
 . S FILE=$S(CODE="C":44,CODE="D":40.8,1:40.7)
 . S INDEX=$S(CODE="S":"C",1:"AOM")
 . S FLG=$S(CODE="S":"XQ",1:"")
 . K DIERR,ERR D
 . S X=$$FIND1^DIC(FILE,,FLG,VAL,INDEX,,"ERR")
 . Q:$D(DIERR)  Q:X'>0  S IEN=X_","  Q:$D(RET(CODE,X))
 . I CODE="S" S RET(CODE,+IEN)=VAL Q
 . S X=$$GET1^DIQ(FILE,IEN,.01,,,"ERR") Q:$D(DIERR)
 . S RET(CODE,+IEN)=X
 K INP
 Q
 ;
GV(DFN,DATE) ;  get VISIT for a scheduled appointment
 ;  return <null> if none found
 N V,DSIC,SDARRAY,RET
 S SDARRAY(1)=+$G(DATE)_";"_+$G(DATE),SDARRAY(3)="R;I",SDARRAY(4)=DFN,SDARRAY("FLDS")="1;12"
 S RET=$$SDAPI^SDAMA301(.SDARRAY)
 S V=""
 I RET<1 Q V  ; error or None found processing
 I RET>0 D
 . N CLN S CLN=$O(^TMP($J,"SDAMA301",DFN,""))
 . S V=$P($G(^TMP($J,"SDAMA301",DFN,CLN,DATE)),U,12)
 . I V D GETOE^SDOERPC(.DSIC,V) S:$P(DSIC,U,5) V=$P(DSIC,U,5)
 Q V
 ;S V=$P($G(^DPT(+$G(DFN),"S",+$G(DATE),0)),U,20)
 ;I V D GETOE^SDOERPC(.DSIC,V) S:$P(DSIC,U,5) V=$P(DSIC,U,5)
 ;
CLST(DSICX,STOP) ;  RPC: VEJDSD GET LOC BY STOP CODE
 ; get list of all HOSPITAL LOCATIONS with certain stop codes
 ; STOP - req - array of 3-digit stop codes STOP(n)=3-digit stop
 ; Return:  @VEJDX@(n) = ifn ^ p2 ^ p3 ^ p4 ^ p5  where
 ;   p2 = name   p3 = 3-digit stop code  p4 = ifn;institution name
 ;   p5 = ifn;medical center division
 N I,J,X,Y,Z,CODE,RTN
 I '$D(STOP) S DSICX(1)=$$ERR(3) Q
 S Y="" F  S Y=$O(STOP(Y)) Q:Y=""  S X=$$ACT^DSICVT3(,STOP(Y)) I X]"" D
 .S CODE(+X)=""
 .Q
 F I=0:0 S I=$O(^SC(I)) Q:'I  S X=^(I,0),Y=+$P(X,U,7) I $D(CODE(Y)) D
 .K RTN D LOC(.RTN,I)
 .I +RTN>0 S Z=CODE(Y)_"~"_$P(RTN,U,2)_"~"_$J(I,6),DSICX(Z)=RTN
 .Q
 I '$D(DSICX) S DSICX(1)=$$ERR(4)
 Q
 ;
LOC(DSICL,VAL) ;  RPC: VEJDSD GET LOCATION
 ; lookup location in file 44
 ; VAL - req - lookup value, name or ifn in file 44
 ; return VEJDL = ifn ^ p2 ^ p3 ^ p4 ^ p5 ^ p6 where
 ;   p2 = name   p3 = 3-digit stop code  p4 = ifn;institution name
 ;   p5 = ifn;medical center division    p6 = active flag [1/0]
 ; on error return -1^error message
 N I,X,Y,Z,ACT,CODE,DIERR,DIV,IENS,INST,NAME,DSIC,DSICERR
 I $G(VAL)="" S DSICL=$$ERR(1) Q
 I VAL=+VAL,$D(^SC(VAL,0)) S IENS=VAL_","
 E  D  Q:$D(DSICL)
 .S X=$$FIND1^DIC(44,,"AMX",VAL,,,"DSICERR")
 .I $D(DIERR) S DSICL=$$ERR(0) Q
 .I X<1 S DSICL=$$ERR(5) Q
 .S IENS=X_","
 .Q
 D GETS^DIQ(44,IENS,".01;3;3.5;8;2505;2506","IE","DSIC","DSICERR")
 I '$D(DSIC) S DSICL=$$ERR(0) Q
 S NAME=$G(DSIC(44,IENS,.01,"E"))
 S INST=$G(DSIC(44,IENS,3,"I"))_";"_$G(DSIC(44,IENS,3,"E"))
 S DIV=$G(DSIC(44,IENS,3.5,"I"))_";"_$G(DSIC(44,IENS,3.5,"E"))
 S CODE="",X=$G(DSIC(44,IENS,8,"I"))
 I X S X=$$GET1^DIQ(40.7,X_",",1,,"DSICERR") I X]"" S CODE=X
 S ACT=$S('$G(DSIC(44,IENS,2505,"I")):1,1:$G(DSIC(44,IENS,2506,"I"))'<DT)
 S DSICL=(+IENS)_U_NAME_U_CODE_U_INST_U_DIV_U_ACT
 Q
 ;
ERR(A) ;
 I A=0 S A=$$MSG^DSICFM01("VE",,,,"DSICERR")
 I A=1 S A="No lookup data received"
 I A=2 S A="No appointments found for input criteria"
 I A=3 S A="No stop codes received"
 I A=4 S A="No clinics found matching for these stop codes"
 I A=5 S A="Did not find hospital location: "_VAL
 I A=6 S A="No data found"
 Q "-1^"_A
 ;
