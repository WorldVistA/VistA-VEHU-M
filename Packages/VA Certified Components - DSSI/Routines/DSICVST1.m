DSICVST1 ;DSS/SGM - RPC TO GET SCHEDULED APPTS ;11/15/2002 11:58
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;************************************************************************
 ; These routines have been replaced by DSICVT* routines.  Please use those 
 ; routines for appointment calls as they have been changed for the new 
 ; Replacement Scheduling Application (RSA) APIs.  06/07/06 - wlc
 ;************************************************************************
 ;
 ; DBIA#  Supported - Description
 ; -----  -------------------------
 ; 10061  ^VADPT: SDA, KVA
 ; 10103  $$NOW^XLFDT
 ;
APPT(RET,DATA,SCR) ; rpc: DSIC GET SCHED APPTS
 ;  called from DSICVST2 - ZSCR() may or may not be defined
 ;  DBIA10040 (& 908) - supported IA to read field .01, file 44
 ;  RET - $NAME of global root with data [^TMP("DSIC",$J,"APPT")]
 ; DATA -   required - DFN ^ BEG ^ END ^ ALOC ^ FLG
 ;    DFN - required - patient file ien
 ;    BEG - optional - earliest appointment date/time [fm d/t format]
 ;    END - optional - latest appointment date/time [fm d/t format]
 ;   ALOC - optional - clinic name or file 44 ien [if not then get all]
 ;          this preserved for backward compatibility - 8/27/2001 sgm
 ;    FLG - optional - default = 0
 ;          0 return active/kept/inpatient/no action taken
 ;          1 return future appts only
 ;          2 return both (0 & 1)
 ; SCR - optional - added 7/3/2002 - sgm
 ;       passed by reference
 ;       format:  SCR(subscript) = code ^ value   where
 ;           code = C for hospital location #44
 ;                  D for medical center division #40.8
 ;                  S for 3-digit stop code from file 40.7 (not ien)
 ;          value = for codes C,D - any unique lookup value or ien
 ;                  for code S - 3-digit stop code (not ien to 40.7)
 ;
 ;  return @RET@(#) = ext date.time^ext loc^int date.time^file 44 ptr
 ;
 N I,X,Y,Z,ALOC,BEG,CLIEN,DFN,DIERR,END,ERR,FLG,VASD
 N:'$D(ZSCR) ZSCR
 S RET=$NA(^TMP("DSIC",$J,"APPT")) K @RET
 S X=$$GET^DSICDPT1(+$G(DATA)) I X<1 S @RET@(1)=X Q
 ;
 ;  set up local variables from DATA
 F I=1:1:5 S @$P("DFN^BEG^END^ALOC^FLG",U,I)=$P(DATA,U,I)
 I 'END S END=$S('FLG:DT+.25,1:9999999)
 I 'BEG S BEG=$S(FLG=1:$$NOW^XLFDT,1:2500101)
 I ALOC]"" S X=$O(SCR("~"),-1)_"~",SCR(X)="C^"_ALOC
 D:$D(SCR) SCR^DSICVST0(.SCR,.ZSCR)
 ;
 ;  check to see if need to screen
 I $D(ZSCR("C")) M VASD("C")=ZSCR("C")
 ;
 ;  vasd(f)=from date.time    vasd(t)=to date.time
 ;  vasd(w):  1-active/kept   2-inpatient   9-no action taken
 S VASD("F")=BEG,VASD("T")=END,VASD("W")=129
 K ^UTILITY("VASD",$J) D SDA^VADPT S X=0,I="A"
 F  S I=$O(^UTILITY("VASD",$J,I),-1) Q:'I  D
 .;  ext date.time ^ ext loc ^ fm date.time ^ ptr to 44
 .S Z=$P(^UTILITY("VASD",$J,I,"E"),U,1,2)_U_$P(^("I"),U,1,2)
 .;  check for items that to be screened out
 .S CLIEN=$P(Z,U,4) I $$CK1^DSICVST0("C",CLIEN,"C") S X=X+1,@RET@(X)=Z
 .Q
 K ^UTILITY("VASD",$J) D KVA^VADPT
 S:'$D(@RET) @RET@(1)="-1^No appointments found"
 Q
 ;
 ;-------  NEW CODE  --------
 N I,X,Y,Z,ALOC,BEG,CLIEN,DFN,DIERR,END,ERR,FLG,VASD
 N:'$D(ZSCR) ZSCR
 S RET=$NA(^TMP("DSIC",$J,"APPT")) K @RET
 S X=$$GET^DSICDPT1(+$G(DATA)) I X<1 S @RET@(1)=X Q
 ;
 ;  set up local variables from DATA
 F I=1:1:5 S @$P("DFN^BEG^END^ALOC^FLG",U,I)=$P(DATA,U,I)
 I 'END S END=$S('FLG:DT+.25,1:9999999)
 I 'BEG S BEG=$S(FLG=1:$$NOW^XLFDT,1:2500101)
 I ALOC]"" S X=$O(SCR("~"),-1)_"~",SCR(X)="C^"_ALOC
 D:$D(SCR) SCR^DSICVST0(.SCR,.ZSCR)
 ;
 ;  check to see if need to screen
 I $D(ZSCR("C")) M VASD("C")=ZSCR("C")
 ;
 ;  vasd(f)=from date.time    vasd(t)=to date.time
 ;  vasd(w):  1-active/kept   2-inpatient   9-no action taken
 S VASD("F")=BEG,VASD("T")=END,VASD("W")=129
