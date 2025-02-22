SDESCHECKIN ;ALB/LAB - SDES VISTA SCHEDULING RPCS CHECK IN APPOINTMENT ;Sep 14,2022@16:15
 ;;5.3;Scheduling;**827**;Aug 13, 1993;Build 10
 ;
 Q
 ;
CHECKIN(SDRETURN,SDAPPTIEN,SDCHECKINDTTIM,SDPROVIDER) ;Check in appointment
 ;
 N BSDVSTN,EMSG,ERRORS,RETURN
 N SDECNOD,DFN,SDECSTART,DIK,DA,SDECID,SDECI,SDECIENS,SDECVEN
 N SDECNOEV,SDECCAN,SDRESOURCE,%DT,X,Y
 S SDECNOEV=1 ;Don't execute protocol
 ;
 D VALIDATEAPPT(.ERRORS,.SDAPPTIEN)
 D:'$D(ERRORS) ASSIGNCLININFO(SDAPPTIEN,.SDCLINICIEN,.SDCLINSTOP) ;need clinic ien for checkin time conversion
 D:'$D(ERRORS) VALIDATECHKINDT(.ERRORS,.SDCHECKINDTTIM,SDAPPTIEN,SDCLINICIEN)
 D VALIDATEPROV(.ERRORS,.SDPROVIDER)
 I $D(ERRORS) M RETURN=ERRORS
 I '$D(ERRORS) D
 . D PROCESSCHECKIN(SDAPPTIEN,SDPROVIDER,.ERRORS)
 I '$D(ERRORS) D
 . S RETURN("Checkin")="Checked in"
 D BUILDJSON^SDESBUILDJSON(.SDRETURN,.RETURN)
 Q
 ;
VALIDATEAPPT(ERRORS,SDAPPTIEN) ;validate SDEC appointment ID
 ;invalid appointment ID is error 15
 I '$G(SDAPPTIEN) D ERRLOG^SDESJSON(.ERRORS,14) Q
 I '$D(^SDEC(409.84,SDAPPTIEN,0)) D ERRLOG^SDESJSON(.ERRORS,15)
 Q
 ;
VALIDATECHKINDT(ERRORS,SDCHECKINDTTIM,SDAPPTIEN,SDCLINICIEN) ;validate checkin date/time (required)
 ; need to change to accept ISO 8601 date/time
 S SDCHECKINDTTIM=$G(SDCHECKINDTTIM)
 I SDCHECKINDTTIM="" D ERRLOG^SDESJSON(.ERRORS,21) Q
 S SDCHECKINDTTIM=$$ISOTFM^SDAMUTDT(SDCHECKINDTTIM,SDCLINICIEN)
 I SDCHECKINDTTIM=-1 D ERRLOG^SDESJSON(.ERRORS,22)
 Q
 ;
ASSIGNCLININFO(SDAPPTIEN,SDCLINICIEN,SDCLINSTOP) ;
 S SDCLINICIEN=$$GET1^DIQ(409.831,$$GET1^DIQ(409.84,SDAPPTIEN,.07,"I"),.04,"I")
 S SDCLINSTOP=$$GET1^DIQ(44,SDCLINICIEN,8,"I")
 Q
 ;
VALIDATEPROV(ERRORS,SDPROVIDER) ;validate provider (optional)
 S SDPROVIDER=$G(SDPROVIDER)
 I SDPROVIDER'="" I '$D(^VA(200,+SDPROVIDER,0)) D ERRLOG^SDESJSON(.ERRORS,54)
 Q
 ;
PROCESSCHECKIN(SDAPPTIEN,SDPROVIDER,ERRORS) ;
 N DFN,SDECSTART,SDRESOURCE
 S DFN=$$GET1^DIQ(409.84,SDAPPTIEN,.05,"I") ; must use variable name DFN as it is needed to be defined for event logic.
 S SDECSTART=$$GET1^DIQ(409.84,SDAPPTIEN,.01,"I")
 S SDRESOURCE=$$GET1^DIQ(409.84,SDAPPTIEN,.07,"I")
 I SDRESOURCE]"",$D(^SDEC(409.831,SDRESOURCE,0)) D
 . S SDRESCLIN=$$GET1^DIQ(409.831,SDRESOURCE,.04,"I")
 . ;Hospital Location is required for CHECKIN
 . I 'SDRESCLIN]"",'$D(^SC(+SDRESCLIN,0)) D ERRLOG^SDESJSON(.ERRORS,342) Q
 . ;
 . ;  Event driver "BEFORE" actions
 . ;
 . N SDATA,SDDA,SDCIHDL ;
 . S SDDA=$$FIND(DFN,SDECSTART,SDRESCLIN)
 . S SDATA=SDDA_U_DFN_U_SDECSTART_U_SDRESCLIN,SDCIHDL=$$HANDLE^SDAMEVT(1) ;
 . D BEFORE^SDAMEVT(.SDATA,DFN,SDECSTART,SDRESCLIN,SDDA,SDCIHDL) ;
 . ;
 . ;  Checkin SDEC APPOINTMENT entry
 . ;
 . D SDECCHK(SDAPPTIEN,SDCHECKINDTTIM,SDPROVIDER) ; sets field .03 (Checkin), in file 409.84
 . D APCHK(SDRESCLIN,DFN,SDCHECKINDTTIM,SDECSTART)
 . ;
 . ;  Event driver "AFTER" actions
 . ;
 . D AFTER^SDAMEVT(.SDATA,DFN,SDECSTART,SDRESCLIN,SDDA,SDCIHDL) ;
 . ;
 . ;  Execute event driver.  4=check in (see #409.66), 2=non-interactive
 . ;
 . D EVT^SDAMEVT(.SDATA,4,2,SDCIHDL)
 . I $D(ERRORS) M RETURN=ERRORS
 ;
 Q
 ;
SDECCHK(SDAPPTIEN,SDCHECKINDTTIM,SDPROVIDER) ;
 N SDECFDA,SDECMSG
 S SDECIENS=SDAPPTIEN_","
 S SDECFDA(409.84,SDECIENS,.03)=SDCHECKINDTTIM
 S SDECFDA(409.84,SDECIENS,.04)=$S(SDCHECKINDTTIM'="":$$NOW^XLFDT,1:"")
 S:$G(SDPROVIDER) SDECFDA(409.84,SDECIENS,.16)=SDPROVIDER
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
APCHK(SDRESCLIN,DFN,SDCHECKINDTTIM,SDECSTART)         ;
 ;Checkin appointment for patient DFN in clinic SDRESCLIN
 ;at time SDECSD
 N BSDMSG,SDECC
 S SDECC("PAT")=DFN
 S SDECC("HOS LOC")=SDRESCLIN
 S SDECC("CLINIC CODE")=SDCLINSTOP
 S SDECC("PROVIDER")=SDPROVIDER
 S SDECC("APPT DATE")=SDECSTART
 S SDECC("CDT")=SDCHECKINDTTIM
 S SDECC("USR")=DUZ
 ;Required by NEW API:
 S SDECC("SRV CAT")="A"
 S SDECC("TIME RANGE")=-1
 S SDECC("VISIT DATE")=SDCHECKINDTTIM
 S SDECC("SITE")=$G(DUZ(2))
 S SDECC("VISIT TYPE")="V"
 S SDECC("CLN")=SDECC("HOS LOC")
 S SDECC("ADT")=SDECC("APPT DATE")
 ;
 N SDECOUT
 D GETVISIT^SDECAPI4(.SDECC,.SDECOUT)
 Q
 ;
VALID(DFN,CLINICIEN,APPTDTTM,SDDA) ; -- return valid appt. 1 for valid appt., 0 for not valid
 Q:($$GET1^DIQ(44.003,SDDA_","_APPTDTTM_","_CLINICIEN_",",310,"I")'="C") 1
 Q:($$GET1^DIQ(2.98,APPTDTTM_","_DFN_",",3,"I")["C") 1
 Q 0
 ;
BUILDERROR(RESULT,JSONRETURN) ;
 NEW RETURNERROR
 M RETURNERROR=RESULT
 D BUILDJSON^SDESBUILDJSON(.JSONRETURN,.RETURNERROR)
 Q
 ;
