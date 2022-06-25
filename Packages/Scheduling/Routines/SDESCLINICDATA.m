SDESCLINICDATA ;;ALB/TAW - VISTA Clinic data getter ;May 26, 2021@15:22
 ;;5.3;Scheduling;**788**;Aug 13, 1993;Build 6
 Q
 ;
 ; The intention of this rtn is to return a unique set of data from the Hospital
 ;Location File (44) for a specifc IEN.
 ;
 ; It is assumed by getting here all business logic and validation has been performed.
 ;
 ; This routine should only be used for retrieving data from the Hospital loation file.
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
 D GETS^DIQ(44,IEN,".01;3.5;10;60;99","IE","CLINICARY","SDMSG")
 S RETURN("Name")=$G(CLINICARY(44,IENS,.01,"E"))
 S RETURN("PhysicalLocation")=$G(CLINICARY(44,IENS,10,"E"))
 S RETURN("PatientFriendlyName")=$G(CLINICARY(44,IENS,60,"E"))
 S RETURN("Telephone")=$G(CLINICARY(44,IENS,99,"E"))
 S RETURN("Division")=$G(CLINICARY(44,IENS,3.5,"E"))
 Q
