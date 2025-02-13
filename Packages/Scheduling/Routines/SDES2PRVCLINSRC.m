SDES2PRVCLINSRC ;ALB/TJB,JAS - VISTA SCHEDULING RPC SDES2 GET CLINICS BY PROVIDER ; Aug 13, 2024
 ;;5.3;Scheduling;**880,887**;Aug 13, 1993;Build 7
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
 ; SDINPUT("PROVIDER IEN")=#  ; IEN of the provider from file #200 (Required)
 ; SDINPUT("INACTIVE CLINIC")=1|0   ; 1=> Send inactive and active, 0 or null => send only active (Optional)
GETPROVCLINICS(SDRETURN,SDCONTEXT,SDINPUT) ;
 N CLINICS,ERRORS,VAL
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("Provider",1)="" D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 D VALFILEIEN^SDES2VALUTIL(.VAL,.ERRORS,200,$G(SDINPUT("PROVIDER IEN")),1,,53,54)
 D VALIDINACTIVE(.ERRORS,$G(SDINPUT("INACTIVE CLINIC")))
 I $D(ERRORS) S ERRORS("Provider",1)="" D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 ;
 D BUILD(.CLINICS,$G(SDINPUT("PROVIDER IEN")),$S($G(SDINPUT("INACTIVE CLINIC"))=1:1,1:0))
 I '$D(CLINICS) S CLINICS("Provider",1)=""
 ;
 D BUILDJSON^SDES2JSON(.SDRETURN,.CLINICS)
 Q
 ;
BUILD(CLINICS,PROVIDERIEN,INACTFLAG) ;
 N CLINICIEN,COUNT,CLINSTATUS
 ;
 I '$D(^SC("AVADPR",PROVIDERIEN)) Q
 S CLINICS("Provider",1,"ProviderName")=$$GET1^DIQ(200,PROVIDERIEN,.01,"E")
 ;
 S CLINICIEN=0,COUNT=0
 F  S CLINICIEN=$O(^SC("AVADPR",PROVIDERIEN,CLINICIEN)) Q:'CLINICIEN  D
 . S CLINSTATUS=$$INACTIVE^SDES2UTIL(CLINICIEN)
 . I INACTFLAG=0,CLINSTATUS'=0 Q
 . S COUNT=COUNT+1
 . S CLINICS("Provider",1,"AssociatedClinicIEN",COUNT)=CLINICIEN
 . S CLINICS("Provider",1,"AssociatedClinicName",COUNT)=$$GET1^DIQ(44,CLINICIEN,.01,"E")
 . S CLINICS("Provider",1,"AssociatedClinicStatus",COUNT)=$S(CLINSTATUS=0:"Active",1:"Inactive")
 . S CLINICS("Provider",1,"PbspID",COUNT)=$$GET1^DIQ(44,CLINICIEN,200,"E")
 . S CLINICS("Provider",1,"VeteranSelfCancel",COUNT)=$$GET1^DIQ(44,CLINICIEN,63,"E")
 Q
 ;
VALIDINACTIVE(ERRORS,FLAG) ; If SDINPUT("INACTIVE CLINIC") If sent make sure it is a 1 or 0
 Q:$G(FLAG)=""
 I (FLAG'=1),(FLAG'=0) D ERRLOG^SDES2JSON(.ERRORS,267)
 Q
 ;
