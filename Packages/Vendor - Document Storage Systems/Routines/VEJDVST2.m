VEJDVST2 ;DSS/SGM - RPC TO GET VISITS ;03/06/2002 14:05
 ;;2.11;VEJDCERT RPCS;;Mar 06, 2002
 Q
 ;
VSIT(RETV,DATA,VECLIN,SCODE,VEDIV) ;  RPC call to get visits, appts, and admits
 ;  only return appointments with no corresponding visit entry
 ;
 ; RETV - $name of global root that stores the data to be returned
 ;        [^TMP("VEJD",$J,"RET")]
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
 ;
 ; VECLIN - optional - passed by reference (or a list)
 ;          list of clinics to be used a screen where
 ;          VECLIN(#) = name of clinic or pointer to file 44
 ;
 ;  SCODE - optional - passed by reference (or a list)
 ;          list of stop codes to be used as a screen where
 ;          SCODE(#) = 3-digit stop code
 ;
 ;  VEDIV - optional - passed by reference (or a list)
 ;          list of medical center divisions to be used as a screen
 ;          VEDIV(#) = name of med center div or pointer to 40.8 
 ;
 ;  Returns @RET@(#) = "A,S,V" ^ visit ien ^ ext d/t ^ ext loc ^
 ;                     int d/t ^ pointer to 44 (int loc)
 ;        where A = admission; S = appt; V = visit file (9000010)
 ;        if errors encountered, return @RET@(#)=-1^error messages
 ;
 N I,X,Y,Z,APPT,BEG,CAT,CNT,DFN,END,FLG,INC,INV,LOC,MODS,SCIEN
 N STOPC,VSIT,ZDIV,ZLOC
 S RETV=$NA(^TMP("VEJD",$J,"RET")) K @RETV
 S X=$$DFN^VEJDVST(+$G(DATA)) I $L(X) S @RETV@(1)=X Q
 ;
 ;  setup local variables
 ;
 F I=1:1:7 S @$P("DFN^BEG^END^ALOC^FLG^MODS^CAT",U,I)=$P(DATA,U,I)
 I MODS="" S MODS="SAV"
 I 'END S END=DT+.5
 S CNT=0
 ;
 ;  check to see if need to screen
 D GET^VEJDVST1
 I ALOC]"" S ALOC=+$$GET^VEJDVST(44,ALOC) S:ALOC>0 ZLOC(ALOC)=""
 ;
 ;  get all appointments - return in appt=$na(^tmp("vejd",$j,"appt"))
 I MODS["S" D APPT^VEJDVST1(.APPT,DFN_U_BEG_U_END_U_U_FLG)
 I +$G(@APPT@(1))=-1 K @APPT
 ;
 ;  get visits - return in vsit=$na(^tmp("vejd",$j,"vsit"))
 I MODS["V" D VS(.VSIT,DFN,BEG,END,.ZLOC,CAT)
 ;
 ; setup sorted return globals
 ;   scien=file_44_pointer    inv=inverse_fileman_date.time
 ;  ^tmp("vejd",$j,"z",scien,inv) = A or S or V^CNT
 ;  ^tmp("vejd",$j,"inv",-inv,counter) = data to return
 ;
 F I=0:0 S I=$O(@VSIT@(I)) Q:'I  Q:+@VSIT@(I)=-1  D
 .S X=@VSIT@(I),INV=+$P(X,U,5),SCIEN=+$P(X,U,6),CNT=1+CNT
 .S ^TMP("VEJD",$J,"Z",SCIEN,INV)="V^"_CNT
 .S ^TMP("VEJD",$J,"INV",-INV,CNT)=X
 .Q
 ;
 ;  get current admission
 I MODS["A" S Z=$$ADM^VEJDVST(DFN) I Z>0 D
 .;  ALOC=admit loc    CLOC=current loc
 .N ALOC,AIEN,CLOC,CIEN,DATA
 .S ALOC=$P(Z,U,3),AIEN=$P(Z,U,5),CLOC=$P(Z,U,6),CIEN=$P(Z,U,7)
 .S INV=+$P(Z,U,4) Q:$E(INV,1,12)>END  ;  current admit > ending date
 .S SCIEN=+AIEN,X=$G(^TMP("VEJD",$J,"Z",SCIEN,$E(INV,1,12)))
 .I $E(X)="A" S Y=+$P(X,U,2),INV=$E(INV,1,12) D
 ..S DATA=^TMP("VEJD",$J,"INV",-INV,Y) K ^(Y)
 ..I CLOC]"" S $P(DATA,U,4)=CLOC,$P(DATA,U,6)=CIEN
 ..Q
 .E  D
 ..S DATA="A^^"_$P(Z,U,2)_"^^"_$P(Z,U,4)
 ..I CLOC]"" S $P(DATA,U,4)=CLOC,$P(DATA,U,6)=CIEN
 ..E  S $P(DATA,U,4)=ALOC,$P(DATA,U,6)=AIEN
 ..S ^TMP("VEJD",$J,"Z",SCIEN,INV)="A"
 ..Q
 .S CNT=CNT+1,^TMP("VEJD",$J,"INV",-9999999,CNT)=DATA
 .Q
 ;
 ;  check for any appts to return for which there is no visit
 ;  if visit date.time and location exists, then do not use appt
 F I=0:0 S I=$O(@APPT@(I)) Q:'I  K Z S Y=^(I) D
 .S INV=+$P(Y,U,3),SCIEN=+$P(Y,U,4) Q:$D(^TMP("VEJD",$J,"Z",SCIEN,INV))
 .S CNT=CNT+1,^TMP("VEJD",$J,"INV",-INV,CNT)="S^^"_Y
 .Q
 ;
 ;  now actually setup the return global
 S X=0,Z=$NA(^TMP("VEJD",$J,"INV"))
 F  S Z=$Q(@Z) Q:$QS(Z,3)'="INV"  S X=X+1,@RETV@(X)=@Z
 S:'X @RETV@(1)="-1^No visits or appointments found"
 F X="APPT","INV","VSIT","Z" K ^TMP("VEJD",$J,X)
 Q
 ;
VS(RETX,DFN,BEG,END,ZLOC,CAT,VECLIN,SCODE,VEDIV) ;  RPC to get VISITs only
 ;  DBIA2028 - read ^AUPNVSIT global
 ;  DBIA10040(& 908) - read field .01, file 44
 ;  DBIA1482 - read field 8, file 44 [stop code]
 ;
 ; RETX = $name of global root that stores data [^TMP("VEJD",$J,"VSIT")]
 ;  DFN = required - pointer to file 2
 ;  BEG = optional - Fileman beginning date/time - default 2500101
 ;  END = optional - Fileman ending date/time - default DT+.25
 ; ZLOC = optional - used to screen selected locations
 ;                   passed by reference where ZLOC(ien)=""
 ;                   ien is pointer to file 44
 ;  CAT = optional - default 0 - if 1 then return historical visits
 ;
 ; VECLIN - optional - passed by reference (or a list)
 ;          list of clinics to be used a screen where
 ;          VECLIN(#) = name of clinic or pointer to file 44
 ;
 ;  SCODE - optional - passed by reference (or a list)
 ;          list of stop codes to be used as a screen where
 ;          SCODE(#) = 3-digit stop code
 ;
 ;  VEDIV - optional - passed by reference (or a list)
 ;          list of medical center divisions to be used as a screen
 ;          VEDIV(#) = name of med center div or pointer to 40.8 
 ;
 ;  return @RETX@(#) = V ^ ptr to 9000010 ^ ext date.time ^ ext loc ^
 ;                    int date.time ^ int loc
 ;                    if errors, then return -1^error message
 ;
 ;if called from VSIT then ZLOC,ZDIV,STOPC may or may not be defined
 ;   for definition of Z* variables see GET^VEJDVST1
 ;
 N:'$D(STOPC) STOPC N:'$D(ZDIV) ZDIV N:'$D(ZLOC) ZLOC
 N X,Y,Z,CLIN,CNT,CODE,DATE,FIN,LOC,ST,STOPIEN
 S RETX=$NA(^TMP("VEJD",$J,"VSIT")) K @RETX
 S X=$$DFN^VEJDVST(+$G(DFN)) I X]"" S @RETX@(1)=X Q
 S:'$G(BEG) BEG=2500101 S:'$G(END) END=DT+.5
 S CAT=$G(CAT),CNT=0
 ;
 ;  check to see if need to screen
 D GET^VEJDVST1
 ;
 S ST=9999999-(END\1)-.000001,FIN=9999999.9-(BEG\1)
 ;  visit index in form <inverse date>.<normal fileman time>
 ;
 K ^TMP("VEJDVST1",$J)
 F  S ST=$O(^AUPNVSIT("AA",DFN,ST)) Q:ST>FIN!'ST  S Z=0 D
 .F  S Z=$O(^AUPNVSIT("AA",DFN,ST,Z)) Q:'Z  S X=$G(^AUPNVSIT(Z,0)) D:X]""
 ..;  check to see if certain service categories should be excluded
 ..I 'CAT Q:"EDNCX"[$P(X,U,7)
 ..S Y=$P(X,U,22),CLIN=$P($G(^SC(+Y,0)),U),STOPIEN=+$P($G(^(0)),U,7)
 ..;  screen for clinics, divisions, stop codes
 ..Q:'$$CK^VEJDVST1(Y,(STOPIEN>0))
 ..I $D(STOPC),STOPIEN,'$D(STOPC(STOPIEN)) Q
 ..;
 ..S CODE=$S($P(X,U,7)="H":"A",1:"V"),CNT=CNT+1
 ..S DATE=$E($$FMTE^XLFDT(+X),1,18)
 ..S @RETX@(CNT)=CODE_U_Z_U_DATE_U_CLIN_U_$E(+X,1,12)_U_Y
 ..Q
 .Q
 K ^TMP("VEJDVST1",$J)
 I '$O(@RETX@(0)) S @RETX@(1)="-1^No visits found"
 Q
