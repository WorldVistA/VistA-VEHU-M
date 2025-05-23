SDESEDITAPPT  ;ALB/BLB,JAS - SDES EDIT APPT ; Oct 04, 2024@12:53
 ;;5.3;Scheduling;**846,893**;Aug 13, 1993;Build 6
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
EDIT(JSON,APPTIEN,NOTE) ;
 N RETURN,ERRORS
 ;
 I $G(NOTE)="" D ERRLOG^SDESJSON(.ERRORS,444)
 D VALIDATEAPPTIEN(.ERRORS,$G(APPTIEN))
 I $D(ERRORS) S ERRORS("Appointment",1)="" M RETURN=ERRORS D BUILDJSON(.JSON,.RETURN) Q
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
 ; 409.84 NOTE AUDIT multiple
 S FDA(409.847,"+1,"_APPTIEN_",",.01)=$$NOW^XLFDT
 S FDA(409.847,"+1,"_APPTIEN_",",1)=DUZ
 S FDA(409.847,"+1,"_APPTIEN_",",2)=NOTE
 D UPDATE^DIE("","FDA") K FDA
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
