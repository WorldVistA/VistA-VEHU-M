SDES2STOREPAT  ;ALB/TJB - SDES2 STORE LAST SELECTED PAT; Oct 20, 2023@09:00
 ;;5.3;Scheduling;**864**;Aug 13, 1993;Build 15
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ;INPUT - 
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;
 ; SDPARAM("DFN")=DFN     Patient IEN to be stored for the space bar recall (required)
 ;
 ;RETURN PARMETER:
 ; Status
 Q
 ;
STORE(JSON,SDCONTEXT,SDPARAM) ;
 N ERRORS,RETURN,VALRETURN,SDDUZ
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("PatientRecordCreated",1)="" D BUILDJSON^SDES2JSON(.JSON,.ERRORS) Q
 D VALPATDFN^SDES2VAL2(.ERRORS,$G(SDPARAM("DFN")),1,0)
 I $D(ERRORS) S ERRORS("PatientRecordCreated",1)="" D BUILDJSON^SDES2JSON(.JSON,.ERRORS) Q
 ;
 S SDDUZ=$S($G(SDCONTEXT("USER DUZ"))'="":$G(SDCONTEXT("USER DUZ")),1:DUZ)
 D RECALL^DILFD(2,SDPARAM("DFN")_",",SDDUZ)
 S RETURN("PatientRecordCreated",1)=1
 D BUILDJSON^SDES2JSON(.JSON,.RETURN)
 Q
 ;
