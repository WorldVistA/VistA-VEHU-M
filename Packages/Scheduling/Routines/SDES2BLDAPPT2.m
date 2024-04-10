SDES2BLDAPPT2 ;ALB/LAB - VISTA SCHEDULING BUILDING APPT OBJECT FROM PATIENT ;JAN 15, 2024
 ;;5.3;Scheduling;**871**;Aug 13, 1993;Build 13
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
GET2INFO(APPTOBJ,APPTIEN,SDDFN,RECCNT) ;
 S APPTOBJ("Appointment",RECCNT,"Patient","DFN")=SDDFN
 S APPTOBJ("Appointment",RECCNT,"Patient","ICN")=$$GETPATICN^SDESINPUTVALUTL(SDDFN)
 S APPTOBJ("Appointment",RECCNT,"Patient","SSN")=$$LAST4SSN^SDESINPUTVALUTL(SDDFN)
 S APPTOBJ("Appointment",RECCNT,"Patient","DateOfBirth")=$$FMTISO^SDAMUTDT($$GET1^DIQ(2,SDDFN_",",.03,"I"))
 S APPTOBJ("Appointment",RECCNT,"Patient","DateOfDeath")=$$FMTISO^SDAMUTDT($$GET1^DIQ(2,SDDFN_",",.351,"I"))
 S APPTOBJ("Appointment",RECCNT,"Patient","EligibilityIEN")=$$GET1^DIQ(2,SDDFN_",",.361,"I")
 S APPTOBJ("Appointment",RECCNT,"Patient","Name")=$$GET1^DIQ(2,SDDFN_",",.01,"E")
 S APPTOBJ("Appointment",RECCNT,"Patient","Street")=$$GET1^DIQ(2,SDDFN_",",.111,"E")
 Q
 ;
GET298INFO(APPTOBJ,APPTIEN,SDDFN,RECCNT,CLINIEN) ;
 N INCLUDEPAT,PATIENS,ARRAY298,ERR
 D CHECKSTATUS(.INCLUDEPAT,SDDFN,APPTIEN,APPTOBJ("Appointment",RECCNT,"StartTimeFM")) ;need to know whether to include PatientAppointment information
 S APPTOBJ("Appointment",RECCNT,"OverLaidAppointmentData")=$S(INCLUDEPAT=1:"NO",1:"YES")
 I INCLUDEPAT=0 D BLANK298(.APPTOBJ) Q
 S PATIENS=APPTOBJ("Appointment",RECCNT,"StartTimeFM")_","_SDDFN_","
 D GETS^DIQ(2.98,PATIENS,"**","IE","ARRAY298","ERR")
 S APPTOBJ("Appointment",RECCNT,"AppointmentTypeSubCategory")=$G(ARRAY298(2.98,PATIENS,24,"E"))
 S APPTOBJ("Appointment",RECCNT,"AutoRebookedApptDateTime")=$$FMTISO^SDAMUTDT($G(ARRAY298(2.98,PATIENS,12,"I")))
 S APPTOBJ("Appointment",RECCNT,"CancellationRemarks")=$G(ARRAY298(2.98,PATIENS,17,"E"))
 S APPTOBJ("Appointment",RECCNT,"CollateralVisit")=$G(ARRAY298(2.98,PATIENS,13,"E"))
 S APPTOBJ("Appointment",RECCNT,"EkgDateTime")=$$FMTISO^SDAMUTDT($G(ARRAY298(2.98,PATIENS,7,"I")),CLINIEN)
 S APPTOBJ("Appointment",RECCNT,"EncounterConversionStatus")=$G(ARRAY298(2.98,PATIENS,23.1,"E"))
 S APPTOBJ("Appointment",RECCNT,"EncounterFormsAsAddOns")=$G(ARRAY298(2.98,PATIENS,23,"E"))
 S APPTOBJ("Appointment",RECCNT,"EncounterFormsPrinted")=$G(ARRAY298(2.98,PATIENS,22,"E"))
 S APPTOBJ("Appointment",RECCNT,"FollowUpVisit")=$G(ARRAY298(2.98,PATIENS,28,"E"))
 S APPTOBJ("Appointment",RECCNT,"LabDateTime")=$$FMTISO^SDAMUTDT($G(ARRAY298(2.98,PATIENS,5,"I")),CLINIEN)
 S APPTOBJ("Appointment",RECCNT,"NextAvaApptIndicator")=$G(ARRAY298(2.98,PATIENS,26,"E"))
 S APPTOBJ("Appointment",RECCNT,"NoShowCancelDateTime")=$$FMTISO^SDAMUTDT($G(ARRAY298(2.98,PATIENS,15,"I")))
 S APPTOBJ("Appointment",RECCNT,"NoShowCancelledBy")=$G(ARRAY298(2.98,PATIENS,14,"E"))
 S APPTOBJ("Appointment",RECCNT,"NumberOfCollateralSeen")=$G(ARRAY298(2.98,PATIENS,11,"E"))
 S APPTOBJ("Appointment",RECCNT,"OutpatientEncounter")=$$FMTISO^SDAMUTDT($$GET1^DIQ(409.68,$G(ARRAY298(2.98,PATIENS,21,"I")),.01,"I"))
 S APPTOBJ("Appointment",RECCNT,"PurposeOfVisit")=$G(ARRAY298(2.98,PATIENS,9,"E"))
 S APPTOBJ("Appointment",RECCNT,"RealAppointment")=$G(ARRAY298(2.98,PATIENS,4,"E"))
 S APPTOBJ("Appointment",RECCNT,"RoutingSlipPrintDate")=$$FMTISO^SDAMUTDT($G(ARRAY298(2.98,PATIENS,8.5,"I")))
 S APPTOBJ("Appointment",RECCNT,"RoutingSlipPrinted")=$G(ARRAY298(2.98,PATIENS,8,"E"))
 S APPTOBJ("Appointment",RECCNT,"SchedulerName")=$G(ARRAY298(2.98,PATIENS,30,"E"))
 S APPTOBJ("Appointment",RECCNT,"SchedulingApplication")=$G(ARRAY298(2.98,PATIENS,29,"I"))
 S APPTOBJ("Appointment",RECCNT,"SchedulingRequestType")=$G(ARRAY298(2.98,PATIENS,25,"E"))
 S APPTOBJ("Appointment",RECCNT,"SpecialSurveyDisposition")=$G(ARRAY298(2.98,PATIENS,10,"E"))
 S:APPTOBJ("Appointment",RECCNT,"Status")="" APPTOBJ("Appointment",RECCNT,"Status")=APPTOBJ("Appointment",RECCNT,"CurrentStatus")
 S APPTOBJ("Appointment",RECCNT,"InpatientFlag")=$S($G(ARRAY298(2.98,PATIENS,3,"I"))="I":1,1:0)
 S APPTOBJ("Appointment",RECCNT,"XrayDateTime")=$$FMTISO^SDAMUTDT($G(ARRAY298(2.98,PATIENS,6,"I")),CLINIEN)
 Q
 ;
BLANK298(APPTOBJ) ;if overlaid appointment, send empty fields
 S APPTOBJ("Appointment",RECCNT,"InpatientFlag")=""
 S APPTOBJ("Appointment",RECCNT,"AppointmentType")=""
 S APPTOBJ("Appointment",RECCNT,"AppointmentTypeSubCategory")=""
 S APPTOBJ("Appointment",RECCNT,"AutoRebookedApptDateTime")=""
 S APPTOBJ("Appointment",RECCNT,"CancellationRemarks")=""
 S APPTOBJ("Appointment",RECCNT,"CollateralVisit")=""
 S APPTOBJ("Appointment",RECCNT,"EkgDateTime")=""
 S APPTOBJ("Appointment",RECCNT,"EncounterConversionStatus")=""
 S APPTOBJ("Appointment",RECCNT,"EncounterFormsAsAddOns")=""
 S APPTOBJ("Appointment",RECCNT,"EncounterFormsPrinted")=""
 S APPTOBJ("Appointment",RECCNT,"FollowUpVisit")=""
 S APPTOBJ("Appointment",RECCNT,"LabDateTime")=""
 S APPTOBJ("Appointment",RECCNT,"NextAvaApptIndicator")=""
 S APPTOBJ("Appointment",RECCNT,"NoShowCancelDateTime")=""
 S APPTOBJ("Appointment",RECCNT,"NoShowCancelledBy")=""
 S APPTOBJ("Appointment",RECCNT,"NumberOfCollateralSeen")=""
 S APPTOBJ("Appointment",RECCNT,"OutpatientEncounter")=""
 S APPTOBJ("Appointment",RECCNT,"PurposeOfVisit")=""
 S APPTOBJ("Appointment",RECCNT,"RealAppointment")=""
 S APPTOBJ("Appointment",RECCNT,"RoutingSlipPrintDate")=""
 S APPTOBJ("Appointment",RECCNT,"RoutingSlipPrinted")=""
 S APPTOBJ("Appointment",RECCNT,"SchedulerName")=""
 S APPTOBJ("Appointment",RECCNT,"SchedulingApplication")=""
 S APPTOBJ("Appointment",RECCNT,"SchedulingRequestType")=""
 S APPTOBJ("Appointment",RECCNT,"SpecialSurveyDisposition")=""
 S APPTOBJ("Appointment",RECCNT,"XrayDateTime")=""
 Q
 ;
CHECKSTATUS(INCLUDEPAT,SDDFN,APPTIEN,APPTDTTM) ;
 S INCLUDEPAT=$O(^SDEC(409.84,"APTDT",SDDFN,APPTDTTM,APPTIEN))
 S:INCLUDEPAT'="" INCLUDEPAT=0 ;Patient appointment was overlaid with new appointment
 S:INCLUDEPAT="" INCLUDEPAT=1
 Q
 ;
