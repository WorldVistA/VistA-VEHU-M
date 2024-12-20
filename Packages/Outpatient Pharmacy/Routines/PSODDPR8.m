PSODDPR8 ;BIR/SAB - display enhanced order checks ;11 May 2010  9:06 AM
 ;;7.0;OUTPATIENT PHARMACY;**390,372,416,500,634**;DEC 1997;Build 3
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to ^PS(50.606 supported by DBIA 2174
 ;External reference to ^PS(52.41 supported by DBIA 2844
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ENCHK^PSJORUT2 supported by DBIA 2376
 ;
DUP ;display drug interaction, clinical effects, and call to display monograph
 Q:$G(PSODLQT)
 S ZZDGDGC=ZZDGDGC+1,ON=$P(ZZDGDG(SV,ZST,ZORS,ZVA,DRG),"^"),CT=$P(ZZDGDG(SV,ZST,ZORS,ZVA,DRG),"^",2),SEV=$G(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT,"SEV")) K ISTX
 S IT=$S(SEV="Critical":1,SEV="Significant":2,1:0),PDRG=$P(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT),"^",4),DRGI=$P(^(CT),"^",2)
 D HD() Q:$G(PSODLQT)
 I $G(ZHDR) W @IOF,PSONULN,!,"***"_SEV_"*** Drug Interaction with Prospective Drug:",!?20,PDRG_" and",! S ZHDR=0
 E  W !
 I $P(ON,";")["C" D ^PSODDPR7
 I $P(ON,";")="N" D ^PSODDPR3 D HD():(($Y+5)>IOSL) Q:$G(PSODLQT)
 I $P(ON,";")="P" D PEND D HD():(($Y+5)>IOSL) Q:$G(PSODLQT)
 I $P(ON,";")="O" D DDRX D HD():(($Y+5)>IOSL) Q:$G(PSODLQT)
 I $P(ON,";")="Z" D DDRX1 D HD():(($Y+5)>IOSL) Q:$G(PSODLQT)
 I $P(ON,";")="R" D RDI^PSODDPR3 D HD():(($Y+5)>IOSL) Q:$G(PSODLQT)
 I '+$G(PSOINTV),IT=2 S PSOINTV=2_"^"_ON
 I IT=1 S PSOINTV=1_"^"_ON
 D HD():(($Y+5)>IOSL) Q:$G(PSODLQT)  I COUNT=ZZDGDG2(SV,ZVA) S COUNT=0 W ! D CL D HD():(($Y+5)'>IOSL)
 Q
 ;
PEND N DUPRX0,RFLS,ISSD,DNM,RXREC,Y
 D HD() Q:$G(PSODLQT)  S RXREC=$P(ON,";",2),DNM=$P(^PS(52.41,RXREC,0),"^",9)
 S DUPRX0=^PS(52.41,RXREC,0),RFLS=$P(DUPRX0,"^",11),ISSD=$P(DUPRX0,"^",6)
 I '$P(DUPRX0,"^",9) D HD() Q:$G(PSODLQT)  S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("Pending Order: ",20)_$P(^PS(50.7,$P(DUPRX0,"^",8),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 E  S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("Pending Drug: ",20)_$S($P(DUPRX0,"^",9):$P(^PSDRUG($P(DUPRX0,"^",9),0),"^"),1:"No Dispense Drug Selected")
 D FSIG^PSOUTLA("P",RXREC,50)
 S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("SIG: ",20) F I=0:0 S I=$O(FSIG(I)) Q:'I  W:'$G(PSODUPF) FSIG(I) I $O(FSIG(I)) S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("      ",20)
 Q
 ;
DDRX ;
 S RXREC=$P(ON,";",2),DUPRX0=^PSRX(RXREC,0),RFLS=$P(DUPRX0,"^",9),ISSD=$P(^PSRX(RXREC,0),"^",13),RX0=DUPRX0,RX2=^PSRX(RXREC,2),($P(RX0,"^",15),STATUS)=+$G(^PSRX(RXREC,"STA"))
 S J=RXREC D STAT^PSOFUNC K RX0,RX2,LSTFD S RXRECLOC=$G(RXREC),DRGNM=$P(^PSDRUG($P(DUPRX0,"^",6),0),"^")
 D HD() Q:$G(PSODLQT)  S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("Local RX#: ",20)_$P(DUPRX0,"^"),!,$J("Drug: ",20)_DRGNM_" ("_ST_")"
 K FSIG,BSIG I $P($G(^PSRX(RXREC,"SIG")),"^",2) D FSIG^PSOUTLA("R",RXREC,50) F PSREV=1:1 Q:'$D(FSIG(PSREV))  S BSIG(PSREV)=FSIG(PSREV)
 K FSIG,PSREV I '$P($G(^PSRX(RXREC,"SIG")),"^",2) D EN2^PSOUTLA1(RXREC,50)
 D HD() Q:$G(PSODLQT)  S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("SIG: ",20),$G(BSIG(1))
 I $O(BSIG(1)) F PSREV=1:0 S PSREV=$O(BSIG(PSREV)) Q:'PSREV  S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("     ",20)_$G(BSIG(PSREV)) D HD()
 K BSIG,PSREV
 I $G(QTHER) D HD() Q:$G(PSODLQT)  S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("QTY: ",20)_$P(DUPRX0,"^",7),?44,$J("Days Supply: ",20)_$P(DUPRX0,"^",8)
 D PRSTAT^PSODDPRE(RXREC) S LSTFD=+^PSRX(RXREC,3) S:$G(PSODUPF) PSODUPC(ZCT)=PSODUPC(ZCT)+1 W:'$G(PSODUPF) !,$J("Last Filled On: ",20)_$E(LSTFD,4,5)_"/"_$E(LSTFD,6,7)_"/"_$E(LSTFD,2,3)
 Q
 ;
DDRX1 ;
 W:SV="C" !,$J("Drug: ",21)_$S($D(PSSDIUTL):PDRG,1:DRG)
 W:SV="S" !,$J("Drug: ",24)_$S($D(PSSDIUTL):PDRG,1:DRG)
 Q
 ;
CL Q:$G(PSODLQT)  N CLI,LT,STX,I,BSIG S ZHDR=1 N CLECNT
 D HD():(($Y+5)>IOSL) Q:$G(PSODLQT)
 I IT=2 W !?2,"*** Refer to MONOGRAPH for SIGNIFICANT INTERACTION CLINICAL EFFECTS",!
 I IT=1 W ! D
 .S CLECNT=0 F  S CLECNT=$O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CLECNT)) Q:CLECNT=""  I $D(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CLECNT,"CLIN")) D
 ..S CLI="",CLI=$P($G(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CLECNT,"CLIN")),"CLINICAL EFFECTS: ",2)
 ..S LT=75,STX=CLI D FT Q:$G(PSODLQT)  F I=0:0 S I=$O(BSIG(I)) Q:'I  W ?2,BSIG(I),! D HD():(($Y+5)>IOSL) Q:$G(PSODLQT)
 ..W !
 D HD():(($Y+5)>IOSL) Q:$G(PSODLQT)  I $O(^TMP($J,LIST,"OUT","DRUGDRUG",SV,DRG,ON,CT,"PMON",0)) D MON^PSODDPR3 K X,Y
 D HD():(($Y+5)>IOSL)
 Q
 ;
FT ;format text
 D HD():(($Y+5)>IOSL) Q:$G(PSODLQT)  K BSIG N BBSIG,BVAR,BVAR1,III,ZNT,NNN,BLIM S BBSIG=STX S (BVAR,BVAR1)="",III=1
 S ZNT=0 F NNN=1:1:$L(BBSIG) I $E(BBSIG,NNN)=" "!($L(BBSIG)=NNN) S ZNT=ZNT+1 D  I $L(BVAR)>LT S BSIG(III)=BLIM_" ",III=III+1,BVAR=BVAR1
 .S BVAR1=$P(BBSIG," ",(ZNT)),BLIM=BVAR,BVAR=$S(BVAR="":BVAR1,1:BVAR_" "_BVAR1) D HD(6):(($Y+6)>IOSL)
 I $G(BVAR)'="" S BSIG(III)=BVAR
 I $G(BSIG(1))=""!($G(BSIG(1))=" ") S BSIG(1)=$G(BSIG(2)) K BSIG(2)
 K LT D HD():(($Y+5)>IOSL)
 Q
 ;
HD(PSOLINES,OVRRID) ;
 Q:$G(PSODUPF)  ;P634
 S:'$G(PSODLQT) PSODLQT=0  S:'$G(OVRRID) OVRRID=0 S:'$G(PSOLINES) PSOLINES=5
 I '$G(OVRRID),$G(PSODLQT)!(($Y+PSOLINES)'>IOSL) Q
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 W ! K DIR,Y S DIR(0)="E",DIR("A")="Press return to continue" D ^DIR K DIR
 K PSOLINES,OVRRID
 I Y'=1!($D(DTOUT))!($D(DUOUT)) S PSODLQT=1,PSORX("DFLG")=1 Q
 W:'$G(PSODUPF) @IOF
 Q
 ;
 ;
CPRS(PSODFN,PSODSULS,PSODSUOI,PSODSUTY,PSODSUAG) ;
 ;Duplicate supply check for CPRS
 ;PSODFN - Patient
 ;PSODSULS - Literal
 ;PSODSUOI - Orderable Item array in format of PSODSUOI(n)=IEN (#50.7) ^ Orderable Name name
 ;PSODSUTY - P1;P2 where P1 is dialogue ("I" for IV, U for Unit Dose, "O" for Outpatient, "N" for Non-VA Meds (required)), P2=Pharm order# (optional)
 ;PSODSUAG - If 1, indicates TMP global from CPRS^PSODDPR4 call still exists, and add to it
 I '$G(PSODFN) Q
 I '$O(PSODSUOI(0)) Q
 I '$D(PSODSULS) Q
 N INDX,PSODSUDL,PSODSUPK,PSODSURG,PSODSUA1,PSODSUA2,PSODSUNM,PSODSUAP,PSODSUIN,PSODSUII,PSODSUNN,PSODSUDM,PSODSUDC,PSODSUST,PSODSUCC,PSODSULP,PSODSUBB,PSODSUB4,PSODSONM,PSODSOP2
 S PSODSUDL=$P($G(PSODSUTY),";") I PSODSUDL'="I",PSODSUDL'="U",PSODSUDL'="O",PSODSUDL'="N" Q
 S PSODSUPK=$S(PSODSUDL="I":1,PSODSUDL="U":1,1:0),PSODSUCC=0
 S PSODSUA1="" F  S PSODSUA1=$O(PSODSUOI(PSODSUA1)) Q:PSODSUA1=""  S PSODSONM=PSODSUOI(PSODSUA1) D
 .S PSODSUA2="" F  S PSODSUA2=$O(^PSDRUG("ASP",PSODSUA1,PSODSUA2)) Q:PSODSUA2=""  D
 ..S PSODSUNM=$P($G(^PSDRUG(PSODSUA2,0)),"^") Q:PSODSUNM=""
 ..S PSODSUAP=$P($G(^PSDRUG(PSODSUA2,2)),"^",3)
 ..I PSODSUPK,PSODSUAP'["I",PSODSUAP'["U" Q
 ..I PSODSUDL="O",PSODSUAP'["O" Q
 ..I PSODSUDL="N",PSODSUAP'["X" Q
 ..I '$$SUP^PSSDSAPI(PSODSUA2) Q
 ..S PSODSUIN=$P($G(^PSDRUG(PSODSUA2,"I")),"^")
 ..I PSODSUIN,PSODSUIN<DT Q
 ..S PSODSURG(PSODSUA2)=PSODSUNM_$S($G(PSODSONM):"^"_PSODSONM,1:"")
 I $O(PSODSURG(""))="" Q
 S INDX=0 K ^TMP($J,"ORDERS") I '$G(PSODSUAG) K ^TMP($J,"DD"),^TMP($J,PSODSULS)
 D BLD^PSOORDRG,ENCHK^PSJORUT2(PSODFN,.INDX),NVA^PSOORDRG I '$D(^TMP($J,"ORDERS")) Q
 S PSODSUDC=0,PSODSUII=""
 I $G(PSODSUAG) D 
 .S PSODSULP="" F  S PSODSULP=$O(^TMP($J,"DD",PSODSULP)) Q:PSODSULP=""  S PSODSUDC=PSODSULP
 .S PSODSUBB="" F  S PSODSUBB=$O(^TMP($J,PSODSULS,"IN","PROSPECTIVE",PSODSUBB)) Q:PSODSUBB=""  I $G(PSODSUTY)=$P(PSODSUBB,";",1,2) S PSODSUB4=$P(PSODSUBB,";",4) I PSODSUB4>PSODSUCC S PSODSUCC=PSODSUB4
 F  S PSODSUII=$O(PSODSURG(PSODSUII)) Q:PSODSUII=""  D
 .S PSODSUNN=$P(PSODSURG(PSODSUII),"^"),PSODSOP2=$P(PSODSURG(PSODSUII),"^",2),PSODSUDM=""
 .F  S PSODSUDM=$O(^TMP($J,"ORDERS",PSODSUDM)) Q:PSODSUDM=""  I PSODSUNN=$P(^TMP($J,"ORDERS",PSODSUDM),"^",3) D
 ..S PSODSUDC=PSODSUDC+1,^TMP($J,"DD",PSODSUDC,0)=PSODSUII_"^"_PSODSUNN_"^"_$P(^TMP($J,"ORDERS",PSODSUDM),"^",4)_"^"_$P(^TMP($J,"ORDERS",PSODSUDM),"^",5) D:'$D(PSODSUST(PSODSUII)) PNODE
 K ^TMP($J,"ORDERS")
 Q
 ;
PNODE ;Set prospective node for duplicate supply check for CPRS
 N PSOSPRID,PSOSPRQN,PSOSPRNF,PSOSPRN1,PSOSPRN2,PSOSPRXX
 S PSOSPRNF=$S($G(^PSDRUG(PSODSUII,"ND"))]"":+^PSDRUG(PSODSUII,"ND")_"A"_$P(^PSDRUG(PSODSUII,"ND"),"^",3),1:0)
 S PSOSPRID=$$GETVUID^XTID(50.68,,+$P($G(PSOSPRNF),"A",2)_",")
 S PSOSPRN1=$P($G(^PSDRUG(PSODSUII,"ND")),"^"),PSOSPRN2=$P($G(^PSDRUG(PSODSUII,"ND")),"^",3),PSOSPRXX=$$PROD0^PSNAPIS(PSOSPRN1,PSOSPRN2),PSOSPRQN=$P(PSOSPRXX,"^",7)
 S PSODSUCC=$G(PSODSUCC)+1,^TMP($J,PSODSULS,"IN","PROSPECTIVE",$P(PSODSUTY,";")_";"_$P(PSODSUTY,";",2)_";PROSPECTIVE;"_PSODSUCC)=PSOSPRQN_"^"_+PSOSPRID_"^"_PSODSUII_"^"_$G(PSODSUNN)_$S($G(PSODSOP2):"^"_PSODSOP2,1:"")
 S PSODSUST(PSODSUII)=""
 Q
