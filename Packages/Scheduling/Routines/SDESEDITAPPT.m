SDESEDITAPPT  ;ALB/BLB - SDES EDIT APPT; Jun 01, 2023@09:49
 ;;5.3;Scheduling;**846**;Aug 13, 1993;Build 12
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
EDIT(JSON,APPTIEN,NOTE) ;
 N RETURN,ERRORS
 ;
 I $G(NOTE)="" D ERRLOG^SDESJSON(.ERRORS,444)
 D VALIDATEAPPTIEN(.ERRORS,$G(APPTIEN))
 I $D(ERRORS) M RETURN=ERRORS D BUILDJSON(.JSON,.RETURN) Q
 ;
 D EDITNOTE(APPTIEN,$TR($E(NOTE,1,150),"^",""),$$GET1^DIQ(409.84,APPTIEN,.01,"I"),$$GET1^DIQ(409.831,$$GET1^DIQ(409.84,APPTIEN,.07,"I"),.04,"I"),$$GET1^DIQ(409.84,APPTIEN,.05,"I"))
 ;
 S RETURN("Appointment","IEN")=APPTIEN
 D BUILDJSON^SDESBUILDJSON(.JSON,.RETURN)
 Q
 ;
EDITNOTE(APPTIEN,NOTE,STARTDATETIME,CLINICIEN,DFN) ;
 N FDA,SUBIEN,EDITED,EDITEDNOTE
 ; 409.84 WP field
 S EDITEDNOTE(1)=NOTE
 D WP^DIE(409.84,APPTIEN_",",1,"","EDITEDNOTE")
 ; 44 free text field
 S SUBIEN=0,EDITED=0
 F  S SUBIEN=$O(^SC(CLINICIEN,"S",STARTDATETIME,1,SUBIEN)) Q:'SUBIEN!(EDITED=1)  D
 .I DFN=$$GET1^DIQ(44.003,SUBIEN_","_STARTDATETIME_","_CLINICIEN_",",.01,"I") D
 ..S FDA(44.003,SUBIEN_","_STARTDATETIME_","_CLINICIEN_",",3)=NOTE
 ..D FILE^DIE(,"FDA") K FDA
 ..S EDITED=1
 Q
 ;
VALIDATEAPPTIEN(ERRORS,APPTIEN) ;
 I APPTIEN="" D ERRLOG^SDESJSON(.ERRORS,14) Q
 I APPTIEN'="",'$D(^SDEC(409.84,APPTIEN,0)) D ERRLOG^SDESJSON(.ERRORS,15) Q
 Q
 ;
BUILDJSON(JSONRETURN,RETURN) ;
 N JSONERROR
 D ENCODE^XLFJSON("RETURN","JSONRETURN","JSONERR")
 Q
 ;
