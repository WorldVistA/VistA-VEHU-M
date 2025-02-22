SDES2GETPATSTAT ;ALB/BLB - SDES2 GET PATIENT CLINIC STATUS Jan 08, 2024
 ;;5.3;Scheduling;**869**;Aug 13, 1993;Build 13
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
GETPATIENTSTATUS(JSON,SDCONTEXT,PATIENT) ;
 N STATUS,ERRORS,DFN,CLINICIEN,STOPCODE
 ;
 D POPULATE(.PATIENT,.DFN,.CLINICIEN,.STOPCODE)
 D VALIDATE(.ERRORS,.SDCONTEXT,.DFN,.CLINICIEN)
 I $D(ERRORS) S ERRORS("PatientClinicstatus",1)="" D BUILDJSON^SDES2JSON(.JSON,.ERRORS) Q
 ;
 S STATUS("PatientClinicStatus","Status")=$$GETSTATUS(DFN,CLINICIEN,STOPCODE)
 ;
 D BUILDJSON^SDES2JSON(.JSON,.STATUS)
 Q
 ;
GETSTATUS(DFN,CLINICIEN,STOPCODE) ;
 N APPTIEN,APPTDATETIME,FOUND,PATIENTSTATUS,BEGINDATE,ENDDATE
 ;
 S PATIENTSTATUS="NEW"
 S BEGINDATE=$P($$FMADD^XLFDT($$NOW^XLFDT,-1095),".",1)
 S ENDDATE=$P($$NOW^XLFDT,".")
 ;
 S APPTDATETIME=$$GETSUB^SDES2UTIL(BEGINDATE),FOUND=0
 F  S APPTDATETIME=$O(^SDEC(409.84,"APTDT",DFN,APPTDATETIME)) Q:'APPTDATETIME!(PATIENTSTATUS="ESTABLISHED")!($P(APPTDATETIME,".")>ENDDATE)  D
 .S APPTIEN=0
 .F  S APPTIEN=$O(^SDEC(409.84,"APTDT",DFN,APPTDATETIME,APPTIEN)) Q:'APPTIEN  D
 ..I $$GET1^DIQ(44,$$GET1^DIQ(409.831,$$GET1^DIQ(409.84,APPTIEN,.07,"I"),.04,"I"),8,"I")=STOPCODE D
 ...I $P(APPTDATETIME,".")>=BEGINDATE,$P(APPTDATETIME,".")<=ENDDATE,$$GET1^DIQ(409.84,APPTIEN,.14,"I") D
 ....S PATIENTSTATUS="ESTABLISHED"
 ;
 Q PATIENTSTATUS
 ;
VALIDATE(ERRORS,SDCONTEXT,DFN,CLINICIEN) ;
 N VAL
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) Q
 ;
 D VALFILEIEN^SDES2VALUTIL(.VAL,.ERRORS,44,CLINICIEN,1,,18,19)
 D VALFILEIEN^SDES2VALUTIL(.VAL,.ERRORS,2,DFN,1,,1,2)
 I $D(ERRORS) Q
 ;
 I '$$GET1^DIQ(44,CLINICIEN,8,"I") D ERRLOG^SDESJSON(.ERRORS,"This clinic does not have a defined stop code number")
 Q
 ;
POPULATE(PATIENT,DFN,CLINICIEN,STOPCODE) ;
 S DFN=$G(PATIENT("DFN"))
 S CLINICIEN=$G(PATIENT("CLINIC IEN"))
 S STOPCODE=$$GET1^DIQ(44,CLINICIEN,8,"I")
 Q
 ;
