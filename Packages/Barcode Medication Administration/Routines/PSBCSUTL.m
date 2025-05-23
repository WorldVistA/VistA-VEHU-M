PSBCSUTL ;BIRMINGHAM/TEJ- BCMA-HSC COVER SHEET UTILITIES ;03/06/16 3:06pm
 ;;3.0;BAR CODE MED ADMIN;**16,13,38,32,50,60,58,68,70,80,83,106**;Mar 2004;Build 43
 ;Per VHA Directive 2004-038 (or future revisions regarding same), this routine should not be modified.
 ;
 ; Reference/IA
 ; EN^PSJBCMA/2828
 ; IN5^VADPT/10061
 ; $$GET^XPAR/2263
 ; ^%DTC/10000
 ; $$FMADD^XLFDT/10103
 ; $$GET1^DIQ/2056
 ; EN1^GMVDCEXT/4251
 ; GETPROVL^PSGSICH1/5653
 ; INTRDIC^PSGSICH1/5654
 ;
 ;*58 - add 30th piece to Results for Override/Intervention flag 1/0
 ;*68 - add new parameter to use new SI/OPI word processing fields
 ;*70 - add Clinic order request IN param flag (true/false 0/1).
 ;      also add to return array ORD line 32 piece Clinic name for CO.
 ;      for CO mode: set to -7 days for pulling pull meds & viewing
 ;       Expired/DC'd orders; set to +7 days to view future orders.
 ;*83 - call new PSBVDLRM, new call FIXADM^PSBUTL for Inserting G
 ;      action code in Results back to coversheet to trigger Removal.
 ;*106- add Hazardous to Handle & Dispose flags 36 & 37
 ;
 ; ** Warning: PSBSIOPI & PSBCLINORD will be used as global variables
 ;
RPC(RESULTS,DFN,EXPWIN,PSBSIOPI,PSBCLINORD) ;
 N PSBONVDL  ;*83 used by psbvdlpa & psbvdlrm
 K RESULTS,^TMP("PSB",$J),^TMP("PSJ",$J)
 S EXPWIN=+$G(EXPWIN)       ;*70
 S PSBSIOPI=+$G(PSBSIOPI)   ;*68 init to 0 if not present or 1 if sent
 S PSBCLINORD=+$G(PSBCLINORD)                   ;*70 init to 0 if null
 S PSBTAB="CVRSHT"
 N PSBCNT S PSBTRFL=0,PSBDFNX=DFN
 D PAINCMT(DFN) ;;Correct Comment if Pain Score entered in BCMA was marked "Entered in Error" in Vitals. (PSB*3*50)
 S RESULTS=$NAME(^TMP("PSB",$J,PSBTAB))
 K ^TMP("PSB",$J,PSBTAB) S ^TMP("PSB",$J,PSBTAB,0)=1 D LIGHTS(PSBDFNX)
 S ^TMP("PSB",$J,PSBTAB,0)=1,^TMP("PSB",$J,PSBTAB,1)=^TMP("PSB",$J,PSBTAB,1)
 Q:$P(^TMP("PSB",$J,PSBTAB,1),U,4)=-1
 D NOW^%DTC S PSBNOW=+$E(%,1,10),PSBDT=$P(%,".",1)
 ;set range
 ;*70 - use diff window values for CO mode vs IM mode
 I PSBCLINORD D
 . S:'EXPWIN EXPWIN=24*7   ;not passed in def to 7 days
 . S PSBWBEG=$P($$FMADD^XLFDT(PSBNOW,-EXPWIN\24),".")
 . S PSBWEND=$P($$FMADD^XLFDT(PSBNOW,EXPWIN\24),".")
 E  D
 . S:'EXPWIN EXPWIN=24   ;not passed in def to 24 hr
 . S PSBWBEG=$$FMADD^XLFDT(PSBNOW,"",-EXPWIN)
 . S PSBWEND=$$FMADD^XLFDT(PSBNOW,"",EXPWIN)
 ;
 S PSBWADM=$$GET^XPAR("DIV","PSB ADMIN BEFORE"),PSBMHBCK=$$GET^XPAR("ALL","PSB MED HIST DAYS BACK",,"B") I +PSBMHBCK=0 S PSBMHBCK=30
 D NOW^%DTC S PSBWADM=$$FMADD^XLFDT(%,"","",+PSBWADM),PSBMHBCK=$$FMADD^XLFDT(%,-1*(PSBMHBCK))
 ;use lst movemnt for API
 S VAIP("D")="LAST" D IN5^VADPT S PSBTRDT=+VAIP(3),PSBTRTYP=$P(VAIP(2),U,2),PSBMVTYP=$P(VAIP(4),U,2) K VAIP
 S PSBPTTR=$$GET^XPAR("DIV","PSB PATIENT TRANSFER") I PSBPTTR="" S PSBPTTR=72
 D NOW^%DTC S PSBNTDT=$$FMADD^XLFDT(%,"",-PSBPTTR) I PSBNTDT'>PSBTRDT S PSBTRFL=1
 ;*70  go back 7 days to pull meds for clinic orders
 S X1=$P(PSBNOW,"."),X2=$S(PSBCLINORD:-7,1:-3) D C^%DTC
 D EN^PSJBCMA(PSBDFNX,X,$S(PSBMHBCK<PSBWBEG:PSBMHBCK,PSBWBEG<PSBMHBCK:PSBWBEG,1:PSBMHBCK))
 ;Filter in/out Clinic Orders               *70
 D:PSBCLINORD
 . I $D(PSBRPT(2)) D FILTERCO^PSBO Q
 . D INCLUDCO^PSBVDLU1
 D:'PSBCLINORD REMOVECO^PSBVDLU1
 ;Devlop Outp
 S PSBTBOUT=0
 I ^TMP("PSJ",$J,1,0)>0 F PSBX=0:0 S PSBX=$O(^TMP("PSJ",$J,PSBX)) Q:('PSBX)!(PSBTBOUT)  D
 .S:(PSBTAB'="CVRSHT")&($G(^TMP("PSB",$J,"CVRSHT",2))>0) PSBTBOUT=1
 .D CLEAN^PSBVT,PSJ^PSBVT(PSBX),NOW^%DTC
 .Q:PSBONX["P"  Q:(PSBOSP<PSBWBEG)&'(PSBONX["V")  ;in rnge?
 .S (PSBREC,PSBONTAB)=""
 .S $P(PSBREC,U,1)=PSBDFN ;Dfn
 .S $P(PSBREC,U,2)=PSBONX ;OrdX 
 .S $P(PSBREC,U,3)=PSBON ;Ord#
 .S $P(PSBREC,U,4)=PSBOTYP ;v/u/p
 .S $P(PSBREC,U,5)=PSBSCHT ;Schtyp
 .S $P(PSBREC,U,6)=PSBSCH ;Sch
 .S $P(PSBREC,U,7)=$S(PSBHSM:"HSM",PSBSM:"SM",1:"") ; slfmed
 .S $P(PSBREC,U,8)=PSBOITX ;Drgnm
 .S $P(PSBREC,U,9)=PSBDOSE_" "_PSBIFR ;Dose
 .S $P(PSBREC,U,10)=PSBMR ;med route
 .;Lst Gvn -AOIP xRef
 .S (PSBCNT,PSBFLAG)=0,(Y,PSBSTUS)="" K PSBHSTA,PSBHSTAX
 .F XZ=1:1:20 S Y=$O(^PSB(53.79,"AOIP",PSBDFN,PSBOIT,Y),-1),(PSBCNT,PSBFLAG)=0 Q:Y=""  D
 ..S:Y>0 $P(PSBREC,U,11)=Y
 ..S X="" F  S X=$O(^PSB(53.79,"AOIP",PSBDFN,PSBOIT,Y,X),-1) Q:X=""  D
 ...S PSBSTUS=$P(^PSB(53.79,X,0),U,9) S:$G(PSBSTUS)="" PSBSTUS="X" I (PSBSTUS'="N") S PSBFLAG=1,PSBHSTA(Y,$G(PSBSTUS))="ORIG"_U_X
 ...D:PSBSTUS="N"
 ....S ($P(PSBREC,U,11),Z)=""
 ....F  S Z=$O(^PSB(53.79,X,.9,Z),-1) Q:'Z  Q:PSBFLAG=1  S PSBDATA=$G(^(Z,0)) D
 .....I (PSBDATA["Set to 'NOT GIVEN'")!(PSBDATA["Set to 'GIVEN'")!(PSBDATA["Set to 'REFUSED'")!(PSBDATA["Set to 'HELD'")!(PSBDATA["Set to 'MISSING DOSE'")!(PSBDATA["Set to 'REMOVED'") S PSBCNT=PSBCNT+1
 .....I (PSBDATA["STATUS 'HELD'")!(PSBDATA["STATUS 'GIVEN'")!(PSBDATA["STATUS 'REFUSED'")!(PSBDATA["STATUS 'MISSING DOSE'")!(PSBDATA["STATUS 'REMOVED'") S PSBCNT=PSBCNT+1
 .....I PSBCNT#2=0,PSBDATA["'REFUSED'" S PSBSTUS="R" D LAST^PSBVDLU1
 .....I PSBCNT#2=0,PSBDATA["'HELD'" S PSBSTUS="H" D LAST^PSBVDLU1
 .....I PSBCNT#2=0,PSBDATA["'MISSING DOSE'" S PSBSTUS="M" D LAST^PSBVDLU1
 .....I PSBCNT#2=0,PSBDATA["'REMOVED'" S PSBSTUS="RM" D LAST^PSBVDLU1
 .....I PSBFLAG=1,'$D(PSBHSTA($P(PSBREC,U,11),$G(PSBSTUS))) S PSBHSTA($P(PSBREC,U,11),$G(PSBSTUS))=Z_U_X
 .I $D(PSBHSTA) S $P(PSBREC,U,11)=$O(PSBHSTA(""),-1),PSBSTUS=$O(PSBHSTA($P(PSBREC,U,11),""),-1) M PSBHSTAX(PSBOIT)=PSBHSTA K PSBHSTA  ;last action date/time
 .S $P(PSBREC,U,12)="" ;ien - below
 .S $P(PSBREC,U,13)="" ;sttus - below
 .S $P(PSBREC,U,14)="" ;admn dte - below
 .S $P(PSBREC,U,15)=PSBOIT ;OI Pointer
 .S $P(PSBREC,U,16)=PSBNJECT  ;njctble med route flag
 .;Var dosg
 .I $P(PSBREC,U,9)?1.4N1"-"1.4N.E S $P(PSBREC,U,17)=1
 .E  S $P(PSBREC,U,17)=0
 .S:PSBDOSEF?1"CAP".E!(PSBDOSEF?1"TAB".E)!(PSBDOSEF="PATCH") $P(PSBREC,U,18)=PSBDOSEF ;DosgFrm
 .D PSJ1^PSBVT(PSBDFN,PSBONX)
 .S PSBPB=$$IVPTAB^PSBVDLU3(PSBOTYP,PSBIVT,PSBISYR,PSBCHEMT,+$G(PSBIVPSH)),PSBLVIV=0
 .Q:PSBPB&(PSBOSP<PSBWBEG)
 .S:(PSBONX["V"&'PSBPB) PSBLVIV=1
 .S $P(PSBREC,U,19)=$S(PSBVNI]"":PSBVNI,PSBVNI']"":"***") ;VerfNrsInts
 .S $P(PSBREC,U,20)=PSBSTUS S:$P(PSBREC,U,11)="" $P(PSBREC,U,20)=""  ;LstActn
 .S $P(PSBREC,U,21)=PSBOST
 .S $P(PSBREC,U,22)=PSBOSTS
 .S $P(PSBREC,U,25)=0 I $G(PSBTRFL),$P(PSBREC,U,11)]"",$P(PSBREC,U,11)'<$G(PSBNTDT),$P(PSBREC,U,11)'>$G(PSBTRDT) S $P(PSBREC,U,25)=1
 .S $P(PSBREC,U,26)=PSBOSP  ;OrdStpDt/Tm
 .S $P(PSBREC,U,27)=$$LASTG($P(PSBREC,U,1),$P(PSBREC,U,15))
 .S $P(PSBREC,U,28)=$S((PSBONX["U")&('PSBPB):1,PSBPB:2,(PSBONX["V")&'PSBPB:3,1:"")
 .;*58 determine if override exists, send 1/0 (true/false)
 .N PSBARR D GETPROVL^PSGSICH1(DFN,PSBONX,.PSBARR)
 .I $O(PSBARR(""))="" D INTRDIC^PSGSICH1(DFN,PSBONX,.PSBARR,2)
 .S $P(PSBREC,U,29)=$S($O(PSBARR(""))]"":1,1:0)
 .;*70 add Clinic name & ien ptr to piece 32 and 33 for CO's, remember
 .;   "ORD" is inserted later as piece 1 which offsets all here by +1
 .S $P(PSBREC,U,31)=$G(PSBCLORD)
 .S $P(PSBREC,U,32)=$G(PSBCLIEN)
 .;       piece 34-35 reserved for Remove meds and set by PSBVDLU1
 .S $P(PSBREC,U,36)=$G(PSBHAZHN)  ;Hazardous to Handle    *106
 .S $P(PSBREC,U,37)=$G(PSBHAZDS)  ;Hazardous to Dispose   *106
 .;get all Admn(s) - DD info.
 .S (PSBDDS,PSBSOLS,PSBADDS,PSBFLAG)="0"
 .;PSB*3*60 adds additional checks to ensure an expired order is within the coversheet time parameter and an "END" is only added to the temp global after an order is added
 .I PSBLVIV D XFERBAGS^PSBCSUTY,LVIV^PSBCSUTY I $G(PSBEXPRD) S X1=$O(^TMP("PSB",$J,PSBTAB,""),-1) S:^TMP("PSB",$J,PSBTAB,X1)'="END"&(X1>1) ^TMP("PSB",$J,PSBTAB,X1+1)="END" Q  ;PSB*3*60
 .D GETADMX^PSBCSUTY
 .F Y=0:0 S Y=$O(PSBDDA(Y)) Q:'Y  D
 ..I $P(PSBDDA(Y),U,5)=$P(%,".") S PSBFLAG=1  ;drug nactvt
 ..Q:$P(PSBDDA(Y),U,5)&($P(PSBDDA(Y),U,5)<%)  ;nactv
 ..S:$P(PSBDDA(Y),U,4)="" $P(PSBDDA(Y),U,4)=1
 ..S PSBDDS=PSBDDS_U_$P(PSBDDA(Y),U,1,4),$P(PSBDDS,U,1)=PSBDDS+1
 .;OnCa O PRN
 .I ("^O^OC^P^"[(U_PSBSCHT_U))!(PSBLVIV) D  S ($P(PSBREC,U,12),$P(PSBREC,U,14))=""  Q
 ..S (PSBIENX,PSBGOT1)="",PSBADMTM="" F  S PSBADMTM=$O(^PSB(53.79,"AORDX",PSBDFNX,PSBONX,PSBADMTM)) Q:(PSBADMTM="")  D
 ...Q:(PSBADMTM<PSBMHBCK)&'PSBLVIV
 ...F  S PSBIENX=$O(^PSB(53.79,"AORDX",PSBDFNX,PSBONX,PSBADMTM,PSBIENX)) Q:PSBIENX=""  D
 ....S $P(PSBREC,U,12)=PSBIENX,$P(PSBREC,U,14)=PSBADMTM,$P(PSBREC,U,23)=$$GET1^DIQ(53.79,PSBIENX_",","IV UNIQUE ID")
 ....S PSBQRR=1 I PSBWBEG<PSBOSP D ADD^PSBVDLU1(PSBREC,PSBOTXT,PSBADMTM,PSBDDS,PSBSOLS,PSBADDS,"CVRSHT") S PSBGOT1=1 ;PSB*3*60
 ..I ('+PSBGOT1)&(PSBOSP'<PSBWBEG) D ADD^PSBVDLU1(PSBREC,PSBOTXT,PSBNOW\1_".",PSBDDS,PSBSOLS,PSBADDS,"CVRSHT") S PSBGOT1=1
 ..I ('+PSBGOT1)&($D(PSBADMX(PSBONX)))&(PSBWBEG<PSBOSP) D ADD^PSBVDLU1(PSBREC,PSBOTXT,PSBNOW\1_".",PSBDDS,PSBSOLS,PSBADDS,"CVRSHT") ;PSB*3*60
 ..S PSBGLBX=$O(^TMP("PSB",$J,PSBTAB,""),-1) S:^TMP("PSB",$J,PSBTAB,PSBGLBX)'="END"&(PSBGLBX>1) ^TMP("PSB",$J,PSBTAB,PSBGLBX+1)="END" ;PSB*3*60
 .;cont - proces AdmnTm
 .S (PSBYES,PSBODD,PSBYTF)=0 S:$$PSBDCHK1^PSBVT1(PSBSCH) PSBYES=1
 .I PSBYES,PSBADST="" Q
 .F I=1:1 Q:$P(PSBSCH,"-",I)=""  I $P(PSBSCH,"-",I)?2N!($P(PSBSCH,"-",I)?4N) S PSBYES=1,PSBYTF=1
 .I PSBSCHT="C",PSBYTF="1",PSBADST="" Q
 .S PSBFREQ=$$GETFREQ^PSBVDLU1(DFN,PSBONX)
 .I PSBFREQ="O" S PSBFREQ=1440
 .I PSBFREQ="D" S PSBFREQ=""
 .S:PSBLVIV PSBYES=1
 .I 'PSBYES,PSBFREQ<1 Q
 .I (PSBADST="")&(+PSBFREQ>0) D ODDSCH^PSBVDLU1(PSBTAB) Q
 .I +PSBFREQ>0 I (PSBFREQ#1440'=0),(1440#PSBFREQ'=0) S PSBODD=1
 .I PSBODD,PSBADST'="" Q
 .S PSBDTX=PSBWBEG\1,PSBGOT1=0
 .F PSBXX=1:1:2 D  S PSBDTX=$$FMADD^XLFDT(PSBDTX,"",24)  ;incrmnt 1 day!
 ..F PSBY=1:1:$L(PSBADST,"-") Q:$P(PSBADST,"-",PSBY)=""  D
 ...S PSB=+(PSBDTX_"."_$P(PSBADST,"-",PSBY))
 ...I (PSB'<PSBWBEG)&(PSB'>PSBWEND) D  ;wndow?
 ....D:(PSB'<PSBOST)&(PSB<PSBOSP)    ;actv?
 .....D:$$OKAY^PSBVDLU1(PSBOST,PSB,PSBSCH,PSBONX,PSBOITX,PSBFREQ,PSBOSTS)  ;dt?
 ......D ADD^PSBVDLU1(PSBREC,PSBOTXT,PSB,PSBDDS,PSBSOLS,PSBADDS,"CVRSHT") S PSBGOT1=1
 ...S PSB=+(PSBWEND\1_"."_$P(PSBADST,"-",PSBY))
 ...I (PSB'<PSBWBEG)&(PSB'>PSBWEND) D  ;wndow?
 ....D:(PSB'<PSBOST)&(PSB<PSBOSP)    ;actv?
 .....D:$$OKAY^PSBVDLU1(PSBOST,PSB,PSBSCH,PSBONX,PSBOITX,PSBFREQ,PSBOSTS)  ;dt?
 ......D ADD^PSBVDLU1(PSBREC,PSBOTXT,PSB,PSBDDS,PSBSOLS,PSBADDS,"CVRSHT") S PSBGOT1=1
 .I ('PSBGOT1)&(PSBOSP'<PSBWBEG) D ADD^PSBVDLU1(PSBREC,PSBOTXT,+(PSBWEND\1_"."_$P(PSBADST,"-")),PSBDDS,PSBSOLS,PSBADDS,"CVRSHT")
 .K PSBSTUS
 D EN^PSBVDLPA
 D EN^PSBVDLRM    ;*83 new rtn
 I $G(^TMP("PSB",$J,PSBTAB,2))]"" S PSBI1=$O(^TMP("PSB",$J,PSBTAB,""),-1) I ^TMP("PSB",$J,PSBTAB,PSBI1)'="END" S ^TMP("PSB",$J,PSBTAB,PSBI1+1)="END"
 S ^TMP("PSB",$J,PSBTAB,0)=$O(^TMP("PSB",$J,PSBTAB,""),-1)
 I $G(^TMP("PSB",$J,PSBTAB,2))']"" S $P(^TMP("PSB",$J,PSBTAB,1),U,4)="-1^No orders to display on Coversheet"     ;*70 was "To" now "to"
 I $G(^TMP("PSB",$J,PSBTAB,2))]"" S $P(^TMP("PSB",$J,PSBTAB,1),U,4)="1^COVERSHEET DATA FOLLOWS" D ADD^PSBCSUTX
 D FIXADM^PSBUTL                                                  ;*83
 D CLEAN
 Q
LASTG(PSBPATPT,PSBOIPT) ;LstGvn-(inpt: DFN,OrItm IEN)
 K PSBHSTG S Y="",LASTG="" F XZ=1:1:20 S Y=$O(^PSB(53.79,"AOIP",PSBPATPT,PSBOIPT,Y),-1),(PSBCNT,PSBFLAG)=0 Q:Y=""  D
 .S:Y>0 LASTG="",X="" F  S X=$O(^PSB(53.79,"AOIP",PSBPATPT,PSBOIPT,Y,X),-1) Q:X=""  D
 ..S PSBSTX=$P(^PSB(53.79,X,0),U,9) S:PSBSTX']"" PSBHSTG(Y)=-1 I PSBSTX="G"  S PSBHSTG(Y)="G"
 ..Q:PSBSTX="N"
 ..D:(PSBSTX'="G")
 ...S Z="" F  S Z=$O(^PSB(53.79,X,.9,Z),-1) Q:'Z  Q:PSBFLAG=1  S PSBDATA=$G(^(Z,0)) D
 ....I (PSBDATA["Set to 'GIVEN'") S PSBCNT=PSBCNT+1
 ....I (PSBDATA["STATUS 'GIVEN'") S PSBCNT=PSBCNT+1
 ....I PSBCNT#2=0,PSBDATA'["'GIVEN'" Q
 ....I '$D(PSBHSTG($P(PSBDATA,U))) S PSBFLAG=1,PSBHSTG($P(PSBDATA,U))=""
 I $D(PSBHSTG) S LASTG="" F  S LASTG=$O(PSBHSTG(LASTG),-1) Q:+LASTG=0  Q:PSBHSTG(LASTG)="G"  I PSBHSTG(LASTG)=-1 S LASTG="" Q
 Q LASTG
PAINCMT(DFN) ;;Add comment if Pain Score entered in BCMA was marked "Entered in Error" in Vitals.
 ;;This will run through all the patients appointments, check their comments to see if they had a Pain Vital entered  through BCMA, and check if that Vital was marked "Entered in Error."
 Q:'$D(^DPT(DFN,0))
 N PSBCMT,PSBGMR,PSBCMTGLB,PSBIEN,PSBCMTM,PSBVITM,PSBTMDF,PSBBDT,PSBEDT,PSBEFTM,PSBCMFL,PSBEXTM,PSBERFL,PSBPNSC,PSBNOW,PSBDFN,PSBPRNDT,PSBSTRTDT,PSBMDHST,PSBEFFL,PSBCOMMENT,X,X1,X2,PSBDUZ,PSBPAIN
 K ^TMP("PSBGMV",$J)
 D NOW^%DTC S PSBEDT=%
 S PSBMDHST=+($$GET^XPAR("ALL","PSB MED HIST DAYS BACK",,"B")) S:+$G(PSBMDHST)=0 PSBMDHST=30
 S X1=$P(PSBEDT,"."),X2=-(PSBMDHST) D C^%DTC S PSBMDHST=X
 S PSBSTRTDT=$S($G(PSBSTRT)]0:PSBSTRT,1:PSBMDHST)
 S PSBPRNDT=PSBSTRTDT F  S PSBPRNDT=$O(^PSB(53.79,"APRN",DFN,PSBPRNDT)) Q:'PSBPRNDT  D
 .S PSBIEN=0 F  S PSBIEN=$O(^PSB(53.79,"APRN",DFN,PSBPRNDT,PSBIEN)) Q:'PSBIEN  D
 ..S PSBCMT=0 F  S PSBCMT=$O(^PSB(53.79,PSBIEN,.3,PSBCMT)) Q:'PSBCMT  S PSBCMTGLB=^PSB(53.79,PSBIEN,.3,PSBCMT,0) D
 ...I $P($G(PSBCMTGLB),U)["Pain Score of" S PSBPAIN=$E($P(PSBCMTGLB,U),15) D
 ....I $E($P($G(PSBCMTGLB),U),1,14)="*Pain Score of" S PSBCMFL=""
 ....I $E($P($G(PSBCMTGLB),U),1,15)="**Pain Score of" S PSBEFFL=""
 ....S PSBCMTM=$P($G(PSBCMTGLB),U,3)
 ....S PSBBDT=$E(PSBCMTM,1,12)
 ....S PSBEXTM=$$FMTE^XLFDT(PSBBDT,"5Z")
 ....I '$D(^TMP("PSBGMV",$J)) D EN1^GMVDCEXT("^TMP(""PSBGMV"",$J)",DFN,2,,1,PSBSTRTDT,PSBEDT,,1)
 ....S PSBGMR=0 F  S PSBGMR=$O(^TMP("PSBGMV",$J,PSBGMR)) Q:PSBGMR=""  I $P(^TMP("PSBGMV",$J,PSBGMR),U,4)="PN" D
 .....S PSBVITM=$P(^TMP("PSBGMV",$J,PSBGMR),U,5)
 .....S PSBTMDF=$$FMDIFF^XLFDT(PSBVITM,PSBCMTM,2)
 .....I PSBTMDF>=-($S($G(DILOCKTM)>0:DILOCKTM,1:3)),PSBTMDF<=$S($G(DILOCKTM)>0:DILOCKTM,1:3) S PSBDUZ=$P(^TMP("PSBGMV",$J,PSBGMR),U,10) D  ;User who marked Pain Score Entered in error, PSB*3*80
 ......I $P(^TMP("PSBGMV",$J,PSBGMR),U,9)=1 S PSBPNSC=$P(^TMP("PSBGMV",$J,PSBGMR),U,8),PSBERFL="" D
 .......I $D(PSBERFL),'$D(PSBCMFL),$G(PSBDUZ),PSBPAIN=PSBPNSC D
 ........S PSBCOMMENT="*Pain Score of "_PSBPNSC_" entered in Vitals via BCMA at "_PSBEXTM_" may have been marked 'Entered in Error'. See Vitals Package for an updated Score." D PNCMNT(PSBIEN,PSBCOMMENT,PSBDUZ) S PSBCMFL=""
 ..K PSBCMFL,PSBERFL
 ..S PSBEFTM=$P($G(^PSB(53.79,PSBIEN,.2)),U,4) Q:PSBEFTM=""
 ..S PSBBDT=$E(PSBEFTM,1,12),PSBPAIN=$E($P(^PSB(53.79,PSBIEN,.2),U,2),15)
 ..S PSBEXTM=$$FMTE^XLFDT(PSBBDT,"5Z")
 ..D:'$D(^TMP("PSBGMV",$J)) EN1^GMVDCEXT("^TMP(""PSBGMV"",$J)",DFN,2,,1,PSBSTRTDT,PSBEDT,,1)
 ..S PSBGMR=0 F  S PSBGMR=$O(^TMP("PSBGMV",$J,PSBGMR)) Q:PSBGMR=""  I $P(^TMP("PSBGMV",$J,PSBGMR),U,4)="PN" D
 ...S PSBVITM=$P(^TMP("PSBGMV",$J,PSBGMR),U,5)
 ...S PSBTMDF=$$FMDIFF^XLFDT(PSBVITM,PSBEFTM,2)
 ...I PSBTMDF>=-($S($G(DILOCKTM)>0:DILOCKTM,1:3)),PSBTMDF<=$S($G(DILOCKTM)>0:DILOCKTM,1:3)  S PSBDUZ=$P(^TMP("PSBGMV",$J,PSBGMR),U,10) D  ;User who marked Pain Score Entered in error, PSB*3*80
 ....I $P(^TMP("PSBGMV",$J,PSBGMR),U,9)=1 S PSBPNSC=$P(^TMP("PSBGMV",$J,PSBGMR),U,8),PSBERFL="" D
 .....I $D(PSBERFL),'$D(PSBEFFL),$G(PSBDUZ),PSBPAIN=PSBPNSC D
 ......S PSBCOMMENT="**Pain Score of "_PSBPNSC_" entered in Vitals via BCMA at "_PSBEXTM_" may have been marked 'Entered in Error'. See Vitals Package for an updated Score." D PNCMNT(PSBIEN,PSBCOMMENT,PSBDUZ) S PSBEFFL=""
 ..K PSBERFL,PSBEFFL
 K ^TMP("PSBGMV",$J)
 Q
PNCMNT(DA,PSBCMT,PSBDUZ) ;Add pain score comment, PSB*3*80
 N PSBFDA,PSBIEN,PSBNOW
 S PSBIEN="+1,"_DA_","
 D NOW^%DTC S PSBNOW=%
 D VAL^PSBML(53.793,PSBIEN,.01,PSBCMT)
 S PSBFDA(53.793,PSBIEN,.02)=PSBDUZ
 S PSBFDA(53.793,PSBIEN,.03)=PSBNOW
 D FILEIT^PSBML
 Q
LIGHTS(PSBDFN) ;
 D RPC^PSBVDLTB(,PSBDFN,"NO TAB",,PSBSIOPI,PSBCLINORD) S PSBTAB="CVRSHT"
 M ^TMP("PSB",$J,PSBTAB,1)=^TMP("PSB",$J,"NO TAB",1) K ^TMP("PSB",$J,"NO TAB")
 Q
CLEAN ;
 D CLEAN^PSBVT
 K PSBACT,PSBACTBY,PSBACTDT,PSBACTPT,PSBADDS,PSBBAGID,PSBCHDT,PSBCHKV,PSBCNT1,PSBCNT2,PSBDDS,PSBDFNX,PSBWEND
 K PSBDT,PSBFLAG,PSBHSTAX,PSBI1,PSBIEN,PSBIENX,PSBLSTS,PSBMAUD,PSBMVTYP,PSBMWC,PSBNOW,PSBNTDT,PSBONMBR,PSBY,PSBXX
 K PSBONXS,PSBORREC,PSBPDT,PSBPRNRE,PSBPTTR,PSBQR,PSBRDOW,PSBREC,PSBRECHD,PSBSCHBR,PSBSCHTM,PSBSOLS,PSBTAB,PSBADMTM,PSBDTX
 K PSBTBOUT,PSBTRDT,PSBTRFL,PSBTRTYP,PSBUID,PSBUIDS,PSBX,PSBXIEN,PSBX2,PSBYEA,PSBYEA1,PSBYTF,PSBYES,VAIP,PSBWADM,PSBWBEG
 K PSBXREC,PSBGOT1,PSBCDT,PSBQUIT,PSBUSED,PSBLST4X,PSBADMX,PSBI2,PSBXXX,PSBI,PSBPB,PSBSHWTB,PSBONTAB,PSBDONE,^TMP("PSJ",$J)
 K PSBNXTDU,LASTG,LSTTIME,PSBMHBCK,PSBHSTG,PSBNXTDT,NEXTADM,PSBLVIV
 K PSBHAZ,PSBHAZHN,PSBHAZDS   ;*106
 Q
