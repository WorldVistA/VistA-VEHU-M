SDESCLINICDATA ;ALB/TAW,MGD,RRM - VISTA Clinic data getter ;July 21, 2021@16:04
 ;;5.3;Scheduling;**788,823,825**;Aug 13, 1993;Build 2
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
 N CLINICARY,SDMSG,IENS
 K RETURN
 S IENS=IEN_","
 D GETS^DIQ(44,IEN,".01;3.5;10;60;99;99.1","IE","CLINICARY","SDMSG")
 S CLINICARY(44,IENS,99,"E")=$$TELEPHONE^SDESUTIL($G(CLINICARY(44,IENS,99,"E")))
 S CLINICARY(44,IENS,99.1,"E")=$$EXT^SDESUTIL($G(CLINICARY(44,IENS,99.1,"E")))
 S RETURN("Name")=$G(CLINICARY(44,IENS,.01,"E"))
 S RETURN("PhysicalLocation")=$G(CLINICARY(44,IENS,10,"E"))
 S RETURN("PatientFriendlyName")=$G(CLINICARY(44,IENS,60,"E"))
 S RETURN("Telephone")=$G(CLINICARY(44,IENS,99,"E"))
 S RETURN("TelephoneExtension")=$G(CLINICARY(44,IENS,99.1,"E"))
 S RETURN("Division")=$G(CLINICARY(44,IENS,3.5,"E"))
 S RETURN("StationNumber")=$$STATIONNUMBER^SDESUTIL($G(IEN)) ;SD,825-Clinic station number
 Q
