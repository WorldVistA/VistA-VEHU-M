SDESCANCHECKIN ;ALB/BWF - VISTA SCHEDULING RPCS ;SEP 22, 2022
 ;;5.3;Scheduling;**827**;Aug 13, 1993;Build 10
 ;
 Q
CANCHECKIN(RES,APPTIEN) ;
 N SDATA,SDDA,SDCIHDL,APPTIENS,DFN,SDESSTART,RESOURCE,CLINICIEN,SDESSTART,ERRORS,CANCKIN,APPTDAT
 S APPTIEN=$G(APPTIEN)
 D VALAPPTIEN^SDESVALUTIL(.ERRORS,APPTIEN)
 S APPTIENS=APPTIEN_","
 I $D(ERRORS) S ERRORS("CancelCheckIn",1)="" D BUILDJSON^SDESBUILDJSON(.RES,.ERRORS) Q
 D GETS^DIQ(409.84,APPTIEN,".01;.03;.05;.07;.12","I","APPTDAT","ERR")
 I $G(APPTDAT(409.84,APPTIENS,.12,"I"))]"" D  Q
 .S ERRORS("CancelCheckIn",1)=""
 .D ERRLOG^SDESJSON(.ERRORS,322)
 .D BUILDJSON^SDESBUILDJSON(.RES,.ERRORS)
 I '$G(APPTDAT(409.84,APPTIENS,.03,"I")) D ERRLOG^SDESJSON(.ERRORS,318)
 I $D(ERRORS) S ERRORS("CancelCheckIn",1)="" D BUILDJSON^SDESBUILDJSON(.RES,.ERRORS) Q
 S DFN=$G(APPTDAT(409.84,APPTIENS,.05,"I"))
 S SDESSTART=$G(APPTDAT(409.84,APPTIENS,.01,"I"))
 S RESOURCE=$G(APPTDAT(409.84,APPTIENS,.07,"I"))
 I 'RESOURCE D ERRLOG^SDESJSON(.ERRORS,282) S ERRORS("CancelCheckIn",1)="" D BUILDJSON^SDESBUILDJSON(.RES,.ERRORS) Q
 S CLINICIEN=$$GET1^DIQ(409.831,RESOURCE,.04,"I")
 I 'CLINICIEN D ERRLOG^SDESJSON(.ERRORS,283) S ERRORS("CancelCheckIn",1)="" D BUILDJSON^SDESBUILDJSON(.RES,.ERRORS) Q
 S DFN=$$GET1^DIQ(409.84,APPTIEN,.05,"I")
 S SDESSTART=$$GET1^DIQ(409.84,APPTIEN,.01,"I")
 S SDDA=$$FIND^SDESCHECKOUT(DFN,SDESSTART,CLINICIEN)
 S SDATA=SDDA_U_DFN_U_SDESSTART_U_CLINICIEN
 S SDCIHDL=$$HANDLE^SDAMEVT(1)
 D BEFORE^SDAMEVT(.SDATA,DFN,SDESSTART,CLINICIEN,SDDA,SDCIHDL) ;
 ;
 ;  Cancel check in - wtc SD*5.3*717 10/24/18
 ;
 D SDECCHK(APPTIEN) ; sets field .03 (Checkin), in file 409.84
 D CANCHKIN(DFN,CLINICIEN,SDESSTART) ;
 ;
 ;  Event driver "AFTER" actions - wtc SD*5.3*717 10/24/18
 ;
 D AFTER^SDAMEVT(.SDATA,DFN,SDESSTART,CLINICIEN,SDDA,SDCIHDL) ;
 ;
 ;  Execute event driver.  4=check in (see #409.66), 2=non-interactive - wtc SD*5.3*717 10/25/18
 ;
 ;*zeb+1 717 3/19/19 prevent extra cancel check-in when canceling a checked-in walkin
 ;I '((SDECCDT="@")&($G(SDECTYP)]"")) D EVT^SDAMEVT(.SDATA,4,2,SDCIHDL) ;assumes SDECTYP, which is defined if coming from APPDEL^SDEC08
 ; todo - this may not be needed at all.
 D EVT^SDAMEVT(.SDATA,4,2,SDCIHDL)
 S CANCKIN("CancelCheckIn",1)="Check-in Cancelled." D BUILDJSON^SDESBUILDJSON(.RES,.CANCKIN)
 ;
 Q
SDECCHK(SDECAPTID) ;
 N SDECFDA,SDECMSG,SDECIENS
 S SDECIENS=SDECAPTID_","
 S SDECFDA(409.84,SDECIENS,.03)="@"
 S SDECFDA(409.84,SDECIENS,.04)="@"
 D FILE^DIE("","SDECFDA","SDECMSG")
 Q
 ;
CANCHKIN(DFN,SDCL,SDT) ; Logic to cancel a checkin if the checkin date/time is passed in as '@'
 ; input:  DFN := ifn of patient
 ;        SDCL := clinic#
 ;         SDT := appt d/t
 ;
 N SDDA
 S SDDA=$$FIND^SDESCHECKOUT(DFN,SDT,SDCL)
 S FDA(44.003,SDDA_","_SDT_","_SDCL_",",309)="" D FILE^DIE(,"FDA","ERR")
 K FDA,ERR
 Q
