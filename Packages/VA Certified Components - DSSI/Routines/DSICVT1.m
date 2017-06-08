DSICVT1 ;DSS/WLC - COMMON FUNCTIONS FOR DSICVT RPC CALLS ;06/06/2006 14:57
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;
 ; DBIA#  Supported  Description
 ; -----  ---------  -------------------------------------------
 ;  2051      X      FIND1^DIC
 ;  2056      X      GET1^DIQ
 ;  2348  ContSub    SCCOND^PXUTLSCC
 ; 10040      X      direct global read of file 44, field .01    
 ; 10103      X      ^XLFDT
 ;  3859  ContSub    GETAPPT^SDAMA201
 ;
SCCND(RET,DATA) ;  RPC: DSIC GET SC CONDITIONS
 ;  call to get environmental checks
 ;  DATA = DFN ^ appt/visit FM date/time ^ location ^ visit pointer
 ;  return RET = ao^ec^ir^sc^mst^hnc^cv^shad where each piece is either 1 or ""
 N I,X,Y,APPT,DFN,DSISC,LOC,STR,VST
 F I=1:1:4 S @$P("DFN^APPT^LOC^VST",U,I)=$P(DATA,U,I)
 S LOC=$$LOC(LOC),X=$$GET^DSICDPT1(+DFN) I X<1 S RET=X Q
 I 'APPT,'VST S RET="-1^No appointment/visit date" Q
 D SCCOND^PXUTLSCC(DFN,APPT,LOC,VST,.DSISC)
 S STR="AO^EC^IR^SC^MST^HNC^CV^SHAD",Y=$L(STR,U)
 F I=1:1:Y S X=$P(STR,U,I),$P(RET,U,I)=$E(1,+$G(DSISC(X)))
 Q
 ;
APPT(RET,DATA,SCR) ; rpc: DSIC GET SCHED APPTS
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
 ; SCR    passed by reference
 ;         array of screened values where each is a IEN for a certain file:
 ;         Where:
 ;         SCR(Code, IEN) = ""
 ;              Code = "C" for Clinic
 ;                     "D" for Division
 ;                     "S" for Stop Code
 ;                     
 ;              IEN = 44 for "C"
 ;                    40.8 for "D"
 ;                    40.7 for "S"
 ;                    
 ;  return @RET@(#) = ext date.time^ext loc^int date.time^file 44 ptr
 ;
 N I,X,Y,Z,ALOC,SDIEN,SDFIELDS,SDSTART,SDEND,SDRES,DFN,DIERR,END,ERR,FLG,VASD
 N CODES
 S DATA=$G(DATA),SCR=$G(SCR)
 S RET=$NA(^TMP("DSIC",$J,"APPT")) K @RET
 S X=$$GET^DSICDPT1(+$G(DATA)) I X<1 S @RET@(1)=X Q
 ;
 ;  set up local variables from DATA
 F I=1:1:5 S @$P("DFN^BEG^END^ALOC^FLG",U,I)=$P(DATA,U,I)
 I 'END S END=$S('FLG:$$FMADD^XLFDT(DT,,23,59),1:$$FMADD^XLFDT(DT,60,23,59))
 I 'BEG S BEG=$S(FLG=1:$$NOW^XLFDT,1:2500101)
 I ALOC]"" S X=$O(SCR("~"),-1)_"~",SCR(X)="C^"_ALOC
 ;
 ; Patient status filter set to Inpatient and Outpatient (value of "")
 ; Appointment status filter set to ALL (value of "") and filtered later
 S SDIEN=DFN,SDFIELDS="1;2;3",SDSTART=BEG,SDEND=END S SDRES=""
 D GETAPPT^SDAMA201(SDIEN,SDFIELDS,"",SDSTART,SDEND,.SDRES,"")
 I SDRES<0 D  G EX
 . N ERR
 . S ERR="",ERR=$O(^TMP($J,"SDAMA201","GETAPPT","ERROR",""))
 . S X=1,@RET@(X)="-1"_U_$G(^TMP($J,"SDAMA201","GETAPPT","ERROR",ERR))
 I SDRES>0 D
 . N DSICL,DATE,LOC,STAT,FLAG S (X,DSICL)=0
 . F  S DSICL=$O(^TMP($J,"SDAMA201","GETAPPT",DSICL)) Q:'DSICL  D
 . . S DATE=$G(^TMP($J,"SDAMA201","GETAPPT",DSICL,1)) Q:DATE=""!((DATE<$$NOW^XLFDT)&(FLG=1))
 . . S LOC=+$G(^TMP($J,"SDAMA201","GETAPPT",DSICL,2)) Q:'LOC
 . . S STAT=$G(^TMP($J,"SDAMA201","GETAPPT",DSICL,3)) I STAT'="R" Q
 . . I $D(SCR("C")),'$D(SCR("C",LOC)) Q  ; Clinic screen
 . . I $D(SCR("D")),'$D(SCR("D",$$DIV(LOC))) Q  ; Division screen
 . . I $D(SCR("S")),'$D(SCR("S",$$GET1^DIQ(44,LOC_",",8,"I"))) Q  ; Stop Code screen
 . . S Z=$$FMTE^XLFDT(DATE)_U_$$GET1^DIQ(44,LOC_",",.01)_U_DATE_U_LOC
 . . S X=X+1,@RET@(X)=Z
 . S:'$D(@RET) @RET@(1)="-1^No appointments found"
EX K ^TMP($J,"SDAMA201","GETAPPT")
 Q
DIV(QLOC) ;  return medical center division (#40.8) pointer for
 ;  LOC = hospital location ien (#44)
 ;  return -1 if failed
 I $G(QLOC)<1 Q -1
 N Z,DIERR,ERR
 S Z=$$GET1^DIQ(44,QLOC_",",3.5,"I",,"ERR") S:Z<1 Z=-1
 Q Z
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
VSIT(RETV,DATA,SCR) ;  RPC: DSIC GET VISITS/APPOINTMENT
 ;  get visits, appts, and admits
 ;  only return appointments with no corresponding visit entry
 ;
 ; RETV - $name of global root that stores the data to be returned
 ;        [^TMP("DSIC",$J,"RET")]
 ;
 ; DATA - required - DFN ^ BEG ^ END ^ ZLOC ^ FLG ^ MODS ^ CAT
 ;    DFN - required - pointer to file 2
 ;    BEG - optional - starting Fileman date/time
 ;    END - optional - ending fileman date/time - default = DT.2359
 ;   ALOC - optional - clinic, either name or file 44 ien
 ;                     retained for backwards compatibility
 ;    FLG - optional - type of appts to return
 ;          0 - active/kept appts (past) - default
 ;          1 - future appts only
 ;          2 - both past and future appts
 ;   MODS - optional - string of codes determine which encounters to
 ;          return default value = ASV
 ;           MODS["A" - return current admission regardless of date
 ;           MODS["S" - return schedule appts
 ;           MODS["V" - return visit file entries (#9000010)
 ;    CAT - optional - default value is 0
 ;          screen visits by service category
 ;             1 - return all visits
 ;             0 or <null> - do not return historical type visits
 ; SCR - optional - added 7/3/2002 - sgm
 ;       passed by reference
 ;       format:  SCR(sub) = code ^ value   where
 ;           code = C for hospital location #44
 ;                  D for medical center division #40.8
 ;                  S for 3-digit stop code from file 40.7 (not ien)
 ;          value = for codes C,D - any unique lookup value or ien
 ;                  for code S - 3-digit stop code (not ien to 40.7)
 ;
 ;  Returns @RET@(#) = "A,S,V" ^ visit ien ^ ext d/t ^ ext loc ^
 ;                     int d/t ^ pointer to 44 (int loc)
 ;        where A = admission; S = appt; V = visit file (9000010)
 ;        if errors encountered, return @RET@(#)=-1^error messages
 ;
 N I,X,Y,Z,AIEN,APPT,BEG,CAT,CIEN,CLOC,CNT,DFN,END,FLG,INC,INV,LOC
 N MODS,SCIEN,VSIT,ZSCR
 S RETV=$NA(^TMP("DSIC",$J,"RET")) K @RETV
 S X=$$GET^DSICDPT1(+$G(DATA)) I X<1 S @RETV@(1)=X Q
 ;
 ;  setup local variables
 F I=1:1:7 S @$P("DFN^BEG^END^ALOC^FLG^MODS^CAT",U,I)=$P(DATA,U,I)
 S:MODS="" MODS="SAV" S:$G(END)="" END=$$FMADD^XLFDT(DT,23,59) S CNT=0
 I ALOC]"" S X=$O(SCR("~"),-1)_"~",SCR(X)="C^"_ALOC
 K ALOC I $D(SCR) D SCR^DSICVT3(.SCR,.ZSCR)
 ;
 ;  get all appointments - return in appt=$na(^tmp("dsic",$j,"appt"))
 I MODS["S" D APPT(.APPT,DFN_U_BEG_U_END_U_U_FLG,.ZSCR)
 I +$G(@APPT@(1))=-1 K @APPT
 ;
 ;  get visits - return in vsit=$na(^tmp("dsic",$j,"vsit"))
 I MODS["V" D VS^DSICVT3(.VSIT,DFN,BEG,END,,CAT)
 ;
 ; setup sorted return globals
 ;   scien=file_44_pointer    inv=inverse_fileman_date.time
 ;  ^tmp("dsic",$j,"z",scien,inv) = A or S or V^CNT
 ;  ^tmp("dsic",$j,"inv",-inv,counter) = data to return
 ;
 I $D(VSIT) S I=0 F  S I=$O(@VSIT@(I)) Q:I=""  S X=@VSIT@(I) Q:+X=-1  D
 .S INV=+$P(X,U,5),SCIEN=+$P(X,U,6),CNT=1+CNT
 .S ^TMP("DSIC",$J,"Z",SCIEN,INV)="V^"_CNT
 .S ^TMP("DSIC",$J,"INV",-INV,CNT)=X
 .Q
 ;
 ;  get current admission
 I MODS["A" S Z=$$ADM^DSICVT2(DFN) I Z>0 D
 .;  ALOC=admit loc    CLOC=current loc
 .S ALOC=$P(Z,U,3),AIEN=$P(Z,U,5),CLOC=$P(Z,U,6),CIEN=$P(Z,U,7)
 .S INV=+$P(Z,U,4) Q:$E(INV,1,12)>END  ;  current admit > ending date
 .S SCIEN=+AIEN,X=$G(^TMP("DSIC",$J,"Z",SCIEN,$E(INV,1,12)))
 .K DATA I $E(X)="A" S Y=+$P(X,U,2),INV=$E(INV,1,12) D
 ..S DATA=^TMP("DSIC",$J,"INV",-INV,Y) K ^(Y)
 ..I CLOC]"" S $P(DATA,U,4)=CLOC,$P(DATA,U,6)=CIEN
 ..Q
 .E  D
 ..S DATA="A^^"_$P(Z,U,2)_"^^"_$P(Z,U,4)
 ..I CLOC]"" S $P(DATA,U,4)=CLOC,$P(DATA,U,6)=CIEN
 ..E  S $P(DATA,U,4)=ALOC,$P(DATA,U,6)=AIEN
 ..S ^TMP("DSIC",$J,"Z",SCIEN,INV)="A"
 ..Q
 .S CNT=CNT+1,^TMP("DSIC",$J,"INV",-9999999,CNT)=DATA
 .Q
 ;
 ;  check for any appts to return for which there is no visit
 ;  if visit date.time and location exists, then do not use appt
 I $D(APPT) F I=0:0 S I=$O(@APPT@(I)) Q:'I  K Z S Y=^(I) D
 .S INV=+$P(Y,U,3),SCIEN=+$P(Y,U,4) Q:$D(^TMP("DSIC",$J,"Z",SCIEN,INV))
 .S CNT=CNT+1,^TMP("DSIC",$J,"INV",-INV,CNT)="S^^"_Y
 .Q
 ;
 ;  now actually setup the return global
 S X=0,Z=$NA(^TMP("DSIC",$J,"INV")),Y=$E(Z,1,$L(Z)-1)
 F  S Z=$Q(@Z) Q:Z'[Y  S X=X+1,@RETV@(X)=@Z
 I 'X D
 .S Y="-1^No " S:MODS["V" Y=Y_"visits, "
 .S:MODS["S" Y=Y_"appointments, "
 .S:MODS["A" Y=Y_"admissions, "
 .S @RETV@(1)=$E(Y,1,$L(Y)-2)_" found"
 .Q
 F X="APPT","INV","VSIT","Z" K ^TMP("DSIC",$J,X)
 Q
 ;
