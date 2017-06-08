PX1P88B ;EXW-Cleanup routine #2
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**88**;Mar 20, 2000
 ;;
 ;The purpose of this routine is to identify invalid cross references
 ;and missing .01 fields in the VISIT, V CPT, V POV and V PRV files. 
 ;This routine will process through the VISIT file by date, identify 
 ;V files with the invalid data and remove those entries.
 ;
 ;The routine provides the option to Report Only or Report and remove
 ;the files with the invalid cross references and missing .01 fields.
 ;
 ;Upon completion an e-mail message, with a list of files to be removed,
 ;will be sent to the user starting the program.
 ;
 ;By date:    VDAT^PX1P88B
 ;
 ;
VDAT ;Check cross references by VISIT DATE
 N IOP,%ZIS,POP,IO,VSTBDT,VSTEDT,VSGL,VIEN
 N VFIX,TYP,VST,REVDT,VSTRNG,I,PXTEMP,EXIT
 I '$D(DUZ) W !,*7,"You do not have a DUZ." Q
 S EXIT=0
 I $$DATE()<0 G EXIT
 S VFIX=$$FIX()
 G:VFIX["^" EXIT
 S ^XTMP("PX1P88B",0)=$$HTFM^XLFDT(+$H+7)_"^"_$$DT^XLFDT()
 S $P(^XTMP("PX1P88B",0),"^",3)=VSTBDT_"^"_VSTEDT_"^"_VFIX_"^"_DUZ
 D TASK
 G:EXIT EXIT
 Q
START ;Entry point from TASKMAN
 N VSTBDT,VSTEDT,VSGL,VIEN,VFIX,TYP,VST,REVDT,VSTRNG
 N PXSTART,I,PXTEMP,PXDUZ,EXIT,IEN
 S PXTEMP="^XTMP(""PX1P88B"")"
 S VSTBDT=$P(@PXTEMP@(0),"^",3),VSTEDT=$P(@PXTEMP@(0),"^",4)
 S VFIX=$P(@PXTEMP@(0),"^",5),PXDUZ=$P(@PXTEMP@(0),"^",6)
 S PXSTART=$$NOW^XLFDT
 S VSGL="^AUPNVSIT(""B"")"
 S EXIT=0
 F I=1:1 S VSTBDT=$O(@VSGL@(VSTBDT)) Q:'VSTBDT  Q:(VSTBDT\1)>VSTEDT  D  Q:EXIT
 .I '(I#5000) D  Q:EXIT
 ..S:$$S^%ZTLOAD EXIT=1
 .S VST=""
 .F  S VST=$O(@VSGL@(VSTBDT,VST)) Q:'VST  D  Q:EXIT
 ..I '$D(^AUPNVSIT(VST)) D  Q
 ...S @PXTEMP@("VSIT",VST)=VSTBDT
 ...Q:'VFIX
 ...D VSTXRF
 ..S VSTRNG=^AUPNVSIT(VST,0)
 ..S IEN=$P(VSTRNG,"^",5)
 ..S REVDT=9999999-($P(VSTRNG,"^")\1)
 ..F TYP="CPT","POV","PRV" D SRCH  Q:EXIT
 D:'EXIT MAIL
 K @PXTEMP
 Q
DATE() ;Ask BEGINNING and ENDING date range to run search
 N DIR,X,Y
 D NOW^%DTC S DT=X
 S DIR(0)="DA^"
 S DIR("A")="Enter BEGINNING date: "
 D ^DIR
 I Y<0!(Y["^") Q -1
 S VSTBDT=Y
 K DIR
 S DIR(0)="DA^"_VSTBDT_":DT"
 S DIR("A")="Enter ENDING date: "
 S DIR("B")=$$FMTE^XLFDT(DT)
 D ^DIR
 I Y<0!(Y["^") Q -1
 S VSTEDT=Y
 Q 1
 ;
TASK ;PROMP TO QUEUE JOB FOR TASKMAN
 K ZTSYNC,ZTSK,ZTSAVE,ZTIO,ZTRTN,ZTDESC,ZTQUEUED
 S ZTRTN="START^PX1P88B"
 S ZTDESC="Indentify and correct missing .01 and XREF in VCPT & VPOV"
 S ZTIO="",ZTSAVE("*")=""
 D ^%ZTLOAD
 I $D(ZTSK)[0 D  Q
 .W !!,"Run Canceled",!!
 .S EXIT=1
 W !!,"TASK ",ZTSK," QUEUED",!
 I $D(ZTSK("D")) D
 .W !,"Correct missing .01 fields and invalid XREF in VCPT & VPOV to start @ ",$$HTE^XLFDT(ZTSK("D"))
 Q
SRCH ;SEARCH CROSS REFERENCES AND CLEANUP INVALID LINKS
 N I,GLB,VFILE,VIEN,QT,ERRTYP
 S VFILE="^AUPNV"_TYP
 S GLB=VFILE_"("_"""AD"""_","_VST_")"
 S VIEN=""
 F I=1:1 S VIEN=$O(@GLB@(VIEN)) Q:'VIEN  D  Q:EXIT
 .I '(I#1000) D  Q:EXIT
 ..S:$$S^%ZTLOAD EXIT=1
 .S ERRTYP=""
 .I $P($G(@VFILE@(VIEN,0)),"^")="" S ERRTYP=1
 .I '$D(@VFILE@(VIEN)) S ERRTYP=2
 .Q:'ERRTYP
 .S @PXTEMP@("VFIL",VST,TYP,VIEN)=$P(VSTRNG,"^",1)_"^"_$P(VSTRNG,"^",5)_"^"_ERRTYP
 .Q:'VFIX
 .I TYP="CPT" D CPTFIX Q
 .D PRVFIX
 Q
CPTFIX ;Find and delete V CPT invalid cross references
 N XRF,CPT
 S XRF=VFILE_"(""AA"""_","_IEN_")"
 S (QT,CPT)=""
 F  S CPT=$O(@XRF@(CPT)) Q:'CPT  D  Q:QT
 .I $D(@XRF@(CPT,REVDT,VIEN)) K @XRF@(CPT,REVDT,VIEN) S QT=1
 .I $D(@VFILE@("B",CPT,VIEN)) K @VFILE@("B",CPT,VIEN) S:'QT QT=1
 I $D(@VFILE@("AD",VST,VIEN)) K @VFILE@("AD",VST,VIEN)
 I $D(@VFILE@("C",IEN,VIEN)) K @VFILE@("C",IEN,VIEN)
 I ERRTYP=1 K @VFILE@(VIEN)
 Q
PRVFIX ;Find and delete V POV and V PRV invalid cross references
 N XRF,VSUB
 S XRF=VFILE_"(""B"")"
 S (QT,VSUB)=""
 F  S VSUB=$O(@XRF@(VSUB)) Q:'VSUB  D  Q:QT
 .I $D(@XRF@(VSUB,VIEN)) K @XRF@(VSUB,VIEN) S QT=1
 I $D(@VFILE@("AD",VST,VIEN)) K @VFILE@("AD",VST,VIEN)
 I $D(@VFILE@("C",IEN,VIEN)) K @VFILE@("C",IEN,VIEN)
 I TYP="POV" D
 .I $D(@VFILE@("AA",IEN,REVDT,VIEN)) K @VFILE@("AA",IEN,REVDT,VIEN)
 I ERRTYP=1 K @VFILE@(VIEN)
 Q
VSTXRF ;Cleanup invalid VISIT X-REF
 N GLB,GLB2,DFN,RDT,SUB,Q,QT,OEN,I,J,LOC
 S GLB="^AUPNVSIT(""AA"")"
 S (Q,DFN)=""
 S RDT=9999999-(VSTBDT\1)_(VSTBDT#1)
 F I=1:1 S DFN=$O(@GLB@(DFN)) Q:'DFN  D  Q:Q  Q:EXIT
 .I '(I#5000) D  Q:EXIT
 ..S:$$S^%ZTLOAD EXIT=1
 .Q:'$D(@GLB@(DFN,RDT,VST))
 .K @GLB@(DFN,RDT,VST)
 .K ^AUPNVSIT("ADEL",VSTBDT,VST)
 .K ^AUPNVSIT("B",VSTBDT,VST)
 .K ^AUPNVSIT("C",DFN,VST)
 .S @PXTEMP@("VSIT",VST)=VSTBDT_"^"_DFN
 .S Q=1
 .S GLB2="^AUPNVSIT(""AAH"")"
 .S (QT,SUB)=""
 .F  S SUB=$O(@GLB2@(DFN,SUB)) Q:'SUB  D  Q:QT
 ..Q:'$D(@GLB2@(DFN,SUB,VST))
 ..K @GLB2@(DFN,SUB,VST)
 ..S QT=1
 .S GLB2="^AUPNVSIT(""AET"")"
 .S (QT,LOC)=""
 .F  S LOC=$O(@GLB2@(DFN,VSTBDT,LOC)) Q:'LOC  D  Q:QT
 ..S TYP=""
 ..F  S TYP=$O(@GLB2@(DFN,VSTBDT,LOC,TYP)) Q:TYP=""  D  Q:QT
 ...Q:'$D(@GLB2@(DFN,VSTBDT,LOC,TYP,VST))
 ...K @GLB2@(DFN,VSTBDT,LOC,TYP,VST)
 ...K ^AUPNVSIT("AHL",LOC,RDT,VST)
 ...S QT=1
 .S GLB2="^AUPNVSIT(""VID"")"
 .S (QT,SUB)=""
 .F J=1:1 S SUB=$O(@GLB2@(SUB)) Q:SUB=""  D  Q:QT  Q:EXIT
 ..I '(J#2000) D  Q:EXIT
 ...S:$$S^%ZTLOAD EXIT=1
 ..Q:'$D(@GLB2@(SUB,VST))
 ..K @GLB2@(SUB,VST)
 .Q:EXIT
 .S GLB2="^AUPNVSIT(""AD"")"
 .S (QT,SUB)=""
 .F J=1:1 S SUB=$O(@GLB2@(SUB)) Q:SUB=""  D  Q:QT  Q:EXIT
 ..I '(J#2000) D  Q:EXIT
 ...S:$$S^%ZTLOAD EXIT=1
 ..Q:'$D(@GLB2@(SUB,VST))
 ..K @GLB2@(SUB,VST)
 Q
ASK() ;PROMPT FOR PATIENT IEN
 N DIR
 S DIR(0)="NO"
 S DIR("A")="ENTER PATIENT IEN"
 D ^DIR
 Q Y
FIX() ;Prompt user for cleanup function
 N DIR,DA,X,Y
 S DIR(0)="Y"
 S DIR("A")="Do you wish to correct entries found"
 D ^DIR
 Q Y
MAIL ;Send mail to user about findings
 N XMDUN,XMDUZ,XMSUB,XMTEXT,XMY,TEXT
 N PXVST,PXTYP,PXVIEN,PXSTR,PXIEN,LN,PXTEMP
 S LN=0
 I 'VFIX D
 .S LN=LN+1,TEXT(LN)="*** REPORT ONLY MODE ***"
 .S LN=LN+1,TEXT(LN)=" "
 S PXTEMP="^XTMP(""PX1P88B"""_","_"""VFIL"""_")"
 I $D(@PXTEMP) D
 .S PXVST=0
 .F  S PXVST=$O(@PXTEMP@(PXVST)) Q:'PXVST  D
 ..S LN=LN+1
 ..S TEXT(LN)="VISIT Date: "_$$GET1^DIQ(9000010,PXVST,.01)
 ..S TEXT(LN)=TEXT(LN)_"  Patient: "_$$GET1^DIQ(9000010,PXVST,.05)
 ..S PXTYP=""
 ..F  S PXTYP=$O(@PXTEMP@(PXVST,PXTYP)) Q:PXTYP=""  D
 ...S PXIEN=""
 ...F  S PXIEN=$O(@PXTEMP@(PXVST,PXTYP,PXIEN)) Q:'PXIEN  D
 ....S PXSTR=@PXTEMP@(PXVST,PXTYP,PXIEN)
 ....S LN=LN+1
 ....I $P(PXSTR,"^",3)=2 D
 .....S TEXT(LN)="MISSING V "_PXTYP_" DATA, IEN="_PXIEN
 ....E  S TEXT(LN)="MISSING .01 FIELD IN V "_PXTYP_", IEN="_PXIEN
 S PXTEMP="^XTMP(""PX1P88B"""_","_"""VSIT"""_")"
 I $D(@PXTEMP) D
 .S LN=LN+1,TEXT(LN)=" "
 .S LN=LN+1,TEXT(LN)="INVALID VISIT X-REF"
 .S VST=""
 .F  S VST=$O(@PXTEMP@(VST)) Q:'VST  D
 ..S LN=LN+1
 ..I $P(@PXTEMP@(VST),"^",2)'="" D
 ...S TEXT(LN)="PATIENT NAME: "_$$GET1^DIQ(2,$P(@PXTEMP@(VST),"^",2),.01)
 ...S LN=LN+1
 ..S TEXT(LN)="VISIT IEN: "_VST_"  VISIT DATE: "_$$FMTE^XLFDT(@PXTEMP@(VST))
 I LN<3 S LN=LN+1,TEXT(LN)="NO ENTRIES FOUND"
 S LN=LN+1,TEXT(LN)=" ",LN=LN+1
 S TEXT(LN)="Start time: "_$$FMTE^XLFDT(PXSTART)
 S TEXT(LN)=TEXT(LN)_"   End time: "_$$FMTE^XLFDT($$NOW^XLFDT)
 S XMSUB="PX1P88B CLEANUP ROUTINE COMPLETE"
 S (XMDUN,XMDUZ)="PX1P88B CLEANUP"
 S XMTEXT="TEXT("
 S XMY(PXDUZ)=""
 D ^XMD
 Q
DIK(DA) ;Delete V FILE entry
 S DIK=VFILE_"("
 D ^DIK
 Q
EXIT ;
 K ^XTMP("PX1P88B")
 W !,"ENDING"
 Q
