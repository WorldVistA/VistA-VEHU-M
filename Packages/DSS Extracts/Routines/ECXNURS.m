ECXNURS ;ALB/JAP,BIR/DMA,PTD-Nursing Extract for DSS ; 11/01/96 10:16
 ;;3.0;DSS EXTRACTS;**8,14,22**;Dec 22, 1997
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ;entry when queued
 ;store in ^tmp by patient and date/time
 N CNT,QFLG,INP,FIRSTDAY,LASTDAY
 S QFLG=0,CNT=0
 K ^TMP("ECX",$J)
 S FIRSTDAY=$P(ECSD1,".")+1,LASTDAY=$P(ECED,".")
 S ECED=ECED+.3,ECD=ECSD1
 F  S ECD=$O(^NURSA(214.6,"B",ECD)),ECDA=0 Q:'ECD  Q:ECD>ECED  D  Q:QFLG
 .F  S ECDA=$O(^NURSA(214.6,"B",ECD,ECDA)) Q:'ECDA  D  Q:QFLG
 ..K LOC S DIC=214.6,DIQ(0)="I",DA=ECDA,DIQ="LOC",DR=".01;.02;1;3;4;6;7;8"
 ..D EN^DIQ1 K DIQ,DIC,DA,DR
 ..F J=.01,.02,1,3,4,6,7,8 S EC(J)=LOC(214.6,ECDA,J,"I")
 ..Q:EC(8)'=""
 ..S INP=$$INP^ECXUTL2(EC(.02),EC(.01))
 ..Q:+INP=1
 ..; retain latest classification per day per patient
 ..S ^TMP("ECX",$J,EC(.02),$P(EC(.01),"."))=EC(1)_U_EC(3)_U_EC(4)_U_EC(6)_U_EC(7)_U_INP_U_EC(.01)
 ..K LOC(214.6,ECDA),EC,INP
 ..S CNT=CNT+1
 ..I $D(ZTQUEUED),(CNT>499),'(CNT#500),$$S^%ZTLOAD S QFLG=1
 I QFLG K ^TMP("ECX",$J) Q
 D RESOLVE
 D FILE
 K ^TMP("ECX",$J)
 Q
 ;
RESOLVE ;process ^tmp by patient
 N DFN,TM,ECD,ECDPREV,ECDNEW,OLDWARD,NEWWARD,NEWDT
 S DFN=0
 F  S DFN=$O(^TMP("ECX",$J,DFN)) S ECD=0 Q:'DFN  D
 .;remove any classifications for day of discharge
 .F  S ECD=$O(^TMP("ECX",$J,DFN,ECD)) Q:'ECD  D
 ..I ECD=$P($P(^TMP("ECX",$J,DFN,ECD),U,11),".") K ^TMP("ECX",$J,DFN,ECD)
 .;proceed only if ^tmp remains
 .Q:'$D(^TMP("ECX",$J,DFN))
 .;proceed with fill-in only if processing more than 3 days' data
 .Q:LASTDAY<(FIRSTDAY+2)
 .;fill-in records for any missing days per inpatient episode
 .K TM S ECD=0
 .F  S ECD=$O(^TMP("ECX",$J,DFN,ECD)) Q:'ECD   D
 ..S TM(ECD)=$P(^TMP("ECX",$J,DFN,ECD),U,9)
 .S (ECD,ECDPREV)=0
 .F  S ECD=$O(TM(ECD)) Q:'ECD  D
 ..I ECDPREV=0 S ECDPREV=ECD Q
 ..I (ECD-ECDPREV)>1,+TM(ECD)=+TM(ECDPREV) D
 ...F ECDNEW=ECDPREV+1:1:ECD-1 S ^TMP("ECX",$J,DFN,ECDNEW)=^TMP("ECX",$J,DFN,ECDPREV) D
 ....S NEWWARD="",OLDWARD=$P(^TMP("ECX",$J,DFN,ECDPREV),U,10)
 ....D NEWWARD(OLDWARD,.NEWWARD)
 ....Q:'NEWWARD
 ....S $P(^TMP("ECX",$J,DFN,ECDNEW),U,4)=$P(NEWWARD,U,1)
 ....S $P(^TMP("ECX",$J,DFN,ECDNEW),U,5)=$P(NEWWARD,U,2)
 ..S ECDPREV=ECD
 .;fill-in to end of extract date range
 .K TM S ECD=0
 .F  S ECD=$O(^TMP("ECX",$J,DFN,ECD)) Q:'ECD   D
 ..S TM(ECD)=$P(^TMP("ECX",$J,DFN,ECD),U,11)
 .S ECD=$O(TM(""),-1),DCDT=+TM(ECD)
 .;if last day in date range is after last classificatin date
 .I LASTDAY>ECD D
 ..;if there is no d/c date
 ..I DCDT=0 F ECDNEW=ECD+1:1:LASTDAY D  Q
 ...I '$D(^TMP("ECX",$J,DFN,ECDNEW)) S ^TMP("ECX",$J,DFN,ECDNEW)=^TMP("ECX",$J,DFN,ECD)
 ...S NEWWARD="",OLDWARD=$P(^TMP("ECX",$J,DFN,ECD),U,10)
 ...D NEWWARD(OLDWARD,.NEWWARD)
 ...Q:'NEWWARD
 ...S $P(^TMP("ECX",$J,DFN,ECDNEW),U,4)=$P(NEWWARD,U,1)
 ...S $P(^TMP("ECX",$J,DFN,ECDNEW),U,5)=$P(NEWWARD,U,2)
 ..;if d/c date is after last classification date
 ..I $P(DCDT,".")>ECD S NEWDT=$S($P(DCDT,".")>LASTDAY:LASTDAY,1:($P(DCDT,".")-1)) F ECDNEW=ECD+1:1:NEWDT D  Q
 ...I '$D(^TMP("ECX",$J,DFN,ECDNEW)) S ^TMP("ECX",$J,DFN,ECDNEW)=^TMP("ECX",$J,DFN,ECD)
 ...S NEWWARD="",OLDWARD=$P(^TMP("ECX",$J,DFN,ECD),U,10)
 ...D NEWWARD(OLDWARD,.NEWWARD)
 ...Q:'NEWWARD
 ...S $P(^TMP("ECX",$J,DFN,ECDNEW),U,4)=$P(NEWWARD,U,1)
 ...S $P(^TMP("ECX",$J,DFN,ECDNEW),U,5)=$P(NEWWARD,U,2)
 Q
 ;
NEWWARD(OLDWARD,NEWWARD) ;get new nursing location
 ; input  OLDWARD = pointer to file #42, previous mas ward
 ;        NEWWARD = null
 ; output NEWWARD = new nursing location^new nursing bedsection
 ;                  OR "^", if new ward same as previous ward or could not be resolved
 ;if the new ward is mapped to multiple nursing locations, get the first active location
 N NEWW,NEWLOC,NEWSEC,OUT,DA,DR,DIC,DIQ,LOC
 S INP=$$INP^ECXUTL2(DFN,ECDNEW) S NEWWARD=$P(INP,U,5)
 I NEWWARD=OLDWARD S NEWWARD=""
 Q:'NEWWARD
 S NEWW="",NEWLOC="",NEWSEC="",OUT=0
 F  S NEWW=$O(^NURSF(211.4,"C",NEWWARD,NEWW)) Q:OUT  Q:+NEWW<1  D
 .S DIC=211.4,DIQ(0)="I",DIQ="LOC",DA=NEWW,DR="1;1.5"
 .D EN^DIQ1 K DIQ,DIC,DA,DR
 .Q:LOC(211.4,NEWW,1,"I")="I"
 .Q:LOC(211.4,NEWW,1.5,"I")="I"
 .S JJ=$O(^NURSF(211.4,"C",NEWWARD,NEWW,""))
 .S DIC=211.4,DIQ(0)="I",DIQ="LOC",DA=NEWW,DA(211.41)=JJ,DR="2",DR(211.41)=".01;1"
 .D EN^DIQ1 K DIQ,DIC,DA,DR
 .Q:NEWWARD'=LOC(211.41,JJ,.01,"I")
 .S NEWLOC=NEWW,NEWSEC=LOC(211.41,JJ,1,"I"),OUT=1
 I (NEWLOC="")!(NEWSEC="") S NEWWARD="" Q
 S NEWWARD=NEWLOC_U_NEWSEC
 Q
 ;
FILE ;file extract records
 ;node0
 ;inst^dfn^ssn^name^in/out^date^acuity level(category)^entered by^classifier^nurs location^nursing bed section^mov #^treat spec^adm date^adm time
 ;node1
 ;mpi^dss dept
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1)
 S DFN=0,QFLG=0
 F  S DFN=$O(^TMP("ECX",$J,DFN)) Q:'DFN  I $D(^DPT(DFN,0)) D  Q:QFLG
 .S ECD=0
 .S ECPN=^DPT(DFN,0),ECPT=$P(ECPN,U,9)_U_$E($P($P(ECPN,U),",")_"    ",1,4)_U_"3"
 .;file patient's classification data
 .F  S ECD=$O(^TMP("ECX",$J,DFN,ECD)) Q:'ECD   D
 ..S ECC=$P(^TMP("ECX",$J,DFN,ECD),U,1,5),ECMN=$P(^(ECD),U,7),ECTS=$P(^(ECD),U,8),ECA=$P(^(ECD),U,9)
 ..S EC7=EC7+1
 ..S ECODE=EC7_U_EC23
 ..S ECODE=ECODE_U_ECINST_U_DFN_U_ECPT_U_$$ECXDATE^ECXUTL(ECD,ECXYM)_U_ECC
 ..S ECODE=ECODE_U_ECMN_U_ECTS_U_$$ECXDATE^ECXUTL(ECA,ECXYM)_U_$$ECXTIME^ECXUTL(ECA)
 ..S ECODE1=U
 ..S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,ECRN=ECRN+1
 ..S DA=EC7,DIK="^ECX("_ECFILE_"," D IX^DIK K DIK,DA
 ..I $D(ZTQUEUED),ECRN>499,'(ECRN#500),$$S^%ZTLOAD S QFLG=1
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="NUR"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL Q
