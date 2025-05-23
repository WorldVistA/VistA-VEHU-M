PSOHLD ;BIR/SAB - hold unhold functionality ; OCT 04, 2023@11:10:12
 ;;7.0;OUTPATIENT PHARMACY;**1,16,21,24,27,32,55,82,114,130,166,148,268,281,298,358,353,385,386,370,488,562,441,712,780**;DEC 1997;Build 3
 ;
 ; Reference to ^DD(52 in ICR #999
 ; Reference to L, UL, PSOL, and PSOUL^PSSLOCK in ICR #2789
 ;
UHLD ; Rx Unhold
 N REASON,RXIEN
 S PSOFROM="UNHOLD" ;*488
 I '$D(PSOPAR) D ^PSOLSET G:'$D(PSOPAR) EX
 I $G(PSOBEDT) W $C(7),$C(7) S VALMSG="Invalid Action at this time !",VALMBCK="" Q
 I $G(PSONACT) W $C(7),$C(7) S VALMSG="No Pharmacy Orderable Item !",VALMBCK="" Q
 S PSOPLCK=$$L^PSSLOCK(PSODFN,0) I '$G(PSOPLCK) D LOCK^PSOORCPY S VALMSG=$S($P($G(PSOPLCK),"^",2)'="":$P($G(PSOPLCK),"^",2)_" is working on this patient.",1:"Another person is entering orders for this patient.") K PSOPLCK S VALMBCK="" Q
 K PSOPLCK D PSOL^PSSLOCK(DA) I '$G(PSOMSG) S VALMSG=$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing this order."),VALMBCK="" K PSOMSG D ULP Q
 S Y(0)=^PSRX(DA,0),STA=+$G(^("STA"))
 I STA=16 S VALMSG="Placed on HOLD by Provider!" K Y,STA D PSOUL^PSSLOCK(DA) D ULP S VALMBCK="" Q
 I STA'=3!(('$D(^XUSEC("PSORPH",DUZ)))&('$D(^XUSEC("PSO TECH ADV",DUZ)))) S VALMSG="Invalid Action Selection!",VALMBCK="" K Y,STA D PSOUL^PSSLOCK(DA) D ULP Q
 S REASON=$$GET1^DIQ(52,DA,99,"I")
 I ('$D(^XUSEC("PSORPH",DUZ))),",1,7,8,98,"'[(","_REASON_",") D  K Y,STA D PSOUL^PSSLOCK(DA) D ULP Q
 . S VALMSG="The HOLD can only be removed by a pharmacist",VALMBCK=""
 D FULL^VALM1 K DIR,DTOUT,DUOUT,DIRUT D NOOR I $D(DIRUT) D ULP G EX
 I DT>$P(^PSRX(DA,2),"^",6) D  D ULP G EX
 .S VALMSG="Medication Expired on "_$E($P(^PSRX(DA,2),"^",6),4,5)_"-"_$E($P(^(2),"^",6),6,7)_"-"_$E($P(^(2),"^",6),2,3) I $P(^PSRX(DA,"STA"),"^")<11 S $P(^PSRX(DA,"STA"),"^")=11
 .S ^PSRX(DA,"H")="",COMM="Medication Expired on "_$E($P(^(2),"^",6),4,5)_"-"_$E($P(^(2),"^",6),6,7)_"-"_$E($P(^(2),"^",6),2,3) D EN^PSOHLSN1(DA,"SC","ZE",COMM,"") K COMM
EN S RXF=0 F I=0:0 S I=$O(^PSRX(DA,1,I)) Q:'I  S RXF=I,RSDT=$P(^(I,0),"^")
 S RXIEN=DA
 ; - Asking for UNHOLD Comments
 N HLDCOM
 S HLDCOM=$$GET1^DIQ(52,RXIEN,99.1)_" (REASON: "_$$GET1^DIQ(52,RXIEN,99)_") on "_$$GET1^DIQ(52,RXIEN,99.2)
 W !!,"HOLD COMMENTS: " F I=1:1 Q:HLDCOM=""  W ?15,$E(HLDCOM,1,65),! S HLDCOM=$E(HLDCOM,66,999)
 K DIR,DUOUT,DTOUT S DIR(0)="FO^3:200",DIR("A")="UNHOLD COMMENTS" D ^DIR I $D(DTOUT)!$D(DUOUT) D ULP G EX
 S OTHCOM=X
 ;
 K Y I RXF D  I $D(Y) D ULP G EX
 .N DA,DIE S DA(1)=RXIEN,DA=RXF,DIE="^PSRX("_DA(1)_",1,",PSOUNHLD=1
 .S RLDT=$P(^PSRX(DA(1),1,DA,0),"^",18)
 .I 'RLDT D
 ..I RSDT<DT D  ;353 Do not display a past date for refill date'
 ...N Y,TD S Y=DT X ^DD("DD") S TD=Y
 ...S DR=".01R///^S X=TD"
 ...D ^DIE
 ..S DR=".01R"
 ..D ^DIE
 ..I $D(Y) D  Q  ;User quit the UNHOLD process
 ...I RSDT<DT D  ;reset refill date
 ....N Y,TD S Y=RSDT X ^DD("DD") S TD=Y
 ....S DR=".01R///^S X=TD"
 ....D ^DIE
 ..D MWPR I $D(DIRUT) K DIRUT D  Q
 ...I RSDT<DT D  ;reset refill date
 ....N Y,TD S Y=RSDT X ^DD("DD") S TD=Y
 ....S DR=".01R///^S X=TD"
 ....D ^DIE
 ..S DR="2////"_Y D ^DIE
 .I $E($$GET1^DIQ(52.1,RXF_","_RXIEN,2))="P" S PSOTOPK=1  ;441
 .I $$GET1^DIQ(52.1,RXF_","_RXIEN,2)["W" S BINGRTE="W",BINGCRT=1  ;*488
 .S ZD(RXIEN)=$P(^PSRX(DA(1),1,DA,0),"^")
 .K PSOUNHLD Q:$D(Y)  S PSORX("FILL DATE")=$P(^PSRX(DA(1),1,DA,0),"^"),DA=PSDA K DA(1)
 ;
 ;PSO*7*298 Require an entry into fill date
 S ACT=1,DIE="^PSRX(",FDT=$S($P(^PSRX(RXIEN,2),"^",2):$P(^PSRX(RXIEN,2),"^",2),1:DT)
 S RLDT=$P(^PSRX(RXIEN,2),"^",13),DR="",RLDTP1=$P(RLDT,".",1)
 N MWPR S MWPR=0 I 'RXF&'RLDT S DR="22R//^S X=FDT;Q;" S MWPR=1
 I RLDT&($P(^PSRX(RXIEN,2),"^",2)="") S DR="22R//^S X=RLDTP1;Q;" S MWPR=1
 D ^DIE K FDT I $D(Y) S VALMBCK="R" D ULP G EX
 I MWPR D  I $D(DIRUT) K DIRUT S VALMBCK="R" D ULP G EX
 .D MWPR Q:$D(DIRUT)
 .S DR="11////"_Y D ^DIE
 S DR="100///0;101///^S X=$S(RXF:$G(ZD(RXIEN)),1:$P(^PSRX(RXIEN,2),""^"",2))"
 D ^DIE K FDT I $D(Y) S VALMBCK="R" D ULP G EX
 I 'RXF,$E($$GET1^DIQ(52,RXIEN,11))="P" S PSOTOPK=1  ;441
 I 'RXF,$$GET1^DIQ(52,RXIEN,11)["W" S BINGRTE="W",BINGCRT=1  ;*488
 ;
 ; - Saving UNHOLD COMMENTS in the Refill REMARKS field.
 I $G(OTHCOM)'="" D
 . N DA,DIE,DR S DA(1)=RXIEN,DA=RXF,DIE="^PSRX("_DA(1)_",1,",DR="3///"_$E($TR(OTHCOM,";",","),1,60) D ^DIE
 ; - Logging Rx Activity Log
 D RXACT(RXIEN,"U",,$G(OTHCOM))
 ;
 S COMM="Medication Removed from Hold by Pharmacy" D EN^PSOHLSN1(RXIEN,"OE","",COMM,PSONOOR) K COMM,PSONOOR
 S PSORX("FILL DATE")=$S('RXF:$P(^PSRX(RXIEN,2),"^",2),1:ZD(RXIEN)) I $G(^PSRX(RXIEN,"H")) K ^PSRX("AH",$P(^PSRX(RXIEN,"H"),"^"),DA)
 S ^PSRX(RXIEN,"H")=""
 ;D ACT^PSOHLDA
 S (NEW1,NEW11)="^^"
 S (RXF,RXFL(RXIEN))=0 F JJ=0:0 S JJ=$O(^PSRX(RXIEN,1,JJ)) Q:'JJ  S (RXFL(RXIEN),RXF)=JJ
 I $G(PSXSYS) D UNHOLD^PSOCMOPA I $G(XFLAG) D ULP G EX
 I $G(RXIEN) D RELC I $G(PSOHRL) D ULP G EX
 I PSORX("FILL DATE")>DT,$P(PSOPAR,"^",6) D S^PSORXL,EX,ULP Q
 S PCOMH(RXIEN)="Medication Removed from Hold by Pharmacy"
 I $G(RXIEN) S RXRH(RXIEN)=RXIEN
 I $P($G(^PSRX(RXIEN,2)),"^",15)'="" S $P(^PSRX(RXIEN,2),"^",14)=1,RXRP(RXIEN)=1,$P(RXRP(RXIEN),"^",2)=$P($G(^PSRX(RXIEN,0)),"^",18) ; MARK PRESCRIPTION AND LABEL AS BEING REPRINTED WHEN UNHOLDING A RETURNED TO STOCK PRESCRIPTION
 I $G(PSOTOPK) D PRK^PSOPRK(RXIEN) D ULP G EX ;441
 ;
 ; - Submitting Rx to ECME
 N ACTION
 I $$SUBMIT^PSOBPSUT(RXIEN,+$G(RXFL(RXIEN))) D  I ACTION="Q"!(ACTION="^") D ULP G EX
 . N RX,RFL S RX=RXIEN,RFL=+$G(RXFL(RXIEN))
 . N DA S ACTION=""
 . D ECMESND^PSOBPSU1(RX,RFL,,$S(RFL:"RF",1:"OF"))
 . ; Quit if there is an unresolved TRICARE/CHAMPVA non-billable reject code, PSO*7*358
 . I $$PSOET^PSOREJP3(RX,RFL) S ACTION="Q" Q
 . I $$FIND^PSOREJUT(RX,RFL) D
 . . S ACTION=$$HDLG^PSOREJU1(RX,RFL,"79,88,943","ED","IOQ","Q")
 ;
 I $G(PSORX("PSOL",1))']"" S PSORX("PSOL",1)=RXIEN_"," D ULP G EX
 F PSOX1=0:0 S PSOX1=$O(PSORX("PSOL",PSOX1)) Q:'PSOX1  S PSOX2=PSOX1
 I $L(PSORX("PSOL",PSOX2))+$L(RXIEN)<220 S PSORX("PSOL",PSOX2)=PSORX("PSOL",PSOX2)_RXIEN_","
 E  S PSORX("PSOL",PSOX2+1)=RXIEN_","
 ;
 D ULP
EX D PSOUL^PSSLOCK($P(PSOLST(ORN),"^",2)) D ^PSOBUILD
 K PSOHRL,PSOMSG,PSOPLCK,ST,PSL,PSNP,IR,NOW,DR,NEW1,NEW11,RTN,DA,PPL,RXN,RX0,RXS,DIK,RXP,FLD,ACT,DIE,DIC,DIR,DIE,X,Y,DIRUT,DUOUT,SUSPT,C,D0,LFD,I,RFDATE,DI,DQ,%,RFN,XFLAG
 K HRX,PSHLD,PSOLIST,PSORX("FILL DATE"),STA,QTY,RFDT,PSORX0,PSRXN,RXF,JJ,PSOTOPK Q
 ;
HLD ;
 I $G(PSOBEDT) W $C(7),$C(7) S VALMSG="Invalid Action at this time !",VALMBCK="" Q
 I $G(PSONACT) W $C(7),$C(7) S VALMSG="No Pharmacy Orderable Item !",VALMBCK="" Q
 I '$D(^XUSEC("PSORPH",DUZ))&'$D(^XUSEC("PSO TECH ADV",DUZ)) S VALMSG="Invalid Action Selection!",VALMBCK="" Q
 S PSOPLCK=$$L^PSSLOCK(PSODFN,0) I '$G(PSOPLCK) D LOCK^PSOORCPY S VALMSG=$S($P($G(PSOPLCK),"^",2)'="":$P($G(PSOPLCK),"^",2)_" is working on this patient.",1:"Another person is entering orders for this patient."),VALMBCK="" K PSOPLCK Q
 K PSOPLCK D PSOL^PSSLOCK(DA) I '$G(PSOMSG) S VALMSG=$S($P($G(PSOMSG),"^",2)'="":$P($G(PSOMSG),"^",2),1:"Another person is editing this order."),VALMBCK="" K PSOMSG D ULP Q
 S Y(0)=^PSRX(DA,0),STA=+$G(^("STA")) I DT>$P(^PSRX(DA,2),"^",6) D  D ULP G D1
 .S VALMSG="Medication Expired on "_$E($P(^PSRX(DA,2),"^",6),4,5)_"-"_$E($P(^(2),"^",6),6,7)_"-"_$E($P(^(2),"^",6),2,3),VALMBCK="R"
 .I $P(^PSRX(DA,"STA"),"^")<11 S $P(^PSRX(DA,"STA"),"^")=11 D
 ..S COMM="Medication Expired on "_$E($P(^PSRX(DA,2),"^",6),4,5)_"-"_$E($P(^(2),"^",6),6,7)_"-"_$E($P(^(2),"^",6),2,3) D EN^PSOHLSN1(DA,"SC","ZE",COMM) K COMM
 S ST=$P("ERROR^ACTIVE^NON-VERIFIED^REFILL^HOLD^NON-VERIFIED^SUSPENDED^^^^^DONE^EXPIRED^DISCONTINUED^DELETED^DISCONTINUED^DISCONTINUED (EDIT)^PROVIDER HOLD^","^",STA+2)
 I STA,STA'>4!(STA>11) D  D ULP G D1
 .S VALMSG="Rx: "_$P(Y(0),"^")_" is currently in a status of "_ST,VALMBCK="R" K ST,Y Q
 D FULL^VALM1 D NOOR I $D(DIRUT) D ULP G D1
 D HLD^PSOCMOPA I $G(XFLAG) K XFLAG D ULP G D1
 K DIR S DIR("A")=$P(^DD(52,99,0),"^"),DIR(0)="52,99"
 ; A reduced set of HOLD REASON CODEs is available for Pharmacy Techs
 I '$D(^XUSEC("PSORPH",DUZ)) D
 . S DIR(0)="S^1:INSUFFICIENT QTY IN STOCK;7:BAD ADDRESS;8:PER PATIENT REQUEST;98:OTHER/TECH (NON-CLINICAL)"
 . S DIR("L",1)="Enter reason medication is placed in a 'Hold' status."
 . S DIR("L",2)="Choose from:"
 . S DIR("L",3)="1        INSUFFICIENT QTY IN STOCK"
 . S DIR("L",4)="7        BAD ADDRESS"
 . S DIR("L",5)="8        PER PATIENT REQUEST"
 . S DIR("L")="98       OTHER/TECH (NON-CLINICAL)"
 ;
 D ^DIR S FLD(99)=Y I $D(DUOUT)!($D(DIRUT)) K DIRUT,DUOUT,DIR D ULP G D1
 I ($G(FLD(99))=98!($G(FLD(99))=99)) K DIR S DIR("A")=$P(^DD(52,99.1,0),"^"),DIR(0)="52,99.1" D ^DIR S FLD(99.1)=Y G AR
 E  K DIR S DIR(0)="FO^10:100",DIR("A")="HOLD COMMENTS" D ^DIR S FLD(99.1)=Y
AR I $D(DUOUT)!($D(DTOUT)) K DIRUT,DUOUT,DIR S VALMBCK="R" D ULP G D1
 F PI=1:1 Q:$P(PPL,",",PI)=""  S DA=$P(PPL,",",PI) D H S DA=PSDA K PSDA D:$D(PSORX("PSOL")) RMP^PSOHLDA
 K PI D ^PSOBUILD
 D ULP
D1 D PSOUL^PSSLOCK($P(PSOLST(ORN),"^",2)) K PSOMSG,PSOPLCK,RFN,DIR,RSDT,FLD,DA,ACT,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 Q
 ;
H ; - Rx HOLD update
 D HOLD^PSOHLDA
 Q
 ;
FLD N DA K DIR S DIR("A")=$P(^DD(52,99,0),"^"),DIR(0)="52,99" D
 .; A reduced set of HOLD REASON CODEs is available for Pharmacy Techs  ;*370
 .I $D(^XUSEC("PSORPH",DUZ)) Q
 .S DIR(0)="S^1:INSUFFICIENT QTY IN STOCK;7:BAD ADDRESS;8:PER PATIENT REQUEST;98:OTHER/TECH (NON-CLINICAL)"
 .S DIR("L",1)="Enter reason medication is placed in a 'Hold' status."
 .S DIR("L",2)="Choose from:"
 .S DIR("L",3)="1        INSUFFICIENT QTY IN STOCK"
 .S DIR("L",4)="7        BAD ADDRESS"
 .S DIR("L",5)="8        PER PATIENT REQUEST"
 .S DIR("L")="98       OTHER/TECH (NON-CLINICAL)"
 D ^DIR Q:$D(DUOUT)!($D(DIRUT))  S FLD(99)=Y
 S COMM=Y(0)
 I $G(FLD(99))=99 K DIR S DIR("A")=$P(^DD(52,99.1,0),"^"),DIR(0)="52,99.1" D ^DIR Q:$D(DUOUT)!($D(DIRUT))  S (FLD(99.1),COMM)=Y Q
 E  S FLD(99.1)=""
 Q
NOOR ;ask nature of order
 K DIR,DTOUT,DTOUT,DIRUT I $T(NA^ORX1)]""  D  Q
 .S PSONOOR=$$NA^ORX1("W",0,"B","Nature of Order",0,"WPSDIVR"_$S(+$G(^VA(200,DUZ,"PS")):"E",1:""))
 .I +PSONOOR S PSONOOR=$P(PSONOOR,"^",3) Q
 .S DIRUT=1 K PSONOOR
 S DIR("A")="Nature of Order: ",DIR("B")="WRITTEN"
 S DIR(0)="SA^W:WRITTEN;V:VERBAL;P:TELEPHONE;S:SERVICE CORRECTED;D:DUPLICATE;I:POLICY;R:SERVICE REJECTED"_$S(+$G(^VA(200,DUZ,"PS")):";E:PROVIDER ENTERED",1:"")
NOORX D ^DIR K DIR,DTOUT,DTOUT Q:$D(DIRUT)  S PSONOOR=Y
 Q
ULP ;
 D UL^PSSLOCK(+$G(PSODFN))
 Q
RELC ;
 S (PSOHRL,PSOHTX)=0  F PSOHT=0:0 S PSOHT=$O(^PSRX(DA,1,PSOHT)) Q:'PSOHT  S:$D(^PSRX(DA,1,PSOHT,0)) PSOHTX=PSOHT
 I $G(PSOHTX) S PSOHRL=$S($P($G(^PSRX(DA,1,PSOHTX,0)),"^",18):1,1:0)
 I '$G(PSOHTX) S PSOHRL=$S($P($G(^PSRX(DA,2)),"^",13):1,1:0)
 K PSOHTX,PSOHT
 Q
RXACT(RX,ACTION,REASON,OTHCOM,SUS) ; Adds HOLD/UNHOLD comments to the Rx Activity Log
 N RFL,X,DIC,DA,DD,DO,DR,DINUM,Y,DLAYGO,COMM
 S RFL=$$LSTRFL^PSOBPSU1(RX)
 I ACTION="H" S COMM="Rx placed on HOLD (Reason: "_REASON_")"_$S(+$G(SUS):" and removed from SUSPENSE",1:"")
 I ACTION="U" S COMM="Rx removed from HOLD"
 S DA(1)=RX,DIC="^PSRX("_RX_",""A"",",DLAYGO=52.3,DIC(0)="L" S:$G(OTHCOM)'="" OTHCOM=$TR(OTHCOM,";",","),COMM=COMM_" -"
 S DIC("DR")=".02///"_ACTION_";.03////"_DUZ_";.04///"_$S((RFL>5):RFL+1,1:RFL)_";.05///"_COMM_$S($G(OTHCOM)'="":";4///"_OTHCOM,1:"")
 S X=$$NOW^XLFDT() D FILE^DICN
 Q
 ;
MWPR ;
 N RESULTS,PSOPARKX,DV K DIR,DUOUT,DTOUT,DIRUT
 S RESULTS="PSOPARKX" D GETPARK^PSORPC01()
 ;PSO*7*780 Do not allow Park when DEA handling contains D
 S DIR(0)="S^M:MAIL;W:WINDOW",DIR("A")="MAIL/WINDOW"
 I $G(PSOPARKX(0))="YES" D
 . I $P(^PSDRUG($P(^PSRX(RXIEN,0),"^",6),0),"^",3)'["D" S DIR(0)="S^M:MAIL;W:WINDOW;P:PARK",DIR("A")="MAIL/WINDOW/PARK"
 S DV=$S(RXF:$$GET1^DIQ(52.1,RXF_","_RXIEN,2),1:$$GET1^DIQ(52,RXIEN,11))
 S:$E(DV)="P" DV="PARK"
 I $E(DV)="P",DIR(0)'["P:" S DV=""
 S DIR("B")=DV
 D ^DIR K DIR,DUOUT,DTOUT
 Q
