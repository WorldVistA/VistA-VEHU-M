SDESCLINICDATA ;ALB/TAW,MGD,RRM,CGP,ANU,BWF - VISTA Clinic data getter ;June 27, 2023@10:00
 ;;5.3;Scheduling;**788,823,825,828,831,844,847,860,871**;Aug 13, 1993;Build 13
 ;;Per VHA Directive 6402, this routine should not be modified
 ; Reference to INSTITUTION in ICR #10090
 Q
 ;
 ; The intention of this routine is to return a unique set of data from the HOSPITAL
 ;LOCATION (#44) for a specific IEN.
 ;
 ; It is assumed by getting here all business logic and validation has been performed.
 ;
 ; This routine should only be used for retrieving data from the HOSPITAL LOCATION file.
 Q
APPTCLINIC(RETURN,IEN) ;
 ; Return clinic data related to an appointment
 ;
 ; Input
 ;  IEN - Specific clinic IEN
 ; Return
 ;  RETURN - Array of field names and the data for the field based on the IEN
 ;
 N CLINICARY,SDMSG,IENS,DIV,INST,TIMEZONEIEN,TIMEZONE,TZEXECPTION
 N TZLOOP,TZCNT,TZIENS,TIMEFRAME,OFFSET,TZCODE,TZDATA,STOPIEN,CRSTOPIEN
 K RETURN
 S IENS=IEN_","
 ;ANU
 D GETS^DIQ(44,IEN,".01;3.5;8;10;20;21;60;62;99;99.1;200;2503","IE","CLINICARY","SDMSG")
 S CLINICARY(44,IENS,99,"E")=$$TELEPHONE^SDESUTIL($G(CLINICARY(44,IENS,99,"E")))
 S CLINICARY(44,IENS,99.1,"E")=$$EXT^SDESUTIL($G(CLINICARY(44,IENS,99.1,"E")))
 ; 831 - add timezone information
 S DIV=$G(CLINICARY(44,IENS,3.5,"I"))
 S INST=$$GET1^DIQ(40.8,DIV,.07,"I")
 S TIMEZONEIEN=$$GET1^DIQ(4,INST,800,"I")
 S TIMEZONE=$$GET1^DIQ(4,INST,800,"E")
 S TZEXECPTION=$$GET1^DIQ(4,INST,802,"E")
 S RETURN("Name")=$G(CLINICARY(44,IENS,.01,"E"))
 S RETURN("PhysicalLocation")=$G(CLINICARY(44,IENS,10,"E"))
 S RETURN("PatientFriendlyName")=$G(CLINICARY(44,IENS,60,"E"))
 S RETURN("PbspID")=$G(CLINICARY(44,IENS,200,"E"))
 ;ANU
 S RETURN("DisplayClinicAppt")=$G(CLINICARY(44,IENS,62,"E"))
 S STOPIEN=$G(CLINICARY(44,IENS,8,"I"))
 S CRSTOPIEN=$G(CLINICARY(44,IENS,2503,"I"))
 S RETURN("StopCodeAMIS")=$$GET1^DIQ(40.7,STOPIEN,1,"I")
 S RETURN("StopCodeName")=$G(CLINICARY(44,IENS,8,"E"))
 S RETURN("CreditStopCodeAMIS")=$$GET1^DIQ(40.7,CRSTOPIEN,1,"I")
 S RETURN("CreditStopCodeName")=$G(CLINICARY(44,IENS,2503,"E"))
 ;
 ;847
 S RETURN("ECheckinAllowed")=$G(CLINICARY(44,IENS,20,"E"))
 S RETURN("PreCheckinAllowed")=$G(CLINICARY(44,IENS,21,"E"))
 ;
 S RETURN("Telephone")=$G(CLINICARY(44,IENS,99,"E"))
 S RETURN("TelephoneExtension")=$G(CLINICARY(44,IENS,99.1,"E"))
 S RETURN("Division")=$G(CLINICARY(44,IENS,3.5,"E"))
 S RETURN("StationNumber")=$$STATIONNUMBER^SDESUTIL($G(IEN)) ;SD,825-Clinic station number
 S RETURN("ClinicIEN")=$G(IEN) ;CP,828-Clinic IEN
 S RETURN("TimeZone")=$G(TIMEZONE)
 S RETURN("TimeZoneException")=TZEXECPTION
 I 'TIMEZONEIEN Q
 S (TZLOOP,TZCNT)=0 F  S TZLOOP=$O(^DIT(1.71,TIMEZONEIEN,1,TZLOOP)) Q:'TZLOOP  D
 .S TZIENS=TZLOOP_","_TIMEZONEIEN_","
 .D GETS^DIQ(1.711,TZIENS,"**","IE","TZDATA")
 .S TIMEFRAME=$G(TZDATA(1.711,TZIENS,.01,"E"))
 .S OFFSET=$G(TZDATA(1.711,TZIENS,.02,"E"))
 .S TZCODE=$G(TZDATA(1.711,TZIENS,.03,"E"))
 .S TZCNT=TZCNT+1
 .S RETURN("TimeZoneDetails",TZCNT,"TimeFrame")=TIMEFRAME
 .S RETURN("TimeZoneDetails",TZCNT,"Offset")=OFFSET
 .S RETURN("TimeZoneDetails",TZCNT,"TimeZoneCode")=TZCODE
 Q
