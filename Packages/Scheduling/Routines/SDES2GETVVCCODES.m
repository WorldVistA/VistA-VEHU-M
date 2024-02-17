SDES2GETVVCCODES ;ALB/JAS - SDES2 GET VVC STOP CODES ;NOV 15, 2023
 ;;5.3;Scheduling;**864**;Aug 13, 1993;Build 15
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
 ; RPC: SDES2 GET VVC STOP CODES
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = 36 character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("USER DUZ")         = The DUZ of the user taking action on the calling application.
 ; SDCONTEXT("USER SECID")       = The Security ID of the user taking action on the calling application.
 ; SDCONTEXT("PATIENT DFN")      = The DFN of the Veteran/user taking action on the calling application.
 ; SDCONTEXT("PATIENT ICN")      = The ICN of the Veteran/user taking action on the calling application.
 ;
 ; PARAMS("") = No input parameters for this RPC
 ;
GETVVCCODES(JSONRETURN,SDCONTEXT) ; Get VVC Stop Codes
 ;
 N SDERRORS,SDRETURN,VALCHK
 ;
 ; Validate SDCONTEXT
 ;
 S VALCHK=$$VALCONTXT(.SDCONTEXT,.SDERRORS)
 I 'VALCHK M SDRETURN=SDERRORS S SDRETURN("VVCStopCode",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 ;
 ; Get National VVC Stop Codes entries from ^SDEC(409.98 - SDEC SETTINGS FILE
 ;
 D GETDATA(.SDRETURN)
 ;
 I '$D(SDRETURN) S SDRETURN("VVCStopCode",1)="" ;
 ;
 ; Build JSON return
 ;
 D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN)
 Q
 ;
VALCONTXT(SDCONTEXT,SDERRORS) ; Validate SDCONTEXT array
 D VALCONTEXT^SDES2VALCONTEXT(.SDERRORS,.SDCONTEXT)
 I $D(SDERRORS) Q 0
 Q 1
 ;
GETDATA(SDRETURN) ; Get Stop Codes and format return
 N AMISSTOPCD,CLINSTPNAME,CLINSTPIEN,SDCOUNT,SDSETIEN
 S SDCOUNT=0
 ;
 ; Get National VVC Stop Codes entries from ^SDEC(409.98) - SDEC SETTINGS FILE
 S SDSETIEN=$O(^SDEC(409.98,"B","VS GUI NATIONAL",0)) Q:'SDSETIEN
 S AMISSTOPCD=0
 F  S AMISSTOPCD=$O(^SDEC(409.98,SDSETIEN,3,"B",AMISSTOPCD)) Q:'AMISSTOPCD  D
 . ;
 . ; Get Clinic Stop data from ^DIC(40.7)
 . S CLINSTPIEN=$$AMISTOSTOPCODE^SDES2UTIL(AMISSTOPCD) Q:'CLINSTPIEN
 . S CLINSTPNAME=$$GET1^DIQ(40.7,CLINSTPIEN,.01,"I")
 . S SDCOUNT=SDCOUNT+1
 . ;
 . ; Format Return
 . S SDRETURN("VVCStopCode",SDCOUNT,"StopCodeIEN")=CLINSTPIEN
 . S SDRETURN("VVCStopCode",SDCOUNT,"StopCodeName")=CLINSTPNAME
 . S SDRETURN("VVCStopCode",SDCOUNT,"StopCodeNumber")=AMISSTOPCD
 Q
