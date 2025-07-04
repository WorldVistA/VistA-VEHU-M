PSODDPR4 ;BHAM - ISC/EJW,SAB - build local OP  & RDI profiles ;07/19/07
 ;;7.0;OUTPATIENT PHARMACY;**251,375,387,379,390,372,416,484,500,518,785**;DEC 1997;Build 1
 ;External references to ^ORRDI1 supported by DBIA 4659
 ;External references to ^XTMP("ORRDI" supported by DBIA 4660
 ;External reference to ^PSDRUG( supported by DBIA 221
 ;External reference to IN^PSJBLDOC supported by DBIA 5306
 ;External references to ^PSSDSAPM supported by DBIA 5570
 ;External reference to ^PS(55 supported by DBIA 2228
 ;External reference to ENCHK^PSJORUT2 supported by DBIA 2376
 ;External reference to IN^PSSHRQ2 supported by DBIA 5369
 ;External reference to ^PS(50.606 supported by DBIA 2174
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference to SUP^PSSDSAPI supported by DBIA 5425
 ;
BLD(PSODFN,LIST,PDRG,PTY) ;
 ;build OP, RDI, INP MEDS profiles
 ;PTY - P1;P2 where P1="I" for IP & "O" for OP (required), P2=Pharm order# (optional)
 I '$D(PSODFN) W !,"Patient UNDEFINED!",! Q
 I '$D(LIST) W !,"Input Base UNDEFINED!",! Q
 K ^TMP($J,LIST)
ORD N PSODTCUT,X1,X2,ODRG,ORTYP,ORN,DO,IEN,NAME,PROF,PSOON,PSOFRMNM S (PROF,CNT)=0
 F ZI=0:0 S ZI=$O(PDRG(ZI)) Q:'ZI  S IEN=$P(PDRG(ZI),"^"),NAME=$P(PDRG(ZI),"^",2) K PSOFRMNM S:$G(PSOFRMOR) PSOFRMNM=$P(PDRG(ZI),"^",4) D DRG
 I $D(PSJDGCK),'$D(PSGDGCKF) Q:$O(^TMP($J,LIST,"IN","PROSPECTIVE",""))=""   ;no prospective drugs to pass in
 I '$D(PSJDGCK),$O(^TMP($J,LIST,"IN","PROSPECTIVE",""))="" D:$O(PSODUPSP(0)) DRGSUP Q  ;no prospective drugs to pass in and drug is supply, create supply nodes
 S X1=DT,X2=-120 D C^%DTC S PSODTCUT=X D ^PSOBUILD,PROFILE
 K PSOSD D REMOTE D:$P($G(PTY),";")="I" IN^PSJBLDOC(PSODFN,LIST,.PDRG,$G(PTY))
 S ^TMP($J,LIST,"IN","IEN")=PSODFN,^TMP($J,LIST,"IN","DRUGDRUG")="",^TMP($J,LIST,"IN","THERAPY")=""
 S ^TMP($J,LIST,"IN","SOURCE")=$P($G(PTY),";")
 I $P($G(PTY),";")="O" D IMO^PSODDPR7(PSODFN)
 N PSOICT,PSODRUG,PSOY,CNT,ZI
 D IN^PSSHRQ2(LIST) D:$O(PSODUPSP(0)) DRGSUP
 Q
PROFILE ;build profile drug input
 N ID,ORTYP,DD,PSOI,ORN,RECTYP S (STA,DNM)="",DO=0
 F  S STA=$O(PSOSD(STA)) Q:STA=""  F  S DNM=$O(PSOSD(STA,DNM)) Q:DNM=""  D
 .I STA="PENDING" D  Q
 ..Q:$P(^PS(52.41,$P(PSOSD(STA,DNM),"^",10),0),"^",3)="RF"
 ..S RXREC=$P(PSOSD(STA,DNM),"^",10),ORN=$P(^PS(52.41,RXREC,0),"^"),ODRG=$P(^(0),"^",9),ORTYP="P"
 ..I ODRG D  K ODRG Q
 ...I $P($G(^PSDRUG(ODRG,0)),"^",3)["S"!($E($P($G(^PSDRUG(ODRG,0)),"^",2),1,2)="XA") Q
 ...S DRNM=$P(^PSDRUG(ODRG,0),"^"),DO=DO+1 D ID
 ..E  N PSOI,DDRG,ODRG,SEQN,DDRG S PSOI=$P(^PS(52.41,RXREC,0),"^",8) D
 ...S DRNM=$P(^PS(50.7,PSOI,0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 ...S DDRG=$$DRG^PSSDSAPM(PSOI,"O") I '$P(DDRG,";") D:'$$NVATST^PSODDPRE(PSOI,"O") OIX Q
 ...I $P($G(^PSDRUG($P(DDRG,";"),0)),"^",3)["S"!($E($P($G(^PSDRUG($P(DDRG,";"),0)),"^",2),1,2)="XA") Q
 ...S ODRG=$P(DDRG,";"),SEQN=+$P(DDRG,";",3) K PSOI
 ...N ID S ID=+$$GETVUID^XTID(50.68,,+$P($G(^PSDRUG(ODRG,"ND")),"^",3)_",")
 ...D ID1
 .I STA="ZNONVA" D  Q
 ..S RXREC=$P(PSOSD(STA,DNM),"^",10),ODRG=$P(^PS(55,PSODFN,"NVA",RXREC,0),"^",2),ORN=$P($G(^(0)),"^",8),ORTYP="N"
 ..I ODRG D  K ODRG Q
 ...I $P($G(^PSDRUG(ODRG,0)),"^",3)["S"!($E($P($G(^PSDRUG(ODRG,0)),"^",2),1,2)="XA") Q
 ...S DRNM=$P(^PSDRUG(ODRG,0),"^"),DO=DO+1 D ID
  ..E  N PSOI,DDRG,ODRG,SEQN,DDRG,DRNM S PSOI=$P(^PS(55,PSODFN,"NVA",RXREC,0),"^") D
 ...S DRNM=$P(^PS(50.7,PSOI,0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 ...S DDRG=$$DRG^PSSDSAPM(PSOI,"X") I '$P(DDRG,";") D:'$$NVATST^PSODDPRE(PSOI,"X") OIX Q
 ...I $P($G(^PSDRUG($P(DDRG,";"),0)),"^",3)["S"!($E($P($G(^PSDRUG($P(DDRG,";"),0)),"^",2),1,2)="XA") Q
 ...S ODRG=$P(DDRG,";"),SEQN=+$P(DDRG,";",3),DO=DO+1 K PSOI
 ...N ID S ID=+$$GETVUID^XTID(50.68,,+$P($G(^PSDRUG(ODRG,"ND")),"^",3)_",")
 ...D ID1
 .S RXREC=+PSOSD(STA,DNM)
 .I $P($G(PTY),";")="O",$P($G(PTY),";",2)=RXREC Q
 .I $P($G(^PSRX(RXREC,0)),"^",6) S ODRG=$P(^PSRX(RXREC,0),"^",6) D
 ..I $P($G(^PSDRUG(ODRG,0)),"^",3)["S"!($E($P($G(^PSDRUG(ODRG,0)),"^",2),1,2)="XA") Q
 ..I STA="DISCONTINUED" Q:$$DUPTHER^PSODDPRE(RXREC)  ;screen out duplicate therapy for local orders
 ..S ORN=$P($G(^PSRX(RXREC,"OR1")),"^",2),ORTYP="O",DRNM=$P(^PSDRUG(ODRG,0),"^"),DO=DO+1 D ID
 K RXREC,ID,STA,DNM,SEQN,PSOI,PSODD,P1,P3,OR1,P2,PSODRUG,DD,DRNM,DDRG
 Q
ID N ID S ID=+$$GETVUID^XTID(50.68,,+$P($G(^PSDRUG(ODRG,"ND")),"^",3)_",")
 S P1=$P($G(^PSDRUG(ODRG,"ND")),"^"),P2=$P($G(^("ND")),"^",3),X=$$PROD0^PSNAPIS(P1,P2),SEQN=+$P(X,"^",7)
ID1 I '$D(PSJDGCK) S ^TMP($J,LIST,"IN","PROFILE",ORTYP_";"_RXREC_";PROFILE;"_DO)=SEQN_"^"_ID_"^"_ODRG_"^"_DRNM_"^"_ORN_"^O" K ID
 I $D(PSJDGCK) S ^TMP($J,LIST,"IN","PROSPECTIVE",ORTYP_";"_RXREC_";PROSPECTIVE;"_DO)=SEQN_"^"_ID_"^"_ODRG_"^"_DRNM_"^"_ORN_"^O" K ID
 Q
OIX S ^TMP($J,LIST,"IN","EXCEPTIONS","OI",DRNM)=1_"^"_ORTYP_";"_RXREC_";PROFILE;"_DO
 K TU
 Q
REMOTE ;
 I $T(HAVEHDR^ORRDI1)']"" Q
 I '$$HAVEHDR^ORRDI1 Q
 I $D(^XTMP("ORRDI","OUTAGE INFO","DOWN")) D  Q
 .I $T(REMOTE^PSORX1)]"" Q
 .D HD^PSODDPR2():(($Y+5)'>IOSL)
 .W !!,"Remote data not available - Only local order checks processed.",! D HD^PSODDPR2():(($Y+5)'>IOSL)
 I $P($G(^XTMP("ORRDI","PSOO",PSODFN,0)),"^",3)<0 W !!,"Remote data not available - Only local order checks processed." D HD^PSODDPR2():(($Y+5)'>IOSL) Q
 N PSORDI,RDIINST,RDIVUID,RDIRX,RDIDNAM,RDISTA,RDISIG,RDIDAYS,RDIQTY,RDIFILL,RDIEXP,RDIISS,RDIFILL,ZI
 N RDIREF,RDIPHYS,PSOPROD,PSOCLASS,DRNM,RDITMP,PSODC,IT,PSOICT,NDF,RDIDI,PSOPRODA,PSOFILE,PSOSIG,PSOSEQN,X
 I '$G(DT) S DT=$$DT^XLFDT
 S PSORDI=0
 I $T(GET^ORRDI1)]"" S PSORDI=$$GET^ORRDI1(PSODFN,"PSOO")
 I PSORDI<1 Q
 I '$D(^XTMP("ORRDI","PSOO",PSODFN)) Q
 K ^TMP($J,LIST,"OUT","REMOTE")
 D PARSE,FILTER
 I '$D(^TMP($J,LIST,"OUT","REMOTE")) Q
 N DIC D REMO
 Q
REMO ;
  S (PSOON,PSORDI)=0 F  S PSORDI=$O(^TMP($J,LIST,"OUT","REMOTE",PSORDI)) Q:'PSORDI  S RDITMP=^(PSORDI) D  K PSOSEQN
 .Q:$P(RDITMP,"^",2)=""
 .;screen out dc'd remotes
 .I $P($G(^TMP($J,LIST,"OUT","REMOTE",PSORDI)),"^",4)["DISC" D  I $G(PSOON) K PSOON Q
 ..K X,Y,X1,X2
 ..S X=$P(^TMP($J,LIST,"OUT","REMOTE",PSORDI),"^",6) D ^%DT S X1=Y,X2=(+$P(^TMP($J,LIST,"OUT","REMOTE",PSORDI),"^",7)+7)
 ..D C^%DTC I X<DT S PSOON=1 K X,Y,X1,X2
 .;
 .S RDIVUID=$P(RDITMP,"^",2),RDIDNAM=$P(RDITMP,"^",3)
 .I $O(PDRG(0)) F ZI=0:0 S ZI=$O(PDRG(ZI)) Q:'ZI  I $P(^PSDRUG($P(PDRG(ZI),"^"),0),"^")=RDIDNAM S INDD=+$G(INDD)+1,^TMP($J,"DD",INDD,0)=$P(PDRG(ZI),"^")_"^"_RDIDNAM_"^^"_PSORDI_"Z;O"
 .S DO=$G(DO)+1 D GETIREF^XTID(50.68,.01,RDIVUID,"PSOSEQN",1) I 'PSOSEQN S ^TMP($J,LIST,"IN","PROFILE","R;"_PSORDI_";PROFILE;"_DO)=0_"^"_RDIVUID_"^0^"_RDIDNAM_"^^" Q
 .S SEQN="" S SEQN=$O(PSOSEQN(50.68,.01,SEQN)) Q:SEQN=""
 .S P3=+SEQN,SEQN=$P($$PROD0^PSNAPIS(,P3),"^",7)
 .;S ^TMP($J,LIST,"IN","PROFILE","R;"_PSORDI_";PROFILE;"_DO)=SEQN_"^"_RDIVUID_"^0^"_RDIDNAM_"^^"
 .S ^TMP($J,LIST,"IN","PROFILE","R;"_PSORDI_";PROFILE;"_DO)=SEQN_"^"_RDIVUID_"^0^"_RDIDNAM_"^^O"     ;P785
 Q
 ;
PARSE ; PULL INFORMATION FROM ^XTMP
 N PSORDI,LOCAL,NEWISS,BADEXP,PSOPRE,PSO30,NEWDC,NEWEXP
 S PSORDI=0 F  S PSORDI=$O(^XTMP("ORRDI","PSOO",PSODFN,PSORDI)) Q:'PSORDI  D
 .S RDISTA=$G(^XTMP("ORRDI","PSOO",PSODFN,PSORDI,5,0))
 .I RDISTA="DELETED" Q
 .S RDIINST=$G(^XTMP("ORRDI","PSOO",PSODFN,PSORDI,1,0))
 .S RDIDNAM=$G(^XTMP("ORRDI","PSOO",PSODFN,PSORDI,2,0))
 .S RDIVUID=$G(^XTMP("ORRDI","PSOO",PSODFN,PSORDI,3,0))
 .I RDIVUID="" Q
 .D GETPROD^PSOORRDI
 .Q:$E($G(PSOCLASS),1,2)="XA"
 .S RDIRX=$G(^XTMP("ORRDI","PSOO",PSODFN,PSORDI,4,0))
 .S RDIQTY=$G(^XTMP("ORRDI","PSOO",PSODFN,PSORDI,6,0))
 .S RDIDAYS=$P(RDIQTY,";",2),RDIQTY=$P(RDIQTY,";")
 .I $E(RDIDAYS)="D" S RDIDAYS=$P(RDIDAYS,"D",2)
 .S RDIEXP=$G(^XTMP("ORRDI","PSOO",PSODFN,PSORDI,7,0))
 .S RDIISS=$G(^XTMP("ORRDI","PSOO",PSODFN,PSORDI,8,0))
 .I RDIEXP?."/" S BADEXP=1 D  I BADEXP Q
 ..I RDIISS?."/" Q
 ..S PSOPRE=$E(DT) I $P(RDIISS,"/",3)>($E(DT,2,3)+1) S PSOPRE=PSOPRE-1
 ..S NEWISS=PSOPRE_$P(RDIISS,"/",3)_$P(RDIISS,"/")_$P(RDIISS,"/",2) I NEWISS>(DT-10000) S RDIEXP=RDIISS,BADEXP=0
 .I RDISTA["EXPIRE" S PSO30=0 D  I PSO30 Q
 ..S PSOPRE=$E(DT) I $P(RDIEXP,"/",3)>($E(DT,2,3)+1) S PSO30=1 Q
 ..S NEWEXP=PSOPRE_$P(RDIEXP,"/",3)_$P(RDIEXP,"/")_$P(RDIEXP,"/",2)
 ..S X1=NEWEXP,X2=30 D C^%DTC I X<DT S PSO30=1
 .I RDIRX'="" S LOCAL=0 D CHKLOCAL I LOCAL Q
 .S RDIFILL=$G(^XTMP("ORRDI","PSOO",PSODFN,PSORDI,9,0))
 .I RDISTA["DISCONT" S PSO30=0 D  I PSO30 Q
 ..S PSOPRE=$E(DT) I $P(RDIFILL,"/",3)>($E(DT,2,3)+1) S PSO30=1 Q
 ..S NEWDC=PSOPRE_$P(RDIFILL,"/",3)_$P(RDIFILL,"/")_$P(RDIFILL,"/",2)
 ..S X1=NEWDC,X2=30+RDIDAYS D C^%DTC I X<DT S PSO30=1
 .I RDISTA["DRUG INTERACTION" S RDISTA="NON-VERIFIED"
 .S RDIREF=$G(^XTMP("ORRDI","PSOO",PSODFN,PSORDI,10,0))
 .S RDIPHYS=$G(^XTMP("ORRDI","PSOO",PSODFN,PSORDI,11,0))
 .S PSOSIG="" F  S PSOSIG=$O(^XTMP("ORRDI","PSOO",PSODFN,PSORDI,14,PSOSIG)) Q:PSOSIG=""  S PSOSIG(PSOSIG)=^(PSOSIG)
 .S ^TMP($J,LIST,"OUT","REMOTE",PSORDI)=RDIINST_"^"_RDIVUID_"^"_RDIDNAM_"^"_RDISTA_"^"_RDIRX_"^"_RDIFILL_"^"_RDIDAYS_"^"_RDIQTY_"^"_RDIREF_"^"_RDIEXP_"^"_RDIPHYS_"^"_RDIISS
 .S PSOSIG="" F  S PSOSIG=$O(PSOSIG(PSOSIG)) Q:PSOSIG=""  S ^TMP($J,LIST,"OUT","REMOTE",PSORDI,"SIG",PSOSIG)=PSOSIG(PSOSIG)
 Q
 ;
CHKLOCAL ; IF SAME RX NUMBER AND ISSUE DATE - LOCAL RX
 N PSOISS
 I $D(^PSRX("B",RDIRX)) D
 .N PSORX
 .S PSORX=$O(^PSRX("B",RDIRX,"")) I 'PSORX Q
 .S PSOISS=$P($G(^PSRX(PSORX,0)),"^",13)
 .S PSOISS=$E(PSOISS,4,5)_"/"_$E(PSOISS,6,7)_"/"_$E(PSOISS,2,3)
 .I PSOISS=RDIISS S LOCAL=1 Q
 Q
 ;
FILTER ; FOR SAME DRUG VUID FOR SAME SITE, KEEP 1 ENTRY - CHECK BY ACTIVE STATUS FIRST THEN BY GREATEST EXPIRATION DATE
 N XX,RDI,OLDEXP,RDIEXP,RDIEXP2,OLDEXP2,PSORDI,RDISTA,OLDSTA,OLDRDI,ZZ
 S PSORDI=0
 F  S PSORDI=$O(^TMP($J,LIST,"OUT","REMOTE",PSORDI)) Q:'PSORDI  D
 .S XX=$G(^TMP($J,LIST,"OUT","REMOTE",PSORDI)),RDIINST=$P(XX,"^"),RDIVUID=$P(XX,"^",2),RDISTA=$P(XX,"^",4),RDIEXP=$P(XX,"^",10) Q:RDIINST=""  Q:RDIVUID=""  I RDIEXP="" Q
 .I $D(RDI(RDIINST,RDIVUID)) S ZZ=RDI(RDIINST,RDIVUID) D  Q
 ..I RDISTA="ACTIVE"!(RDISTA["SUSPEN") D  Q
 ...S OLDSTA=$P(ZZ,"^",2) I OLDSTA["ACTIVE"!(OLDSTA["SUSPEN") D CHKEXP Q
 ...S OLDRDI=$P(ZZ,"^") K ^TMP($J,LIST,"OUT","REMOTE",OLDRDI) D SETRDI
 ..S OLDSTA=$P(ZZ,"^",2) I OLDSTA["ACTIVE"!(OLDSTA["SUSPEN") K ^TMP($J,LIST,"OUT","REMOTE",PSORDI) Q
 ..D CHKEXP ; ALL OTHER STATUSES - KEEP BY GREATER EXPIRATION DATE
 .D SETRDI
 Q
 ;
CHKEXP ; 
 N PSOPRE
 S OLDEXP=$P(ZZ,"^",3) D  I OLDEXP2>RDIEXP2 K ^TMP($J,"OUT","REMOTE",PSORDI) Q
 .S PSOPRE=$E(DT) I $P(RDIEXP,"/",3)>($E(DT,2,3)+1) S PSOPRE=PSOPRE-1
 .S RDIEXP2=PSOPRE_$P(RDIEXP,"/",3)_$P(RDIEXP,"/")_$P(RDIEXP,"/",2)
 .S PSOPRE=$E(DT) I $P(OLDEXP,"/",3)>($E(DT,2,3)+1) S PSOPRE=PSOPRE-1
 .S OLDEXP2=PSOPRE_$P(OLDEXP,"/",3)_$P(OLDEXP,"/")_$P(OLDEXP,"/",2)
 S OLDRDI=$P(ZZ,"^") K ^TMP($J,LIST,"OUT","REMOTE",OLDRDI) D SETRDI
 Q
 ;
SETRDI ;
 S RDI(RDIINST,RDIVUID)=PSORDI_"^"_RDISTA_"^"_RDIEXP
 Q
CPRS(PSODFN,LIST,PDRG,PTY) ;
 ;PDRG - Drug array in format of PDRG(n)=IEN (#50) ^ Drug name
 ;PTY - P1;P2 where P1="I" for IP & "O" for OP (required), P2=Pharm order# (optional)
 I '$G(PSODFN) W !,"Patient UNDEFINED!",! Q
 I '$O(PDRG(0)) W !,"Dispense Drug(s) UNDEFINED!",! Q
 I '$D(LIST) W !,"Input Base UNDEFINED!",! Q
 S ^TMP($J,LIST,"IN","PING")="" D IN^PSSHRQ2(LIST) I $P(^TMP($J,LIST,"OUT",0),"^")=-1 Q
 K ^TMP($J,"ORDERS"),^TMP($J,"DD"),^TMP($J,LIST) N ZII,INDX,INDD,PSODUPSP,PSODUPSY,PSODUPLS,PSOFRMOR,PSOSUPNN S (INDX,INDD)=0,PSODUPSY=$G(PTY),PSODUPLS=LIST,PSOFRMOR=1
 ;build patient's drug profile outpat/inpat/non-va
 D BLD^PSOORDRG,ENCHK^PSJORUT2(PSODFN,.INDX),NVA^PSOORDRG
 ;dup drug check CPRS ONLY
 S PSOICT="",CNT=0 F ZII=0:0 S ZII=$O(PDRG(ZII)) Q:'ZII  D:$$SUP^PSSDSAPI(+$P(PDRG(ZII),"^"))
 .S PSOY=$P(PDRG(ZII),"^")_"^"_$P($G(^PSDRUG($P(PDRG(ZII),"^"),0)),"^"),PSOY(0)=$G(^PSDRUG(PDRG(ZII),0)),PSOSUPNN=$P(PDRG(ZII),"^",4)
 .S IEN=+PSOY,NAME=$P(PSOY,"^",2),DNM=0 K PSOX1,PSOY
 .F  S DNM=$O(^TMP($J,"ORDERS",DNM)) Q:'DNM  I NAME=$P(^TMP($J,"ORDERS",DNM),"^",3) D
 ..S INDD=$G(INDD)+1,^TMP($J,"DD",INDD,0)=IEN_"^"_NAME_"^"_$P(^TMP($J,"ORDERS",DNM),"^",4)_"^"_$P(^(DNM),"^",5),PSODUPSP(IEN,$S(PSOSUPNN:PSOSUPNN,1:"ACCEPT"))=PSODUPSY,PSODUPSP(IEN,"NAME")=NAME
 K ^TMP($J,"ORDERS")
 D ORD
 Q
DRG ;
 I $$SUP^PSSDSAPI(IEN) Q
 N ID,SEQN S PSODRUG("NDF")=$S($G(^PSDRUG(IEN,"ND"))]"":+^("ND")_"A"_$P(^("ND"),"^",3),1:0)
 S ID=$$GETVUID^XTID(50.68,,+$P($G(PSODRUG("NDF")),"A",2)_",")
 S P1=$P($G(^PSDRUG(IEN,"ND")),"^"),P2=$P($G(^("ND")),"^",3),X=$$PROD0^PSNAPIS(P1,P2),SEQN=$P(X,"^",7)
 I '$D(PSJDGCK) S CNT=$G(CNT)+1,^TMP($J,LIST,"IN","PROSPECTIVE",$P(PTY,";")_";"_$P(PTY,";",2)_";PROSPECTIVE;"_CNT)=SEQN_"^"_+ID_"^"_IEN_"^"_NAME_$S($G(PSOFRMOR):"^"_PSOFRMNM,1:"")
 I $D(PSJDGCK),'$D(PSGDGCKF) S CNT=$G(CNT)+1,^TMP($J,LIST,"IN","PROSPECTIVE",$P(PTY,";")_";"_$P(PTY,";",2)_";PROSPECTIVE;"_CNT)=SEQN_"^"_+ID_"^"_IEN_"^"_NAME
 K ID,SEQN,P1,P2,X,DNM
 Q
 ;
DRGSUP ;Create "prospective" nodes for duplicate supply entries 
 N PSODPSID,PSODPSQN,PSODPSP1,PSODPSP2,PSODPSP3,PSODPSXX,PSODPSLP,PSODPSNF,PSODPSCT,PSODPSC1,PSODPSNM,PSODPSOR
 S PSODPSCT=0
 S PSODPSC1="" F  S PSODPSC1=$O(^TMP($J,PSODUPLS,"IN","PROSPECTIVE",PSODPSC1)) Q:PSODPSC1=""  S PSODPSP3=$P(PSODPSC1,";",4) I PSODPSP3>PSODPSCT S PSODPSCT=PSODPSP3
 S PSODPSLP="" F  S PSODPSLP=$O(PSODUPSP(PSODPSLP)) Q:PSODPSLP=""  D
 .S PSODPSOR="" F  S PSODPSOR=$O(PSODUPSP(PSODPSLP,PSODPSOR)) Q:PSODPSOR=""  D:PSODPSOR'="NAME"
 ..S PSODPSNM=$G(PSODUPSP(PSODPSLP,"NAME"))
 ..S PSODPSNF=$S($G(^PSDRUG(PSODPSLP,"ND"))]"":+^PSDRUG(PSODPSLP,"ND")_"A"_$P(^PSDRUG(PSODPSLP,"ND"),"^",3),1:0)
 ..S PSODPSID=$$GETVUID^XTID(50.68,,+$P($G(PSODPSNF),"A",2)_",")
 ..S PSODPSP1=$P($G(^PSDRUG(PSODPSLP,"ND")),"^"),PSODPSP2=$P($G(^PSDRUG(PSODPSLP,"ND")),"^",3),PSODPSXX=$$PROD0^PSNAPIS(PSODPSP1,PSODPSP2),PSODPSQN=$P(PSODPSXX,"^",7)
 ..S PSODPSCT=$G(PSODPSCT)+1,^TMP($J,PSODUPLS,"IN","PROSPECTIVE",$P(PSODUPSY,";")_";"_$P(PSODUPSY,";",2)_";PROSPECTIVE;"_PSODPSCT)=PSODPSQN_"^"_+PSODPSID_"^"_PSODPSLP_"^"_$G(PSODPSNM)_$S(PSODPSOR="ACCEPT":"",1:"^"_PSODPSOR)
 Q
 ;
RVAGEN ;va generic for remote drugs
 N PSOVUID,PSONDF,PSOVAG,DIC
 S PSOVUID=$P(^TMP($J,"PSOPEPS","OUT","REMOTE",$P(ON,";",2)),"^",2) Q:'$G(PSOVUID)
 K PSORDIID S PSOVAGEN="" D GETIREF^XTID("50.68",".01",PSOVUID,"PSORDIID")
 S PSONDF=$O(PSORDIID(50.68,.01,"")) K PSORDIID
 I +PSONDF D DATA^PSN50P68(+PSONDF,,"PSONDF") D
 .S PSOVAG=$P($G(^TMP($J,"PSONDF",+PSONDF,.05)),U,2) ;*484
 .N ZOT ;*484
 .S ZOT=$S($P(ON,";")["C":1,$P(ON,";")="O":2,$P(ON,";")="R":3,$P(ON,";")="P":4,1:5) ;*484
 .S ZDGDG(SV,ZOT,PSOVAG,DRG)=ON_"^"_CT,ZZDGDG3(SV,PSOVAG,DRG)="" ;*484
 .I '$D(NSRT(SV,PSOVAG)) S NSRT(SV,PSOVAG)=3
 .E  S $P(NSRT(SV,PSOVAG),"^",1)=$P(NSRT(SV,PSOVAG),"^",1)_",3"
 K ^TMP($J,"PSONDF")
 Q
