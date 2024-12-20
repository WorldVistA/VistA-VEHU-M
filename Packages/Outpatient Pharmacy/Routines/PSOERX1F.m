PSOERX1F ;ALB/MR - Accept/Un-Accept eRx function ; 8/18/2020 5:14pm
 ;;7.0;OUTPATIENT PHARMACY;**617,651,700,746**;DEC 1997;Build 106
 ;
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
 N VADAYS,UNEXPI,PINARY,WRITDT,SLOOP2,MTYPE,REQIEN,ORXIEN,RESTYPE,DELTAS,RXIEN,ERXMSG,I,CSERRMSG,PSOQUIT,DIC
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 S F=52.49
 Q:'$G(PSOIEN)
 D FULL^VALM1 I MBMSITE S VALMBCK="R"
 I $$DONOTFIL^PSOERXUT(PSOIEN) Q
 S RXSTAT=$$GET1^DIQ(52.49,PSOIEN,1,"E")
 I RXSTAT="RJ"!(RXSTAT="RM")!($E(RXSTAT,1,3)="REM")!(RXSTAT="PR")!(RXSTAT="CXP")!(RXSTAT="RXP") D  Q
 . W !!,"Cannot accept a prescription with a status of 'Rejected', 'Removed',",!,"or 'Processed",!
 . S DIR(0)="E" D ^DIR
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
 ; CS eRx Validations
 D PRDRVAL^PSOERXUT(.CSERRMSG,"AC",PSOIEN)
 I '$G(CSERRMSG),$P(CSERRMSG,"^",2)="B" D MSGDIR^PSOERXU1(.CSERRMSG) Q
 I $$GET1^DIQ(52.49,PSOIEN,95.1,"I"),'$$VALPTADD^PSOERXUT(+$G(PSODAT(F,PSOIENS,.05,"I"))) D  Q
 . S CSERRMSG(1)="Patient does not have a current mailing or residential address on file."
 . D MSGDIR^PSOERXU1(.CSERRMSG)
 ;
 S POORD=$G(PSODAT(F,PSOIENS,25.2,"I")) I POORD S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Pending outpatient order already exists."
 S PATIEN=$G(PSODAT(F,PSOIENS,.05,"I")) I 'PATIEN S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="No matched vista patient."
 S PROVIEN=$G(PSODAT(F,PSOIENS,2.3,"I")) I 'PROVIEN S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Provider not matched to a vista provider."
 S VADRUG=$G(PSODAT(F,PSOIENS,3.2,"I")) I 'VADRUG S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Drug not matched to a vista drug."
 S ERXNUM=$G(PSODAT(F,PSOIENS,.01,"E")) I 'ERXNUM S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="eRx number missing."
 S VQTY=$G(PSODAT(F,PSOIENS,20.1,"E")) I 'VQTY S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Quantity missing."
 S EFFDT=$G(PSODAT(F,PSOIENS,6.3,"I")),WRITDT=$G(PSODAT(F,PSOIENS,5.9,"I"))
 S LOC=$G(PSODAT(F,PSOIENS,20.6,"I")) I 'LOC S LOC=$$GET1^DIQ(59,PSOSITE,10,"I")
 ; if the effective date is passed in and there is no time, add .000001 to the date
 I EFFDT]"" S EFFDT=$P(EFFDT,".")
 I '$L(EFFDT) S EFFDT=WRITDT
 S VADAYS=$G(PSODAT(F,PSOIENS,20.2,"E"))
 S VAOI=$$GET1^DIQ(50,VADRUG,2.1,"I") I 'VAOI S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Orderable item not associated with drug."
 S VAREF=$G(PSODAT(F,PSOIENS,20.5,"E"))
 S VAROUT=$G(PSODAT(F,PSOIENS,20.4,"I")) I '$L(VAROUT) S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Pickup routing missing."
 S PATINST=$G(PSODAT(F,PSOIENS,27,"E"))
 ; CALL TO AVOID SPACE CONCATENATION
 D TXT2ARY^PSOERXD1(.PINARY,$$LSIG^PSOERXU6(PATINST))
 ; get provider comments from VA PROVIDER COMMENTS field
 S PRVCOMM=$G(PSODAT(F,PSOIENS,30,"E"))
 D TXT2ARY^PSOERXD1(.PRVARY,$$LSIG^PSOERXU6(PRVCOMM))
 S (PLOOP,PCNT)=0 F  S PLOOP=$O(PRVARY(PLOOP)) Q:'PLOOP  D
 .S PCNT=PCNT+1,PSOHY("PRCOM",PCNT)=$G(PRVARY(PLOOP))
 I '$O(^PS(52.49,PSOIEN,21,0)) S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Dosing information missing."
 S (QTLOOP,QTCNT)=0 F  S QTLOOP=$O(^PS(52.49,PSOIEN,21,QTLOOP)) Q:'QTLOOP  D
 .S QTCNT=QTCNT+1 M PSOHY("QTSUB",QTCNT)=^PS(52.49,PSOIEN,21,QTLOOP)
 ;
 ; Assigning Clinic which the User is logged into
 S PSOQUIT=0
 I $G(MBMSITE),+$$GET1^DIQ(52.49,PSOIEN,20.6,"I")'=+$G(PSOCLNC) D  I $G(PSOQUIT) Q
 . W !!,"Current Clinic assigned to the eRx: ",$$GET1^DIQ(52.49,PSOIEN,20.6),!
 . K DIC S DIC(0)="AEMQ",DIC=44,DIC("S")="I '$P($G(^(""I"")),U,1)!$P($G(^(""I"")),U,2)"
 . S DIC("A")="Send to eRx Clinic: "
 . I $G(PSOCLNC) S DIC("B")=$$GET1^DIQ(44,PSOCLNC,.01)
 . D ^DIC I Y="^"!$D(DTOUT)!$D(DUOUT) S PSOQUIT=1 Q
 . I $G(Y)>0 S LOC=+Y
 ; always 'routine' for now
 S VAPRIOR="R"
 ; always 'new' for this version
 I '$L($G(ORDERTYP)) S ORDERTYP="NW"
 S PSOHY("LOC")=LOC,PSOHY("CHNUM")=$G(ERXNUM)
 S PSOHY("PICK")=VAROUT ;,PSOHY("ENTER")=PROVIEN
 S PSOHY("ENTER")=DUZ
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
 D ADD
 I $G(PSOEXMS)]"" W !,PSOEXMS S DIR(0)="E" D ^DIR K DIR
 K DFN
 Q
ADD(QUIET) ;Add CHCS message to Outpatient Pending Orders file
 N MBMSITE,PSOHQ,PSOHQT,PSOCPEND,PSOHINI,PSOHINLO,ERXSTA,ORDNUM,ILOOP,IARY,PSSRET,DA
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 I '$G(PSOHY("DRUG")) D  Q
 . S PSOEXCNT=PSOEXCNT+1,PSOEXMS(PSOEXCNT)="Invalid Dispense Drug" Q
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
 S PSORDNUM=$P($G(^PS(52.41,PSOCPEND,0)),U)
 S PSORDEA=$$FIND1^DIC(101.52,"","B",PSORDNUM)
 I $E($$GET1^DIQ(101.52,PSORDEA,1,"I"),*)'="S" S PSORDEA=""
 I PSORDEA S PSORDFDA(101.52,PSORDEA_",",1)="@" D FILE^DIE("K","PSORDFDA")
 ;
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
 ;
 ; Saves the Actual eRx SIG (from outside provider) into the PROVIDER COMMENTS field (P-651/14)
 N UNEXINS S UNEXINS(1)=$$ERXSIG^PSOERXUT(PSOIEN)
 I $L($G(UNEXINS(1))) D WP^DIE(52.41,PSOCPEND_",",9,"K","UNEXINS")
 ;
 I '$D(QUIET) D
 . W !!,"eRx #"_PSOHY("CHNUM")_" sent to PENDING ORDERS Queue."
 . W:$G(MBMSITE) " (Clinic: "_$$GET1^DIQ(44,+$G(PSOHY("LOC")),.01)_")"
 ;PSO*7*520 - add sending and warning/information related to RxVerify Message.
 I '$$UNACCBEF(PSOIEN),MTYPE="N"!((MTYPE="RE")&(RESTYPE="R"))!(MTYPE="CX") D
 .W !!,"Sending rxVerify Message to prescriber."
 .D POST^PSOERXO1(PSOIEN,.PSSRET,,,,1)
 .; if the post was unsuccessful, inform the user and quit.
 .I $P(PSSRET(0),U)<1 W !,$P(PSSRET(0),U,2) S DIR(0)="E" D ^DIR K DIR Q
 .I $D(PSSRET("errorMessage")) W !,PSSRET("errorMessage") S DIR(0)="E" D ^DIR K DIR Q
 ;PSO*7*520 - end rxVerify changes
 ;
 K QUIET
 Q
 ;
UNACC ; Un-Accept eRx from Pending Queue back into the Holding Queue
 N ORDNUM,ERXIEN,PSOIEN,DIE,DA,DR,DIC,PSOHOLD,PSOQUIT,DIR,X,Y,DTOUT,DUOUT,HOLDCOMM,POERR
 S VALMBCK="R"
 I '$G(ORD)!'$D(^PS(52.41,+$G(ORD),0)) S VALMSG="Invalid Pending Order" W $C(7) Q
 I " NW RNW "'[$$GET1^DIQ(52.41,ORD,2,"I") S VALMSG="eRx has already been finished or un-accepted." W $C(7) Q
 S ORDNUM=$$GET1^DIQ(52.41,+ORD,.01) I 'ORDNUM S VALMSG="Invalid Pending Order" W $C(7) Q
 S (ERXIEN,PSOIEN)=$$CHKERX^PSOERXU1(ORDNUM) I 'PSOIEN S VALMSG="This Pending Order is not related to an eRx" W $C(7) Q
 I '$G(ERXIEN) S VALMSG="This is not an eRx Prescription" W $C(7) Q
 D FULL^VALM1
 ;
 K DIC W ! S DIC("A")="Select HOLD reason code: "
 S DIC="^PS(52.45,",DIC(0)="AEMQ",DIC("B")="HOLD FOR RX EDIT"
 S DIC("S")="I $D(^PS(52.45,""TYPE"",""ERX"",Y)),$E($P(^PS(52.45,Y,0),U),1)=""H"""
 S (PSOHOLD,PSOQUIT)=0
 F  D ^DIC D  I PSOHOLD!PSOQUIT Q
 . I $G(DUOUT)!$G(DTOUT) S PSOQUIT=1 Q
 . I X="" W !,"HOLD Reason is required",!,$C(7) Q
 . S PSOHOLD=Y
 I PSOQUIT Q
 ;
 K DIR,DA S DIR(0)="52.4919,1",DIR("A")="Comments (Optional)"
 D ^DIR K DIR I Y="^" Q
 S HOLDCOMM=$G(Y)
 ;
 K DIR W ! S DIR("A",1)="This eRx will be Un-Accepted and sent back to the eRx Holding Queue."
 S DIR("A",2)="",DIR("A")="Confirm",DIR(0)="Y",DIR("B")="N"
 D ^DIR I $G(DIRUT)!$G(DUOUT)!'Y Q
 W ?40,"Please wait..."
 ;
 ; Changing eRx Order Status to Hold
 D UPDSTAT^PSOERXU1(ERXIEN,$P(PSOHOLD,"^",2),HOLDCOMM,1)
 ; Removing pointer to the Pending Order entry
 I $P($G(^PS(52.49,ERXIEN,25)),"^",2) S $P(^PS(52.49,ERXIEN,25),"^",2)=""
 ;
 Q:'$D(^PS(52.41,ORD,0))
 K ^PS(52.41,"AOR",$P(^PS(52.41,ORD,0),"^",2),+$P($G(^PS(52.41,ORD,"INI")),"^"),ORD)
 K ^PS(52.41,"AD",$P(^PS(52.41,ORD,0),"^",12),+$P($G(^PS(52.41,ORD,"INI")),"^"),ORD)
 S $P(^PS(52.41,ORD,0),"^",3)="DC",POERR("PLACER")=$P(^(0),"^"),POERR("STAT")="OC"
 S POERR("COMM")="eRx Un-Accepted: "_$$GET1^DIQ(52.45,+PSOHOLD,.02)_$S(HOLDCOMM'="":" - "_HOLDCOMM,1:"")
 S $P(^PS(52.41,ORD,4),"^")=POERR("COMM")
 D EN^PSOHLSN(POERR("PLACER"),POERR("STAT"),POERR("COMM"),"W")
 ;
 W !!,"eRx successfully un-accepted and placed back on the eRx Holding Queue."
 K DIR D PAUSE^VALM1
 ;
 D JUMP2ERX K VALMBCK
 Q
 ;
JUMP2ERX ; Jump to the eRx Holding Queue for the specific order after Un-Accepting eRx
 N ORDNUM,PSOIEN,ERXIEN
 D FULL^VALM1
 S VALMBCK="R"
 I $G(PSOJUMP) S VALMSG="Cannot jump back to the Holding Queue, use ^" W $C(7) Q
 S ORDNUM=+$$ORDNUM() I 'ORDNUM S VALMSG="Invalid Order" W $C(7) Q
 S (ERXIEN,PSOIEN)=$$CHKERX^PSOERXU1(ORDNUM) I 'PSOIEN S VALMSG="This Order is not related to an eRx" W $C(7) Q
 X "N (DUZ,IO,U,DT,DILOCKTM,DTIME,PSOIEN,ERXIEN,PSOSITE,PSOJUMP,PSNPINST)"
 K ^TMP("PSOERXPO",$J) M ^TMP("PSOERXPO",$J)=^TMP("XQORS",$J)
 S PSOJUMP=1
 D EN^VALM("PSO ERX SINGLE ERX DISPLAY")
 K ^TMP("XQORS",$J) M ^TMP("XQORS",$J)=^TMP("PSOERXPO",$J)
 S PSOJUMP=0
 Q
 ;
ORDNUM() ; Returns the correct IEN for the ORDER file (#100) for the Rx
 I $P(XQY0,"^")="PSO LM BACKDOOR ORDERS"!($P(XQY0,"^")="PSO LMOE FINISH"),$P(VALMKEY,"^",2)="PSO HIDDEN ACTIONS",$G(RXN) Q +$$GET1^DIQ(52,RXN,39.3,"I")
 I $P(XQY0,"^")="PSO LM BACKDOOR ORDERS"!($P(XQY0,"^")="PSO LMOE FINISH")!($P(XQY0,"^")="PSO PMP"),$P(VALMKEY,"^",2)="PSO HIDDEN ACTIONS #3"!($P(VALMKEY,"^",2)="PSO HIDDEN ACTIONS #4"),$G(ORD) Q +$$GET1^DIQ(52.41,+ORD,.01)
 I $P(XQY0,"^")="PSO VIEW"!($P(XQY0,"^")="PSO PMP"),$P(VALMKEY,"^",2)="PSO PMP HIDDEN ACTIONS MENU #2",$G(RXN) Q +$$GET1^DIQ(52,RXN,39.3,"I")
 Q 0
 ;
UNACCBEF(ERXIEN) ; Determines if the eRx has been Un-Accepted Before
 ; Input: (r)ERXIEN - Pointer to ERX HOLDING QUEUE (#52.49)
 ;Output: 1 - eRx has been Un-Accepted Before | 0 - Exclude the eRx
 N UNACCBEF,STSHST
 S UNACCBEF=0
 S STSHST=9999 F  S STSHST=$O(^PS(52.49,ERXIEN,19,STSHST),-1) Q:'STSHST  D  I UNACCBEF Q
 . S UNACCBEF=+$$GET1^DIQ(52.4919,STSHST_","_ERXIEN,.04,"I")
 Q UNACCBEF
