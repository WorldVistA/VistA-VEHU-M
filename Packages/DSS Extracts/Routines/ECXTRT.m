ECXTRT ;ALB/JAP,BIR/DMA,CML,PTD-Treating Specialty Change Extract ; [ 01/10/97  4:33 PM ]
 ;;3.0;DSS EXTRACTS;**1,8,17**;Dec 22, 1997
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ; start package specific extract
 N LOC,TRT,SPC
 S QFLG=0
 K ECXDD D FIELD^DID(405,.19,,"SPECIFIER","ECXDD") S ECPRO=$E(+$P(ECXDD("SPECIFIER"),"P",2)) K ECXDD
 K ^TMP($J,"ECXTMP") S TRT=0
 F  S TRT=$O(^DIC(45.7,TRT)) Q:+TRT=0  S SPC=$P(^DIC(45.7,TRT,0),U,2),^TMP($J,"ECXTMP",TRT)=SPC
 S ECED=ECED+.3,ECD=ECSD1
 ;loop through type 6 movements to get treating specialty and provider changes
 F  S ECD=$O(^DGPM("ATT6",ECD)),ECDA=0 Q:'ECD  Q:ECD>ECED  F  S ECDA=$O(^DGPM("ATT6",ECD,ECDA)) Q:'ECDA  D  Q:QFLG
 .I $D(^DGPM(ECDA,0)) S EC=^(0),DFN=+$P(EC,U,3) I $D(^DPT(DFN,0)) S PAT=^(0) D  Q:QFLG
 ..S ECXMVD1=$P(EC,U,1),ECMT=$P(EC,U,18),ECXADM=$P(EC,U,14),ECXADT=$P($G(^DGPM(ECXADM,0)),U,1)
 ..;skip the record if its the admission treat. spec. change for this episode of care
 ..Q:ECXADM=$P(EC,U,24)
 ..S (ECXLOS,ECXLOSA,ECXLOSP)=""
 ..K LOC D SETLOC(DFN,ECXADM,ECPRO,.LOC)
 ..;get data for current (new) ts movement
 ..S ECD1=9999999.9999999-ECXMVD1
 ..D FINDLOC(ECD1,.LOC,.ECXSPCN,.ECXPRVN,.ECXATTN,.ECXMOVN,.ECXTRTN)
 ..Q:ECXSPCN=""
 ..S ECD2=$O(LOC(ECD1)) Q:ECD2=""
 ..S ECXMVD2=9999999.9999999-ECD2
 ..;get data for previous (losing) ts movement
 ..D FINDLOC(ECD2,.LOC,.ECXSPCL,.ECXPRVL,.ECXATTL,.ECXMOVL,.ECXTRTL)
 ..;if ts has changed, find los on losing ts
 ..D:ECXTRTL'=ECXTRTN PREVTRT^ECXTRT1(.LOC,ECD1,ECD2,ECXTRTL,.ECXLOS)
 ..;whether ts has changed or not, see if primary provider has changed
 ..;dont bother if there's no data on current primary provider or no change in provider
 ..D:(ECXPRVN'="")&(ECXPRVN'=ECXPRVL) PREVPRV^ECXTRT1(.LOC,ECD1,ECXPRVN,ECD2,.ECXPRVL,.ECXLOSP)
 ..;whether ts has changed or not, see if attending physician has changed
 ..;dont bother if theres no data on current attending physician or no change in attending
 ..D:(ECXATTN'="")&(ECXATTN'=ECXATTL) PREVATT^ECXTRT1(.LOC,ECD1,ECXATTN,ECD2,.ECXATTL,.ECXLOSA)
 ..S ECXDATE=$$ECXDATE^ECXUTL(ECXMVD1,ECXYM),ECXTIME=$$ECXTIME^ECXUTL(ECXMVD1)
 ..S ECXADMDT=$$ECXDATE^ECXUTL(ECXADT,ECXYM),ECXADMTM=$$ECXTIME^ECXUTL(ECXADT),ECXDCDT=""
 ..D FILE
 ;for nhcu episodes with intervening asih stays, the los calculated here is not accurate,
 ;but it never has been; this is best solution within current extract framework;
 ;at discharge the los calculated for nhcu apisodes will be the los since admission w/o asih los subtracted;
 ;
 ;loop through discharges to get last treating specialty
 S ECD=ECSD1
 F  S ECD=$O(^DGPM("ATT3",ECD)),ECDA=0 Q:'ECD  Q:ECD>ECED  F  S ECDA=$O(^DGPM("ATT3",ECD,ECDA)) Q:'ECDA  D  Q:QFLG
 .I $D(^DGPM(ECDA,0)) S EC=^(0),DFN=+$P(EC,U,3) I $D(^DPT(DFN,0)) S PAT=^(0) D  Q:QFLG
 ..S ECXMVD1=$P(EC,U,1)
 ..S (ECXDATE,ECXDCDT)=$$ECXDATE^ECXUTL(ECXMVD1,ECXYM),ECXTIME=$$ECXTIME^ECXUTL(ECXMVD1)
 ..S ECMT=$P(EC,U,18),ECXADM=$P(EC,U,14),ECXADT=$P($G(^DGPM(ECXADM,0)),U,1)
 ..S ECXADMDT=$$ECXDATE^ECXUTL(ECXADT,ECXYM),ECXADMTM=$$ECXTIME^ECXUTL(ECXADT)
 ..S (ECXTRTN,ECXSPCN,ECXPRVN,ECXATTN)="" S (ECXLOS,ECXLOSA,ECXLOSP)=""
 ..K LOC D SETLOC(DFN,ECXADM,ECPRO,.LOC)
 ..S ECD1=9999999.9999999-ECXMVD1
 ..;get ts change just before d/c
 ..S ECD2=$O(LOC(ECD1)),ECXMVD2=9999999.9999999-ECD2
 ..D FINDLOC(ECD2,.LOC,.ECXSPCL,.ECXPRVL,.ECXATTL,.ECXMOVL,.ECXTRTL)
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
 ..S:ECXLOS>9999 ECXLOS=9999 S:ECXLOSA>9999 ECXLOSA=9999 S:ECXLOSP>9999 ECXLOSP=9999
 ..D FILE
 Q
 ;
SETLOC(DFN,ECXADM,ECXPRO,ECXLOC) ;setup the local array from the ATS index
 ; output
 ; ECXLOC = local array (passed by reference)
 ;
 N SUB3,SUB4,SUB5,SPC,PRV,ATT,MOV
 S SUB3=0
 F  S SUB3=$O(^DGPM("ATS",DFN,ECXADM,SUB3)) Q:SUB3=""  D
 .S (SUB4,SUB5)=0
 .S SUB4=$O(^DGPM("ATS",DFN,ECXADM,SUB3,SUB4)),SUB5=$O(^DGPM("ATS",DFN,ECXADM,SUB3,SUB4,SUB5))
 .S ECXLOC(SUB3,SUB4,SUB5)=""
 .S SPC=$G(^TMP($J,"ECXTMP",SUB4))
 .S DATA=$G(^DGPM(SUB5,0)),PRV=$P(DATA,U,8),ATT=$P(DATA,U,19),MOV=$P(DATA,U,14)
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
 .S LOC=ECXLOC(SUB3,SUB4,SUB5)
 .S ECXTRT=SUB4
 .S ECXSPC=$P(LOC,U,1)
 .S ECXPRV=$P(LOC,U,2)
 .S ECXATT=$P(LOC,U,3)
 .S ECXMOV=$P(LOC,U,4)
 Q
 ;
FILE ;file the extract record
 ;node0
 ;fac^dfn^ssn^name^i/o^date^product^adm date^d/c date^mov#^type^new ts^losing ts^losing ts los
 ;^losing attending^movement type^time^adm time^new provider^new attending^losing provider
 ;node1
 ;mpi^dss dept^losing attending npi^new provider npi^new attending npi^losing provider npi^losing attending los^losing provider los
 ;
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23_U_U_DFN_U_$P(PAT,U,9)_U_$E($P($P(PAT,U),",")_"    ",1,4)_U_3_U_ECXDATE_U_U_ECXADMDT_U_ECXDCDT
 S ECODE=ECODE_U_ECDA_U_6_U_ECXSPCN_U_ECXSPCL_U_ECXLOS_U_ECXATTL_U_ECMT_U_ECXTIME_U_ECXADMTM_U_ECXPRVN_U_ECXATTN_U_ECXPRVL
 S ECODE1=U_U_U_U_U_U_ECXLOSA_U_ECXLOSP
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX^DIK K DIK,DA
 I $D(ZTQUEUED),'(ECRN#500),$$S^%ZTLOAD S QFLG=1
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
