PSORXEDT ;BIR/SAB - Edit RX Routine ;Jan 05, 2021@12:04
 ;;7.0;OUTPATIENT PHARMACY;**21,23,44,71,146,185,148,253,390,372,416,313,427,422,402,500,482,556,622,753**;DEC 1997;Build 53
 ;External Reference to ^PS(55 supported by DBIA 2228
 ;External reference to $$BSA^PSSDSAPI supported by DBIA 5425
 D:'$D(PSOPAR) ^PSOLSET I '$D(PSOPAR) G EOJ Q
 K PSODRUG,PSOLIST,DIR,DIRUT,DUOUT,X,Y,PSOFROM,^TMP("PSOBEDT",$J),NOPP,CLOZPST,PSOTITRX,PSOMTFLG
 N PSOODOSP
 W !! S DIR(0)="FAO^1:245",DIR("A")="Edit Rx(s) => ",DIR("?",1)="Enter Rx Number or A List of numbers Separated",DIR("?")="by Commas, e.g. 1234A,345,937002Q."
 D ^DIR K DIR G:$D(DIRUT) EOJ
 S END=$L(X,","),BAD=0
 F I=1:1:END S RXM=$P(X,",",I) I +RXM F J=I+1:1:END S DUP=$P(X,",",J) I DUP=RXM S $P(X,",",J)="" W !?5,$C(7),"Duplicate Rx # "_RXM_"  was found in your list, ignoring it!",! S BAD=1
 S PSORLST=$P(X,",") F I=2:1:END S RXM=$P(X,",",I) S:RXM'?1.N.A BAD=1 I RXM?1.N.A S PSORLST=PSORLST_","_RXM
 F I=1:1:$L(PSORLST) S RXM=$P(PSORLST,",",I) I +RXM F J=I+1:1:END S DUP=$P(PSORLST,",",J) I DUP=RXM S $P(PSORLST,",",J)=""
 ;
BAD I PSORLST D  I 'Y K Y G PSORXEDT
 .W !?15,"=> "_PSORLST
 .K DIR,DIRUT S DIR(0)="Y",DIR("A")="Is this OKAY ",DIR("B")="Yes"
 .D ^DIR K DIR
 .I 'Y!$D(DIRUT) K X,PSORLST,BAD
 K BAD I 'PSORLST K PSORLST G PSORXEDT
 F I=1:1:$L(PSORLST,",") S RXM=$P(PSORLST,",",I) S GOOD=$D(^PSRX("B",RXM)) D
 .I 'GOOD W !!?5,"Couldn't Find RX # "_RXM H 3 Q
 .S RXN=$O(^PSRX("B",RXM,0)) D  I $P(^PSRX(RXN,"STA"),"^")=13 W !!?5,"Rx # "_RXM_" is marked for Deletion." H 3 Q
 ..I $G(RXN),$P($G(^PS(55,+$P($G(^PSRX(RXN,0)),"^",2),0)),"^",6)'=2 S PSOLOUD=1 D EN^PSOHLUP(+$P($G(^PSRX(RXN,0)),"^",2)) K PSOLOUD
 .D LIST K GOOD
 K GOOD,END
 ;
EPH ; - Entry for Epharmacy Rx Edit (PSOREJP1)
 F PSOT1=1:1 Q:'$D(PSOLIST(PSOT1))  F PSOLST2=1:1:$L(PSOLIST(PSOT1),",") S ORN=$P(PSOLIST(PSOT1),",",PSOLST2) D:+ORN PT
 ;
 ; If variable PSOREJCT is set, the EPH entry point was called by
 ; EDT^PSOREJP1, which is invoked by the ED Edit Rx Action on the
 ; ePharmacy Reject Info Screen.  If set, PSOREJCT will be Rx IEN ^ Fill.
 ; If the Rx is not released, and the Status is not Suspended, and the
 ; PSORX("NOLABEL") flag is not set, then add this Rx to the PSORX("PSOL")
 ; array.  The ED Edit Rx Action sends only one RX, so add as entry 1.
 I $G(PSOREJCT),'$$RXRLDT^PSOBPSUT(+PSOREJCT,$P(PSOREJCT,U,2)),$$GET1^DIQ(52,+PSOREJCT_",",100,"I")'=5,'$G(PSORX("NOLABEL")) S PSORX("PSOL",1)=+PSOREJCT
 ;
 ;call to add bingo board data to file 52.11
 K POP,PSOLIST,TM,TM1 G:'$O(PSORX("PSOL",0)) NX
 D:$G(PSORX("PSOL",1))]"" ^PSORXL K PSORX G:$G(NOBG) NX
 ;
PRF G:'$P(PSOPAR,"^",8)!($G(NOPP)="H")!($G(NOPP)="S")!('$D(^TMP("PSOBEDT",$J))) BBG
 I $O(^TMP("PSOBEDT",$J,0)),$P(PSOPAR,"^",8) S PSOFROM="NEW",PSOION=ION K RXRS
 G:$D(PSOPROP)&($G(PSOPROP)'=ION) QUP
 I '$D(PSOPROP)!($G(PSOPROP)=ION) D  G:$G(POP)!($E(IOST)["C")!(PSOION=ION) BBG
 .S PSOION=ION W !,"Profiles must be sent to Printer !!",! K IOP,%ZIS,IO("Q"),POP
 .S %ZIS="MNQ",%ZIS("A")="Select Profile Device: " D ^%ZIS K %ZIS("A")
 .Q:$G(POP)!($E(IOST)["C")!(PSOION=ION)  S PSOPROP=ION
 ;
QUP S X1=DT,X2=-120 D C^%DTC S PSODTCUT=X,HOLDRPAS=$G(PSOPRPAS),PSOPRPAS=$P(PSOPAR,"^",13)
 F DFN=0:0 S DFN=$O(^TMP("PSOBEDT",$J,DFN)) Q:'DFN  S PPL=^TMP("PSOBEDT",$J,DFN,0) D
 .S ZTRTN="DQ^PSOPRF",ZTIO=PSOPROP,ZTDESC="Outpatient Pharmacy Patient Profiles",ZTDTH=$H
 .F G="PSOPAR","PSODTCUT","PSOPRPAS","DFN","PSOSITE","NEW1","NEW11","PSOBMST","PFIO","PPL" S:$D(@G) ZTSAVE(G)=""
 .D ^%ZTLOAD
 W:$D(ZTSK) !,"PROFILE(S) QUEUED to PRINT",!! K G,ZTSK D ^%ZISC
 S PSOPRPAS=$G(HOLDRPAS) K:PSOPRPAS']"" PSOPRPAS K HOLDRPAS
 ;
BBG K DFN F PSODFN=0:0 S PSODFN=$O(^TMP("PSOBEDT",$J,PSODFN)) Q:'PSODFN  I $G(^TMP("PSOBEDT",$J,PSODFN,1)),$D(DISGROUP) S TM=$P($G(^TMP("PSOBB",$J)),"^"),TM1=$P($G(^($J)),"^",2),PPL=^TMP("PSOBEDT",$J,PSODFN,0) D ^PSOBING1
 ;
NX ;
 K %X,%Y,ACTREF,ACTREN,D,D0,DAT,DFN,DIC,DIQ,DQ,DRG,END,FDR,PSOBEDT,TM,TM1,PSOT1,PSOLST2,NOBG,BBFLG,BINGCRT,BINGRTE,C,CC,CMOP,COM,CT,D1,DI,DREN,BBRX,PSOFROM,POP,PSORX("QFLG"),IT,PSOERR,PSOBCK,PSOBM,PPL
 K ^TMP("PSOBEDT",$J),^TMP("PSOBB",$J),ZTSK,NOPP,VALMSG,VALMBCK D EOJ
END Q
 ;---------------------------------------------------------
PT ;
 N PSOTXEDT,PSOTPEXT S PSOTXEDT=$P($G(^PSRX(ORN,0)),"^",2) I PSOTXEDT I $D(^PS(52.91,PSOTXEDT,0)) I '$P(^PS(52.91,PSOTXEDT,0),"^",3)!($P(^(0),"^",3)>DT) D PDIR^PSOTPCAN(PSOTXEDT) I $G(PSOTPEXT) K PSOTPEXT,PSOTXEDT D EOJ Q
 K PSOTXEDT,PSOTPEXT
 D NOW^%DTC S TM=$E(%,1,12),TM1=$P(TM,".",2) S ^TMP("PSOBB",$J)=TM_"^"_TM1
 S $P(PSOLST(ORN),"^",2)=ORN,(PSOBEDT)=1
 S (DFN,PSODFN)=+$P(^PSRX(ORN,0),"^",2),PSORX("NAME")=$P(^DPT(DFN,0),"^") I PSODFN'=$G(PSOODOSP) K PSORX("DOSING OFF") S PSOODOSP=PSODFN
 D ICN^PSODPT(DFN)
 S RX0=^PSRX(ORN,0),RX2=$G(^(2)),RX3=$G(^(3))
 N PSOCHK S PSOCHK=$$CHK^PSODPT(PSODFN,1,1)  ;*422
 I PSOCHK=-1 D EOJ Q  ;*422
 D:$G(DUZ("AG"))="V" COPAY^PSOPTPST ; Deals with copay
 K ^TMP("PSOHDR",$J),^TMP("PSOPI",$J) D ^VADPT,ADD^VADPT
 S ^TMP("PSOHDR",$J,1,0)=VADM(1),^TMP("PSOHDR",$J,2,0)=$P(VADM(2),"^",2)
 S ^TMP("PSOHDR",$J,3,0)=$P(VADM(3),"^",2)
 S ^TMP("PSOHDR",$J,4,0)=VADM(4),^TMP("PSOHDR",$J,5,0)=$P(VADM(5),"^",2)
 S POERR=1 D RE^PSODEM K POERR,VALMBCK
 S ^TMP("PSOHDR",$J,6,0)=$S($P(WT,"^",8):$P(WT,"^",9)_" ("_$P(WT,"^")_")",1:"_______ (______)")
 S ^TMP("PSOHDR",$J,7,0)=$S($P(HT,"^",8):$P(HT,"^",9)_" ("_$P(HT,"^")_")",1:"_______ (______)") K VM,WT,HT S PSOHD=7
 S ^TMP("PSOHDR",$J,9,0)="",^TMP("PSOHDR",$J,10,0)=""
 S GMRA="0^0^111" D ^GMRADPT S ^TMP("PSOHDR",$J,8,0)=+$G(GMRAL)
 ;
 ; Display CrCl/BSA - show serum creatinine if CrCl can't be calculated
 S PSOBSA=$$BSA^PSSDSAPI(DFN),PSOBSA=$P(PSOBSA,"^",3),PSOBSA=$S(PSOBSA'>0:"_______",1:$J(PSOBSA,4,2)) S ^TMP("PSOHDR",$J,12,0)=PSOBSA
 S RSLT=$$CRCL^PSOORUT2(DFN)
 ; Display format of CrCL and Creatinine results updated - PSO*7.0*556
 I ($P($G(RSLT),"^",2)["Not Found")&($P($G(RSLT),"^",3)<.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_" (CREAT: Not Found)"
 I ($P($G(RSLT),"^",2)["Not Found")&($P($G(RSLT),"^",3)>=.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_"  (CREAT: "_$P($G(RSLT),"^",3)_"mg/dL "_$P($G(RSLT),"^")_")"
 I ($P($G(RSLT),"^",2)'["Not Found")&($P($G(RSLT),"^",3)<.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_" (CREAT: Not Found)"
 I ($P($G(RSLT),"^",2)'["Not Found")&($P($G(RSLT),"^",3)>=.01) S ZDSPL="  CrCL: "_$P(RSLT,"^",2)_"(est.)"_" (CREAT: "_$P($G(RSLT),"^",3)_"mg/dL "_$P($G(RSLT),"^")_")"
 S ^TMP("PSOHDR",$J,13,0)=$G(ZDSPL)
 K PSOBSA,RSLT,ZDSPL
 S ^TMP("PSOHDR",$J,14,0)=$$POSTSHRT^WVRPCOR(PSODFN)
 ;
 D NOW^%DTC S TM=$E(%,1,12),TM1=$P(TM,".",2) S ^TMP("PSOBB",$J)=TM_"^"_TM1
 S PSOLOUD=1 D:$P($G(^PS(55,PSODFN,0)),"^",6)'=2 EN^PSOHLUP(PSODFN) K PSOLOUD
 S PSOX=$G(^PS(55,PSODFN,"PS")) I PSOX]"" S PSORX("PATIENT STATUS")=$P($G(^PS(53,PSOX,0)),"^")
 D CLEAR^VALM1
 S STA="ACTIVE^NON-VERIFIED^REFILL^HOLD^NON-VERIFIED^SUSPENDED^^^^^^EXPIRED^DISCONTINUED^^DISCONTINUED^DISCONTINUED^HOLD"
 S $P(PSOLST(ORN),"^",3)=$P(STA,"^",$P(^PSRX(ORN,"STA"),"^")+1),PSLST=ORN,ORD=1
 D ACT^PSOORNE2
 ;
EOJ ;
 K INS1,HDR,IK,INDT,LOG,NODE,ORN,P1,PSI,PSL,PSOLION,PSNP,PSOACT,PSOBM,PSOCLC,PSOCNT,PSODD,PSODFN,PSOHD,PSOJ,PSOLST,PSOOI,PSOPF,PSLST
 K PSOIBQS,PSORLST,PSOSD,PSOSIG,PSPRXN,PSORX0,PSORX1,PTST,REFL,RF,RFD,RIFN,RLD,RPH,RTS,RX0,RX1,RX2,RX3,RXM,RXOR,SIG,SIGOK
 D KVA^VADPT K SLPPL,ST,STA,^TMP("PS",$J),PSOQFLG,PSORXED,PSOEDIT,DIR,DIRUT,DUOUT,DTOUT,PSOLOUD,GMRAL,GG,FEV,ACNT
 D FULL^VALM1 K ^TMP("PSOAL",$J),^TMP("PSOAO",$J),^TMP("PSOSF",$J),^TMP("PSOPF",$J),^TMP("PSOPI",$J),^TMP("PSOPO",$J),^TMP("PSOHDR",$J),PAT
 K JJ,K,MM,PSDAYS,PSOAC,PSOAL,PSOCOU,PSOCOUU,PSONEW,PSODRUG,PSONOOR,PSRX0,QTY,REA,RFCNT,RFDT,RXDA,RXFL,RXREF,SUB,X,Z,ZII,PSOMAILX
 K ACOM,CRIT,DA,DDH,DGI,DGS,PSONEW3,SER,SERS,ZONE,RN,RXN,PSOX,PSOERR,ORD,PSOBCK,PSOBILL,SURX,PSORX("QFLG"),PSORX("FN"),CLOZPAT
 Q
 ;
LIST ;
 I $G(^PSRX(RXN,0))']"" W !,$C(7),"Rx data is not on file !",! G LISTX
 I $P(^PSRX(RXN,0),"^",15)=13 S PSVD=1 W !,$C(7),"Rx # "_RXM_" has been deleted."
 S RXN1=RXN,RXM1=RXM D:'$G(PSVD) LST1 W "." S RXN=RXN1,RXM=RXM1 K RXN1,RXM1
 F  S RXN=$O(^PSRX("B",RXM,RXN)) Q:'RXN  D
 .I $G(^PSRX(RXN,0))']"" Q
 .I $P(^PSRX(RXN,0),"^",15)=13 Q
 .D LST1
 K RXN1 G LISTX
 Q
 ;
LST1 I $G(PSOLIST(1))']"" S PSOLIST(1)=RXN_"," G LISTX
 F PSOX1=0:0 S PSOX1=$O(PSOLIST(PSOX1)) Q:'PSOX1  S PSOX2=PSOX1
 I $L(PSOLIST(PSOX2))+$L(RXN)<220 S:RXN_","'[PSOLIST(PSOX2) PSOLIST(PSOX2)=PSOLIST(PSOX2)_RXN_","
 E  S:RXN_","'[PSOLIST(PSOX2+1) PSOLIST(PSOX2+1)=RXN_","
 ;
LISTX K PSOX1,PSOX2,RXN,PSVD
 Q
