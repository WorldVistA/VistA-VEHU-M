SDES2CHECKIN ;ALB/LAB,TJB,JAS - SDES VISTA SCHEDULING SDES2 CHECKIN ;May 1,2024@10:00
 ;;5.3;Scheduling;**866,878**;Aug 13, 1993;Build 11
 ;;Per VHA Directive 6402, this routine should not be modified
 Q
 ; Copied from SDESCHECKIN to be in SDES2 namespace
 ; CHECKIN(SDRETURN,SDAPPTIEN,SDCHECKINDTTIM,SDPROVIDER) ;Check in appointment
CHECKIN(SDRETURN,SDCONTEXT,SDPARAM) ;Check in appointment
 ;INPUT - 
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;
 ; SDPARAM("APPOINTMENT IEN")=IEN       The appointment IEN from the SDES APPOINTMENT (#409.84) file. (required)
 ; SDPARAM("CHECKIN DATE TIME")=DATE    ISO DATE and TIME to check-in the patient (required)
 ; SDPARAM("PROVIDER")=IEN              IEN of the PROVIDER in file NEW PERSON (#200)
 ;
 ;RETURN PARMETER:
 ; {
 ;  "Checkin":[
 ;   "Checked In."
 ;   ]
 ; }
 ;
 N BSDVSTN,EMSG,ERRORS,RETURN
 N SDECNOD,DFN,SDECSTART,DIK,DA,SDECID,SDECI,SDECIENS,SDECVEN,SDCLINICIEN
 N SDECNOEV,SDECCAN,SDRESOURCE,%DT,X,Y
 S SDECNOEV=1 ;Don't execute protocol
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("Checkin",1)="" D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 D VALIDATEAPPT(.ERRORS,$G(SDPARAM("APPOINTMENT IEN")))
 D:'$D(ERRORS) ASSIGNCLININFO($G(SDPARAM("APPOINTMENT IEN")),.SDCLINICIEN,.SDCLINSTOP) ;need clinic ien for checkin time conversion
 S SDPARAM("CHECKIN DATE TIME")=$G(SDPARAM("CHECKIN DATE TIME"))
 I '$D(ERRORS) S SDPARAM("CHECKIN DATE TIME")=$$VALIDATECHKINDT(.ERRORS,SDPARAM("CHECKIN DATE TIME"),SDCLINICIEN)
 D VALPROVIDER^SDES2VAL200(.ERRORS,$G(SDPARAM("PROVIDER")))
 I $D(ERRORS) S ERRORS("Checkin",1)="" M RETURN=ERRORS
 I '$D(ERRORS) D
 . D PROCESSCHECKIN(SDPARAM("APPOINTMENT IEN"),$G(SDPARAM("PROVIDER")),SDCLINICIEN,$G(SDCONTEXT("USER DUZ")),SDCLINSTOP,SDPARAM("CHECKIN DATE TIME"),$G(SDCONTEXT("ACHERON AUDIT ID")),.ERRORS)
 I '$D(ERRORS) D
 . S RETURN("Checkin")="Checked in"
 D BUILDJSON^SDES2JSON(.SDRETURN,.RETURN)
 Q
 ;
VALIDATEAPPT(ERRORS,SDAPPTIEN) ;validate SDEC appointment ID
 ;invalid appointment ID is error 15
 N RET
 D VALFILEIEN^SDES2VALUTIL(.RET,.ERRORS,"409.84",SDAPPTIEN,1,,14,15)
 Q
 ;
VALIDATECHKINDT(ERRORS,SDCHECKINDTTIM,SDCLINICIEN) ;validate checkin date/time (required)
 ; need to change to accept ISO 8601 date/time
 S SDCHECKINDTTIM=$$VALISODTTM^SDES2VALISODTTM(.ERRORS,$G(SDCHECKINDTTIM),SDCLINICIEN,1,21,22)
 Q SDCHECKINDTTIM
 ;
ASSIGNCLININFO(SDAPPTIEN,CLINICIEN,CLINICSTOP) ;
 S CLINICIEN=$$GET1^DIQ(409.831,$$GET1^DIQ(409.84,SDAPPTIEN,.07,"I"),.04,"I")
 S CLINICSTOP=$$GET1^DIQ(44,CLINICIEN,8,"I")
 Q
 ;
PROCESSCHECKIN(SDAPPTIEN,SDPROVIDER,SDCLINICIEN,SDDUZ,SDCLINICSTOP,SDCHECKINDTTIM,SDACHAUDIT,ERRORS) ;
 N DFN,SDECSTART,SDRESOURCE
 S DFN=$$GET1^DIQ(409.84,SDAPPTIEN,.05,"I") ; must use variable name DFN as it is needed to be defined for event logic.
 S SDECSTART=$$GET1^DIQ(409.84,SDAPPTIEN,.01,"I")
 S SDRESOURCE=$$GET1^DIQ(409.84,SDAPPTIEN,.07,"I")
 ; Hospital Location is required for CHECKIN
 I 'SDCLINICIEN]"",'$D(^SC(+SDCLINICIEN,0)) D ERRLOG^SDES2JSON(.ERRORS,342) Q
 I SDRESOURCE]"",$D(^SDEC(409.831,SDRESOURCE,0)) D
 . ;
 . ;  Event driver "BEFORE" actions
 . N SDATA,SDDA,SDCIHDL ;
 . S SDDA=$$FIND(DFN,SDECSTART,SDCLINICIEN)
 . S SDATA=SDDA_U_DFN_U_SDECSTART_U_SDCLINICIEN,SDCIHDL=$$HANDLE^SDAMEVT(1) ;
 . D BEFORE^SDAMEVT(.SDATA,DFN,SDECSTART,SDCLINICIEN,SDDA,SDCIHDL) ;
 . ;
 . ;  Checkin SDEC APPOINTMENT entry
 . D SDECCHK(SDAPPTIEN,SDCHECKINDTTIM,SDPROVIDER,$G(SDACHAUDIT)) ; sets field .03 (Checkin), in file 409.84
 . D APCHK(SDCLINICIEN,DFN,SDCHECKINDTTIM,SDECSTART,SDDUZ,SDCLINICSTOP,SDPROVIDER)
 . ;
 . ;  Event driver "AFTER" actions
 . D AFTER^SDAMEVT(.SDATA,DFN,SDECSTART,SDCLINICIEN,SDDA,SDCIHDL) ;
 . ;
 . ;  Execute event driver.  4=check in (see #409.66), 2=non-interactive
 . ;
 . D EVT^SDAMEVT(.SDATA,4,2,SDCIHDL)
 . Q
 ;
 Q
 ;
SDECCHK(SDAPPTIEN,SDCHECKINDTTIM,SDPROVIDER,SDACHAUDIT) ;
 N SDECFDA,SDECMSG
 S SDECIENS=SDAPPTIEN_","
 S SDECFDA(409.84,SDECIENS,.03)=SDCHECKINDTTIM
 S SDECFDA(409.84,SDECIENS,.04)=$S(SDCHECKINDTTIM'="":$$NOW^XLFDT,1:"")
 S:$G(SDPROVIDER) SDECFDA(409.84,SDECIENS,.16)=SDPROVIDER
 S:$G(SDACHAUDIT)'="" SDECFDA(409.84,SDECIENS,100)=SDACHAUDIT
 D FILE^DIE("","SDECFDA","SDECMSG")
 Q
 ;
FIND(DFN,APPTDTTM,CLINICIEN) ; -- return appt ifn for pat
 ;   input:        DFN := ifn of pat.
 ;                 APPTDTTM := appt d/t
 ;                SDCL := ifn of clinic
 ;  output: [returned] := ifn if pat has appt on date/time
 ;
 N CLNAPPTIEN,FND,APPTIEN
 S CLNAPPTIEN=99999
 S APPTIEN=0
 S FND=0
 F  S CLNAPPTIEN=$O(^SC(CLINICIEN,"S",APPTDTTM,1,CLNAPPTIEN),-1) Q:('CLNAPPTIEN)!(FND)  D
 . I $D(^SC(CLINICIEN,"S",APPTDTTM,1,CLNAPPTIEN,0)) D
 . . I DFN=+^SC(CLINICIEN,"S",APPTDTTM,1,CLNAPPTIEN,0) D
 . . . I $D(^DPT(+DFN,"S",APPTDTTM,0)) D
 . . . . I $$VALID(DFN,CLINICIEN,APPTDTTM,CLNAPPTIEN) D
 . . . . . S FND=1
 . . . . . S APPTIEN=CLNAPPTIEN
 Q APPTIEN
 ;
APCHK(SDRESCLIN,DFN,SDCHECKINDTTIM,SDECSTART,SDDUZ,SDCLINSTOP,SDPROVIDER) ;
 ;Checkin appointment for patient DFN in clinic SDRESCLIN
 ;at time SDECSD
 N BSDMSG,SDECC
 S SDECC("PAT")=DFN
 S SDECC("HOS LOC")=SDRESCLIN
 S SDECC("CLINIC CODE")=SDCLINSTOP
 S SDECC("PROVIDER")=SDPROVIDER
 S SDECC("APPT DATE")=SDECSTART
 S SDECC("CDT")=SDCHECKINDTTIM
 S SDECC("USR")=$S(SDDUZ'="":SDDUZ,1:DUZ) ; DUZ
 ;Required by NEW API:
 S SDECC("SRV CAT")="A"
 S SDECC("TIME RANGE")=-1
 S SDECC("VISIT DATE")=SDCHECKINDTTIM
 S SDECC("SITE")=$$GETSITECODE(SDRESCLIN)
 S SDECC("VISIT TYPE")="V"
 S SDECC("CLN")=SDECC("HOS LOC")
 S SDECC("ADT")=SDECC("APPT DATE")
 ;
 N SDECOUT
 D GETVISIT^SDES2GETVISIT(.SDECOUT,.SDECC)
 Q
 ;
VALID(DFN,CLINICIEN,APPTDTTM,SDDA) ; -- return valid appt. 1 for valid appt., 0 for not valid
 Q:($$GET1^DIQ(44.003,SDDA_","_APPTDTTM_","_CLINICIEN_",",310,"I")'="C") 1
 Q:($$GET1^DIQ(2.98,APPTDTTM_","_DFN_",",3,"I")["C") 1
 Q 0
 ;
GETSITECODE(CLINICIEN) ; Get the SITE/INSTITUTION from the CLINIC IEN otherwise use DUZ(2)
 N SDDIV,CLINICSITECODE
 S SDDIV=$$GET1^DIQ(44,CLINICIEN_",",3.5,"I")
 S CLINICSITECODE=$$GET1^DIQ(40.8,SDDIV_",",.07,"I")
 Q $S(+CLINICSITECODE:CLINICSITECODE,1:DUZ(2))
 ;
BUILDERROR(RESULT,JSONRETURN) ;
 N RETURNERROR
 M RETURNERROR=RESULT
 D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.RETURNERROR)
 Q
 ;
