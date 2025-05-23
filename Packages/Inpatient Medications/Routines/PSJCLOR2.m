PSJCLOR2 ;BIR/JCH - BUILD CLINIC ORDER LM HEADERS ; 2/28/12 9:11am
 ;;5.0;INPATIENT MEDICATIONS;**275,279,315,256,387**;16 DEC 97;Build 1
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; Reference to ^PS(55 is supported by DBIA 2191
 ; Reference to CWAD^ORQPT2 is supported by DBIA 2831
 ; Reference to ^SC( is supported by DBIA 10040
 ; Reference to BSA^PSSDSAPI supported by DBIA #5425
 ; Reference to LS^PSSLOCK supported by DBIA #2789
 ; Reference to UNL^PSSLOCK supported by DBIA #2789
 ;
HDR(DFN) ; -- list screen header
 ;   input:       DFN := ifn of pat
 ;  output:  VALMHDR() := hdr array
 ;
 K VAIN,VADM,GMRA,PSJACNWP,PSJ,VAERR,VA,X
 S PSJACNWP=1 D ENBOTH^PSJAC
 D HDRO(DFN)
 S PSJ="   Sex: "_$P(PSJPSEX,U,2),VALMHDR(4)=$$SETSTR^VALM1($S(PSJPDD:"Last ",1:"     ")_"Admitted: "_$P($G(PSJPAD),U,2),PSJ,45,23)
 S PSJ="    Dx: "_$G(PSJPDX)
 S:PSJPDD VALMHDR(5)=$$SETSTR^VALM1("Discharged: "_$E($P(PSJPDD,U,2),1,8),PSJ,48,26)
 S:'PSJPDD VALMHDR(5)=$$SETSTR^VALM1("Last transferred: "_$$ENDTC^PSGMI(PSJPTD),PSJ,42,26)
 ;
 ;  Display CrCl/BSA - show serum creatinine if CrCl can't be calculated
 S PSJBSA=$$BSA^PSSDSAPI(DFN),PSJBSA=$P(PSJBSA,"^",3),PSJBSA=$S(PSJBSA'>0:"__________",1:$J(PSJBSA,4,2))
 ; RSLT -- DATE^CRCL^Serum Creatinine -- Ex.  11/25/11^68.7^1.1
 S RSLT=$$CRCL^PSJLMHED(DFN)
 ; Display format of CrCL and Creatinine results updated - PSJ*5.0*387
 I ($P($G(RSLT),"^",2)["Not Found")&($P($G(RSLT),"^",3)<.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_" (CREAT: Not Found)"
 I ($P($G(RSLT),"^",2)["Not Found")&($P($G(RSLT),"^",3)>=.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_"  (CREAT: "_$P($G(RSLT),"^",3)_"mg/dL "_$P($G(RSLT),"^")_")"
 I ($P($G(RSLT),"^",2)'["Not Found")&($P($G(RSLT),"^",3)<.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_" (CREAT: Not Found)"
 I ($P($G(RSLT),"^",2)'["Not Found")&($P($G(RSLT),"^",3)>=.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_"(est.)"_" (CREAT: "_$P($G(RSLT),"^",3)_"mg/dL "_$P($G(RSLT),"^")_")"
 S PSJDB=$G(ZDSPL),VALMHDR(6)=$$SETSTR^VALM1("BSA (m2): "_$G(PSJBSA),PSJDB,50,23) K PSJBSA,ZDSPL,RSLT
 Q
 ;
HDRO(DFN) ; Standardized part of profile header.
 N PSJCLIN,PSJAPPT,PSJCLINN,RMORDT S (PSJCLIN,PSJAPPT)=0,(RMORDT,PSJCLINN)="" I $G(PSJORD) D
 . S PSJCLIN=$S($G(PSJORD)["V":$G(^PS(55,DFN,"IV",+PSJORD,"DSS")),$G(PSJORD)["U":$G(^PS(55,DFN,5,+PSJORD,8)),$G(PSJORD)["P":$G(^PS(53.1,+PSJORD,"DSS")),1:"")
 . S:PSJCLIN PSJAPPT=$P($G(PSJCLIN),U,2) I PSJCLIN,PSJAPPT S PSJCLINN=$P($G(^SC(+PSJCLIN,0)),U)
 K VALMHDR I PSJCLINN]"" S PSJ=VADM(1),PSJ=$$SETSTR^VALM1("   Clinic: "_PSJCLINN,PSJ,28,26)
 I PSJCLINN="" S PSJ=VADM(1),PSJ=$$SETSTR^VALM1($S('PSJPDD:"     ",1:"Last ")_"Ward: "_PSJPWDN,PSJ,30,18)
 S X=$$CWAD^ORQPT2(DFN)
 S:X]"" X=$G(IORVON)_X_$G(IORVOFF),PSJ=$$SETSTR^VALM1(X,PSJ,80-$L(X),80) S VALMHDR(1)=PSJ
 S PSJ="   PID: "_$P(PSJPSSN,U,2)
 S RMORDT=$S($G(PSJPDD):"Last ",1:"     ")_"Room-Bed: "_$G(PSJPRB)
 I PSJCLINN]"",PSJAPPT S RMORDT="Clinic Date: "_$$ENDTC^PSGMI(PSJAPPT),RMORDT=$P(RMORDT,"  ")_" "_$P(RMORDT,"  ",2)
 S PSJ=$$SETSTR^VALM1(RMORDT,PSJ,26,28),VALMHDR(2)=$$SETSTR^VALM1("Ht(cm): "_PSJPHT_" "_PSJPHTD,PSJ,55,25)
 S PSJ="   DOB: "_$P($P(PSJPDOB,U,2)," ")_" ("_PSJPAGE_")",VALMHDR(3)=$$SETSTR^VALM1("Wt(kg): "_PSJPWT_" "_PSJPWTD,PSJ,55,25)
 Q
 ;
INIT(PSJPROT) ; -- init bld vars
 ; PSJPROT=1:UD ONLY; 2:IV ONLY; 3:BOTH
 K PSJUDPRF,^TMP("PSJ",$J),^TMP("PSJON",$J),^TMP("PSJPRO",$J),^TMP("PSJCLOR",$J) D FULL^VALM1
 N TMPCLIN,DFN,UDU S PSJVALQ=0,TMPCLIN="",DFN=PSGP,PSGSSAV=PSGSS,UDU=$S($P(PSJSYSU,";",3)>1:3,1:1)
 S:PSJPROT=1 PSJUDPRF=1
 D KILL^VALM10(),EN^PSJCLOR3(PSJPROT)
 I '$D(^TMP("PSJ",$J)) W !!,?22,"NO CLINIC ORDERS FOUND." S VALMQUIT=1,PSJVALQ=1 D PAUSE^PSJLMUTL Q
 S PSJLN=1,PSJEN=1 S PSJCLIN="" F  S PSJCLIN=$O(^TMP("PSJ",$J,PSJCLIN)) Q:PSJCLIN=""  S PSJTF=0,PSJC="" F  S PSJC=$O(^TMP("PSJ",$J,PSJCLIN,PSJC)) Q:PSJC=""  D
 .N PSJF S PSJF="^PS("_$S("AO"[PSJC:"55,"_PSGP_",5,",PSJC="DF":"55,"_PSGP_",5,",1:"53.1,")
 .I TMPCLIN'=PSJCLIN D TF S PSJTF=$E(PSJC,1),TMPCLIN=PSJCLIN    ;DAM 8-29-07 Added Q:PSJC="CB"  Q:PSJC="O"
 .S PSJST="" F  S PSJST=$O(^TMP("PSJ",$J,PSJCLIN,PSJC,PSJST)) Q:PSJST=""  D
 ..S PSJS="" F  S PSJS=$O(^TMP("PSJ",$J,PSJCLIN,PSJC,PSJST,PSJS)) Q:PSJS=""  Q:PSJC="CB"  Q:PSJC="O"  Q:PSJC="DF"  D ON      ;DAM 8-29-07  Added Q:PSJC="CB"  Q:PSJC="O"
 .;
 .;DAM 8-29-07   New code to place Pending Orders after Pending Renewal Orders on the roll and scroll display.  Non-Active Orders appear last.
 S PSJCLIN="" F  S PSJCLIN=$O(^TMP("PSJ",$J,PSJCLIN)) Q:PSJCLIN=""  S PSJTF=0,PSJC="" F  S PSJC=$O(^TMP("PSJ",$J,PSJCLIN,PSJC)) Q:PSJC=""  D
 . N PSJF S PSJF="^PS("_$S("AO"[PSJC:"55,"_PSGP_",5,",PSJC="DF":"55,"_PSGP_",5,",1:"53.1,")
 . I PSJC="CB" I TMPCLIN'=PSJCLIN D TF S PSJTF=$E(PSJC,1),TMPCLIN=PSJCLIN                            ;These are Pending Orders
 . I PSJC="CB" S PSJST="" F  S PSJST=$O(^TMP("PSJ",$J,PSJCLIN,PSJC,PSJST)) Q:PSJST=""  D
 . . S PSJS="" F  S PSJS=$O(^TMP("PSJ",$J,PSJCLIN,PSJC,PSJST,PSJS)) Q:PSJS=""   D ON
 . I PSJC="DF" I TMPCLIN'=PSJCLIN D TF S PSJTF=$E(PSJC,1),TMPCLIN=PSJCLIN                              ;These are recently DC Orders (mv)
 . I PSJC="DF" S PSJST="" F  S PSJST=$O(^TMP("PSJ",$J,PSJCLIN,PSJC,PSJST)) Q:PSJST=""  D
 . . S PSJS="" F  S PSJS=$O(^TMP("PSJ",$J,PSJCLIN,PSJC,PSJST,PSJS)) Q:PSJS=""   D ON
 . I PSJC="O" I TMPCLIN'=PSJCLIN D TF S PSJTF=$E(PSJC,1),TMPCLIN=PSJCLIN                              ;These are Non-Active Orders
 . I PSJC="O" S PSJST="" F  S PSJST=$O(^TMP("PSJ",$J,PSJCLIN,PSJC,PSJST)) Q:PSJST=""  D
 . . S PSJS="" F  S PSJS=$O(^TMP("PSJ",$J,PSJCLIN,PSJC,PSJST,PSJS)) Q:PSJS=""   D ON
 .; END DAM changes
 .;
 S VALMCNT=PSJLN-1
DONE ;
 K ^TMP("PSJCLOR",$J) M ^TMP("PSJCLOR",$J)=^TMP("PSJON",$J)
 K PSJC,PSJEN,PSJLN,PSJST,PSJS,CNT,PSJPRI,^TMP("PSJ",$J),PSGSSAV,PSJDCEXP,PSJL,PSJON,PSJOS,PSJTF
 Q
ON ; Set order number into ^TMP
 N PSJCLORD S PSJCLORD=1
 S PSJSCHT=$S(PSJOS:PSJS,1:PSJST)
 S PSJO="" F FQ=0:0 S PSJO=$O(^TMP("PSJ",$J,PSJCLIN,PSJC,PSJST,PSJS,PSJO)) Q:PSJO=""  S DN=^(PSJO) D
 .N PRJPRI S PSJPRI=$S(PSJO["V":$P($G(^PS(55,PSGP,"IV",+PSJO,.2)),"^",4),PSJO["U":$P($G(^PS(55,PSGP,5,+PSJO,.2)),"^",4),1:$P($G(^PS(53.1,+PSJO,.2)),"^",4))
 .S ^TMP("PSJON",$J,PSJEN)=PSJO,PSJL=$J(PSJEN,4) D @$S(PSJO["V":"PIV^PSJLMPRI(PSGP,PSJO,PSJF,DN)",PSJO["U":"PUD^PSJLMPRU(PSGP,PSJO,PSJF,DN)",1:"PIV^PSJLMPRI(PSGP,PSJO,PSJF,DN)") S ^TMP("PSJPRO",$J,0)=PSJEN,PSJEN=PSJEN+1
 .S ^TMP("PSJON",$J)=+$O(^TMP("PSJON",$J,""),-1)
 K DN,FQ,PSJSCHT
 Q
TF ; Set up order type header
 NEW PSJDFHDR
 I $D(^TMP("PSJ",$J,PSJCLIN)) D
 .S PSJDCEXP=$$RECDCEXP^PSJP()
 .S PSJDFHDR="RECENTLY DISCONTINUED/EXPIRED (LAST "_+$G(PSJDCEXP)_" HOURS)"
 .N C,X,Y S C=PSJC,Y="",$P(Y," -",40)=""
 .S X=PSJCLIN
 .I $G(PSJCLIN)]"" S X=PSJCLIN
 .S ^TMP("PSJPRO",$J,PSJLN,0)=$E($E(Y,1,(80-$L(X))/2)_" "_X_$E(Y,1,(80-$L(X))/2),1,80),PSJLN=PSJLN+1
 Q
TEST ; Headers
 N X,Y S Y="",$P(Y," -",40)=""
 F X="A C T I V E","P E N D I N G   R E N E W A L S","P E N D I N G ","N O N - V E R I F I E D","N O N - A C T I V E" W !,$E($E(Y,1,(80-$L(X))/2)_" "_X_$E(Y,1,(80-$L(X))/2),1,80)
 Q
VWDETAIL(PSGP) ;
 N VAIN,VADM,PSJLM,PSGPRF,PSJPRP,PSJSYSL,DFN D ENCV^PSGSETU
 S DFN=PSGP D ^PSJAC D INIT^PSJCLOR2(3)
 S PSGPRF="",PSJPRP="P",PSJPR=0,PSJON=+$G(^TMP("PSJON",$J)) D FULL^VALM1,ENVW
 D DONEVD
 Q
ENVW ; ask user to select or view any of the orders shown
 S (PSGONC,PSGONR,PSGONV)=0,PSGLMT=PSJON S:$D(PSJPRF) PSGPRF=1
 N PSJXDIR S PSJXDIR=$P($G(XQORNOD(0)),"=",2) I PSJXDIR S X=$E(PSJXDIR,1,$L(PSJXDIR)-1) D ENCHK^PSGON
 I '$G(PSJXDIR) D ENASR^PSGON
 K PSGPRF
 G:X["^" DONEVD I X]"" S PSGOEA=""
 K PSJDLW
 I  F PSJOE=1:1:PSGODDD S PSGOE=PSJOE F PSJOE1=1:1:$L(PSGODDD(PSJOE),",")-1 S PSJOE2=$P(PSGODDD(PSJOE),",",PSJOE1),(PSGORD,PSJORD)=^TMP("PSJON",$J,PSJOE2) G:$D(PSJDLW) DONEVD D
 .I PSJORD=+PSJORD N PSJO,PSJO1 S PSJO=PSJORD,PSJO1=0 F  S PSJO1=$O(^PS(53.1,"ACX",PSJO,PSJO1)) Q:'PSJO1  Q:$D(PSJDLW)  S PSJORD=PSJO1_"P",PSGOEA="" D GODO(PSJORD) S PSJORD=""
 .Q:PSJORD=""  S PSGOEA="" D GODO(PSJORD)
 Q
 ;
GODO(PSJORD) ; 
 D GODO^PSJOE0
 Q
DONEVD ; Kill variables
 K DTOUT,PSGONC,PSGONR,PSGONV,PSGODDD,PSGOE,PSGOEA,PSJL,PSJOE,PSJOE1,PSJOE2,PSJON,PSJPR,PSJPRF
 Q
 ;
NEWORDER(PSGP,PSGORD,PSGNWSD,PSGOEAV) ;
 N PSGSD,PSGOEEF,PSGOFD,PSGNEFD,PSGOSD,PSGFD,PSGAT,PSGFDN S PSGOEEF(10)=1,PSJNOLOK=0
 K DIR I '$$LS^PSSLOCK(DFN,PSGORD) W !,"NO ACTION TAKEN ON ORDER",! D CONT^PSJOE0 S PSJNOLOK=1 Q
 I $D(^PS(53.45,+$G(PSJSYSP),5)) N PSJFSI S PSJFSI=1 D FILESI^PSJBCMA5(DFN,PSGORD) N SIARRAY S SIARRAY="" D
 .I PSGORD["P" M SIARRAY=^PS(53.1,+PSGORD,15) D NEWNVAL^PSGAL5(PSGORD,6000,"SPECIAL INSTRUCTIONS",,.SIARRAY)
 .I PSGORD["U" M SIARRAY=^PS(55,DFN,5,+PSGORD,15) D NEWUDAL^PSGAL5(DFN,PSGORD,6000,"SPECIAL INSTRUCTIONS",,.SIARRAY)
 I PSGORD["P" S PSJCOM=+$P($G(^PS(53.1,+PSGORD,.2)),"^",8) I PSJCOM D NEW^PSJCOM1 Q
 ;
 I PSGORD["P"!(PSGORD["U") D
 .N PSGST,PSGSCH,PSGNESD,ND,ND2,ND2P1,PSJEDFLD,I ;*315
 .F I=0,2 S ND(I)=$S($G(PSGORD)["P":$G(^PS(53.1,+PSGORD,I)),$G(PSGORD)["U":$G(^PS(55,+$G(PSGP),5,+PSGORD,I)),$G(PSJTMPON)["V":$G(^PS(55,+$G(PSGP),"IV",+PSGORD,I)),1:"")
 .S PSGNESD=PSGNWSD,PSGSCH=$S(PSGORD["P"!(PSGORD["U"):$P(ND(2),"^"),PSGORD["V":$P(ND(0),"^",9),1:"")
 .S PSGST=$S(PSGORD["P"!(PSGORD["U"):$P(ND(0),"^",7),1:""),(PSGFD,PSGOFD)=$S(PSGORD["V":$P(ND(0),"^",3),1:$P(ND(2),"^",4)),(PSGSD,PSGOSD)=$S(PSGORD["V":$P(ND(0),"^",2),1:$P(ND(2),"^",2))
 .S PSGNEFD="" D ENFD^PSGNE3(PSGNWSD) S PSGFD=$S($G(PSGRDTX(+PSGORD,"PSGFD")):PSGRDTX(+PSGORD,"PSGFD"),1:PSGNEFD)
 .I $G(PSGNEFD),(PSGNEFD<PSGNWSD) W $C(7),!?5,"*** THE START DATE CANNOT BE AFTER THE STOP DATE! ***" S PSJQMSG=1 Q
 .S PSJEDFLD=$S(PSGORD["P":25,1:34) S PSGOEEF(PSJEDFLD)=1
 ;
 I PSGORD["U" D  Q
 .N TMPNEFD S TMPNEFD=$G(PSGNEFD) S PSGOEEWF="^PS(55,"_PSGP_",5,"_+PSGORD_"," S (ND,ND0)=$G(@(PSGOEEWF_"0)")),ND2=$G(^(2)),ND2P1=$G(^(2.1)) ;*315
 .D EN2^PSGOEEW
 .S PSGOORD=PSGORD S (PSGNESD,SD,PSGSD)=PSGNWSD I ($G(TMPNEFD)'="") S (PSGNEFD,PSGFD)=TMPNEFD,PSGFDN=$$ENDD^PSGMI(PSGNEFD)_U_$$ENDTC^PSGMI(PSGNEFD)
 .S PSGOFD=$P(^PS(55,PSGP,5,+PSGORD,2),"^",4),PSGOEENO=1,PSJOCL=+$G(^PS(55,PSGP,5,+PSGORD,8))
 .W !,"START DATE/TIME: ",$$ENDD^PSGMI(PSGSD) D A34^PSJCLOR4
 .S PSJNOO=$$ENNOO^PSJUTL5("E") I PSJNOO<0 W "    No changes made to this order!" D CONT^PSJOE0 Q
 .N PSJOCL,PSGOEENO S PSGOEENO=1,PSJOCL=+$G(^PS(55,PSGP,5,+PSGORD,8))
 .D NEW^PSGOEE
 .Q
 ;
 I PSGORD["P"  D
 .N DR,PSJTMPFD,P S DR="10////^S X=PSGSD;" S:$G(PSGOEEF(25)) DR=DR_"25////^S X=PSGFD;" S DR=DR_"W ""."";"
 .S PSJTMPFD=PSGFD
 .D GETUD^PSJLMGUD(PSGP,PSGORD) N PSGNESD,PSGPDRG,PSJOCL S PSGPDRG=PSGPD,PSJOCL=+$G(^PS(53.1,+PSGORD,"DSS")) S:$G(PSGOEEF(25)) (PSGNEFD,PSGFD)=PSJTMPFD,PSGFDN=$$ENDD^PSGMI(PSGNEFD)_U_$$ENDTC^PSGMI(PSGNEFD)
 .Q:'$G(PSJOCL)  S PSGS0Y=PSGAT,(PSGNESD,PSGSD)=PSGNWSD,PSGPDRG=PSGPD,PSGPDRGN=PSGPDN,PSGOEE="E"
 .W !,"START DATE/TIME: ",$$ENDD^PSGMI(PSGSD) D A25NV^PSJCLOR4
 .N PSGOEENO S PSGOEENO=0 D UPD^PSGOEE
 .D EN1^PSJHL2(PSGP,"XX",PSGORD)
 ;
 I PSGORD["V" D
 .N ON55,ND,ND2,ND0,PSIVCHG,PSIVSYSP,P,PSJSTRDF,PSJSTPDF,PSJINIV S PSGOEEWF="^PS(55,"_PSGP_",""IV"","_+PSGORD_",",PSIVCHG=1
 .I '$G(XQORNOD),$G(PSJTMPXQ) N XQORNOD S XQORNOD=PSJTMPXQ
 .S XQORNOD(0)="^^E"
 .S PSJSYSW0=$G(PSJSYSW0) ; Initialize/restore PSJSYSW0 ward parameters. Killed at exit in ENKV^PSGSETU.
 .I $G(PSGOEAV),'$P(PSJSYSP0,U,9) S PSIVSYSP=PSJSYSP0 N PSJSYSP0 S PSJSYSP0=PSIVSYSP,$P(PSJSYSP0,"^",9)=1
 .S (ND,ND0)=$G(@(PSGOEEWF_"0)")),ND2=$G(^(2)),ON55=PSGORD
 .D GT55^PSIVORFB S P(2)=PSGNWSD D ENSTOP^PSIVCAL
 .W !,"START DATE/TIME: ",$$ENDD^PSGMI(P(2))
 .D A25V^PSJCLOR4(PSGP,PSGORD)
 .D NEWORD^PSIVOPT1
 .S PSJORL=$$ENORL^PSJUTL($G(VAIN(4))) S ON=ON55,OD=P(2) D:ON["V" EN^PSIVORE D EN1^PSJHL2(DFN,"SN",ON55,"NEW ORDER")
 .N TMPOLD S TMPOLD=$S(ON55["P":$P($G(^PS(53.1,+ON55,0)),"^",25),ON55["V":$P($G(^PS(55,PSGP,"IV",+ON55,2)),"^",5),1:"") I TMPOLD D
 ..I TMPOLD["V",$D(^PS(55,PSGP,"IV",+TMPOLD,10,1)) N LN S LN=+$O(^PS(55,PSGP,"IV",+TMPOLD,10,""),-1) D
 ...S:ON55["P" ^PS(53.1,+ON55,16,0)="^53.1136^"_LN_"^"_LN S:ON55["V" ^PS(55,PSGP,"IV",+ON55,10,0)="^55.1154^"_LN_"^"_LN
 ...S LN=0 F  S LN=$O(^PS(55,PSGP,"IV",+TMPOLD,10,LN)) Q:'LN  S:ON55["P" ^PS(53.1,+ON55,16,LN,0)=^PS(55,PSGP,"IV",+TMPOLD,10,LN,0) S:ON55["V" ^PS(55,PSGP,"IV",+ON55,10,LN,0)=^PS(55,PSGP,"IV",+TMPOLD,10,LN,0)
 .;
 I $G(PSJFSI)=1 I $$GETSI^PSJBCMA5(DFN,PSGORD) D FILESI^PSJBCMA5(DFN,$S($G(PSGOORD):PSGOORD,1:PSGORD))
 I 'PSGOEAV,($G(PSGORD)["P"),'$G(^PS(53.1,+PSGORD,2.5)),$G(^PS(53.1,+PSGORD,0)) D
 . N DUR S DUR=$$GETDUR^PSJLIVMD(PSGP,PSGORD,$S(PSGORD["P":"P",1:5),1) I DUR]"" K DA,DR,DIE S DIE="^PS(53.1,",DA=+PSGORD,DR="116////"_DUR D ^DIE
 D NEWCLN^PSJCLOR5
 D UNL^PSSLOCK(PSGP,PSGORD) I $G(PSGOORD) D UNL^PSSLOCK(PSGP,PSGOORD)
 Q
 ;
DSPORD(PSGP,TMPORDER,PSJORDAR) ; Display order summary
 D DSPORD^PSJCLOR5(PSGP,TMPORDER,.PSJORDAR)
 Q
 ;
HDRDT ; Header Date Range
 Q:'$G(PSJBEG)!'($G(PSJEND))  I $G(PSJTMPED),$P(PSJTMPED,"^",2) S PSJEND=$S($P(PSJTMPED,"^",2)'=$G(PSGP):+PSJTMPED,1:+PSJEND)
 S VALMHDR(6)="          CLINIC ORDERS: "_$$FMTE^XLFDT(+$G(PSJBEG))_" to "_$$FMTE^XLFDT(+$G(PSJEND))
 Q
 ;
CHGDT ; Change date range
 N TMPBEG,TMPEND S TMPBEG=+PSJBEG,TMPEND=+PSJEND
 D BEGDT I '$G(PSJBEG) S PSJBEG=+TMPBEG
 D ENDDT(PSJBEG) I '$G(PSJEND) S PSJEND=+TMPEND
 D INIT^PSJCLOR2(3) S VALMBCK="R" D HDR^PSJLMHED($S($G(DFN):DFN,1:$G(PSGP))) D HDRDT^PSJCLOR2
 Q
BEGDT ; begin date
 I '$G(PSJTMPBG) S PSJTMPBG=+PSJBEG_"^"_PSGP
 W !!?5,"Search for CLINIC Medication Orders with a Start Date/Time"
 W !?5,"within the date range selected below: "
 W ! K %DT S %DT("A")="Begin Search Date: ",%DT="TAE",%DT("B")=$P($$FMTE^XLFDT(PSJBEG,1),"@")
 D ^%DT Q:Y<0!($D(DTOUT))  S (%DT(0),PSJBEG)=Y
 Q
ENDDT(BEG) ; end date
 I $G(BEG) S $P(BEG,".",2)=24
 I '$G(PSJTMPED) S PSJTMPED=+PSJEND_"^"_PSGP
 W ! K DIR S DIR(0)="DA^"_BEG_"::TAE",DIR("A")="End Search Date: ",DIR("B")=$$FMTE^XLFDT(BEG) D ^DIR
 S PSJEND=$S($G(Y):Y,1:BEG) I '$P(PSJEND,".",2) S PSJEND=Y_".24"
 Q
