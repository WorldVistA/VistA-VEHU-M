PSOLLL7 ;BHAM/JLC - LASER LABEL MULTI RX REFILL REQUEST FORM ;08/23/17  20:04
 ;;7.0;OUTPATIENT PHARMACY;**120,161,200,326,441**;DEC 1997;Build 209
 ;
 ;Reference to ^PS(59.7 supported by DBIA 694
 ;Reference to ^PS(55 supported by DBIA 2228
 ;Read-only reference to %ZIS(2 supported by DBIA 3435
 ;
EN D MAIL
 I $G(PSOIO("PII"))]"" X PSOIO("PII")
 S T="Use the adhesive label above to mail prescription" D PRINT(T)
 S T="documents to your pharmacy." D PRINT(T)
REFILL Q:'DFN  S PS1=$G(^PS(59,PSOSITE,1)),PSOSITE7=$G(^("IB")),PSOSYS=$G(^PS(59.7,1,40.1))
 I '$D(PSSPND) F PSRX=0:0 S PSRX=$O(RX(PSRX)) Q:'PSRX  K RX(PSRX)
 S BLNKLIN="",$P(BLNKLIN,"_",45)="_"
 F PSRX=0:0 S PSRX=$O(^PS(55,DFN,"P",PSRX)) Q:'PSRX  D RZX
 ;NEW LABEL
 S PSOX=0
DOCNEW I $G(PSOIO("RPI"))]"" X PSOIO("RPI")
 S PSOYI=PSOTYI,PSOX=PSOLX,ORIGY=PSOY
 D HDR S PSA=0
 F J=1:1 S PSA=$O(RX(PSA)) Q:'PSA  D SCRPTNEW
 I $O(RX(0))="" G EXIT
 I PSOY=ORIGY G EXIT
 S PSOYI=PSOSYI,T=BLNKLIN D PRINT(T) S PSOYI=PSOTYI
 S PS=$S($D(^PS(59,PSOSITE,0)):^(0),1:"")
 S T="Patient's Signature & Date        "_$P(PS,"^",6)_"     "_PSONOW D PRINT(T)
EXIT K PSINF,AMC,PSA,PSDFN,PSDO,PSDT2,PSRFL,PSRX,PSLN,PSRXX,PSSS,PSST,PSOCR,DIWL,DIWR,DIWF,PSO9
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
SCRPTNEW S T="____"_$$ZZ^PSOSUTL(PSA) K ZDRUG D PRINT(T) S PSOYI=PSOTYI
 D DTCONNW
 S PSOYI=PSOTYI,OPSOX=PSOX,PSOX=PSOX+PSOXI,T="Refills "_$P(RX(PSA),"^",2)_"   Exp "_PSDT2_"    Rx# "_$P(^PSRX(PSA,0),"^") K TN D PRINT(T)
 S PSOYI=PSOBYI
 I $G(PSOIO("SBT"))]"" X PSOIO("SBT")
 S X2=PSOINST_"-"_PSA,PSOX=PSOX+PSOXI
 W X2
 I $G(PSOIO("EBT"))]"" X PSOIO("EBT")
 S PSOX=OPSOX
 I PSOY>PSOYM D  D:$O(RX(PSA)) HDR Q
 .S T=BLNKLIN,PSOYI=PSOSYI D PRINT(T) S PSOYI=PSOTYI
 .S T="Patient's Signature & Date         "_$P(PS,"^",6)_"     "_PSONOW D PRINT(T)
 .S PSOY=ORIGY,PSOYI=PSOTYI
 .I PSOX=PSORX S PSOX=PSOLX W @IOF Q
 .S PSOX=PSORX
 Q
DTCONNW S PSDT2=$P(RX(PSA),"^"),PSDT2=$E(PSDT2,4,5)_"/"_$E(PSDT2,6,7)_"/"_($E(PSDT2,1,3)+1700) Q
RFILL2 F AMC=0:0 S AMC=$O(^PSRX(PSRXX,1,AMC)) Q:'AMC  S PSRFL=PSRFL-1
 I PSRFL>0 S X1=DT,X2=$P(^PSRX(PSRXX,0),"^",8)-10 D C^%DTC I X'<$P(^(2),"^",6) S PSRFL=0
 Q
RZX ;
 S PSOORIG=0   ;441 PAPI
 S PSRXX=+^PS(55,DFN,"P",PSRX,0) I $D(^PSRX(PSRXX,0)) D
 .N EXPDT
 .S EXPDT=$P(^PSRX(PSRXX,2),"^",6) I EXPDT'>DT Q
 .S PSRFL=$P(^PSRX(PSRXX,0),"^",9) D:$D(^PSRX(PSRXX,1))&PSRFL RFILL2
 .I +PSRFL=0,$G(^PSRX(PSRXX,"PARK")),$P($G(^PSRX(PSRXX,"STA")),"^")=0 D CHKLBL^PSOPRKA(PSRXX,0) I 'LBLP S RX(PSRXX)=EXPDT_"^"_PSRFL,PSOORIG=1
 .I PSRFL>0,$P($G(^PSRX(PSRXX,"STA")),"^")<10,134'[$E(+$P($G(^("STA")),"^")) S RX(PSRXX)=EXPDT_"^"_PSRFL
 Q
HDR S T=PNM D PRINT(T)
 D ADD^VADPT
 I $G(VAPA(1))="" G HDR5
 F I=1:1:3 I $G(VAPA(I))]"" S T=VAPA(I) D PRINT(T)
 S A=+$G(VAPA(5)) I A S A=$S($D(^DIC(5,A,0)):$P(^(0),"^",2),1:"UNKNOWN")
 S B=$G(VAPA(4))_", "_A_"  "_$S($G(VAPA(11)):$P(VAPA(11),"^",2),1:$G(VAPA(6)))
 S T=B D PRINT(T)
HDR5 I $O(RX(0))="" D  S PSOY=PSOY+PSOYI Q
 .S PSOY=PSOY+PSOYI,T="You have no refillable prescriptions as of "_PSONOW_"." D PRINT(T)
 .S T="Please contact your provider if you need new prescriptions." D PRINT(T)
 .I '$D(PSOINST) D SITE
 .S PS=$S($D(^PS(59,PSOSITE,0)):^(0),1:"")
 .S OPSOX=PSOX,OPSOY=PSOY,T=$P(PS,"^",6) S PSOX=2300,PSOY=3900 D PRINT(T) S PSOX=OPSOX,PSOY=OPSOY
ADD S PSOY=PSOY+PSOYI
 I 'PSOORIG S T="Please check prescriptions to be refilled, sign the form, then" D PRINT(T)  ;441 PAPI
 I PSOORIG S T="Please check prescriptions to be filled/refilled, sign the form, then" D PRINT(T)
 S T="mail or return to your pharmacy." D PRINT(T) S PSOY=PSOY+PSOYI
 Q
MAIL ;PRINT MAILING ADHESIVE LABEL
 S PS=$S($D(^PS(59,PSOSITE,0)):^(0),1:"")
 I $P(PSOSYS,"^",4),$D(^PS(59,+$P($G(PSOSYS),"^",4),0)) S PS=^PS(59,$P($G(PSOSYS),"^",4),0)
 S VAADDR1=$P(PS,"^"),VASTREET=$P(PS,"^",2),STATE=$S($D(^DIC(5,+$P(PS,"^",8),0)):$P(^(0),"^",2),1:"UNKNOWN")
 S PSZIP=$P(PS,"^",5),PSOHZIP=$S(PSZIP["-":PSZIP,1:$E(PSZIP,1,5)_$S($E(PSZIP,6,9)]"":"-"_$E(PSZIP,6,9),1:""))
 I $G(PSOIO("MLI"))]"" X PSOIO("MLI")
 I $G(PSOIO("PSOFONT"))]"" X PSOIO("PSOFONT")
 S TEXT="Attn: (119)" D PRINT(TEXT)
 S TEXT=VAADDR1 D PRINT(TEXT)
 S TEXT=$G(VASTREET) D PRINT(TEXT)
 S TEXT=$P(PS,"^",7)_", "_$G(STATE)_"  "_$G(PSOHZIP) D PRINT(TEXT)
 Q
PRINT(T) ;
 I $G(PSOIO(PSOFONT))]"" X PSOIO(PSOFONT)
 I $G(PSOIO("ST"))]"" X PSOIO("ST")
 W T,!
 I $G(PSOIO("ET"))]"" X PSOIO("ET")
 Q
QUEUE ; ENTRY POINT TO PRINT STAND-ALONE MULTI-RX FORM
 S SAVDFN=$D(DFN) ; DFN SET IF COMING FROM HIDDEN ACTION
 I '$D(PSOPAR) D ^PSOLSET I '$D(PSOPAR) Q
 I '$G(PSOSYS) S PSOSYS=$G(^PS(59.7,1,40.1))
 I '$D(PSOINST) D SITE
 W !
 I $D(DFN) G GETPT2
GETPT S DIC("A")="Enter patient to reprint Multi-Rx refill form for: ",DIC(0)="QEAM" D EN^PSOPATLK S Y=PSOPTLK I Y<0!("^"[X) K PSOPTLK,DIC Q
 S DFN=$P(Y,"^")
GETPT2 D DEM^VADPT S PNM=VADM(1)
 I $P(VADM(6),"^",2)]"" D  G GETPT
 .W $C(7),!!,PNM_" Died "_$P(VADM(6),"^",2)_".",!
Q1 W ! K POP,ZTSK S %ZIS("B")="",%ZIS="MNQ",%ZIS("A")="Select LABEL DEVICE: " D ^%ZIS S PSLION=ION K %ZIS("A")
 I $G(POP) Q
 I $G(IOST(0)),'$D(^%ZIS(2,IOST(0),55,"B","LL")) W !,"Must specify a laser labels printer for Multi-Rx form." G Q1
 I '$G(IOST(0)) W !,"Nothing queued to print." H 1 Q
 D 6^VADPT,PID^VADPT6 S SSNP=""
 D NOW^%DTC S Y=$P(%,"."),PSOFNOW=% X ^DD("DD") S PSONOW=Y
 F G="DFN","PNM","PSOPAR","PSOSITE","SSNP","PSONOW","PSOSYS","PSOINST" S:$D(@G) ZTSAVE(G)=""
 S ZTRTN="DQ^PSOLLL7",ZTIO=PSLION,ZTDESC="Outpatient Pharmacy Multi-Rx print",ZTDTH=$H,PDUZ=DUZ
 D ^%ZISC,^%ZTLOAD W:$D(ZTSK) !!,"Multi-Rx form queued to print",!! H 1 K G
 I $G(SAVDFN)=0 K DFN,SAVDFN
 Q
DQ N PSOBIO S (I,PSOIO)=0 F  S I=$O(^%ZIS(2,IOST(0),55,I)) Q:'I  S X0=$G(^(I,0)) I X0]"" S PSOIO($P(X0,"^"))=^(1),PSOIO=1
 I $G(PSOIO("LLI"))]"" X PSOIO("LLI")
 G EN
SITE ;
 K ^UTILITY("DIQ1",$J) S DA=$P($$SITE^VASITE(),"^")
 I $G(DA)>0 S DIC=4,DIQ(0)="I",DR="99" D EN^DIQ1 S PSOINST=$G(^UTILITY("DIQ1",$J,4,DA,99,"I")) K ^UTILITY("DIQ1",$J),DA,DR,DIC
 I '$D(PSOINST) S PSOINST=""
 Q
