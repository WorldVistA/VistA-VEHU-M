PSOVER1 ;BHAM ISC/SAB - verify one rx ;3/9/05 12:53pm
 ;;7.0;OUTPATIENT PHARMACY;**32,46,90,131,202,207,148,243,268,281,324,358,251,375,387,379,390,372,416,411,422,402,500,562,747**;DEC 1997;Build 7
 ; Reference to ^PSDRUG( in ICR #221
 ; Reference to PSOUL^PSSLOCK in ICR #2789
 ; Reference to ^PS(55 in ICR #2228
 ; Reference to DOSE^PSSORPH is in ICR #3234
 ; Reference to ^ORRDI1 in ICR #4659
 ; Reference to ^XTMP("ORRDI" in ICR #4660
 ; Reference to $$DS^PSSDSAPI in ICR #5425
 ; Reference to $$GETNDC^PSSNDCUT in ICR #4707
 ; Reference to ^DPT( in ICR #3097
 ; Reference to ^PS(50.606 in ICR #2174
 ; Reference to ^PS(50.7 in ICR #2223
 ; Reference to ^PS(56 in ICR #2229
REDO ;
 I '$G(PSOCLK) Q:$G(PSVERFLG)
 S (DRG,PSODRUG("NAME"))=$P(^PSDRUG(+$P(^PSRX(PSONV,0),"^",6),0),"^"),PSODRUG("VA CLASS")=$P(^(0),"^",2)
 S PSOVQUIT=0,PSODRUG("IEN")=$P(^PSRX(PSONV,0),"^",6)
 S PSOY(0)=^PSDRUG(PSODRUG("IEN"),0),PSOY=PSODRUG("IEN")_"^"_$P(PSOY(0),"^")
 D SET^PSODRG
 I '$D(PSODFN) S PSODFN=$P(^PSRX(PSONV,0),"^",2)
 ;
EDIT ;
 N PSDNEW,PSDOLD
 S (PSDNEW,PSDOLD)="",PSDOLD=$P(^PSDRUG($P(^PSRX(PSONV,0),"^",6),0),"^")_"^"_PSONV
 S DA=PSONV D ^PSORXPR
 I $G(PSORX("DFLG")) G OUT  ;*422
 I $G(PKI1)=2 D DCV1^PSOPKIV1 G OUT
 K PSDTSTOP S DIR("A")="EDIT",DIR("B")="N",DIR(0)="SB^Y:YES;N:NO;P:PROFILE",DIR("?")="Enter Y to change this RX, P to see a profile, or N to proceed with verification and order checks."
 D ^DIR K DIR W ! I $G(DIRUT)!($G(DTOUT)) S PSOVBCK=1 G OUT
 ;PSOPOCK=1 called from Process Order Check option; PSOCLK=1 means initiated from Rx verify by clerk.
 I Y="Y",($G(PSOCLK)!($G(PSOPOCK))) D FULLEDT S VALMBCK="R" G KILL:$$CHECK(PSONV) G EDIT
 I Y="Y",$G(PSOACT)]"" S VALMBCK="R",PSVERFLG=1 G OUT  ;this pops the user back to the med profile screen when verify is called from Patient Prescription Processing
 I $D(DIRUT),$G(PSOCLK) S PSOCQ=1 G OUT
 I $D(DIRUT),$G(PSOACT)]"" S VALMBCK="R" G OUT
 G ORDCHK:Y="N",PROF:Y="P",OUT:"YNP"'[$E(Y)
 ;
 D EXPIRE K DIE,DR,DEA1,DEA2,P(5),PSRX1,PSRX2
 K PSD(PSDOLD) S PSDNEW="",PSDNEW=$P(^PSDRUG($P(^PSRX(PSONV,0),"^",6),0),"^")_"^"_PSONV,PSD(PSDNEW)=PSONV_"^*^1^"_$P(^PSDRUG($P(^PSRX(PSONV,0),"^",6),0),"^",2)
 ;
 S DA=$S($D(PSORXED("IRXN")):PSORXED("IRXN"),1:PSONV) D ^PSORXPR G OUT:$G(DIRUT)
 G OUT:$D(DIRUT)!($D(DTOUT))
 I '$G(PSOCLK) S DA=$S($D(PSORXED("IRXN")):PSORXED("IRXN"),1:PSONV) W !,"CHANGE",! D ^PSORXPR G OUT:$D(DIRUT)!($D(DTOUT)) G EDIT
 G EDIT:PSDNEW=PSDOLD,REDO
PROF I '$D(PSOSD) W !,$C(7),"This patient has no other prescriptions on file",!! G EDIT Q
 W !!,$P(^DPT(DFN,0),"^"),?40,"ID#:"_VA("PID") W:$D(INT)!$D(PSONV) "  RX#: "_$S($D(INT):$P(INT,"^"),$D(^PSRX(PSONV)):$P(^PSRX(PSONV,0),"^"),1:"")
 D HD^PSODDPR2() D ^PSODSPL D SHOW2^PSOVER G EDIT Q
 ;
EXPIRE S RX0=^PSRX(DA,0),X1=$P($P(RX0,"^",13),"."),X2=$P(RX0,"^",9)+1*$P(RX0,"^",8),X2=$S($P(RX0,"^",8)=X2:X2,X2<181:184,X2=360:366,1:X2),X=X1 D:X1&X2 C^%DTC
 K ^PS(55,PSDFN,"P","A",+$P(^PSRX(DA,2),"^",6),DA) S ^PS(55,PSDFN,"P","A",X,DA)="",$P(^PSRX(DA,2),"^",6)=X,$P(^PS(52.4,DA,0),"^",7)=X K X1,X2 Q
 ;
ORDCHK ;
 S PSOVER1=1
 S RX0=^PSRX(PSONV,0)
 D ORDCK
 I $G(PSOQUIT) S:$G(PSOCLK) PSOQUIT=0 S:'$G(PSOCLK) PSORX("DFLG")=1  ;if verify by clerk continue on with the next Rx; if not exit
 I $G(PSOVQUIT)!$G(PSORX("DFLG")) G OUT
 ;------
VERIFY ;
 D FULL^VALM1 G:'$P(PSOPAR,"^",2) VERY
 W !,$P(^DPT(DFN,0),"^"),?40,"ID#:"_VA("PID") W:$D(INT)!$D(PSONV) "  RX#: "_$S($D(INT):$P(INT,"^"),$D(^PSRX(PSONV)):$P(^PSRX(PSONV,0),"^"),1:"") W:$D(PSODRUG("NAME")) !,PSODRUG("NAME"),!
 I $G(PSONAM)="" S PSONAM=$P(^DPT(PSDFN,0),"^")
 S DIR("A")="VERIFY FOR "_PSONAM_"? (Y/N/Delete/Quit): ",DIR("B")="Y",DIR(0)="SA^Y:YES;N:NO;D:DELETE;Q:QUIT"
 S DIR("?",1)="Enter Y (or return) to verify this prescription",DIR("?",2)="N to leave this prescription non-verified and to end this session of verification",DIR("?")="D to delete this prescription"
 D ^DIR K DIR
 I Y="N"!("Q^"[$E(Y)) D  G OUT
 .S (PSVERFLG,PSOVBCK)=1,PSORX("DFLG")=1
 .S:$D(PSOOVNOD) ^PS(52.4,PSONV,0)=PSOOVNOD S:$G(PSOOVSTA) $P(^PSRX(PSONV,"STA"),"^")=PSOOVSTA
 .S:PSOOVSTA=4 ^PS(52.4,"ADI",PSONV,1)=""
 G DELETE:Y="D"
VERY I $G(PKI1)=1 D REA^PSOPKIV1 G:'$D(PKIR) VERIFY
 K ^PSRX(PSONV,"DAI") S $P(^PSRX(PSONV,3),"^",6)=""
 K ^PSRX(PSONV,"DRI"),SPFL1
 I '$O(^PSRX(PSONV,6,0)) D  I $D(DUOUT)!($D(DTOUT)) W !!,"Rx: "_$P(^PSRX(DA,0),"^")_" not Verified!!",! H 2 G OUT
 .W !!,"Dosing Instructions Missing. Please add!",!
 .I $P($G(^PSRX(PSONV,"SIG")),"^")]"",'$P($G(^("SIG")),"^",2) W "SIG: "_$P(^PSRX(PSONV,"SIG"),"^"),!
 .I $P($G(^PSRX(PSONV,"SIG")),"^",2),$O(^PSRX(PSONV,"SIG1",0)) D  K I
 ..W "SIG: " F I=0:0 S I=$O(^PSRX(PSONV,"SIG1",I)) Q:'I  W ^PSRX(PSONV,"SIG1",I,0),!
 .S DA=PSONV,PSOVER=1 K DIR,DIRUT,DUOUT,DTOUT
 .S PSODRUG("IEN")=$P(^PSRX(DA,0),"^",6),PSODFN=$P(^(0),"^",2),PSORXED("IRXN")=DA,PSODRUG("OI")=$P(^PSRX(DA,"OR1"),"^")
 .D DOSE^PSSORPH(.DOSE,PSODRUG("IEN"),"O",PSODFN),^PSOORED3
 .K PSODFN,PSODRUG("IEN"),DOSE,PSOVER
 .I '$G(ENT) S DUOUT=1
 .Q:$D(DUOUT)!($D(DTOUT))
 .K DIR,DIRUT,DUOUT,DTOUT S DIE=52,DR=114 D ^DIE K DIE,DR,DTOUT
 .I X'="" D SIG^PSOHELP D:$G(INS1)]"" EN^DDIOL($E(INS1,2,9999999)) S PSORXED("SIG",1)=$E(INS1,2,9999999)
 .D EN^PSOFSIG(.PSORXED,1),UDSIG^PSOORED3 H 2
 S DA=PSONV,$P(^PSRX(DA,2),"^",10)=DUZ,DRG=$P(^PSDRUG($P(^PSRX(DA,0),"^",6),0),"^")
 I $P(^PSRX(DA,2),"^",2)>DT,$P(PSOPAR,"^",6) D  G KILL
 .S (SPFL1,PSOVER)="",PSORX("FILL DATE")=$P(^PSRX(DA,2),"^",2),RXF=0
 .D UPSUS S PSTRIVER=1 D SUS^PSORXL
 .K PSORX("FILL DATE"),PSTRIVER
 .I $D(^TMP("PSODAOC",$J)) D ^PSONEWOC K ^TMP("PSODAOC",$J)
 S PSOVER(PSONV)="" S $P(^PSRX(PSONV,"STA"),"^")=0,DRG=$P(^PSDRUG($P(^PSRX(DA,0),"^",6),0),"^")
 S $P(PSOSD("NON-VERIFIED",DRG),"^",2)=0,PSOSD("ACTIVE",DRG)=PSOSD("NON-VERIFIED",DRG)
 I $D(^TMP("PSODAOC",$J)) D ^PSONEWOC K ^TMP("PSODAOC",$J)
 I $G(PKI1)=1,$G(PKIR)]"" D ACT^PSOPKIV1(DA)
 K PSOSD("NON-VERIFIED",DRG) D EN^PSOHLSN1(PSONV,"SC","CM","") ;S VALMBCK=""
 ;saves drug allergy order chks pso*7*390
 I +$G(^TMP("PSODAOC",$J,1,0)) D
 .I $G(PSORX("DFLG")) K ^TMP("PSODAOC",$J) Q
 .N RXN,PSODAOC S RXN=PSONV,PSODAOC="Rx Backdoor VERIFIED NEW Order Acceptance_OP"
 .D DAOC^PSONEW
 .K ^TMP("PSODAOC",$J),RET
 ;
 ; - Calling ECME for claims generation and transmission / REJECT handling
 N ACTION
 I $$SUBMIT^PSOBPSUT(PSONV) D  I ACTION="Q"!(ACTION="^") Q
 . S ACTION="" D ECMESND^PSOBPSU1(PSONV,,,$S($O(^PSRX(PSONV,1,0)):"RF",1:"OF"))
 . ; Quit if there is an unresolved Tricare non-billable reject code, PSO*7*358
 . I $$PSOET^PSOREJP3(PSONV) S ACTION="Q" Q
 . I $$FIND^PSOREJUT(PSONV) D
 . . S ACTION=$$HDLG^PSOREJU1(PSONV,0,"79,88,943","OF","IOQ","Q")
 ;
KILL S DA=PSONV,DIK="^PS(52.4," D ^DIK K DA,DIK D DCORD^PSONEW2
OUT ;
 K PSOVER1
 I '$G(PSOCLK) S:$G(DIRUT)!($G(DTOUT)) PSORX("DFLG")=1 K DIRUT,DTOUT,DUOUT,UPFLAGX D CLEAN S VALMBCK="Q" Q
 I $G(PSOCLK) S PSORX("DFLG")=0 K UPFLAGX D CLEAN Q
DELETE K UPFLAGX D DELETE^PSOVER2 G:$G(UPFLAGX) OUT K PSOSD("NON-VERIFIED",$G(DRG)) Q
QUIT S PSOQUIT="" D CLEAN K PSOVER1 Q
UPSUS S $P(PSOSD("NON-VERIFIED",DRG),"^",2)=5,PSOSD("ACTIVE",DRG)=PSOSD("NON-VERIFIED",DRG) K PSOSD("NON-VERIFIED",DRG) D EN^PSOHLSN1(PSONV,"SC","CM","")
 Q
CLEAN ;cleans up tmp("psorxdc") global
 I $G(PSODOSEX) K PSODOSEX Q
 N PSOWRITE
 I $O(^TMP("PSORXDC",$J,0)) F RORD=0:0 S RORD=$O(^TMP("PSORXDC",$J,RORD)) Q:'RORD  D
 .D PSOUL^PSSLOCK(RORD_$S($P(^TMP("PSORXDC",$J,RORD,0),"^")="P":"S",1:""))
 .I $P(^TMP("PSORXDC",$J,RORD,0),"^")="P" D  Q
 ..S PSOR=^PS(52.41,RORD,0)
 ..S DNM=$S($P(PSOR,"^",9):$P($G(^PSDRUG($P(PSOR,"^",9),0)),"^"),1:$P(^PS(50.7,$P(PSOR,"^",8),0),"^")_" "_$P(^PS(50.606,$P(^PS(50.7,$P(PSOR,"^",8),0),"^",2),0),"^"))
 ..W $C(7),!," Duplicate "_$S($P(^TMP("PSORXDC",$J,RORD,0),"^",10):"Therapy",1:"Drug")_" Pending Order "_DNM_" NOT Discontinued." S PSOWRITE=1
 .W !," Duplicate "_$S($P(^TMP("PSORXDC",$J,RORD,0),"^",10):"Therapy",1:"Drug")_" Rx #"_$P(^PSRX(RORD,0),"^")_" "_$P(^TMP("PSORXDC",$J,RORD,0),"^",7)_" NOT Discontinued." S PSOWRITE=1
 I $G(PSOWRITE)&('$G(PSOWRIT)) W ! K DIR S DIR(0)="E",DIR("?")="Press Return to continue",DIR("A")="Press Return to Continue" D ^DIR S:($D(DTOUT))!($D(DUOUT)) PSODLQT=1,PSORX("DFLG")=1 K DIR,X,Y I ($Y+5)>IOSL W @IOF
 K ^TMP("PSORXDC",$J),RORD,PRNXZ,ORNZZ,PSOR
 Q
KV1 ;
 K PSOANSQD,DRET,LST,PSOQUIT,PSODRUG,PSONEW,SIG,PSODIR,PHI,PRC,ORCHK,ORDRG,PSOSIGFL,PSORX("ISSUE DATE"),PSORX("FILL DATE"),CLOZPAT
KV K DIR,DIRUT,DTOUT,DUOUT
 Q
NVA ;
 I $P(PSOSD(STA,DNM),"^",11) D NVA^PSODRDU1 Q
 N PSOOI,CLASS,FLG,X,Y,RXREC,IFN
 S (Y,FLG)=""
 S RXREC=$P(PSOSD(STA,DNM),"^",10),PSOOI=+$G(^PS(55,DFN,"NVA",RXREC,0)),IFN=RXREC N DNM
 F  S Y=$O(^PSDRUG("ASP",PSOOI,Y)) Q:Y=""!(FLG)  S DNM=$P(^PSDRUG(Y,0),"^"),CLASS=$P(^PSDRUG(Y,0),"^",2) I PSODRUG("NAME")=DNM!(CLASS=PSODRUG("VA CLASS")) D DSP^PSODRDU1 S FLG=1 Q
 Q
REMOTE ; 
 K ^TMP($J,"DD"),^TMP($J,"DC"),^TMP($J,"DI"),^TMP($J,"DI"_PSODFN) D
 .I $T(HAVEHDR^ORRDI1)']"" Q
 .I '$$HAVEHDR^ORRDI1 Q
 .D HD^PSODDPR2():(($Y+5)'>IOSL)
 .I $D(^XTMP("ORRDI","OUTAGE INFO","DOWN")) D  Q
 ..I $T(REMOTE^PSORX1)]"" Q
 ..W !!,"Remote data not available - Only local order checks processed.",! D HD^PSODDPR2():(($Y+5)>IOSL)
 .W !!,"Now doing remote order checks. Please wait..."
 .D REMOTE^PSOORRDI(PSODFN,+$P($G(^PSRX(PSONV,0)),"^",6))
 .I $P($G(^XTMP("ORRDI","PSOO",PSODFN,0)),"^",3)<0 W !!,"Remote data not available - Only local order checks processed.",! D HD^PSODDPR2():(($Y+5)>IOSL) ;D PAUSE^PSOORRD2 Q
 .I $D(^TMP($J,"DD")) D DUP^PSOORRD2
 .I $D(^TMP($J,"DC")) D CLS^PSOORRD2
 .I $D(^TMP($J,"DI"_PSODFN)) K ^TMP($J,"DI") M ^TMP($J,"DI")=^TMP($J,"DI"_PSODFN) D DRGINT^PSOORRD2
 K ^TMP($J,"DD"),^TMP($J,"DC"),^TMP($J,"DI"),^TMP($J,"DI"_PSODFN)
 Q
NOALRGY ;
 N PSODFN,PSODRUG
 S PSODFN=$P(^PSRX(PSONV,0),"^",2),PSODRUG("IEN")=$P(^PSRX(PSONV,0),"^",6)
 D NOALRGY^PSODRG
 Q
 ;
ORDCK ;
 N ORN,ORNZZ,PSOLST,Y,PSOODFN S ORN=PSONV,PSOLST(PSONV)=PSONV_"^"_PSONV,PSOVORD=1
 N DRG,ON,CT,DRGI,PDRG,SEV,STX,INT,CLI,PSONULN,PSONULN1,LST,LSI,DGI,SER,SERS,DUPT,SV
 S ORNZZ=ORN,PRNXZ(ORN)=PSOLST(ORN),PSORENW("OIRXN")=PSONV,PSOODFN=DFN
 I '$D(PSODFN) S PSODFN=$P(^PSRX(PSONV,0),"^",2)
 D SHOW^PSOVER D HD^PSODDPR2():(($Y+5)>IOSL)
 S (PSODRUG("IEN"),PSDRUG("IEN"))=$P(^PSRX(PSONV,0),"^",6)
 N PSOVINF S PSOVINF=^PSDRUG(PSDRUG("IEN"),0),PSODRUG("VA CLASS")=$P(^(0),"^",2)
 S PSODRUG("VA CLASS")=$P(PSOVINF,"^",2),(DRG,PSODRUG("NAME"))=$P(^PSDRUG(PSDRUG("IEN"),0),"^")
 S PSODRUG("NDF")=$S($G(^PSDRUG(PSDRUG("IEN"),"ND"))]"":+^("ND")_"A"_$P(^("ND"),"^",3),1:0)
 S PSODRUG("MAXDOSE")=$P(PSOVINF,"^",4),PSODRUG("DEA")=$P(PSOVINF,"^",3),PSODRUG("CLN")=$S($D(^PSDRUG(PSDRUG("IEN"),"ND")):+$P(^("ND"),"^",6),1:0)
 S PSODRUG("SIG")=$P(PSOVINF,"^",5),PSODRUG("NDC")=$$GETNDC^PSSNDCUT(PSDRUG("IEN"),$G(PSOSITE)),PSODRUG("STKLVL")=$G(^PSDRUG(PSDRUG("IEN"),660.1))
 S PSODRUG("DAW")=$$GET1^DIQ(50,PSONV,81)
 I PSODRUG("DAW")="" S PSODRUG("DAW")=0
 K PSOVINF
 D POST^PSODRG S DFN=PSOODFN
 I $$GET1^DIQ(52,PSONV,100,"I")=13 S PSORX("DFLG")=1 Q
 I $G(PSVERFLG),$G(PSOCLK) S PSVERFLG=0
 I $G(PSOCLK),$G(PSORX("DFLG")) S PSOVQUIT=1 K PSORX("DFLG"),DIRUT,DTOUT Q
 Q:PSORX("DFLG")
 D:'$G(PSORX("DFLG")) DOSCK^PSODOSUT("V")
 I $$GET1^DIQ(52,PSONV,100,"I")=13 S PSORX("DFLG")=1 Q
 I $G(PSOCLK),$G(PSORX("DFLG")) S PSOVQUIT=1 K PSORX("DFLG"),DIRUT,DTOUT Q
 Q:PSORX("DFLG")!($G(PSOQUIT))
 S PSOLST(ORNZZ)=PRNXZ(ORNZZ),ORN=ORNZZ K PSORENW("OIRXN")
 Q
 ;
FULLEDT  ;
 D FULL^VALM1
 N RX,FILL,OPSOLST,OPSLST,OLDDA,PSODRUG,REJ
 S (RX,PSORXED("IRXN"))=PSONV
 M OPSOLST=PSOLST,OPSLST=PSLST,ODA=DA
 N PSOSITE,ORN,PSOPAR,PSOLIST,PSOSD
 S PSOSITE=$$RXSITE^PSOBPSUT(RX,""),ORN=RX
 S PSOPAR=$G(^PS(59,PSOSITE,1)),PSOLIST(1)=ORN_","
 D EPH^PSORXEDT
 M PSOLST=OPSOLST,PSLST=OPSLST S VALMBCK="R" S:$D(OLDDA) DA=OLDDA
 Q
 ;
DRIDOSE(DA,RX0) ;where DA is RXIEN and RX0 is zero node of file 52 for the RXIEN
 N T,RXN,RXX,SCRIPT,SEV,X,SER,PSOSERV,PSOSCPT,PSODOSF,RX
 S RX=RX0
 S RXN=$P(RX0,"^")
 I $D(^PS(52.4,RX,0))!($D(^PSRX(RX,"DRI"))) D
 . Q:'$P($G(^PS(52.4,RX,0)),"^",8)&('$D(^PSRX(RX,"DRI")))
 .W !!,"*** During order, there were DRUG-DRUG INTERACTION for the following RX(s):"
 I $P($G(^PS(52.4,RX,0)),"^",8) S SCRIPT=$P(^PS(52.4,RX,0),"^",10),SEV=$P(^PS(52.4,RX,0),"^",9) F X=1:1 S RXX(X)=$P(SCRIPT,",",X),SEV(X)=$P(SEV,",",X) Q:RXX(X)=""  D
 . S SER=$P(^PS(56,SEV(X),0),"^",4) S:$G(SER)=1 PSOSERV=1
 . S PSOSCPT(RXX(X))="     "_$S(SER=1:"CRITICAL",SER=2:"SIGNIFICANT",1:"UNKNOWN")_" INTERACTION    "_$P(^PSDRUG($P(^PSRX(RXX(X),0),"^",6),0),"^")
 I $D(^PSRX(RX,"DRI")) S SCRIPT=$P(^PSRX(RX,"DRI"),"^",2),SEV=$P(^PSRX(RX,"DRI"),"^") F X=1:1 S RXX(X)=$P(SCRIPT,",",X),SEV(X)=$P(SEV,",",X) Q:RXX(X)=""  D
 .S SER=$P(^PS(56,SEV(X),0),"^",4)
 .S PSOSCPT(RXX(X))="     "_$P($G(^PSRX(RXX(X),0)),"^")_"  "_$S(SER=1:"CRITICAL",SER=2:"SIGNIFICANT",1:"UNKNOWN")_" INTERACTION  "_$P(^PSDRUG($P(^PSRX(RXX(X),0),"^",6),0),"^")
 S SCRIPT="" F  S SCRIPT=$O(PSOSCPT(SCRIPT)) Q:SCRIPT=""  W !,PSOSCPT(SCRIPT)
 I $$DS^PSSDSAPI,$D(^PS(52.4,RX,1)) S T=$P(^PS(52.4,RX,1),"^") D  W:PSODOSF'="" !,"*** Dose Warning: ",PSODOSF
 . S PSODOSF="",PSODOSF=$S(T=4:"DOSAGE EXCEEDS MAX SINGLE DOSE AND/OR MAX DAILY DOSE",T=3:"MAX SINGLE DOSE & DAILY DOSE RANGE",T=2:"MAX SINGLE DOSE",T=1:"DAILY DOSE RANGE",1:"")
 W !
 Q
CHECK(PSONV) ;
 N PSOSTAT S PSOSTAT=$$GET1^DIQ(52,PSONV,100,"I")
 I ",11,12,13,14,15,"[(","_PSOSTAT_",") Q 1
 Q 0
