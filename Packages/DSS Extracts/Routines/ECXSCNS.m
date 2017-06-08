ECXSCNS ;ALB/JAP,BIR/DMA,PTD-No Show Clinic Extract ; [ 11/22/96  5:48 PM ]
 ;;3.0;DSS EXTRACTS;**11,8,13,20**;Dec 22, 1997
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ;start package specific extract
 N QFLG
 S QFLG=0
 S ECED=ECED+.3
 S SC=0
 F  S SC=$O(^SC(SC)) Q:('SC)!(QFLG)  I $D(^(SC,0)) S EC=^(0) I $P(EC,U,3)="C" D  Q:QFLG
 .S SU=$P(EC,U,15)
 .D FEEDER^ECXSCX1(SC,ECSD1,.ECXP1,.ECXP2,.ECXP3,.ECXSEND)
 .Q:ECXSEND=6
 .S ECXDSS=ECXP1_ECXP2,ECD=ECSD1
 .F  S ECD=$O(^SC(SC,"S",ECD)) Q:'ECD  Q:ECD>ECED  D  Q:QFLG
 ..S ECDA=0
 ..F  S ECDA=$O(^SC(SC,"S",ECD,1,ECDA)) Q:'ECDA  I $D(^(ECDA,0)),$S('$D(^("C")):1,1:^("C")="") D
 ...S EC=^SC(SC,"S",ECD,1,ECDA,0),DFN=$P(EC,U)
 ...I $D(^DPT(+DFN,0)) S EC1=^(0) D INP
 ...;log no shows only for outpatients
 ...I ECA=1 D
 ....S DOB=$$ECXDOB^ECXUTL($P(EC1,U,3)),VET=$P($G(^("VET")),U),RACE=$P($G(^DIC(10,+$P(EC1,U,6),0)),U,2),ELG=$P($G(^DIC(8,+$G(^DPT(DFN,.36)),0)),U,9) I ELG S ELG=$C(ELG+64)
 ....I $D(^DPT(DFN,"S",ECD,0)),$P(^(0),U)=SC,$P(^(0),U,2)]"",$P(^(0),U,2)["N" D FILE
 Q
 ;
FILE ;file record
 ;node0
 ;fac^dfn^ssn^name^in/out^day^^mov #^treat spec^dob^elig^vet^time^primary care team^primary care provider^provider^race^dss identifier
 ;node1
 ;mpi^dss dept^pc provider npi^provider npi^pc prov person class
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23
 S ECODE=ECODE_U_SU_U_DFN_U_$P(EC1,U,9)_U_$E($P($P(EC1,U),",")_"    ",1,4)_U_ECA_U_$$ECXDATE^ECXUTL(ECD,ECXYM)
 S ECODE=ECODE_U_U_ECMN_U_ECTS_U_DOB_U_ELG_U_VET_U_$$ECXTIME^ECXUTL(ECD)_U_ECPTTM_U_ECPTPR_U_U_RACE_U_ECXDSS
 S ECODE1=U_U_U_U_ECCLAS
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX^DIK K DIK,DA
 I $D(ZTQUEUED),ECRN>499,'(ECRN#500),$$S^%ZTLOAD S QFLG=1
 Q
 ;
INP ;Determine in/outpatient status, movement number, primary care team and provider.
 N X
 S X=$$INP^ECXUTL2(DFN,ECD),ECA=$P(X,U,1),ECMN=$P(X,U,2),ECTS=$P(X,U,3)
 S X=$$PRIMARY^ECXUTL2(DFN,ECD),ECPTTM=$P(X,U,1),ECPTPR=$P(X,U,2),ECCLAS=$P(X,U,3)
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="NOS"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL Q
