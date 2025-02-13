PSOERX1B ;ALB/BWF - Accept eRx function ; 8/3/2016 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**467,506,520,527,508,551,591,606,581,617,700**;DEC 1997;Build 261
 ;
 Q
ACVAL(PSOIEN,TYPE) ; NEW MTYPE, GET IT OFF FIELD .08, IF NOT DEFINED, 
 ;Input: PSOIEN - eRx IEN (Pointer to #52.49)
 ;       TYPE   - Validation Type (P: Patient, PR: Provider, D: Drug)
 N MBMSITE,F,VBFLD,VBDTTMF,DIR,TAG,VALPAR,VAL,CURVAL,MVFLD,VBFLD,VBDTTMF,PSOIENS,RXSTAT,QFLG,VDTTM,ERXMMFLG,MTYPE,Y
 N RESTYPE,GMRA,GMRAL,ERXPTIEN,DFN
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 S F=52.49,PSOIENS=PSOIEN_","
 D FULL^VALM1
 S VALMBCK="R"
 ; first check to see if the entry exists. cannot validate something that has no value
 S MTYPE=$$GET1^DIQ(52.49,PSOIEN,.08,"I") ;mtype
 S RXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E") I RXSTAT="RJ"!(RXSTAT="RM")!($E(RXSTAT,1,3)="REM")!(RXSTAT="PR")!(RXSTAT="CRP")!(RXSTAT="CXP")!(RXSTAT="RRP") D  Q
 . W !!,"Cannot accept validation for a prescription with a status of 'Rejected',",!,"'Removed',or 'Processed",!
 . S DIR(0)="E" D ^DIR
 Q:TYPE']""
 S TAG=$S(TYPE="P":"patient",TYPE="PR":"provider",TYPE="D":"drug",1:"")
 S VALPAR=$S(TYPE="P":.05,TYPE="PR":2.3,TYPE="D":3.2,1:"") Q:VALPAR=""
 S VAL=$$GET1^DIQ(F,PSOIEN,VALPAR,"I") I 'VAL D  Q
 . W !,"Vista "_TAG_" has not been matched. Cannot manually validate."
 . S DIR(0)="E" D ^DIR
 S MVFLD=$S(TYPE="P":1.7,TYPE="PR":1.3,TYPE="D":1.5,1:"")
 S VBFLD=$S(TYPE="P":1.13,TYPE="PR":1.8,TYPE="D":1.11,1:"")
 S VBDTTMF=$S(TYPE="P":1.14,TYPE="PR":1.9,TYPE="D":1.12,1:"")
 ; check if Patient has a valid adress - CS prescriptions only
 I TYPE="P",$$GET1^DIQ(52.49,PSOIEN,95.1,"I"),'$$VALPTADD^PSOERXUT(+$G(VAL)) D  Q
 . W !!,"Unable to validate - VistA Patient does not have a current mailing"
 . W !,"or residential address on file.",$C(7),!
 . S DIR(0)="E" D ^DIR
 ; check to see if this is already validated
 I MVFLD S CURVAL=$$GET1^DIQ(F,PSOIEN,MVFLD,"I")
 I CURVAL D  Q
 . W !!,"This "_TAG_" has already been "_$S(TYPE="PR"&$$GET1^DIQ(52.49,PSOIEN,2.7,"I"):"automatically",1:"manually")_" validated."
 . W !,"Validated By: "_$$GET1^DIQ(F,PSOIEN,VBFLD,"E")
 . W !,"Validated Date/Time: "_$$GET1^DIQ(F,PSOIEN,VBDTTMF,"E"),!
 . S DIR(0)="E" D ^DIR
 S QFLG=0
 I TYPE="D" D
 . W !
 . I '$O(^PS(52.49,PSOIEN,21,0)) W !,"Dosing information missing.",$C(7) S QFLG=1
 . I $$GET1^DIQ(52.49,PSOIEN,20.1,"E")="" W !,"Quantity missing.",$C(7) S QFLG=1
 . I $$GET1^DIQ(52.49,PSOIEN,20.2,"E")="" W !,"Days supply missing.",$C(7) S QFLG=1
 I $G(QFLG) W ! S DIR(0)="E" D ^DIR K DIR Q
 I TYPE="D" D
 . N ERXMSG,I
 . D PRDRVAL^PSOERXUT(.ERXMSG,"VD",PSOIEN) I $P(ERXMSG,"^",2)="B" S QFLG=1
 . I $O(ERXMSG(0)) D
 . . W !!,"*********************************",$S($P(ERXMSG,"^",2)="W":" WARNING(S) ",1:"INVALID DRUG"),"***********************************"
 . . S I=0 F  S I=$O(ERXMSG(I)) Q:'I  W !,$P(ERXMSG(I),"^")
 . . W !,"********************************************************************************",$C(7)
 I $G(QFLG) W ! S DIR(0)="E" D ^DIR K DIR Q
 ;
 I TYPE="P" D  I '$G(ERXMMFLG) S DIR(0)="E" D ^DIR K DIR
 . S ERXMMFLG=$$PATWARN^PSOERX1A("VP",PSOIEN)
 ;
 S DFN=$$GET1^DIQ(52.49,PSOIEN,.05,"I")
 ; VistA Patient ChampVA Eligibility Check (MbM Only)
 I $G(MBMSITE),TYPE="P",'$$CHVAELIG^PSOERXU9(DFN) D  Q
 . I ",N,I,W,RXI,RXN,RXW,RXR,CXI,CXN,CXW,"[(","_$G(RXSTAT)_",") D
 . . D UPDSTAT^PSOERXU1(PSOIEN,"HEL","Hold due to Eligibility Issue")
 . . W !!,"This eRx has been put on Hold (HEL) because the VistA Patient ("_$$GET1^DIQ(2,DFN,.01)_") is not Eligible for ChampVA Rx Benefit."
 . . K DIR D PAUSE^VALM1
 . D AUTOHOLD^PSOERX1E("E",PSOIEN,DFN)
 ;
 ; VistA Patient Allergy Check (MbM Only)
 I $G(MBMSITE),TYPE="P" D  I $G(GMRAL)="" Q
 . S GMRA="0^0^111" D EN1^GMRADPT I $G(GMRAL)'="" Q
 . I ",N,I,W,RXI,RXN,RXW,RXR,CXI,CXN,CXW,"[(","_$G(RXSTAT)_",") D
 . . D UPDSTAT^PSOERXU1(PSOIEN,"HAL","Hold for Allergy Assessment")
 . . W !!,"This eRx has been put on Hold (HAL) because the VistA Patient ("_$$GET1^DIQ(2,DFN,.01)_") does not have an Allergy Assessment.."
 . . K DIR D PAUSE^VALM1
 . D AUTOHOLD^PSOERX1E("A",PSOIEN,DFN)
 ;
 I TYPE="P",'$G(ERXMMFLG) Q
 ;
 I TYPE="PR" S ERXMMFLG=$$PRVWARN^PSOERX1A("VP",PSOIEN) I 'ERXMMFLG S DIR(0)="E" D ^DIR K DIR Q
 W !,"Would you like to mark this "_TAG_" as VALIDATED?"
 S DIR(0)="Y",DIR("B")=$S($G(ERXMMFLG):"NO",1:"YES") D ^DIR Q:Y'=1
 K FDA,DIR
 S VDTTM=$$NOW^XLFDT I MVFLD S FDA(F,PSOIENS,MVFLD)=1
 I VBFLD S FDA(F,PSOIENS,VBFLD)=$G(DUZ)
 I VBDTTMF S FDA(F,PSOIENS,VBDTTMF)=VDTTM
 I $D(FDA) D FILE^DIE(,"FDA") K FDA
 W !,"Validation Updated!!"
 ; check validations and update status to 'wait' if all validations have occured.
 I MTYPE="N" D
 . I $$GET1^DIQ(52.49,PSOIEN,1.3,"I"),$$GET1^DIQ(52.49,PSOIEN,1.5,"I"),$$GET1^DIQ(52.49,PSOIEN,1.7,"I") D UPDSTAT^PSOERXU1(PSOIEN,"W") Q
 . D UPDSTAT^PSOERXU1(PSOIEN,"I")
 I MTYPE="RE" D
 . S RESTYPE=$$GET1^DIQ(52.49,PSOIEN,52.1,"I")
 . I RESTYPE'="R" D UPDSTAT^PSOERXU1(PSOIEN,"RXW") Q
 . I $$GET1^DIQ(52.49,PSOIEN,1.3,"I"),$$GET1^DIQ(52.49,PSOIEN,1.5,"I"),$$GET1^DIQ(52.49,PSOIEN,1.7,"I") D UPDSTAT^PSOERXU1(PSOIEN,"RXW") Q
 . D UPDSTAT^PSOERXU1(PSOIEN,"RXI")
 I MTYPE="CX" D
 . I $$GET1^DIQ(52.49,PSOIEN,1.3,"I"),$$GET1^DIQ(52.49,PSOIEN,1.5,"I"),$$GET1^DIQ(52.49,PSOIEN,1.7,"I") D UPDSTAT^PSOERXU1(PSOIEN,"CXW") Q
 . D UPDSTAT^PSOERXU1(PSOIEN,"CXI")
 I TYPE="P" D BPROC^PSOERXU8(PSOIEN,"PA",MVFLD,VBFLD,VBDTTMF,VDTTM) K @VALMAR D INIT^PSOERXP1
 I TYPE="PR" D BPROC^PSOERXU8(PSOIEN,"PR",MVFLD,VBFLD,VBDTTMF,VDTTM) K @VALMAR D INIT^PSOERXR1
 I TYPE="D" K @VALMAR D INIT^PSOERXD1
 Q
 ;PSOHY("LOC")=IEN of hospital location file (#44) - NOT USED, 
 ;PSOHY("CHNUM")=EXTERNAL PLACER ORDER NUMBER (NEED TO FIND OUT HOW WE SHOULD SET THIS) (25)
 ;PSOHY("PICK")=MAIL/WINDOW (20.4) 
 ;PSOHY("ENTER")=ENTERED BY IEN (2.1)
 ;PSOHY("PROV")=PROVIDER IEN (2.3)
 ;PSOHY("SDT")=EFFECTIVE DATE (6.3)
 ;PSOHY("ITEM")=PHARMACY ORDERABLE ITEM (DERIVED FROM THE DRUG IEN) - NO MAPPING TO 52.49
 ;PSOHY("DRUG")=DRUG IEN (3.2)
 ;PSOHY("QTY")=QUANTITY (20.1)
 ;PSOHY("REF")=# OF REFILLS (20.5)
 ;PSOHY("PAT")=PATIENT IEN (.05)
 ;PSOHY("OCC")=ORDER TYPE (ALWAYS 'NW') - NO MAPPING TO 52.49
 ;PSOHY("EDT")=LOGIN DATE/TIME (ERX MSG DATE/TIME #.03)
 ;PSOHY("PRIOR")=PRIORITY (SET OF CODES, 52.41,25 - STAT, EMERGENCY, ROUTINE)
 ;PSOHY("EXAPP")=EXTERNAL APPLICATION (FREE TEXT), LIKELY "PSO" - NO MAPPING TO 52.49
 ;PSOHY("PRCOM",#)=PROVIDER COMMENTS (8- NOTES)
 ;PSOHY("SIG",#)=SIG (52.4911 (STRUCTURED SIG), FIELD 1 (SIG FREE TEXT)
 ;PSOHY("QTSUB",CNT)=QUANTITY TIMING SUBFILE DATA. MERGED IN, FULL SUBFILE DATA
 ; QUANTITY/TIMING MAPS DIRECTLY TO QUANTITY TIMING IN 52.41
SETUP ;
 N MBMSITE,PSOIENS,PSODAT,F,PATIEN,PROVIEN,OC,VQTY,EFFDT,VADRUG,VAOI,VAREF,VAROUT,VAPRIOR,PSOHY,LOC,ERXNUM,PRVARY,PRVCOMM
 N PLOOP,PCNT,QTLOOP,QTCNT,PSOEXMS,DIR,ORDERTYP,PSOEXCNT,SCNT,SIGDAT,SLOOP,POORD,PMVAL,PRMVAL,DMVAL,PATINST,RXSTAT
 N VADAYS,UNEXPI,PINARY,WRITDT,SLOOP2,MTYPE,REQIEN,ORXIEN,RESTYPE,DELTAS,RXIEN
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 S F=52.49
 Q:'$G(PSOIEN)
 D FULL^VALM1
 S RXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E") I RXSTAT="RJ"!(RXSTAT="RM")!($G(MBMSITE)&($E(RXSTAT,1,3)="REM"))!(RXSTAT="PR")!(RXSTAT="RXP") D  Q
 .W !!,"Cannot accept a prescription with a status of 'Rejected', 'Removed',",!,"or 'Processed",!
 .S DIR(0)="E" D ^DIR
 S PSOIENS=PSOIEN_","
 D GETS^DIQ(F,PSOIENS,".01;.05;.07;.08;1;1.3;1.5;1.7;2.1;2.3;3.2;5.9;6.2;6.3;8;20.1;20.2;20.4;20.5;20.6;25;25.2;27;30;52.1","IE","PSODAT")
 S PSOEXCNT=0
 S MTYPE=$G(PSODAT(F,PSOIENS,.08,"I"))
 S RESTYPE=$G(PSODAT(F,PSOIENS,52.1,"I"))
 I MTYPE="RE",RESTYPE'="R" D  Q
 .S REQIEN=$$GETREQ^PSOERXU2(PSOIEN)
 .I REQIEN S RXIEN=$$GET1^DIQ(52.49,REQIEN,.13,"I")
 .D PREFRES^PSOERXU3(PSOIEN,.PSOHY,.PSOEXCNT,.PSOEXMS,.PSODAT)
 .D RRDELTA^PSOERXU2(.DELTAS,REQIEN,PSOIEN)
 .I $O(PSOEXMS(0)),RESTYPE="AWC",$D(DELTAS(52.49,"EXTERNAL PROVIDER")) D  Q
 ..D MSGDIR^PSOERXU1(.PSOEXMS)
 .I $O(PSOEXMS(0)),$E(RESTYPE)="A",'$D(DELTAS(52.49,"EXTERNAL PROVIDER")) D  Q
 ..D UPDSTAT^PSOERXU1(PSOIEN,"RXF","Unable to add order to Pending file.") Q
 .I $D(DELTAS(52.49,"EXTERNAL PROVIDER")) D ADD Q
 .; call using silent mode if this is auto-processing
 .D ADD(1)
 S ERXSTA=$G(PSODAT(F,PSOIENS,1,"E")) I ERXSTA="E"!($E(ERXSTA)="H") S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="eRx is in a 'Hold' status." D MSGDIR^PSOERXU1(.PSOEXMS) Q
 I MTYPE="N"!(MTYPE="RE"&(RESTYPE="R")!(MTYPE="CX")) D
 .S PMVAL=$G(PSODAT(F,PSOIENS,1.7,"I")) I 'PMVAL S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Patient has not been manually validated."
 .S PRMVAL=$G(PSODAT(F,PSOIENS,1.3,"I")) I 'PRMVAL S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Provider has not been manually validated."
 .S DMVAL=$G(PSODAT(F,PSOIENS,1.5,"I")) I 'DMVAL S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Drug has not been manually validated."
 ; for now, if validations have not occurred, do not check the other fields.
 I $O(PSOEXMS(0)) D MSGDIR^PSOERXU1(.PSOEXMS) Q
 S POORD=$G(PSODAT(F,PSOIENS,25.2,"I")) I POORD S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Pending outpatient order already exists."
 S PATIEN=$G(PSODAT(F,PSOIENS,.05,"I")) I 'PATIEN S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="No matched vista patient."
 S PROVIEN=$G(PSODAT(F,PSOIENS,2.3,"I")) I 'PROVIEN S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Provider not matched to a vista provider."
 S VADRUG=$G(PSODAT(F,PSOIENS,3.2,"I")) I 'VADRUG S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Drug not matched to a vista drug."
 S LOC=$G(PSODAT(F,PSOIENS,20.6,"I"))
 S ERXNUM=$G(PSODAT(F,PSOIENS,.01,"E")) I 'ERXNUM S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="eRx number missing."
 S VQTY=$G(PSODAT(F,PSOIENS,20.1,"E")) I 'VQTY S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Quantity missing."
 S EFFDT=$G(PSODAT(F,PSOIENS,6.3,"I")),WRITDT=$G(PSODAT(F,PSOIENS,5.9,"I"))
 ; if the effective date is passed in and there is no time, add .000001 to the date
 I EFFDT]"" S EFFDT=$P(EFFDT,".")
 I '$L(EFFDT) S EFFDT=WRITDT
 S VADAYS=$G(PSODAT(F,PSOIENS,20.2,"E"))
 S VAOI=$$GET1^DIQ(50,VADRUG,2.1,"I") I 'VAOI S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Orderable item not associated with drug."
 S VAREF=$G(PSODAT(F,PSOIENS,20.5,"E"))
 S VAROUT=$G(PSODAT(F,PSOIENS,20.4,"I")) I '$L(VAROUT) S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Pickup routing missing."
 S PATINST=$G(PSODAT(F,PSOIENS,27,"E"))
 D TXT2ARY^PSOERXD1(.PINARY,$$LSIG^PSOERXU6(PATINST))
 ; get provider comments from VA PROVIDER COMMENTS field
 S PRVCOMM=$G(PSODAT(F,PSOIENS,30,"E"))
 D TXT2ARY^PSOERXD1(.PRVARY,$$LSIG^PSOERXU6(PRVCOMM))
 S (PLOOP,PCNT)=0 F  S PLOOP=$O(PRVARY(PLOOP)) Q:'PLOOP  D
 .S PCNT=PCNT+1,PSOHY("PRCOM",PCNT)=$G(PRVARY(PLOOP))
 I '$O(^PS(52.49,PSOIEN,21,0)) S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Dosing information missing."
 S (QTLOOP,QTCNT)=0 F  S QTLOOP=$O(^PS(52.49,PSOIEN,21,QTLOOP)) Q:'QTLOOP  D
 .S QTCNT=QTCNT+1 M PSOHY("QTSUB",QTCNT)=^PS(52.49,PSOIEN,21,QTLOOP)
 ; always 'routine' for now
 S VAPRIOR="R"
 ; always 'new' for this version
 I '$L($G(ORDERTYP)) S ORDERTYP="NW"
 S PSOHY("LOC")=LOC,PSOHY("CHNUM")=$G(ERXNUM)
 S PSOHY("PICK")=VAROUT,PSOHY("ENTER")=PROVIEN
 S PSOHY("PROV")=PROVIEN,PSOHY("SDT")=EFFDT
 S PSOHY("ITEM")=VAOI,PSOHY("DRUG")=VADRUG
 S PSOHY("QTY")=VQTY,PSOHY("REF")=VAREF
 S (PSOHY("PAT"),DFN)=PATIEN,PSOHY("OCC")=ORDERTYP
 ; Login date will always be the Message Received Date/Time
 S PSOHY("EDT")=$$GET1^DIQ(52.49,PSOIEN,.03,"I"),PSOHY("PRIOR")=VAPRIOR
 ; ALWAYS PSO as the external application
 S PSOHY("EXAPP")="PHARMACY"
 S PSOHY("DAYS")=VADAYS
 ; sig from eRx
 S (SLOOP,SCNT)=0 F  S SLOOP=$O(^PS(52.49,PSOIEN,"SIG",SLOOP)) Q:'SLOOP  D
 .S SIGDAT=$G(^PS(52.49,PSOIEN,"SIG",SLOOP,0))
 .S SCNT=SCNT+1,PSOHY("SIG",SCNT)=SIGDAT
 S SLOOP2=0 F  S SLOOP2=$O(PINARY(SLOOP2)) Q:'SLOOP2  D
 .S SCNT=SCNT+1,PSOHY("SIG",SCNT)=$G(PINARY(SLOOP2))
 ; if provider, patient or drug is missing, no need to continue.
 ; future consideration - do we need to check more fields?
 D ADD
 I $G(PSOEXMS)]"" W !,PSOEXMS S DIR(0)="E" D ^DIR K DIR
 K DFN
 Q
ADD(QUIET) ;Add CHCS message to Outpatient Pending Orders file
 N PSOHQ,PSOHQT,PSOCPEND,PSOHINI,PSOHINLO,ERXSTA,ORDNUM,ILOOP,IARY,PSSRET,RESTYPE,RTHIEN,RTHID,X
 S (PSOHINI,PSOHINLO)=0 D
 .I $G(PSOHY("LOC")) S PSOHINLO=$P($G(^SC(PSOHY("LOC"),0)),"^",4) I PSOHINLO Q
 ; get institution from 52.49 if clinic was not passed in
 S RESTYPE=$$GET1^DIQ(52.49,PSOIEN,52.1,"I")
 I $G(PSOHINLO)<1 S PSOHINLO=$$GET1^DIQ(52.49,PSOIEN,24.1,"I")
 I +$G(PSOHINLO)<1 S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Unable to derive Institution from Clinic." Q
 K DD,DO,DIC S X=PSOHY("CHNUM"),DIC="^PS(52.41,",DIC(0)="L"
 S:$G(PSOHY("PICK"))="" PSOHY("PICK")="M"
 S DIC("DR")="4////"_$G(PSOHY("ENTER"))_";5////"_PSOHY("PROV")_";6////"_$G(PSOHY("SDT"))_";8////"_PSOHY("ITEM")_";11////"_PSOHY("DRUG")
 S DIC("DR")=$G(DIC("DR"))_";12////"_$G(PSOHY("QTY"))_";13////"_$G(PSOHY("REF"))_";22.1////"_$G(PSOHY("PREVORD"))_";101////"_$G(PSOHY("DAYS"))
 D FILE^DICN K DD,DIC,DO I Y<0 D  Q
 .S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Unable to add order to Pending file."
 .I MTYPE="RE" D UPDSTAT^PSOERXU1(PSOIEN,"RXF",PSOEXMS(PSOEXCNT))
 .S REQIEN=$$GETREQ^PSOERXU2(PSOIEN) I REQIEN D UPDSTAT^PSOERXU1(PSOIEN,"RRF",PSOEXMS)
 S PSOCPEND=+Y
 S $P(^PS(52.41,PSOCPEND,0),"^",2)=PSOHY("PAT"),$P(^(0),"^",3)=PSOHY("OCC"),$P(^(0),"^",12)=$G(PSOHY("EDT")),$P(^(0),"^",13)=$G(PSOHY("LOC"))
 S $P(^PS(52.41,PSOCPEND,0),"^",14)=$G(PSOHY("PRIOR")),$P(^(0),"^",17)=$G(PSOHY("PICK"))
 S $P(^PS(52.41,PSOCPEND,"EXT"),"^")=PSOHY("CHNUM"),$P(^("EXT"),"^",2)=0,$P(^("EXT"),"^",3)=PSOHY("EXAPP")
 S DIE="^PS(52.41,",DA=PSOCPEND,DR="104.1///1" D ^DIE K DIE,DA,DR
 ; PSO*7*506
 S FDA(52.41,PSOCPEND_",",104)=$G(PATINST) D FILE^DIE(,"FDA") K FDA
 N DA,DIK S DA=PSOCPEND,DIK="^PS(52.41,",DIK(1)="114^C" D EN1^DIK
 I $O(PSOHY("PRCOM",0)) D  I PSOHQT S ^PS(52.41,PSOCPEND,3,0)="^^"_PSOHQT_"^"_PSOHQT_"^"_DT_"^"
 .S PSOHQ="",PSOHQT=0 F  S PSOHQ=$O(PSOHY("PRCOM",PSOHQ)) Q:PSOHQ=""  I $G(PSOHY("PRCOM",PSOHQ))'="" S PSOHQT=PSOHQT+1,^PS(52.41,PSOCPEND,3,PSOHQT,0)=$G(PSOHY("PRCOM",PSOHQ))
 I $O(PSOHY("SIG",0)) D  I PSOHQT S ^PS(52.41,PSOCPEND,"SIG",0)="^52.4124A^"_PSOHQT_"^"_PSOHQT
 .S PSOHQ="",PSOHQT=0 F  S PSOHQ=$O(PSOHY("SIG",PSOHQ)) Q:PSOHQ=""  I $G(PSOHY("SIG",PSOHQ))'="" S PSOHQT=PSOHQT+1,^PS(52.41,PSOCPEND,"SIG",PSOHQT,0)=$G(PSOHY("SIG",PSOHQ))
 S $P(^PS(52.41,PSOCPEND,"INI"),"^")=$G(PSOHINLO)
 ; add quantity/timing subfile information
 I $O(PSOHY("QTSUB",0)) D  I PSOHQT S ^PS(52.41,PSOCPEND,1,0)="^52.413^"_PSOHQT_"^"_PSOHQT
 .S PSOHQ="",PSOHQT=0 F  S PSOHQ=$O(PSOHY("QTSUB",PSOHQ)) Q:PSOHQ=""  D
 ..I $O(PSOHY("QTSUB",PSOHQ,0)) S PSOHQT=PSOHQT+1
 ..S ^PS(52.41,PSOCPEND,1,PSOHQT,0)=PSOHY("QTSUB",PSOHQ,0)
 ..S ^PS(52.41,PSOCPEND,1,PSOHQT,1)=PSOHY("QTSUB",PSOHQ,1)
 ..S ^PS(52.41,PSOCPEND,1,PSOHQT,2)=PSOHY("QTSUB",PSOHQ,2)
 I $O(PINARY(0)) D WP^DIE(52.41,PSOCPEND_",",105,"K","PINARY")
 ;Cross references not set yet preventing Pharmacy from finishing order
 D EN^PSOHLSNC(PSOCPEND,"SN","IP")
 D FULL^VALM1
 ;Just set to DC, don't delete because 52.41 entry would be re-used
 I '$P($G(^PS(52.41,PSOCPEND,"EXT")),"^",2) D  S $P(^PS(52.41,PSOCPEND,0),"^",3)="DC" S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Unable to send CHCS order to CPRS." Q
 .;x-ref shouldn't be set, but we'll kill them just in case
 .K ^PS(52.41,"AOR",$P(^PS(52.41,PSOCPEND,0),"^",2),+$P($G(^("INI")),"^"),PSOCPEND),^PS(52.41,"AD",$P(^PS(52.41,PSOCPEND,0),"^",12),+$P($G(^("INI")),"^"),PSOCPEND)
 .K ^PS(52.41,"ACL",+$P(^PS(52.41,PSOCPEND,0),"^",13),$P(^(0),"^",12),PSOCPEND),^PS(52.41,"AQ",+$P($G(^PS(52.41,PSOCPEND,0)),"^",21),PSOCPEND)
 .S $P(^PS(52.41,PSOCPEND,4),"^")="External order, unable to successfully transmit to CPRS."
 .I $D(QUIET) S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="External order, unable to successfully transmit to CPRS."
 .I '$D(QUIET) W !!,"External order, unable to successfully transmit to CPRS."
 .I '$D(QUIET) S DIR(0)="E" D ^DIR
 ;Successful transmission to CPRS
 S DA=PSOCPEND,DIK="^PS(52.41," D IX^DIK
 ; add the pending outpatient order number to 52.49 and update status of eRx to PR (Processed)
 S ERXSTA=$O(^PS(52.45,"C","ERX","PR",0))
 S ORDNUM=$P($G(^PS(52.41,PSOCPEND,0)),U)
 S DIE="^PS(52.49,",DR="25.2///"_PSOCPEND_";.12///"_ORDNUM,DA=PSOIEN D ^DIE K DIE,DA,DR
 ; PSO*7*508 - add checks to update refill requests and responses
 ; add activity to status history
 I MTYPE="N" D UPDSTAT^PSOERXU1(PSOIEN,"PR")
 I MTYPE="RE" D UPDSTAT^PSOERXU1(PSOIEN,"RXP")
 ;B3S4
 I MTYPE="CX" D 
 .D UPDSTAT^PSOERXU1(PSOIEN,"CXP")
 .S RTHID=$$GET1^DIQ(52.49,PSOIEN,.14),RTHIEN=$O(^PS(52.49,"FMID",RTHID,0))
 .D UPDSTAT^PSOERXU1(RTHIEN,"CRP")
 S REQIEN=$$GETREQ^PSOERXU2(PSOIEN) I REQIEN,$$GET1^DIQ(52.49,REQIEN,.08,"I")="RR" D UPDSTAT^PSOERXU1(REQIEN,"RRP")
 ; PSO*7*508 - end
 ; gather the unexpanded sig and file in 52.41
 S ILOOP=0 F  S ILOOP=$O(^PS(52.49,PSOIEN,31,ILOOP)) Q:'ILOOP  D
 .S IARY(ILOOP)=$G(^PS(52.49,PSOIEN,31,ILOOP,0))
 I $D(IARY) D WP^DIE(52.41,PSOCPEND_",",9,"K","IARY","IERR")
 I '$D(QUIET) W !!,"eRx #"_PSOHY("CHNUM")_" sent to PENDING OUTPATIENT ORDERS!"
 ;PSO*7*520 - add sending and warning/information related to RxVerify Message.
 I MTYPE="N"!((MTYPE="RE")&(RESTYPE="R"))!(MTYPE="CX") D
 .W !!,"Sending rxVerify Message to prescriber."
 .D POST^PSOERXO1(PSOIEN,.PSSRET,,,,1)
 .; if the post was unsuccessful, inform the user and quit.
 .I $P(PSSRET(0),U)<1 W !,$P(PSSRET(0),U,2) S DIR(0)="E" D ^DIR K DIR Q
 .I $D(PSSRET("errorMessage")) W !,PSSRET("errorMessage") S DIR(0)="E" D ^DIR K DIR Q
 ;PSO*7*520 - end rxVerify changes
 K QUIET
 Q
 ; remove eRx from holding queue
REM ;
 D REM^PSOERXU4
 Q
 ; unremove eRx from holding queue
UNREM ;
 D UNREM^PSOERXU4
 Q
 ; reject eRx
REJ ;
 D REJ^PSOERXU4
