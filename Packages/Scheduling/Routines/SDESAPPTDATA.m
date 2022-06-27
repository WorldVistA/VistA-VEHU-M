SDESAPPTDATA ;ALB/TAW/RRM - VISTA Appointment data getter ;May 26, 2021@15:22
 ;;5.3;Scheduling;**788,814**;Aug 13, 1993;Build 11
 ;;Per VHA Directive 6402, this routine should not be modified
 Q
 ; The intention of this rtn is to return a unique set of data from the Appointment
 ;File (409.84) for a specifc IEN.
 ;
 ; It is assumed by getting here all business logic and validation has been performed.
 ;
 ; This routine should only be used for retrieving data from the Appointment file.
 ;
SUMMARY(APPTDATA,IEN) ;
 ;Returns a basic set of data for a specific appointment
 ;
 ; Input
 ;  IEN - Specific appointment IEN
 ; Return
 ;  APPTDATA - Array of field names and the data for the field based on the IEN
 ;
 N APPTARY,FN,IENS,SDMSG,DFN,RESOURCEIEN,CLINICIEN,SIEN,OVERBOOK,STIME,ETIME,X
 N DATETIME,NUM,STATPOINTER,CLINICARY,STAT,CLINICDATA
 K APPTDATA
 S FN=409.84,IENS=IEN_",",OVERBOOK=0
 D GETS^DIQ(FN,IEN,".01;.02;.03;.04;.05;.06;.07;.14;.17;.18;1;3;100","IE","APPTARY","SDMSG") ;SD,814-Added 100 for the EAS Tracking Number
 S APPTDATA("StartTime")=$G(APPTARY(FN,IENS,.01,"E"))
 S APPTDATA("StartTimeFM")=$G(APPTARY(FN,IENS,.01,"I"))
 S STIME=$G(APPTARY(FN,IENS,.01,"I"))
 S APPTDATA("EndTime")=$G(APPTARY(FN,IENS,.02,"E"))
 S ETIME=$G(APPTARY(FN,IENS,.02,"I"))
 S APPTDATA("AppointmentTypeIEN")=$G(APPTARY(FN,IENS,.06,"I"))
 S APPTDATA("LengthOfAppt")=$G(APPTARY(FN,IENS,.18,"E"))
 K APPTARY(FN,IENS,1,"I"),APPTARY(FN,IENS,1,"E")
 I $D(APPTARY(FN,IENS,1)) M APPTDATA("Note")=APPTARY(FN,IENS,1)
 E  S APPTDATA("Note")=""
 S APPTDATA("AppointmentIEN")=IEN
 S DATETIME=$G(APPTARY(FN,IENS,.03,"E"))
 S APPTDATA("CheckIn")=$$FMTE^XLFDT(DATETIME)
 S DATETIME=$G(APPTARY(FN,IENS,.04,"E"))
 S APPTDATA("CheckInEntered")=$$FMTE^XLFDT(DATETIME)
 S DATETIME=$G(APPTARY(FN,IENS,.14,"E"))
 S APPTDATA("CheckOut")=$$FMTE^XLFDT(DATETIME)
 S APPTDATA("Status")=$G(APPTARY(FN,IENS,.17,"E"))
 S APPTDATA("EASTrackingNumber")=$G(APPTARY(FN,IENS,100,"I")) ;SD,814-Retrieve EAS Tracking Number
 ;
 ;Always sent these Resource / Clinic data elements
 S APPTDATA("Clinic","IsOverbook")=0
 S RESOURCEIEN=$G(APPTARY(FN,IENS,.07,"I"))
 S APPTDATA("ResourceIEN")=RESOURCEIEN
 S APPTDATA("Resource","Name")=$G(APPTARY(FN,IENS,.07,"E"))
 S CLINICIEN=$$GET1^DIQ(409.831,RESOURCEIEN,.04,"I")
 S APPTDATA("Resource","ClinicIEN")=CLINICIEN
 D APPTCLINIC^SDESCLINICDATA(.CLINICDATA,CLINICIEN)
 M APPTDATA("Clinic")=CLINICDATA
 I CLINICIEN D
 .S SIEN=0
 .F  S SIEN=$O(^SC(CLINICIEN,"S",STIME,SIEN)) Q:'SIEN  D
 ..S X=$O(^SC(CLINICIEN,"S",STIME,SIEN,""),-1)
 ..S:X OVERBOOK=$G(^SC(CLINICIEN,"S",STIME,SIEN,X,"OB"))
 I OVERBOOK="O" S APPTDATA("Clinic","IsOverbook")=1
 ;
 S (SIEN,NUM)=0
 F  S SIEN=$O(^SDEC(409.84,IEN,3,SIEN)) Q:'SIEN  D
 .S NUM=NUM+1
 .S STATPOINTER=$$GET1^DIQ(409.843,SIEN_","_IEN_",",.01,"I")
 .S STAT=$$GET1^DIQ(409.842,STATPOINTER,.01,"E")
 .S DATETIME=$$GET1^DIQ(409.843,SIEN_","_IEN_",",1,"E")
 .S APPTDATA("CheckInSteps",NUM,"IEN")=SIEN
 .S APPTDATA("CheckInSteps",NUM,"Status")=$G(STAT)
 .S APPTDATA("CheckInSteps",NUM,"DateTime")=$$FMTE^XLFDT(DATETIME)
 I '$D(APPTDATA("CheckInSteps")) S APPTDATA("CheckInSteps")=""
 ;
 ;Always send these Patient data elements
 S DFN=$G(APPTARY(FN,IENS,.05,"I"))
 S APPTDATA("DFN")=DFN
 S APPTDATA("Patient","EligibilityIEN")=$$GET1^DIQ(2,DFN,.361,"I")
 S APPTDATA("Patient","Name")=$$GET1^DIQ(2,DFN,.01,"E")
 Q
