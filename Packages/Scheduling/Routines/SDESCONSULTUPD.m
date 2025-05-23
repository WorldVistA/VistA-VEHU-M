SDESCONSULTUPD ;ALB/BWF - VISTA SCHEDULING RECALL REQUEST/CONSULT RPCS ; Dec 29, 2022
 ;;5.3;Scheduling;**835**;Aug 13, 1993;Build 4
 ;;Per VHA Directive 6402, this routine should not be modified
 ; Reference to REQUEST/CONSULTATION in ICR #4837
 ; Reference to REQUEST ACTION TYPES in ICR #6186
 ;
 Q
 ;RE-WRITE OF REQSET^SDEC07A
REQSET(SDRIEN,SDPROV,SDUSR,SDACT,SDECTYP,SDECNOTE,APPTDTTM,SDECRES) ;add SCHEDULED activity to REQUEST/CONSULTATION file
 ;INPUT:
 ; SDRIEN  - (required) pointer to REQUEST/CONSULTATION file 123
 ; SDPROV  - (required) Provider pointer to NEW PERSON
 ; SDUSR   - (optional) User that entered appointment pointer to NEW PERSON
 ; SDACT   - (required) ACTIVITY type to add  1=SCHEDULED  2=STATUS CHANGE
 ; SDECTYP - (required if SDACT=2) appointment Status valid values:
 ;                          C=CANCELLED BY CLINIC
 ;                         PC=CANCELLED BY PATIENT
 ; SDECNOTE - Comments from Appointment
 ; APPTDTTM - Appointment time in fileman format
 ; SDECRES  - Appointment Resource
 ;
 N DISCONTINUED,SDSCHED,SDSTAT,Y,COMPLETE,CPRSSTAT,%DT,TMPYCLNC,SDPL,DFN,CLINICIEN,SDTTM
 S SDACT=$G(SDACT)
 S APPTDTTM=$G(APPTDTTM)
 S SDECRES=$G(SDECRES)
 Q:"12"'[SDACT
 S SDSCHED=$$GETIEN("SCHEDULED")
 S SDSTAT=$$GETIEN("STATUS CHANGE")
 S DISCONTINUED=$O(^ORD(100.01,"B","DISCONTINUED",0))
 S COMPLETE=$O(^ORD(100.01,"B","COMPLETE",0))
 I SDACT=1,SDSCHED="" Q
 I SDACT=2,SDSTAT="" Q
 S CPRSSTAT=$$GET1^DIQ(123,SDRIEN_",",8,"I")
 Q:CPRSSTAT=DISCONTINUED!(CPRSSTAT=COMPLETE)
 S SDECNOTE=$G(SDECNOTE)
 ;
 S DFN=$$GET1^DIQ(123,SDRIEN,.02,"I")
 I SDACT=1 D
 .S TMPYCLNC=$$GET1^DIQ(409.831,+SDECRES,.04,"I")
 .I TMPYCLNC'="" S TMPYCLNC=TMPYCLNC_U_$$GET1^DIQ(44,TMPYCLNC,.01,"I")
 .D EDITCS^SDCNSLT(APPTDTTM,SDECNOTE,TMPYCLNC,SDRIEN)
 ;
 I SDACT=2 D
 .S CLINICIEN=$$GET1^DIQ(409.831,+SDECRES,.04,"I")
 .S SDPL=0 F  S SDPL=$O(^SC(CLINICIEN,"S",APPTDTTM,1,SDPL)) Q:'SDPL  Q:$$GET1^DIQ(44.003,SDPL_","_APPTDTTM_","_CLINICIEN)=DFN
 .D SDECCAN^SDCNSLT(SDRIEN,DFN,APPTDTTM,CLINICIEN,SDECTYP,SDPL,SDECNOTE) ; send comments to consult
 Q
GETIEN(NAME) ;get ID from REQUEST ACTION TYPES file 123.1
 N DIC,X,Y
 S DIC=123.1
 S DIC(0)="BO"
 S X=NAME
 D ^DIC
 I Y=-1 Q ""
 Q $P(Y,U,1)
