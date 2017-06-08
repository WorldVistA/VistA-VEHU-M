RGMTUT99 ;BIR/CML-DIAGNOSTIC FOR HLMA("AC" TO MPIVA; [ 04/10/99  12:34 PM ]
V ;;1.0V21;CIRN MAINTENANCE (SITE);;JUL 1,2000
 Q
 ;
DELXREF ;
 S LINK=$O(^HLCS(870,"B","MPIVA",0)),PROT=$O(^ORD(101,"B","VAFC MFU-TFL CLIENT",0))
 K ICNARR S ICNCNT=0,DELCNT=0
 S HLMA=0 F  S HLMA=$O(^HLMA("AC","O",LINK,HLMA)) Q:'HLMA  D
 .I $P(^HLMA(HLMA,0),"^",8)'=PROT Q
 .S HL772=$P(^HLMA(HLMA,0),"^")
 .S LN=0 F  S LN=$O(^HL(772,HL772,"IN",LN)) Q:'LN  I $P(^HL(772,HL772,"IN",LN,0),"^")="MFE" D  Q
 .I $P(^HL(772,HL772,"IN",LN,0),"^")="MFE" D  Q
 ..S ICN=$P($P(^HL(772,HL772,"IN",LN,0),"^",5),"~",4)
 ..I $D(ICNARR(ICN)) D  Q
 ...S PREV=ICNARR(ICN)
 ...S $P(^HLMA(PREV,"P"),"^")=3
 ...K ^HLMA("AC","O",LINK,PREV)
 ...S ICNARR(ICN)=HLMA
 ...S DELCNT=DELCNT+1
 ..I '$D(ICNARR(ICN)) S ICNARR(ICN)=HLMA,ICNCNT=ICNCNT+1
 W !,DELCNT," ^HLMA(""AC"",""O"",",LINK," xrefs killed for Treating Fac. Updates to MPI."
 W !,ICNCNT," unique ICNs left for Treating Fac. Updates to MPI."
 Q
 ;
LINK ;do loop on call to start an HL7 Link
 D START^HLCSLNCH
 W ! S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Again" D ^DIR K DIR
 I Y=1 G LINK
 K DIR,Y
 Q
 ;
CML ;find mail for CML to load PackMan msgs of utility changes 
 N DUZ
 S SITE=$P($$SITE^VASITE(),"^",3)
 I SITE=550 S DUZ=10934 D ^XM Q
 I SITE=534 S DUZ=7365 D ^XM Q
 I SITE=622 S DUZ=6304 D ^XM Q
 I SITE=603 S DUZ=12939 D ^XM Q
 S DIC="^VA(200,",X="LINK,CHRI",DIC(0)="QM" D ^DIC K DIC
 I +Y<0 W !,"Can't find DUZ for Chris Link." Q
 S DUZ=+Y D ^XM
 Q
 ;
CMORCC ;cleanup of CMOR conflict exceptions
 W !,"Use this call for cleanup of CMOR exceptions."
 W !!,"- After all necessary edits of CMOR field has been done at all involved sites,"
 W !,"  use this call at the CMOR to add any TF and subscriptions that are needed."
 W !!,"- Then the patient is dropped in the pivot so all involved sites are updated."
 ;
 S PAT261=$$PATCH^XPDUTL("DG*5.3*261")
 ;
CMORCC1 S CMORCC=1
 ;select patient
 W !!
 S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT: "
 D ^DIC K DIC G:Y<0 QUIT S CCDFN=+Y
 ;select site to be added as TF and subscriber
 W !
 S DIC="^DIC(4,",DIC(0)="QEAM",DIC("A")="Select site to be added as TF and SUBSCRIBER: "
 S DIC("S")="I $D(^HLCS(870,""C"",+Y))"
 D ^DIC K DIC G:Y<0 QUIT
 S TF=+Y
 S CCDEST=$P(^HLCS(870,($O(^HLCS(870,"C",TF,0))),0),"^")
 W !!,"Adding treating facility..."
 D ADDTF
 W !!,"Adding subscription..."
 D ADDSUB
 D TFUPDT^MPIFBT2(CCDFN,0) W !!,"Patient added to pivot file"
 I 'PAT261 D INSERT^RGJCTS01(CCDFN) W !,"Patient added to event queue"
 G CMORCC1
 ;
ADDPIV ;Insert an individual patient into the pivot file and event queue (if patch DG*5.3*261 not present)
 S PAT261=$$PATCH^XPDUTL("DG*5.3*261")
 S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT: "
 D ^DIC K DIC G:Y<0 QUIT S DFN=+Y
 D TFUPDT^MPIFBT2(DFN,0) W !!,"added to pivot file"
 I 'PAT261 D INSERT^RGJCTS01(DFN) W !,"added to event queue"
 K DFN G ADDPIV
 ;
ADDSUB ;add a new DESTINATION to SCN entry in file #774
 ;and add patient to Pivot file - use for testing PATIENT NOT FOUND messages
 N DIC,SCN,TYPE,DFN,DEST
 I $D(CMORCC) S DEST=CCDEST,DFN=CCDFN
 I '$D(CMORCC) D  G:Y<0 QUIT S DFN=+Y
 .S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT: "
 .D ^DIC K DIC
 S SCN=$P(^DPT(DFN,"MPI"),"^",5)
 I 'SCN D
 .S SCN=$$GETSCN^RGJCREC(DFN)
 .W !?3,"New SCN #",SCN," created for this patient."
 I '$D(CMORCC) D  G:Y<0 QUIT S DEST=$P(Y,"^",2)
 .S DIC="^HLCS(870,",DIC(0)="QEAM",DIC("A")="Select NEW SUBSCRIBER: "
 .D ^DIC K DIC
 S TYPE=0
 D UPD^HLSUB(SCN,DEST,TYPE,"","","",.ER)
 I $D(^HLS(774,SCN,"TO","B","@"_DEST)) D
 .W !?3,"New DESTINATION of ",DEST," created for SUBSCRIPTION #",SCN,"."
 I '$D(CMORCC) G ADDSUB
 Q
 ;
ADDTF ;Add a TF entry for a selected patient
 S PAT261=$$PATCH^XPDUTL("DG*5.3*261")
 N SITE,STANUM,DFN
 I $D(CMORCC) S DFN=CCDFN
 I '$D(CMORCC) D  G:Y<0 QUIT S DFN=+Y
 .S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT: "
 .D ^DIC K DIC
 I '$D(CMORCC) D  G:Y<0 QUIT S TF=+Y
 .S DIC="^DIC(4,",DIC(0)="QEAM",DIC("A")="Select TREATING FACILITY to add: "
 .S DIC("S")="I $D(^HLCS(870,""C"",+Y))"
 .D ^DIC K DIC
 S STANUM=$P($$NS^XUAF4(TF),"^",2),TFNAME=$P($$NS^XUAF4(TF),"^")
 I PAT261 D FILE^VAFCTFU(DFN,TF,1)
 I 'PAT261 D TFLIST^MPIFBT2(STANUM,DFN)
 D TFLIST^MPIFBT2(STANUM,DFN)
 I $D(^DGCN(391.91,"APAT",DFN,TF)) D
 .W !?3,TFNAME," added as a TF for ",$P(^DPT(DFN,0),"^"),"."
 I '$D(CMORCC) G ADDTF
 Q
 ;
ADDLOC ;give a patient a local ICN
 S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT to give a Local ICN: "
 D ^DIC K DIC G:Y<0 QUIT S DFN=+Y
 S LOCICN=+$$ICNLC^MPIF001(DFN)
 W !?3,"Local ICN ",LOCICN," assigned."
 K DFN,DIC,LOCICN
 Q
 ;
EDITPT ;Allow edit of PATIENT file data and bypass entry in pivot file
 S DIC=2,DIC(0)="QEAM",DIC("A")="Select PATIENT: "
 D ^DIC K DIC G:Y<0 QUIT
 S (VAFCA08,VAFHCA08)=1
 S DA=+Y
 S DIE=2,DR=".01;.09" D ^DIE K DIE,DR,DA
 G QUIT
 ;
EDCMOR ;used for exception work to edit a patient's CMOR
 S DIC="^DPT(",DIC(0)="QEAM",DIC("A")="Select PATIENT: " D ^DIC K DIC G:Y<0 QUIT
 S DA=+Y,DIE="^DPT(",DR=991.03
 D ^DIE K DIE,DA
 G QUIT
 ;
DELTF ;delete entries for a patient from Treating Facility file (#391.91)
 W !! S DIC=391.91,DIC(0)="QEAM",DIC("A")="Select PATIENT: " D ^DIC K DIC G:Y<0 QUIT S TFIEN=+Y
 S TF=$P(^DGCN(391.91,TFIEN,0),"^",2),TFNAME=$P(^DIC(4,TF,0),"^")
 S DIK="^DGCN(391.91,",DA=TFIEN D ^DIK K DIK,DA W !,"TF entry for ",TFNAME," deleted."
 G QUIT
 ;
QUIT K CCDEST,CCDFN,CMORCC,DA,DELCNT,DEST,DFN,DIC,DIE,DIR,DR,ER,HL772,HLMA,ICN,ICNARR,ICNCNT
 K LINK,LN,LOCICN,PAT261,PREV,PROT,SCN,SITE,STANUM,TF,TFNAME,TYPE,VAFCA08,VAFHCA08,X,Y
 Q
