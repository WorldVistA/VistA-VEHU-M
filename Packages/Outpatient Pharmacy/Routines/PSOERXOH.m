PSOERXOH ;ALB/BWF - eRx parsing Utilities ; 11/14/2019 3:46pm
 ;;7.0;OUTPATIENT PHARMACY;**581**;DEC 1997;Build 126
 ;
 Q
ODIAG(GL,CNT,ERXIEN,MIEN) ; outbound diagnosis segment (52.493113)
 N F,DIAGIEN,DIAGDAT,DIAGIENS,CIQ,PDXCODE,PDXQUAL,PDXOV
 N PDXDESC,PDCOV,SDXCODE,SDXQUAL,SDXDESC,SDXOV
 S F=52.493113
 I '$O(^PS(52.49,ERXIEN,311,MIEN,3,0)) Q
 S DIAGIEN=0 F  S DIAGIEN=$O(^PS(52.49,ERXIEN,311,MIEN,3,DIAGIEN)) Q:'DIAGIEN  D
 .K DIAGDAT
 .S DIAGIENS=DIAGIEN_","_MIEN_","_ERXIEN_","
 .D GETS^DIQ(F,DIAGIENS,"**","IE","DIAGDAT")
 .S CIQ=$G(DIAGDAT(F,DIAGIENS,.02,"I")),PDXCODE=$G(DIAGDAT(F,DIAGIENS,1.1,"E")),PDXQUAL=$G(DIAGDAT(F,DIAGIENS,1.2,"I"))
 .S PDXOV=$G(DIAGDAT(F,DIAGIENS,1.3,"I")),PDXDESC=$G(DIAGDAT(F,DIAGIENS,2,"E")),SDXCODE=$G(DIAGDAT(F,DIAGIENS,3.1,"E"))
 .S SDXQUAL=$G(DIAGDAT(F,DIAGIENS,3.2,"I")),SDXOV=$G(DIAGDAT(F,DIAGIENS,3.3,"I")),SDXDESC=$G(DIAGDAT(F,DIAGIENS,4,"E"))
 .I $G(PDXOV) S PDXOV=$P($$EXTIME^PSOERXO1(PDXOV),"T")
 .I $G(SDXOV) S SDXOV=$P($$EXTIME^PSOERXO1(SDXOV),"T")
 .D C S @GBL@(CNT,0)="<Diagnosis>"
 .D BL(GBL,.CNT,"ClinicalInformationQualifier",CIQ)
 .I $L(PDXCODE_PDXQUAL_PDXDESC_PDXOV) D
 ..D C S @GBL@(CNT,0)="<Primary>"
 ..D BL(GBL,.CNT,"Code",PDXCODE)
 ..D BL(GBL,.CNT,"Qualifier",PDXQUAL)
 ..D BL(GBL,.CNT,"Description",PDXDESC)
 .I $L(PDXOV) D
 ..D C S @GBL@(CNT,0)="<DateOfLastOfficeVisit>"
 ..D BL(GBL,.CNT,"Date",PDXOV)
 ..D C S @GBL@(CNT,0)="</DateOfLastOfficeVisit>"
 .I $L(PDXCODE_PDXQUAL_PDXDESC_PDXOV) D
 ..D C S @GBL@(CNT,0)="</Primary>"
 .I $L(SDXCODE_SDXQUAL_SDXDESC_SDXOV) D
 ..D C S @GBL@(CNT,0)="<Secondary>"
 ..D BL(GBL,.CNT,"Code",SDXCODE)
 ..D BL(GBL,.CNT,"Qualifier",SDXQUAL)
 ..D BL(GBL,.CNT,"Description",SDXDESC)
 .I $L(SDXOV) D
 ..D C S @GBL@(CNT,0)="<DateOfLastOfficeVisit>"
 ..D BL(GBL,.CNT,"Date",SDXOV) ; need to write function to convert this date
 ..D C S @GBL@(CNT,0)="</DateOfLastOfficeVisit>"
 .I $L(SDXCODE_SDXQUAL_SDXDESC_SDXOV) D
 ..D C S @GBL@(CNT,0)="</Secondary>"
 .D C S @GBL@(CNT,0)="</Diagnosis>"
 Q
ODUE(GL,CNT,ERXIEN,MIEN) ;outbound drug use evaluation segment
 N F,DUEIEN,DUEDAT,DUEIENS,SERVREA,PROFSERV,SVXRC
 N CAC,CAQ,COAGDESC,CLINCODE,ACKREA
 S F=52.493116
 I '$O(^PS(52.49,ERXIEN,311,MIEN,6,0)) Q
 S DUEIEN=0 F  S DUEIEN=$O(^PS(52.49,ERXIEN,311,MIEN,6,DUEIEN)) Q:'DUEIEN  D
 .K DUEDAT
 .S DUEIENS=DUEIEN_","_MIEN_","_ERXIEN_","
 .D GETS^DIQ(F,DUEIENS,"**","IE","DUEDAT")
 .S SERVREA=$G(DUEDAT(F,DUEIENS,.02,"E")),PROFSERV=$G(DUEDAT(F,DUEIENS,.03,"E"))
 .S SVXRC=$G(DUEDAT(F,DUEIENS,.04,"E")),CAC=$G(DUEDAT(F,DUEIENS,.05,"E"))
 .S CAQ=$G(DUEDAT(F,DUEIENS,.06,"E")),CLINCODE=$G(DUEDAT(F,DUEIENS,.07,"I"))
 .S COAGDESC=$G(DUEDAT(F,DUEIENS,1,"E")),ACKREA=$G(DUEDAT(F,DUEIENS,2,"E"))
 .D C S @GBL@(CNT,0)="<DrugUseEvaluation>"
 .D BL(GBL,.CNT,"ServiceReasonCode",SERVREA)
 .D BL(GBL,.CNT,"ProfessionalServiceCode",PROFSERV)
 .D BL(GBL,.CNT,"ServiceResultCode",SVXRC)
 .I $L(CAC_CAQ_COAGDESC) D
 ..D C S @GBL@(CNT,0)="<CoAgent>"
 ..D C S @GBL@(CNT,0)="<CoAgentCode>"
 ..D BL(GBL,.CNT,"Code",CAC)
 ..D BL(GBL,.CNT,"Qualifier",CAQ)
 ..D BL(GBL,.CNT,"Description",COAGDESC)
 ..D C S @GBL@(CNT,0)="</CoAgentCode>"
 ..D C S @GBL@(CNT,0)="</CoAgent>"
 .D BL(GBL,.CNT,"ClinicalSignificanceCode",CLINCODE)
 .D BL(GBL,.CNT,"AcknowledgementReason",ACKREA)
 .D C S @GBL@(CNT,0)="</DrugUseEvaluation>"
 Q
ODCS(GL,CNT,ERXIEN,MIEN) ;outbound drug coverage status segment
 N F,DCSIEN,DCSDAT,DCSIENS,DCSTCODE
 S F=52.493117
 S DCSIEN=0 F  S DCSIEN=$O(^PS(52.49,ERXIEN,311,MIEN,7,DCSIEN)) Q:'DCSIEN  D
 .K DCSDAT
 .S DCSIENS=DCSIEN_","_MIEN_","_ERXIEN_","
 .D GETS^DIQ(F,DCSIENS,"**","E","DCSDAT")
 .S DCSTCODE=$G(DCSDAT(F,DCSIENS,.02,"E"))
 .D BL(GBL,.CNT,"DrugCoverageStatusCode",DCSTCODE)
 Q
BL(GBL,CNT,TAG,VAR) ;
 Q:VAR=""
 D C S @GBL@(CNT,0)="<"_TAG_">"_$$SYMENC^MXMLUTL(VAR)_"</"_TAG_">"
 Q
C ;
 S CNT=$G(CNT)+1
 Q
