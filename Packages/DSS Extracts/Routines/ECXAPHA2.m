ECXAPHA2 ;ALB/TMD-Pharmacy Extracts Unusual Volumes Report ;4/9/19  15:47
 ;;3.0;DSS EXTRACTS;**40,49,84,104,105,113,136,143,144,174,178,184,187,190**;Dec 22, 1997;Build 36
 ;
 ; Reference to EXTRACT^PSO52EX in ICR #4902
 ; Reference to ^TMP($J supported by SACC 2.3.2.5.1
 ;
EN ; entry point
 N COUNT,ECUNIT,LINE,ECDFN,ECD,ECDRG,ECDAY,ECDFN,ECQTY,ECUNIT,ECCOST,ECDS,ECXCOUNT
 I '$G(ECXPORT) K ^TMP($J) ;144
 S (COUNT,ECDS,ECXCOUNT)=0,ECUNIT=""
 S ECD=ECSD1,ECED=ECED+.3
 S LINE=$S(ECXOPT=1:"PRE",ECXOPT=2:"IVP",ECXOPT=3:"UDP",ECXOPT=4:"BCM",1:"EXIT") ;144
 D @LINE
 Q
 ;
PRE ; entry point for PRE data
 N ECRFL,ECRX,ECREF,ECDATA,ECDATA1,ECPRC,IEN
 K ^TMP($J,"ECXDSS")
 ;call pharmacy api pso52ex
 D EXTRACT^PSO52EX(ECD,ECED,"ECXDSS")
 S ECREF="RF"
 ;order thru fills and refills; refill values 0 thru 11
 ;     Note:  refill 0 = original fill
 F  S ECD=$O(^TMP($J,"ECXDSS","AL",ECD)),IEN=0 Q:'ECD  Q:ECD>ECED  Q:ECXERR  F  S IEN=$O(^TMP($J,"ECXDSS","AL",ECD,IEN)),ECRFL=""  Q:'IEN  Q:ECXERR  F  S ECRFL=$O(^TMP($J,"ECXDSS","AL",ECD,IEN,ECRFL)) Q:ECRFL=""  Q:ECXERR  D PRE2
 ;
 ;order thru partial fills
 S ECD=ECSD1,ECREF="P"
 F  S ECD=$O(^TMP($J,"ECXDSS","AM",ECD)),IEN=0 Q:'ECD  Q:ECD>ECED  Q:ECXERR  F  S IEN=$O(^(ECD,IEN)),ECRFL=""  Q:'IEN  Q:ECXERR  F  S ECRFL=$O(^(IEN,ECRFL)) Q:'ECRFL  Q:ECXERR  D PRE2
 K ^TMP($J,"ECXDSS")
 Q
 ;
PRE2 ; get Prescription data
 I (ECREF="RF")&(ECRFL) D
 .S ECQTY=+^TMP($J,"ECXDSS",IEN,ECREF,ECRFL,1)
 .S ECDS=+^TMP($J,"ECXDSS",IEN,ECREF,ECRFL,1.1)
 .S ECPRC=^TMP($J,"ECXDSS",IEN,ECREF,ECRFL,1.2)
 I (ECREF="RF")&('ECRFL) D
 .S ECQTY=+^TMP($J,"ECXDSS",IEN,7)
 .S ECDS=+^TMP($J,"ECXDSS",IEN,8)
 .S ECPRC=+^TMP($J,"ECXDSS",IEN,17)
 I ECREF="P" D
 .S ECQTY=+^TMP($J,"ECXDSS",IEN,ECREF,ECRFL,.04)
 .S ECDS=+^TMP($J,"ECXDSS",IEN,ECREF,ECRFL,.041)
 .S ECPRC=+^TMP($J,"ECXDSS",IEN,ECREF,ECRFL,.042)
 S ECDAY=ECD ;144
 S ECDFN=$P(^TMP($J,"ECXDSS",IEN,2),U) ;144
 S ECDRG=+$P(^TMP($J,"ECXDSS",IEN,6),U) ;144
 S ECCOST=ECQTY*ECPRC ;144
 S ECORD=^TMP($J,"ECXDSS",IEN,.01)
 ;Is cost/volume greater than threshold?
 I $S($G(ECXCOST):ECCOST,1:ECQTY)>ECTHLD D FILE ;144
 Q
 ;
IVP ; entry point for IVP Data
 N DFN,ON,DA,SA,ECCOUNT ;143
 F  S ECD=$O(^ECX(728.113,"A",ECD)),DFN=0 Q:'ECD  Q:ECD>ECED  Q:ECXERR  F  S DFN=$O(^ECX(728.113,"A",ECD,DFN)),ON=0  Q:'DFN  F  S ON=$O(^ECX(728.113,"A",ECD,DFN,ON)),DA=0 Q:'ON  K ^TMP($J,"A"),^("S") D  Q:ECXERR
 .F  S DA=$O(^ECX(728.113,"A",ECD,DFN,ON,DA)) Q:'DA  Q:ECXERR  I $D(^ECX(728.113,DA,0)) S EC=^(0) Q:ECXERR  D
 ..S ECDRG=$P(EC,U,4)
 ..S SA=$S($P(EC,U,8)]"":"A",$P(EC,U,9):"S",1:"")
 ..I SA="" Q  ;187
 ..; set up new record for first DA for this drug
 ..I '$D(^TMP($J,SA,ECDRG)) D
 ...S ECQTY=+$S(SA="A":+$P(EC,U,7),SA="S":+$P(EC,U,9),1:0)
 ...S ECUNIT=$S(SA="A":$P(EC,U,8),SA="S":"ML",1:"")
 ...S ECCOST=$P(EC,U,12),ECDFN=DFN
 ...S ^TMP($J,SA,ECDRG)=ECUNIT_U_ECD_U_ECDFN_U_ECCOST_U_ECQTY
 ...S ^(ECDRG,1)=0
 ..; add to qty (0,1, or -1) to total
 ..S ^TMP($J,SA,ECDRG,1)=^TMP($J,SA,ECDRG,1)+$S($P(EC,U,6)=1:1,$P(EC,U,6)=4:-1,1:-1) ;187 if transaction type is "canceled" subtract 1
 .; looped thru all DAs for this order - now check for unusual volumes
 .F SA="S","A" S ECDRG="" F  S ECDRG=$O(^TMP($J,SA,ECDRG)) Q:ECDRG=""  Q:ECXERR  D
 ..S ECQTY=$P(^TMP($J,SA,ECDRG),U,5),ECCOUNT=^(ECDRG,1)
 ..S ECQTY=ECQTY*ECCOUNT
 ..S ECUNIT=$P(^TMP($J,SA,ECDRG),U) ;144
 ..S ECDAY=$P(^(ECDRG),U,2) ;144
 ..S ECDFN=$P(^(ECDRG),U,3) ;144
 ..; New Cost calculation ** 136,144
 ..; Removed avg cost search from 136 use existing avgcost and quantity vs count  ** 143,144
 ..S ECCOST=$P(^(ECDRG),U,4)*ECQTY ;144
 ..;144 Check volume versus threshold
 ..I '$G(ECXCOST) I ECQTY>ECTHLD!(ECQTY<-ECTHLD) D FILE ;144
 ..;144 Check cost versus threshold
 ..I $G(ECXCOST) I ECCOST>ECTHLD D FILE ;144
 K ^TMP($J,"A"),^("S")
 Q
 ;
UDP ; entry point for UDP data
 N ECXJ,ECDATA,ECORD ;136
 F  S ECD=$O(^ECX(728.904,"A",ECD)) Q:'ECD  Q:ECD>ECED  Q:ECXERR  D
 .S ECXJ=0 F  S ECXJ=$O(^ECX(728.904,"A",ECD,ECXJ)) Q:'ECXJ  Q:ECXERR  I $D(^ECX(728.904,ECXJ,0)) D
 ..S DATA=^ECX(728.904,ECXJ,0),ECQTY=$P(DATA,U,5)
 ..S ECDFN=$P(DATA,U,2),ECDRG=$P(DATA,U,4),ECCOST=$P(DATA,U,8),ECDAY=ECD,ECORD=$P(DATA,U,10) ;136,144
 ..;144 Check volume or cost against threshold
 ..I $S($G(ECXCOST):ECCOST,1:ECQTY)>ECTHLD D FILE ;144
 Q
 ;
BCM ;Section added in patch 144
 N PIEN,IDAT,RIEN,ECXDFN,ECXNOD,ECXORN,ACTDT,ECXASTA,CCDORD,CCDGVN,CCUNIT,CCTYPE,DRG,ECXDRGC,UNITCOST,CCIEN,ECXIVSC,ECXIVAC,ECORD
 S PIEN=0
 I $G(ECSD)="" S ECSD=DT
 ; loop thru and get each new patient, reset the start date to ECSD
 F  S PIEN=$O(^PSB(53.79,"AADT",PIEN)) Q:('PIEN)  Q:ECXERR  S IDAT=ECSD D
 .F  S IDAT=$O(^PSB(53.79,"AADT",PIEN,IDAT)) Q:'IDAT!(IDAT>ECED)  Q:ECXERR  S RIEN="" D
 ..F  S RIEN=$O(^PSB(53.79,"AADT",PIEN,IDAT,RIEN)) Q:'RIEN  D
 ...S ECXNOD=^PSB(53.79,RIEN,0) Q:'ECXNOD  S ECXDFN=$P($G(ECXNOD),U)
 ...S ECXORN=$$GET1^DIQ(53.79,RIEN,.11)
 ...I ECXORN["U" Q:$$CHKUD^ECXBCM(ECXDFN,ECSD,ECED)  Q:ECXBCM="I"
 ...I ECXORN["V" Q:$$CHKIV^ECXBCM(ECXDFN,ECSD,ECED)  Q:ECXBCM="N"
 ...S ACTDT=$$GET1^DIQ(53.79,RIEN,.06,"I") Q:ACTDT'=IDAT
 ...S ECXASTA=$$GET1^DIQ(53.79,RIEN,.09,"I")
 ...I "^G^S^C^"'[("^"_ECXASTA_"^") Q  ;process 'G'iven,'S'topped,'C'ompleted
 ...D CCODE(RIEN)
 Q
 ;
CCODE(RIEN) ; 144 get component information added in patch 144
 ;  input - IEN of the BCMA MEDICATION LOG File
 ; 
 ; output - CCIEN: pointer to a variable pointer field to file #50, #52.6, or #52.7
 ;          CCDORD: .02 field of file #50, #52.6, or #52.7
 ;          CCDGVN: .03 FIELD of file #50, #52.6, or #52.7
 ;          CCUNIT: .04 field of file #50, #52.6, or #52.7
 ;          CCTYPE: derived field, "D", "A", or "S"
 ;
 N J,DATA,I
 S (CCIEN,CCDORD,CCDGVN,CCUNIT,CCTYPE)=""
 F I=.5,.6,.7 D  Q:ECXERR
 .I '$O(^PSB(53.79,RIEN,I,0)) Q
 .S J=0 F  S J=$O(^PSB(53.79,RIEN,I,J)) Q:'J  Q:ECXERR  D
 ..S (UNITCOST,ECXDRGC,ECXIVSC,ECXIVAC)=0
 ..S (ECDSPU,ECPPOU,ECDUPOU)=0 ;184
 ..S DATA=^PSB(53.79,RIEN,I,J,0)
 ..S CCIEN=$P(DATA,U),CCDORD=$P(DATA,U,2),CCDGVN=$S($P(DATA,U,3)?1.N1"E"1.N.E:1,+($P(DATA,U,3))>0:+($P(DATA,U,3)),1:1) ;174 Added check for exponential numbers
 ..S CCUNIT=$S($P(DATA,U,4)?1.N1"E"1.N.E:1,+($P(DATA,U,4))>0:+($P(DATA,U,4)),1:1) ;174 Added check for exponential numbers
 ..I I=.5 D
 ...S DRG=CCIEN,UNITCOST=$$GET1^DIQ(50,DRG,16,"I")
 ...;S ECXDRGC=(CCDGVN*CCUNIT)*UNITCOST
 ...S ECXDRGC=(CCDGVN*UNITCOST) ;184 Don't include Unit of Administration in Drug Cost.
 ..I I=.6 D
 ...S DRG=$$GET1^DIQ(52.6,CCIEN,1,"I"),UNITCOST=$$GET1^DIQ(52.6,CCIEN,7,"I")
 ...S ECXIVAC=CCDGVN*UNITCOST
 ..I I=.7 D
 ...S DRG=$$GET1^DIQ(52.7,CCIEN,1,"I"),UNITCOST=$$GET1^DIQ(52.7,CCIEN,7,"I")
 ...S ECXIVSC=CCDGVN*UNITCOST
 ..S CCTYPE=$S(I=.5:"D",I=.6:"A",I=.7:"S",1:"")
 ..S CCIEN=$S(I=.5:CCIEN_";PSDRUG(",I=.6:CCIEN_";PS(52.6,",I=.7:CCIEN_";PS(52.7,",1:"")
 ..S ECDAY=IDAT
 ..S ECDFN=ECXDFN
 ..S ECDRG=DRG
 ..S ECQTY=CCDGVN
 ..S ECCOST=$S(ECXDRGC:ECXDRGC,ECXIVSC:ECXIVSC,ECXIVAC:ECXIVAC,1:0)
 ..S ECORD=+ECXORN
 ..;S ECPPDU=UNITCOST ;184,187
 ..I $S($G(ECXCOST):ECCOST,1:CCDGVN)>ECTHLD D FILE
 Q
 ;
FILE ; put records in temp file to print later
 N OK,ECXPAT,ECNAME,ECSSN,ECGNAME,ECNDC,ECPROD,ECFKEY,ECXPHA,J ;144
 N ECDSPU,ECPPOU,ECDUPOU ;184
 N SIG ;178
 S SIG="" ;178
 S (ECDSPU,ECPPOU,ECDUPOU)="" ;184
 ; get demographics
 S OK=$$PAT^ECXUTL3(ECDFN,$P(ECD,"."),"1;",.ECXPAT)
 I 'OK Q
 S ECNAME=ECXPAT("NAME")
 S ECSSN=ECXPAT("SSN")
 S ECDAY=$E(ECDAY,4,5)_"/"_$E(ECDAY,6,7)
 ; get drug file data
 S ECXPHA="",ECXPHA=$$PHAAPI^ECXUTL5(ECDRG)
 S ECGNAME=$P(ECXPHA,U)
 S ECNDC=$P(ECXPHA,U,3)
 S ECNDC=$$RJ^XLFSTR($P(ECNDC,"-"),6,0)_$$RJ^XLFSTR($P(ECNDC,"-",2),4,0)_$$RJ^XLFSTR($P(ECNDC,"-",3),2,0)
 S ECNDC=$TR(ECNDC,"*",0)
 S ECPROD=$P(ECXPHA,U,6)
 S ECPROD=$$RJ^XLFSTR(ECPROD,5,0)
 S ECFKEY=ECPROD_ECNDC
 S ECPPDU=$P(ECXPHA,U,7) ;187 - Price per Dispense Unit
 ;I ECXOPT'=2&'(ECXOPT=4&($G(ECXBCM)="I")) S ECUNIT=$P(ECXPHA,U,8)
 I ECXOPT'=2 S ECUNIT=$P(ECXPHA,U,8) ;184,187,190
 ;S ECUNIT=$P(ECXPHA,U,8) ;187 - Dispense Unit
 I ECXOPT=4 S ECPPOU=$P(ECXPHA,U,9),ECDUPOU=$P(ECXPHA,U,10) ;184 Added Price Per Order Unit, Dispense Unit Per Order Unit
 ; file 
 S ^TMP($J,ECFKEY,-ECQTY,ECDAY,ECXCOUNT,ECSSN)=ECNAME_U_ECSSN_U_ECDAY_U_ECGNAME_U_ECFKEY_U_ECQTY_U_ECUNIT_U_"$"_$FNUMBER(ECCOST,",",4)_U_ECDS
 ;I $G(ECXISIG) S $P(^TMP($J,ECFKEY,-ECQTY,ECDAY,ECXCOUNT,ECSSN),U,10)=$$SIG^ECXAPHA(ECORD,ECDFN) ;136,144 Get SIG data if UDP or BCM Non-IV report
 I $G(ECXISIG) S SIG=$S(ECXOPT=1:$$SIGPRE^ECXAPHA(ECORD),ECXOPT=2:$$SIGIVP^ECXAPHA(ON,ECDFN),ECXOPT=3:$$SIG^ECXAPHA(ECORD,ECDFN),$G(ECXBCM)="N":$$SIG^ECXAPHA(ECORD,ECDFN),1:$$SIGIVP^ECXAPHA(ECORD,ECDFN)) ;178
 ; 184 - Begin
 ;I $G(ECXISIG) S $P(^TMP($J,ECFKEY,-ECQTY,ECDAY,ECXCOUNT,ECSSN),U,10)=SIG ;178
 S $P(^TMP($J,ECFKEY,-ECQTY,ECDAY,ECXCOUNT,ECSSN),U,10)=SIG
 ;184 - End
 S ^TMP($J,ECFKEY,-ECQTY,ECDAY,ECXCOUNT,ECSSN)=^(ECSSN)_U_ECPPDU ;187 
 I (ECXOPT=4) D  ;184
 .;S ^TMP($J,ECFKEY,-ECQTY,ECDAY,ECXCOUNT,ECSSN)=^TMP($J,ECFKEY,-ECQTY,ECDAY,ECXCOUNT,ECSSN)_U_CCDORD_U_ECPPDU_U_ECUNIT_U_ECPPOU_U_ECDUPOU
 .S ^TMP($J,ECFKEY,-ECQTY,ECDAY,ECXCOUNT,ECSSN)=^(ECSSN)_U_CCDORD_U_ECPPOU_U_ECDUPOU ;187
 S COUNT=COUNT+1
 S ECXCOUNT=ECXCOUNT+1
 I COUNT#100=0 I $$S^ZTLOAD S (ZTSTOP,ECXERR)=1 ;136 Update ZTSTOP var to be spelled correctly
 Q
 ;
EXIT S ECXERR=1 Q
