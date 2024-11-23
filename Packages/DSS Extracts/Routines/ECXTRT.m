ECXTRT ;ALB/JAP,BIR/DMA,CML,PTD-Treating Specialty Change Extract ;6/29/18  14:57
 ;;3.0;DSS EXTRACTS;**1,8,17,24,33,35,39,46,49,84,107,105,127,161,166,170,184,190**;Dec 22, 1997;Build 36
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ; start package specific extract
 N LOC,SPC,TRT,WRD,ECATLNPI,ECPRLNPI,ECXADMTM,ECXATLPC,ECXATNPC,ECXDCDT,ECXPRLPC,ECXPRNPC,ECXMOVL,ECXMOVN,ECXMVD1,ECXMVD2,ECXTIME,REC ;161,166
 N ECXDWARD,TEMPPDIV,ECXASIH  ;166 tjl,170
 N ECXDCTM,ECD1,ECD2,ECPRO ;190
 S QFLG=0
 K ECXDD D FIELD^DID(405,.19,,"SPECIFIER","ECXDD")
 S ECPRO=$E(+$P(ECXDD("SPECIFIER"),"P",2)) K ECXDD
 K ^TMP($J,"ECXTMP"),^TMP($J,"ECXTRTMM") S TRT=0 ;190 - Clear Mailman Message tmp global
 F  S TRT=$O(^DIC(45.7,TRT)) Q:+TRT=0  S SPC=$P(^DIC(45.7,TRT,0),U,2),^TMP($J,"ECXTMP",TRT)=SPC
 S ECED=ECED+.3,ECD=ECSD1
 ;loop through type 6 movements to get treating specialty and provider changes
 F  S ECD=$O(^DGPM("ATT6",ECD)),ECDA=0 Q:('ECD)!(ECD>ECED)!(QFLG)  F  S ECDA=$O(^DGPM("ATT6",ECD,ECDA)) Q:'ECDA  D  Q:QFLG
 .I $D(^DGPM(ECDA,0)) S EC=^(0),ECXDFN=+$P(EC,U,3) D  Q:QFLG
 ..S ECXMVD1=$P(EC,U)  ; ,WRD=$P(EC,U,6)  166  tjl
 ..N ECXNMPI,ECXCERN,ECXSIGI ;184
 ..;
 ..;- Call sets ECXA (In/Out indicator)
 ..Q:'$$PATDEM^ECXUTL2(ECXDFN,ECXMVD1,"1;",13)
 ..S ECXNMPI=ECXMPI ;184
 ..S ECMT=$P(EC,U,18),ECXADM=$P(EC,U,14),ECXADT=$P($G(^DGPM(ECXADM,0)),U)
 ..;skip the record if its the admission treat. spec. change for this episode of care
 ..Q:ECXADM=$P(EC,U,24)
 ..S (ECXLOS,ECXLOSA,ECXLOSP)="" S ECXDSSD=""
 ..K LOC D SETLOC(ECXDFN,ECXADM,ECPRO,.LOC)
 ..;get data for current (new) ts movement
 ..S ECD1=9999999.9999999-ECXMVD1
 ..I '+ECXMVD1 D SETTMP("MISSING MOVEMENT DATE",ECDA,ECXMVD1,ECXDFN,ECXADM) Q  ;190 - if missing movement date, log error and skip record
 ..D FINDLOC(ECD1,.LOC,.ECXSPCN,.ECXPRVN,.ECXATTN,.ECXMOVN,.ECXTRTN)
 ..Q:ECXSPCN=""
 ..S ECD2=$O(LOC(ECD1)) Q:ECD2=""
 ..S ECXMVD2=9999999.9999999-ECD2
 ..;get data for previous (losing) ts movement
 ..I '+ECD2 D SETTMP("MISSING PREVIOUS TS MOVEMENT DATE/TIME",ECDA,ECXMVD1,ECXDFN,ECXADM) Q  ;190 - if missing previous ts movement date, log error and skip record
 ..D FINDLOC(ECD2,.LOC,.ECXSPCL,.ECXPRVL,.ECXATTL,.ECXMOVL,.ECXTRTL)
 ..;if ts has changed, find los on losing ts
 ..D:ECXTRTL'=ECXTRTN PREVTRT^ECXTRT1(.LOC,ECD1,ECD2,ECXTRTL,.ECXLOS)
 ..;whether ts has changed or not, see if primary provider has changed
 ..;don't bother if there's no data on current primary provider or no change in provider
 ..D:(ECXPRVN'="")&(ECXPRVN'=ECXPRVL) PREVPRV^ECXTRT1(.LOC,ECD1,ECXPRVN,ECD2,.ECXPRVL,.ECXLOSP)
 ..;whether ts has changed or not, see if attending physician has changed
 ..;don't bother if there's no data on current attending physician or no change in attending
 ..D:(ECXATTN'="")&(ECXATTN'=ECXATTL) PREVATT^ECXTRT1(.LOC,ECD1,ECXATTN,ECD2,.ECXATTL,.ECXLOSA)
 ..S ECXDATE=$$ECXDATE^ECXUTL(ECXMVD1,ECXYM),ECXTIME=$$ECXTIME^ECXUTL(ECXMVD1)
 ..S ECXADMDT=$$ECXDATE^ECXUTL(ECXADT,ECXYM),ECXADMTM=$$ECXTIME^ECXUTL(ECXADT),ECXDCDT="",ECXDCTM="" ;190
 ..;- Production Division
 ..S ECXPDIV=""
 ..I ECXLOGIC>2003 S ECXPDIV=$S(WRD="":"",1:$$NPDIV(WRD))
 ..;
 ..;- Observation patient indicator (YES/NO)
 ..S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS)
 ..;
 ..;- Chg outpat with movemnt/discharge to inpat (to comply w/existing business rule)
 ..I ECXA="O"&(ECXOBS="NO")&(ECXMVD1) S ECXA="I"
 ..; ******* - PATCH 127, ADD PATCAT CODE ********
 ..S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)
 ..;
 ..;- Get providers person classes
 .. S ECXATLPC=$$PRVCLASS^ECXUTL($E(ECXATTL,2,999),ECXADT)
 .. S ECATLNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXATTL,2,999),ECXADT)
 .. S:+ECATLNPI'>0 ECATLNPI="" S ECATLNPI=$P(ECATLNPI,U)
 .. S ECXPRNPC=$$PRVCLASS^ECXUTL($E(ECXPRVN,2,999),ECXADT)
 .. S ECPRVNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXPRVN,2,999),ECXADT)
 .. S:+ECPRVNPI'>0 ECPRVNPI="" S ECPRVNPI=$P(ECPRVNPI,U)
 .. S ECXATNPC=$$PRVCLASS^ECXUTL($E(ECXATTN,2,999),ECXADT)
 .. S ECATTNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXATTN,2,999),ECXADT)
 .. S:+ECATTNPI'>0 ECATTNPI="" S ECATTNPI=$P(ECATTNPI,U)
 .. S ECXPRLPC=$$PRVCLASS^ECXUTL($E(ECXPRVL,2,999),ECXADT)
 .. S ECPRLNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXPRVL,2,999),ECXADT)
 .. S:+ECPRLNPI'>0 ECPRLNPI="" S ECPRLNPI=$P(ECPRLNPI,U)
 ..;
 ..;- If no encounter number, don't file record
 ..S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADT,,ECXTS,ECXOBS,ECHEAD,,)
 ..I $G(ECXASIH) S ECXA="A" ;170
 ..D:ECXENC'="" FILE^ECXTRT2
 ;for nhcu episodes with intervening asih stays, the los calculated here is not accurate,
 ;but it never has been; this is best solution within current extract framework;
 ;at discharge the los calculated for nhcu episodes will be the los since admission w/o asih los subtracted;
 ;
 ;loop through discharges to get last treating specialty
 S ECD=ECSD1
 F  S ECD=$O(^DGPM("ATT3",ECD)),ECDA=0 Q:'ECD  Q:ECD>ECED  F  S ECDA=$O(^DGPM("ATT3",ECD,ECDA)) Q:'ECDA  D  Q:QFLG
 .I $D(^DGPM(ECDA,0)) S EC=^(0),ECXDFN=+$P(EC,U,3) D  Q:QFLG
 ..S ECXMVD1=$P(EC,U)  ;WRD=$P(EC,U,6)  166  tjl
 ..S (ECXDATE,ECXDCDT)=$$ECXDATE^ECXUTL(ECXMVD1,ECXYM),(ECXTIME,ECXDCTM)=$$ECXTIME^ECXUTL(ECXMVD1) ;190
 ..I ECXDCDT'>0 S ECXDCDT=""
 ..S ECMT=$P(EC,U,18),ECXADM=$P(EC,U,14),ECXADT=$P($G(^DGPM(ECXADM,0)),U,1)
 ..S (ECXTRTN,ECXSPCN,ECXPRVN,ECXATTN)="" S (ECXLOS,ECXLOSA,ECXLOSP)="" S ECXDSSD=""
 ..K LOC D SETLOC(ECXDFN,ECXADM,ECPRO,.LOC)
 ..S ECD1=9999999.9999999-ECXMVD1
 ..;get ts change just before d/c
 ..S ECD2=$O(LOC(ECD1)),ECXMVD2=9999999.9999999-ECD2
 ..I '+ECD2 D SETTMP("MISSING PREVIOUS TS MOVEMENT DATE",ECDA,ECXMVD1,ECXDFN,ECXADM) Q  ;190 - if missing previous ts movement date, log error and skip record
 ..D FINDLOC(ECD2,.LOC,.ECXSPCL,.ECXPRVL,.ECXATTL,.ECXMOVL,.ECXTRTL)
 ..;
 ..;- Call sets ECXA (In/Out indicator) using date before discharge
 ..Q:'$$PATDEM^ECXUTL2(ECXDFN,ECXMVD2,"1;",13)
 ..S ECXNMPI=ECXMPI ;184
 ..S WRD=$P($G(ECXDWARD),U)  ;166 tjl - Set Production Division Code based on Ward at Discharge
 ..S ECXADMDT=$$ECXDATE^ECXUTL(ECXADT,ECXYM),ECXADMTM=$$ECXTIME^ECXUTL(ECXADT)
 ..;if closest ts change is admission ts, cant go back any further
 ..S TRT=$O(LOC(ECD2,0)),REC=$O(LOC(ECD2,TRT,0))
 ..I REC=ECXADM D
 ...S X1=ECXMVD1,X2=ECXMVD2 D ^%DTC S ECXLOS=X
 ...I ECXPRVL'="" S X1=ECXMVD1,X2=ECXMVD2 D ^%DTC S ECXLOSP=X
 ...I ECXATTL'="" S X1=ECXMVD1,X2=ECXMVD2 D ^%DTC S ECXLOSA=X
 ..;otherwise, need to find when change to last ts occurred
 ..I REC'=ECXADM D
 ...D PREVTRT^ECXTRT1(.LOC,ECD1,ECD2,ECXTRTL,.ECXLOS)
 ...D PREVPRV^ECXTRT1(.LOC,ECD1,ECXPRVN,ECD2,.ECXPRVL,.ECXLOSP)
 ...D PREVATT^ECXTRT1(.LOC,ECD1,ECXATTN,ECD2,.ECXATTL,.ECXLOSA)
 ..S:ECXLOS>9999 ECXLOS=9999 S:ECXLOSA>9999 ECXLOSA=9999
 ..S:ECXLOSP>9999 ECXLOSP=9999
 ..;- Production Division
 ..S ECXPDIV=""
 ..I ECXLOGIC>2003 S ECXPDIV=$S(WRD="":"",1:$$NPDIV(WRD))
 ..;
 ..;- Observation patient indicator (YES/NO)
 ..S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS)
 ..;
 ..;- Chg outpat with movemnt/discharge to inpat (to comply w/existing business rule)
 ..I ECXA="O"&(ECXOBS="NO")&(ECXMVD1) S ECXA="I"
 ..; ******* - PATCH 127, ADD PATCAT CODE ********
 ..S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)
 ..;
 ..;- Get providers person classes
 .. S ECXATLPC=$$PRVCLASS^ECXUTL($E(ECXATTL,2,999),ECXADT)
 .. S ECATLNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXATTL,2,999),ECXADT)
 .. S:+ECATLNPI'>0 ECATLNPI="" S ECATLNPI=$P(ECATLNPI,U)
 .. S ECXPRNPC=$$PRVCLASS^ECXUTL($E(ECXPRVN,2,999),ECXADT)
 .. S ECPRVNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXPRVN,2,999),ECXADT)
 .. S:+ECPRVNPI'>0 ECPRVNPI="" S ECPRVNPI=$P(ECPRVNPI,U)
 .. S ECXATNPC=$$PRVCLASS^ECXUTL($E(ECXATTN,2,999),ECXADT)
 .. S ECATTNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXATTN,2,999),ECXADT)
 .. S:+ECATTNPI'>0 ECATTNPI="" S ECATTNPI=$P(ECATTNPI,U)
 .. S ECXPRLPC=$$PRVCLASS^ECXUTL($E(ECXPRVL,2,999),ECXADT)
 .. S ECPRLNPI=$$NPI^XUSNPI("Individual_ID",$E(ECXPRVL,2,999),ECXADT)
 .. S:+ECPRLNPI'>0 ECPRLNPI="" S ECPRLNPI=$P(ECPRLNPI,U)
 ..;
 ..;- If no encounter number don't file record
 ..S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADT,,ECXTS,ECXOBS,ECHEAD,,)
 ..I $G(ECXASIH) S ECXA="A" ;170
 ..D:ECXENC'="" FILE^ECXTRT2
 I $D(^TMP($J,"ECXTRTMM")) D SENDMSG
 D KPATDEM^ECXUTL2
 Q
 ;
NPDIV(WRD) ;National Production Division
 N DIV
 S DIV=$$GET1^DIQ(42,WRD,.015,"I")
 Q $S(DIV="":"",1:$$GETDIV^ECXDEPT(DIV))
 ;
SETLOC(ECXDFN,ECXADM,ECXPRO,ECXLOC) ;setup the local array from the ATS index
 ; output
 ; ECXLOC = local array (passed by reference)
 ;
 N SUB3,SUB4,SUB5,SPC,PRV,ATT,MOV
 S SUB3=0
 F  S SUB3=$O(^DGPM("ATS",ECXDFN,ECXADM,SUB3)) Q:SUB3=""  D
 .S (SUB4,SUB5)=0
 .S SUB4=$O(^DGPM("ATS",ECXDFN,ECXADM,SUB3,SUB4))
 .S SUB5=$O(^DGPM("ATS",ECXDFN,ECXADM,SUB3,SUB4,SUB5))
 .S ECXLOC(SUB3,SUB4,SUB5)="",SPC=$G(^TMP($J,"ECXTMP",SUB4))
 .S DATA=$G(^DGPM(SUB5,0)),PRV=$P(DATA,U,8),ATT=$P(DATA,U,19)
 .S MOV=$P(DATA,U,14)
 .S:PRV]"" PRV=ECXPRO_PRV S:ATT]"" ATT=ECXPRO_ATT
 .S ECXLOC(SUB3,SUB4,SUB5)=SPC_U_PRV_U_ATT_U_MOV
 Q
 ;
FINDLOC(ECXTSD,ECXLOC,ECXSPC,ECXPRV,ECXATT,ECXMOV,ECXTRT) ;find local array node for current ts movement
 ;   input
 ;   ECXTSD = inverse date/time for current ts movement; required
 ;   ECXLOC = local array; passed by reference; required
 ;   output; data from record contained in MOVE
 ;   ECXSPC = piece 1 of LOC (passed by reference)
 ;   ECXPRV = piece 2 of LOC concatenated to PRO (passed by reference)
 ;   ECXATT = piece 3 of LOC concatenated to PRO (passed by reference)
 ;   ECXMOV = piece 4 of LOC (passed by reference)
 ;   ECXTRT = pointer to file #45.7
 ;
 N SUB3,SUB4,SUB5,LOC
 S (ECXSPC,ECXPRV,ECXATT,ECXMOV)=""
 S SUB3=ECXTSD
 I $D(ECXLOC(SUB3)) D
 .S SUB4=$O(ECXLOC(SUB3,0)),SUB5=$O(ECXLOC(SUB3,SUB4,0))
 .S LOC=ECXLOC(SUB3,SUB4,SUB5),ECXTRT=SUB4,ECXSPC=$P(LOC,U)
 .S ECXPRV=$P(LOC,U,2),ECXATT=$P(LOC,U,3),ECXMOV=$P(LOC,U,4)
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="TRT"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL
 Q
SETTMP(ERRMSG,ECDA,ECDATE,DFN,ECADM) ;190 Set TMP global for MM messages
 N ECMOVDT,VADM,ECXSSN,PTNAME,ECADMDT,ECDIS,ECDISDT
 S PTNAME=$$GET1^DIQ(2,DFN,.01,"I")
 I PTNAME["ZZ" Q  ;don't include test patients
 D DEM^VADPT
 S ECMOVDT=$$FMTE^XLFDT(ECDATE,"2M")
 S SSN=$P(VADM(2),U)
 S ECADMDT=$$GET1^DIQ(405,ECADM_",",.01,"I"),ECDIS=$$GET1^DIQ(405,ECADM_",",.17,"I")
 ; If we couldn't get the discharge date from the admission movement and this *is* the discharge movement
 ; then use this movement's date
 I '+ECDIS,$$GET1^DIQ(405,ECDA_",",.02,"I")=3 S ECDIS=ECDA
 S ECDISDT=$$GET1^DIQ(405,ECDIS_",",.01,"I")
 S ECADMDT=$$FMTE^XLFDT(ECADMDT,"2M"),ECDISDT=$$FMTE^XLFDT(ECDISDT,"2M")
 S ^TMP($J,"ECXTRTMM",ERRMSG,DFN,ECDA)=VADM(1)_U_SSN_U_ECMOVDT_U_ECDA_U_ECADMDT_U_ECDISDT
 Q
 ;
SENDMSG ;190 Send error MM messages
 N ERRMSG,ECMSG,ECDFN,ECSSN,ECSTR,ECDA,I,J,XMY,XMDUZ,XMSUB,XMTEXT
 I '$D(^TMP($J,"ECXTRTMM")) Q
 S XMSUB="RECORDS NOT PROCESSED in DSS-"_ECPACK_" Extract" ; (#"_$P(EC23,U,2)_")"
 K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))="",XMDUZ="DSS SYSTEM"
 S ECMSG(1,0)="Because of missing information in the PATIENT MOVEMENT file (#405), the"
 S ECMSG(2,0)="following records were not included in the DSS-TREATING SPECIALTY CHANGE"
 S ECMSG(3,0)="EXTRACT (#"_$P(EC23,U,2)_") for the dates from "_ECSDN_" to "_ECEDN_"."
 S ECMSG(4,0)=""
 S ERRMSG="",J=0
 F I=1:1 S ERRMSG=$O(^TMP($J,"ECXTRTMM",ERRMSG)) Q:ERRMSG=""  D
 . S ECMSG(5*I+J,0)="*** "_ERRMSG_" ***",J=J+1
 . S ECMSG(5*I+J,0)="                                                                   MOVEMENT",J=J+1
 . S ECMSG(5*I+J,0)="PATIENT NAME                      SSN        MOVEMENT DATE/TIME    IEN",J=J+1
 . S ECMSG(5*I+J,0)="  ADMISSION DATE/TIME                DISCHARGE DATE/TIME              ",J=J+1
 . S ECMSG(5*I+J,0)="-------------------------------------------------------------------------------",J=J+1
 . S ECDFN=""
 . F J=J:1 S ECDFN=$O(^TMP($J,"ECXTRTMM",ERRMSG,ECDFN)) Q:ECDFN=""  D
 .. S ECDA=0
 .. F  S ECDA=$O(^TMP($J,"ECXTRTMM",ERRMSG,ECDFN,ECDA)) Q:ECDA=""  D
 ... S ECSTR=^TMP($J,"ECXTRTMM",ERRMSG,ECDFN,ECDA) S (ACADM,ECDIS)=""
 ... S ECADM=$$GET1^DIQ(405,ECDA_",",.16),ECDIS=$$GET1^DIQ(405,ECDA_",",.17)
 ... S ECMSG(5*I+J,0)=$$LJ^XLFSTR($P(ECSTR,U),30)_"  "_$$LJ^XLFSTR($P(ECSTR,U,2),11)_"  "_$$LJ^XLFSTR($P(ECSTR,U,3),20)_"  "_$$LJ^XLFSTR(ECDA,12),J=J+1
 ... S ECMSG(5*I+J,0)="  "_$$LJ^XLFSTR($P(ECSTR,U,5),30)_"     "_$$LJ^XLFSTR($P(ECSTR,U,6),30),J=J+1
 . S J=J+1,ECMSG(5*I+J,0)=""
 S XMTEXT="ECMSG("
 D ^XMD
 K ^TMP($J,"ECXTRTMM")
 Q
