PSJLMHED ;BIR/MLM - BUILD LM HEADERS ; 8/6/14 11:00am
 ;;5.0;INPATIENT MEDICATIONS;**4,58,85,110,148,181,260,275,331,256,353,387**;16 DEC 97;Build 1
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to $$CWAD^ORQPT2 is supported by DBIA 2831.
 ; Reference to ^SC( is supported by DBIA 10040.
 ; External reference to $$BSA^PSSDSAPI supported by DBIA 5425.
 ; External reference to ^ORQQVI supported by DBIA 5770.
 ; External reference to ^ORB31 supported by DBIA 5140.
 ; External reference to ^ORQQLR1 supported by DBIA 5787.
 ;
HDR(DFN) ; -- list screen header
 ;   input:       DFN := ifn of pat
 ;  output:  VALMHDR() := hdr array
 ;
 K VAIN,VADM,GMRA,PSJACNWP,PSJ,VAERR,VA,X
 S PSJACNWP=1 D ENBOTH^PSJAC
 D HDRO(DFN)
 S PSJ="   Sex: "_$E($P(PSJPSEX,U,2)_"                 ",1,17)   ;353
 S PSJ=PSJ_"TrSp: "_$$GET1^DIQ(2,PSGP_",",.103),VALMHDR(4)=$$SETSTR^VALM1($S(PSJPDD:"Last ",1:"     ")_"Admitted: "_$P(PSJPAD,U,2),PSJ,49,23)   ;353
 S PSJ="    Dx: "_PSJPDX
 S:PSJPDD VALMHDR(5)=$$SETSTR^VALM1("Discharged: "_$E($P(PSJPDD,U,2),1,8),PSJ,48,26)
 S:'PSJPDD VALMHDR(5)=$$SETSTR^VALM1("Last transferred: "_$$ENDTC^PSGMI(PSJPTD),PSJ,49,26)
 ;
 ;  Display CrCl/BSA - show serum creatinine if CrCl can't be calculated
 S PSJBSA=$$BSA^PSSDSAPI(DFN),PSJBSA=$P(PSJBSA,"^",3),PSJBSA=$S(PSJBSA'>0:"__________",1:$J(PSJBSA,4,2))
 ; RSLT -- DATE^CRCL^Serum Creatinine -- Ex.  11/25/11^68.7^1.1
 S RSLT=$$CRCL(DFN)
 ; Display format of CrCL and Creatinine results updated - PSJ*5.0*387
 I ($P($G(RSLT),"^",2)["Not Found")&($P($G(RSLT),"^",3)<.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_" (CREAT: Not Found)"
 I ($P($G(RSLT),"^",2)["Not Found")&($P($G(RSLT),"^",3)>=.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_"  (CREAT: "_$P($G(RSLT),"^",3)_"mg/dL "_$P($G(RSLT),"^")_")"
 I ($P($G(RSLT),"^",2)'["Not Found")&($P($G(RSLT),"^",3)<.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_" (CREAT: Not Found)"
 I ($P($G(RSLT),"^",2)'["Not Found")&($P($G(RSLT),"^",3)>=.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_"(est.)"_" (CREAT: "_$P($G(RSLT),"^",3)_"mg/dL "_$P($G(RSLT),"^")_")"
 S PSJDB=$G(ZDSPL),VALMHDR(6)=$$SETSTR^VALM1("BSA (m2): "_$G(PSJBSA),PSJDB,50,23) K PSJBSA,RSLT,ZDSPL
 Q
 ; 
HDRO(DFN) ; Standardized part of profile header.
 N PSJCLIN,PSJAPPT,PSJCLINN,RMORDT S (PSJCLIN,PSJAPPT)=0,(RMORDAT,PSJCLINN)="" I $G(PSJORD) D
 . S PSJCLIN=$S($G(PSJORD)["V":$G(^PS(55,DFN,"IV",+PSJORD,"DSS")),$G(PSJORD)["U":$G(^PS(55,DFN,5,+PSJORD,8)),$G(PSJORD)["P":$G(^PS(53.1,+PSJORD,"DSS")),1:"")
 . S:PSJCLIN PSJAPPT=$P($G(PSJCLIN),U,2) S:'PSJAPPT PSJCLIN="" I PSJCLIN,PSJAPPT S PSJCLINN=$P($G(^SC(+PSJCLIN,0)),U)
 K VALMHDR I PSJCLINN]"" S PSJ=VADM(1),PSJ=$$SETSTR^VALM1("   Clinic: "_PSJCLINN,PSJ,28,26)
 I PSJCLINN="" S PSJ=VADM(1),PSJ=$$SETSTR^VALM1($S('PSJPDD:"",1:"Last ")_"Ward: "_PSJPWDN,PSJ,30,18)
 S X=$$CWAD^ORQPT2(DFN)
 S:X]"" X=IORVON_X_IORVOFF,PSJ=$$SETSTR^VALM1(X,PSJ,80-$L(X),80) S VALMHDR(1)=PSJ
 S PSJ="   PID: "_$P(PSJPSSN,U,2)
 S RMORDT=$S($G(PSJPDD):"Last ",1:"")_"Room-Bed: "_$G(PSJPRB)
 I PSJCLINN]"",PSJAPPT S RMORDT="Clinic Date: "_$$ENDTC^PSGMI(PSJAPPT),RMORDT=$P(RMORDT,"  ")_" "_$P(RMORDT,"  ",2)
 S PSJ=$$SETSTR^VALM1(RMORDT,PSJ,26,28),VALMHDR(2)=$$SETSTR^VALM1("Ht(cm): "_PSJPHT_" "_PSJPHTD,PSJ,55,25)
 S PSJ="   DOB: "_$E($P($P(PSJPDOB,U,2)," ")_" ("_PSJPAGE_")"_"                 ",1,17)   ;*353
 S PSJ=PSJ_"Att:  "_$$GET1^DIQ(2,PSGP_",",.1041),VALMHDR(3)=$$SETSTR^VALM1("Wt(kg): "_PSJPWT_" "_PSJPWTD,PSJ,55,25)   ;*353
 Q
 ;
INIT(PSJPROT) ; -- init bld vars
 ; PSJPROT=1:UD ONLY; 2:IV ONLY; 3:BOTH
 K PSJUDPRF,^TMP("PSJ",$J),^TMP("PSJON",$J),^TMP("PSJPRO",$J)
 S:PSJPROT=1 PSJUDPRF=1
 D KILL^VALM10(),EN^PSJO1(PSJPROT)
 I '$D(^TMP("PSJ",$J)) W !!,?22,"NO ORDERS FOUND FOR "_$S(PSJOL="S":"SHORT",1:"LONG")_" PROFILE." S VALMQUIT=1 D PAUSE^PSJLMUTL Q
 S PSJTF=0,PSJLN=1,PSJEN=1,PSJC="" F  S PSJC=$O(^TMP("PSJ",$J,PSJC)) Q:PSJC=""!(PSJC["^")  D
 .S PSJF="^PS("_$S("AO"[PSJC:"55,"_PSGP_",5,",PSJC="DF":"55,"_PSGP_",5,",1:"53.1,")
 .I PSJTF'=$E(PSJC,1)!(PSJC="CC")!(PSJC="CD")!(PSJC="BD") Q:PSJC="CB"  Q:PSJC="O"  Q:PSJC="DF"  D TF S PSJTF=$E(PSJC,1)    ;DAM 8-29-07 Added Q:PSJC="CB"  Q:PSJC="O"
 .S PSJST="" F  S PSJST=$O(^TMP("PSJ",$J,PSJC,PSJST)) Q:PSJST=""  D
 ..S PSJS="" F  S PSJS=$O(^TMP("PSJ",$J,PSJC,PSJST,PSJS)) Q:PSJS=""  Q:PSJC="CB"  Q:PSJC="O"  Q:PSJC="DF"  D ON      ;DAM 8-29-07  Added Q:PSJC="CB"  Q:PSJC="O"
 .;
 .;DAM 8-29-07   New code to place Pending Orders after Pending Renewal Orders on the roll and scroll display.  Non-Active Orders appear last.
 S PSJTF=0,PSJC="" F  S PSJC=$O(^TMP("PSJ",$J,PSJC)) Q:PSJC=""  D
 . S PSJF="^PS("_$S("AO"[PSJC:"55,"_PSGP_",5,",PSJC="DF":"55,"_PSGP_",5,",1:"53.1,")
 . I PSJC="CB" D TF S PSJTF=$E(PSJC,1)                            ;These are Pending Orders
 . I PSJC="CB" S PSJST="" F  S PSJST=$O(^TMP("PSJ",$J,PSJC,PSJST)) Q:PSJST=""  D
 . . S PSJS="" F  S PSJS=$O(^TMP("PSJ",$J,PSJC,PSJST,PSJS)) Q:PSJS=""   D ON
 . ;
 . I PSJC["Cz" D
 . . N PSJCLIN
 . . S PSJF="^PS("_$S("AO"[$P(PSJC,"^",4):"55,"_PSGP_",5,",$P(PSJC,"^",4)="DF":"55,"_PSGP_",5,",1:"53.1,")
 . . S PSJCLIN=$P(PSJC,"^",2) Q:PSJCLIN=""
 . . I ($P(PSJTF,"^",2)'=$P(PSJC,"^",2)) D TF S PSJTF=PSJC
 . . S PSJST="" F  S PSJST=$O(^TMP("PSJ",$J,PSJC,PSJST)) Q:PSJST=""  D
 . . . S PSJS="" F  S PSJS=$O(^TMP("PSJ",$J,PSJC,PSJST,PSJS)) Q:PSJS=""  D ON      ;DAM 8-29-07  Added Q:PSJC="CB"  Q:PSJC="O"
 . ;
 . I PSJC="DF" D TF S PSJTF=$E(PSJC,1)                              ;These are recently DC Orders (mv)
 . I PSJC="DF" S PSJST="" F  S PSJST=$O(^TMP("PSJ",$J,PSJC,PSJST)) Q:PSJST=""  D
 . . S PSJS="" F  S PSJS=$O(^TMP("PSJ",$J,PSJC,PSJST,PSJS)) Q:PSJS=""   D ON
 . I PSJC="O" D TF S PSJTF=$E(PSJC,1)                              ;These are Non-Active Orders
 . I PSJC="O" S PSJST="" F  S PSJST=$O(^TMP("PSJ",$J,PSJC,PSJST)) Q:PSJST=""  D
 . . S PSJS="" F  S PSJS=$O(^TMP("PSJ",$J,PSJC,PSJST,PSJS)) Q:PSJS=""   D ON
 .; END DAM changes
 .;
 S VALMCNT=PSJLN-1
DONE ;
 K PSJC,PSJEN,PSJLN,PSJST,PSJS,CNT,PSJPRI,PSJORD
 Q
 ;
ON ;
 S PSJSCHT=$S(PSJOS:PSJS,1:PSJST)
 S PSJO="" F FQ=0:0 S PSJO=$O(^TMP("PSJ",$J,PSJC,PSJST,PSJS,PSJO)) Q:PSJO=""  S DN=^(PSJO)   D
 .N PRJPRI S PSJPRI=$S(PSJO["V":$P($G(^PS(55,PSGP,"IV",+PSJO,.2)),"^",4),PSJO["U":$P($G(^PS(55,PSGP,5,+PSJO,.2)),"^",4),1:$P($G(^PS(53.1,+PSJO,.2)),"^",4))
 .S ^TMP("PSJON",$J,PSJEN)=PSJO,PSJL=$J(PSJEN,4) I ($P(PSJC,"^")="Cz") N PSJTMPJC S PSJTMPJC=PSJC N PSJC S PSJC=$P(PSJTMPJC,"^",4)
 .D @$S(PSJO["V":"PIV^PSJLMPRI(PSGP,PSJO,PSJF,DN)",PSJO["U":"PUD^PSJLMPRU(PSGP,PSJO,PSJF,DN)",1:"PIV^PSJLMPRI(PSGP,PSJO,PSJF,DN)") S ^TMP("PSJPRO",$J,0)=PSJEN,PSJEN=PSJEN+1
 Q
 ;
TF ; Set up order type header
 NEW PSJDFHDR
 I $D(^TMP("PSJ",$J,PSJC)) D
 .S PSJDCEXP=$$RECDCEXP^PSJP()
 .S PSJDFHDR="RECENTLY DISCONTINUED/EXPIRED (LAST "_+$G(PSJDCEXP)_" HOURS)"
 .N C,X,Y S C=PSJC,Y="",$P(Y," -",40)=""
 .S X=$S(($G(PSJCLIN)]""):$G(PSJCLIN),C="A":$$TXT^PSJO("A"),C["CC":$$TXT^PSJO("PR"),C["CD":$$TXT^PSJO("PC"),C["C":$$TXT^PSJO("P"),C["BD":$$TXT^PSJO("NC"),C["B":$$TXT^PSJO("N"),C["DF":PSJDFHDR,1:$$TXT^PSJO("NA"))
 .S ^TMP("PSJPRO",$J,PSJLN,0)=$E($E(Y,1,(80-$L(X))/2)_" "_X_$E(Y,1,(80-$L(X))/2),1,80),PSJLN=PSJLN+1
 Q
TEST ;
 N X,Y S Y="",$P(Y," -",40)=""
 F X="A C T I V E","P E N D I N G   R E N E W A L S","P E N D I N G ","N O N - V E R I F I E D","N O N - A C T I V E" W !,$E($E(Y,1,(80-$L(X))/2)_" "_X_$E(Y,1,(80-$L(X))/2),1,80)
 Q
CRCL(DFN) ;
 N HTGT60,ABW,IBW,BWRATIO,BWDIFF,LOWBW,ADJBW,X1,X2,RSLT,PSCR,PSRW,ABW,ZHT,PSRH,PSCXTL,PSCXTLS,SCR,SCRD,OCXT,OCXTS,SCRV,ZAGE,ZSERUM,SEX
 S RSLT="0^<Not Found>"
 S PSCR="^^^^^^0"
 S PSCXTL="" Q:'$$TERMLKUP^ORB31(.PSCXTL,"SERUM CREATININE") RSLT
 S PSCXTLS="" Q:'$$TERMLKUP^ORB31(.PSCXTLS,"SERUM SPECIMEN") RSLT
 S SCR="",OCXT=0 F  S OCXT=$O(PSCXTL(OCXT)) Q:'OCXT  D
 .S OCXTS=0 F  S OCXTS=$O(PSCXTLS(OCXTS)) Q:'OCXTS  D
 ..S SCR=$$LOCL^ORQQLR1(DFN,$P(PSCXTL(OCXT),U),$P(PSCXTLS(OCXTS),U))
 ..I $P(SCR,U,7)>$P(PSCR,U,7) S PSCR=SCR
 S SCR=PSCR,SCRV=$P(SCR,U,3) Q:+$G(SCRV)<.01 RSLT
 S SCRD=$P(SCR,U,7) Q:'$L(SCRD) RSLT
 S RSLT=SCRD_"^<Not Found>^"_$P($G(SCR),"^",3)
 S X1=$P(RSLT,"^"),X2=$$FMTE^XLFDT(X1,"2M"),$P(RSLT,"^")=$P(X2,"@") K X1,X2
 D VITAL^ORQQVI("WEIGHT","WT",DFN,.PSRW,0,"",$$NOW^XLFDT)
 Q:'$D(PSRW) RSLT
 S ABW=$P(PSRW(1),U,3) Q:+$G(ABW)<1 RSLT
 S ABW=ABW/2.20462262  ;ABW (actual body weight) in kg; changed 2.2 to 2.20462262 per CQ 10637 ; PSO 402
 D VITAL^ORQQVI("HEIGHT","HT",DFN,.PSRH,0,"",$$NOW^XLFDT)
 Q:'$D(PSRH) RSLT
 S ZHT=$P(PSRH(1),U,3) Q:+$G(ZHT)<1 RSLT
 N VADM D DEM^VADPT S ZAGE=$G(VADM(4)) Q:'$L(ZAGE) RSLT
 ;S ZAGE=$$AGE^ORQPTQ4(DFN) Q:'ZAGE RSLT
 S SEX=$P($G(VADM(5)),"^") Q:'$L(SEX) RSLT
 ;S SEX=$P($$SEX^ORQPTQ4(DFN),U,1) Q:'$L(SEX) RSLT
 I '$G(ABW)!($G(ZHT)<1)!'$G(ZAGE)!'$D(SEX) Q RSLT
 S SCRD=$P(SCR,U,7) Q:'$L(SCRD) RSLT
 S HTGT60=$S(ZHT>60:(ZHT-60)*2.3,1:0)  ;if ht > 60 inches
 I HTGT60>0 D
 .S IBW=$S(SEX="M":50+HTGT60,1:45.5+HTGT60)  ;Ideal Body Weight
 .S BWRATIO=(ABW/IBW)  ;body weight ratio
 .S BWDIFF=$S(ABW>IBW:ABW-IBW,1:0)
 .S LOWBW=$S(IBW<ABW:IBW,1:ABW)
 .I BWRATIO>1.3,(BWDIFF>0) S ADJBW=((0.3*BWDIFF)+IBW)
 .E  S ADJBW=LOWBW
 I +$G(ADJBW)<1 D
 .S ADJBW=ABW
 S CRCL=(((140-ZAGE)*ADJBW)/(SCRV*72))
 S:SEX="M" RSLT=SCRD_U_$J(CRCL,1,1)
 S:SEX="F" RSLT=SCRD_U_$J((CRCL*.85),1,1)
 S X1=$P(RSLT,"^"),X2=$$FMTE^XLFDT(X1,"2M"),$P(RSLT,"^")=$P(X2,"@") K X1,X2
 S $P(RSLT,"^",3)=$P($G(SCR),"^",3)
 K HTGT60,ABW,IBW,BWRATIO,BWDIFF,LOWBW,ADJBW,X1,X2,PSCR,PSRW,ABW,ZHT,PSRH,ZAGE,PSCXTL,PSCXTLS,SCR,OCXT,OCXTS,SCRV,CRCL,ZSERUM
 Q RSLT
