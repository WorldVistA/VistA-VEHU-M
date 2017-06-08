ECXDENT ;ALB/JAP,BIR/DMA,PTD-Dental Extract for DSS ; [ 11/22/96  5:23 PM ]
 ;;3.0;DSS EXTRACTS;**11,8,13**;Dec 22, 1997
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ;start package specific extract
 N DATA,X,Y
 S QFLG=0
 K ECXDD D FIELD^DID(220.5,.01,,"SPECIFIER","ECXDD") S ECPRO=$E(+$P(ECXDD("SPECIFIER"),"P",2)) K ECXDD
 S ECED=ECED+.3,ECD=ECSD1
 F  S ECD=$O(^DENT(221,"B",ECD)),J=0 Q:'ECD  Q:ECD>ECED  Q:QFLG  F  S J=$O(^DENT(221,"B",ECD,J)) Q:'J  D  Q:QFLG
 .Q:'$D(^DENT(221,J,0)) 
 .S DATA=^DENT(221,J,0),$P(DATA,U,50)="" D STUFF
 Q
 ;
STUFF ;get data
 S DFN=+$P(DATA,U,4) Q:'$D(^DPT(DFN,0))
 S ECP=^DPT(DFN,0),SSN=$P(ECP,U,9),ECNA=$E($P($P(ECP,U),",")_"    ",1,4)
 S X=$$INP^ECXUTL2(DFN,ECD),ECA=$P(X,U,1),ECMN=$P(X,U,2),ECTS=$P(X,U,3)
 S ECDEN=$P(DATA,U,3),ECDEN=$P($G(^DENT(220.5,ECDEN,0)),U) S:ECDEN]"" ECDEN=ECPRO_ECDEN
 S X=$$PRIMARY^ECXUTL2(DFN,ECD,ECPRO),ECPTTM=$P(X,U,1),ECPTPR=$P(X,U,2),ECCLAS=$P(X,U,3)
 D FILE
 Q
 ;
FILE ;file record
 ;node0
 ;inst^dfn^ssn^name^in/out^day^provider^screen/complete^admin proc^x-rays ex^x-rays int^prophy natural^prophy denture^op room^neoplasm malig^
 ;neoplasm removed^biopsy/smear^fracture^pat category^other sig surg^surface restored^root canal^periodontal quads (surg)^perio quads (root plane)^
 ;patient ed^spot check exam^indiv crowns^posts & cores^fixed partials (abut)^fixed partials (pont)^removable partials^complete dentures^prosthetic repair^
 ;splints & spec procs^extractions^surg extractions^other sig treatment^div^completion/termination^interdisc consult^evaluation^pre-auth 2nd opinion^
 ;spot check discrepancy^mov #^treat spec^primary care team^primary care provider^time
 ;node1
 ;mpi^dss dept^provider npi^pc provider npi^pc prov person class
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23
 S ECODE=ECODE_U_$P(DATA,U,40)_U_DFN_U_SSN_U_ECNA_U_ECA_U_$$ECXDATE^ECXUTL($P(DATA,U),ECXYM)_U_ECDEN
 S ECODE=ECODE_U_$P(DATA,U,7,9)_U_$P(DATA,U,11,20)_U_$P(DATA,U,22,38)_U_$P(DATA,U,40,45)_U_ECMN_U_ECTS
 S ECODE=ECODE_U_ECPTTM_U_ECPTPR_U_$$ECXTIME^ECXUTL($P(DATA,U))
 S ECODE1=U_U_U_U_ECCLAS
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX^DIK K DIK,DA
 I $D(ZTQUEUED),ECRN>499,'(ECRN#500),$$S^%ZTLOAD S QFLG=1
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="DEN"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL Q
