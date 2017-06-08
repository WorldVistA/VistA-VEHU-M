DSICVST2 ;DSS/SGM - RPC TO GET VISITS ;06/09/2004 20:07
 ;;1.5;VA CERTIFIED COMPONENTS - DSSI;;Jul 09, 2008;Build 9
 ;Copyright 1995-2008, Document Storage Systems, Inc., All Rights Reserved
 ;************************************************************************
 ; These routines have been replaced by DSICVT* routines.  Please use those 
 ; routines for appointment calls as they have been changed for the new 
 ; Replacement Scheduling Application (RSA) APIs.  06/07/06 - wlc
 ;************************************************************************
 ;
 ; DBIA#  Supported
 ; -----  ---------  ----------------------------------
 ;  1905  Cont Sub    SELECTED^VSIT
 ; 10103      x       $$FMTE^XLFDT
 ;
VSIT(RETV,DATA,SCR) ;  RPC: DSIC GET VISITS/APPOINTMENT
 ;  called by routines VEJDSD01, VEJDPXLU
 ;  get visits, appts, and admits
 ;  only return appointments with no corresponding visit entry
 ;
 ; RETV - $name of global root that stores the data to be returned
 ;        [^TMP("DSIC",$J,"RET")]
 ;
 ; DATA - required - DFN ^ BEG ^ END ^ ZLOC ^ FLG ^ MODS ^ CAT
 ;    DFN - required - pointer to file 2
 ;    BEG - optional - starting Fileman date/time
 ;    END - optional - ending fileman date/time - default = DT+.5
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
 S:MODS="" MODS="SAV" S:'END END=DT+.5 S CNT=0
 I ALOC]"" S X=$O(SCR("~"),-1)_"~",SCR(X)="C^"_ALOC
 K ALOC D:$D(SCR) SCR^DSICVST0(.SCR,.ZSCR)
 ;
 ;  get all appointments - return in appt=$na(^tmp("dsic",$j,"appt"))
 I MODS["S" D APPT^DSICVST1(.APPT,DFN_U_BEG_U_END_U_U_FLG)
 I +$G(@APPT@(1))=-1 K @APPT
 ;
 ;  get visits - return in vsit=$na(^tmp("dsic",$j,"vsit"))
 I MODS["V" D VS(.VSIT,DFN,BEG,END,,CAT)
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
 I MODS["A" S Z=$$ADM^DSICVST(DFN) I Z>0 D
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
 N I,X,Y,Z,LOC,NSERVCAT,ROOT,ST,STOP,TYPE,VIEN,XLOC,XSC
 N:'$D(ZSCR) ZSCR
 S RETX=$NA(^TMP("DSIC",$J,"VSIT")) K @RETX,^TMP("VSIT",$J)
 S X=$$GET^DSICDPT1(+$G(DFN)) I X<1 S @RETX@(1)=X Q
 S:'$G(BEG) BEG=2500101 S:'$G(END) END=DT+.5
 S CAT=$G(CAT),NSERVCAT=$S(+$G(CAT):"",1:"EDNCX"),CNT=0
 S X=$O(SCR("~"),-1)_"~"
 I $D(ZLOC) F I=0:0 S I=$O(ZLOC(I)) Q:'I  S SCR(X_I)="C^"_I
 K ZLOC D:$D(SCR) SCR^DSICVST0(.SCR,.ZSCR)
 D SELECTED^VSIT(DFN,BEG,END,,,,,NSERVCAT)
 S ROOT=$NA(^TMP("VSIT",$J,0)),STOP=$P(ROOT,",",1,2)
 F  S ROOT=$Q(@ROOT) Q:ROOT'[STOP  S X=@ROOT D
 .S LOC="",VIEN=$QS(ROOT,3),TYPE=$P(X,U,3)
 .;
 .;  excluded child visits
 .I $$VALL^DSICVST0(,VIEN,"I",.12,1) Q
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
