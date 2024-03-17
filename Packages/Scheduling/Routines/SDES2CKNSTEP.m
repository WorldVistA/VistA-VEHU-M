SDES2CKNSTEP ;ALB/ANU - VISTA SCHEDULING RPCS ;DEC 18, 2023
 ;;5.3;Scheduling;**869**;Aug 13, 1993;Build 13
 ;;Per VHA Directive 6402, this routine should not be modified;
 Q
 ; INPUT
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDINPUT("STATUS") = (Required) STATUS, Status to be set in Check-in step status (#409.842) file.
 ;
SETCKNSTEP(JSON,SDCONTEXT,SDINPUT) ;create new status entry in check-in step status file
 N ERRORS,SDRETURN,PARAMETERS,FDA,SDCHECKIN,IEN,ENTRY,SDUSER
 ;
 ; Validate SDCONTEXT
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("CheckInSteps",1)="" D BUILDJSON^SDES2JSON(.JSON,.ERRORS) Q
 ; Validate PARAMS
 S PARAMETERS=$$VALPARAMS(.SDINPUT,.ERRORS)
 I $D(ERRORS) S ERRORS("CheckInSteps",1)="" D BUILDJSON^SDES2JSON(.JSON,.ERRORS) Q
 ;
 S SDUSER=$S(+$G(SDCONTEXT("USER DUZ")):+SDCONTEXT("USER DUZ"),1:$G(DUZ))
 S STATUS=$P(PARAMETERS,"^")
 D SETCKN(.SDRETURN,STATUS,SDUSER,SDCONTEXT("ACHERON AUDIT ID"))
 I '$D(SDRETURN) S SDRETURN("CheckInSteps",1)=""
 D BUILDJSON^SDES2JSON(.JSON,.SDRETURN)
 Q
 ;
VALPARAMS(PARAMS,SDERRORS) ; Validate
 N STATUS,SDIEN,SDENTRY
 ;
 ; Validate Status
 S STATUS=$G(PARAMS("STATUS"))
 I $G(STATUS)="" D ERRLOG^SDESJSON(.SDERRORS,38) Q 0
 I $L(STATUS)<3!($L(STATUS)>30) D ERRLOG^SDESJSON(.SDERRORS,39) Q 0
 I STATUS'?.E1A.E!(STATUS?1P.E) D ERRLOG^SDESJSON(.SDERRORS,41) Q 0
 ;
 S SDIEN=0,SDENTRY=""
 F  S SDIEN=$O(^SDEC(409.842,SDIEN)) Q:'SDIEN!(STATUS=SDENTRY)  D
 .S SDENTRY=$$GET1^DIQ(409.842,SDIEN,.01,"E")
 I STATUS=SDENTRY D ERRLOG^SDESJSON(.SDERRORS,32) Q 0 ; duplicate status entry, will not file
 Q:$D(SDERRORS) 0
 Q STATUS
 ;
SETCKN(SDRETURN,STATUS,SDUSER,AUDITID) ;create new status entry in check-in step status file
 N FDA,SDCHECKIN,ERR
 S FDA(409.842,"+1,",.01)=STATUS
 D UPDATE^DIE(,"FDA",,"ERR") K FDA,ERR
 I '$D(ERR) S SDRETURN("CheckInSteps","FilingSuccess")=1
 I $D(ERR) D ERRLOG^SDESJSON(.SDRETURN,34)
 Q
 ;
