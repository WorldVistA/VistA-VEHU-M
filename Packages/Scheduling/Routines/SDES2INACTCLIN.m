SDES2INACTCLIN ;ALB/TJB,MGD - Inactivate Clinic in HOSPITAL LOCATION FILE 44 ;Mar 18, 2024
 ;;5.3;Scheduling;**864,877**;Aug 13, 1993;Build 14
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ;Reference to $$GETS^DIQ is supported by IA #2056
 ;Reference to $$GETS1^DIQ is supported by IA #2056
 ;
 Q
 ;
SDINACTCLN(SDRETURN,SDCONTEXT,SDPARAM) ;Inactivate Clinic
 ;INPUT -
 ; SDCONTEXT("ACHERON AUDIT ID") = Up to 40 Character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("PATIENT DFN") = The DFN/IEN of the target patient from the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the target patient from the calling application.
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action in the calling application.
 ; SDCONTEXT("USER SECID") = The SECID of the user taking action in the calling application.
 ;
 ; SDPARAM("CLINIC IEN")=CLINIC IEN     IEN of the clinic in file 44 - Hospital location
 ; SDPARAM("INACTIVATION DATE")=DATE    ISO DATE to inactivate the clinic if empty default to today (DT)
 ;
 ;RETURN PARMETER:
 ; Status
 ;
 N ERRORS,RESULTS,CLINICIEN,INACTDATE
 ; validate context array
 D VALCONTEXT^SDES2VALCONTEXT(.ERRORS,.SDCONTEXT)
 I $D(ERRORS) S ERRORS("ClinicInactivate",1)="" D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 D VALCLINIEN^SDES2VAL44(.ERRORS,$G(SDPARAM("CLINIC IEN")),1)
 I $D(ERRORS) S ERRORS("ClinicInactivate",1)="" D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 D INIT(.SDPARAM,.CLINICIEN,.INACTDATE)
 D VALIDATE(.ERRORS,INACTDATE,CLINICIEN)
 D NOAPPOINTMENTS(CLINICIEN,INACTDATE,.ERRORS)
 I $D(ERRORS) D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q
 ; File the inactivation on HOSPITAL LOCATION
 D BLDCINREC(.RESULTS,CLINICIEN,INACTDATE,.ERRORS)
 ; If the Clinic was inactivated then update the SDEC RESOURCE (409.831) with the inactivation information
 I '$D(ERRORS) D UPDATECLNRES(CLINICIEN,INACTDATE,$G(SDCONTEXT("USER DUZ")),.ERRORS)
 I $D(ERRORS) D BUILDJSON^SDES2JSON(.SDRETURN,.ERRORS) Q  ; There was a problem updating 409.831 with the inactivation
 D ENCODE^SDES2JSON(.RESULTS,.SDRETURN)
 Q
 ;
INIT(SDPARAM,CLINICIEN,INACTDATE) ; initialize values needed
 S CLINICIEN=$G(SDPARAM("CLINIC IEN"))
 S INACTDATE=$G(SDPARAM("INACTIVATION DATE"))
 ; If no Inactivation Date then default it to today
 I INACTDATE="" S INACTDATE=$$FMTISO^SDAMUTDT(DT)
 Q
 ;
VALIDATE(ERRORS,INACTIVEDATE,CLINICIEN) ; validate incoming parameters
 N FMDATE
 ; Validate the inactivation date
 S FMDATE=$$ISOTFM^SDAMUTDT(INACTIVEDATE)
 I FMDATE=-1 D ERRLOG^SDES2JSON(.ERRORS,46,"For Clinic Inactivation")
 I FMDATE>0,(FMDATE<DT) D ERRLOG^SDES2JSON(.ERRORS,46,"Clinic Inactivation can't be before today")
 I (FMDATE>$$FMADD^XLFDT(DT,182)) D ERRLOG^SDES2JSON(.ERRORS,46,"Inactivation Date greater than 6 Months in the future")
 Q
 ; Make sure there are no active appointments after the inactivation date
NOAPPOINTMENTS(CLINICIEN,INACTDATE,ERRORS) ;
 N POP,FMDATE,DATEIDX,LASTDATE,I1
 S FMDATE=$$ISOTFM^SDAMUTDT($G(INACTDATE))
 S CLINICIEN=$G(CLINICIEN)
 S POP=0,LASTDATE=9999999,DATEIDX=FMDATE-.0001
 F  S DATEIDX=$O(^SC(CLINICIEN,"S",DATEIDX)) Q:'DATEIDX!(POP)!(FMDATE'<LASTDATE&(LASTDATE))  D
 . S I1=0 F  S I1=$O(^SC(CLINICIEN,"S",DATEIDX,1,I1)) Q:'I1  I $$GET1^DIQ(44.003,I1_","_DATEIDX_","_CLINICIEN_",",310,"I")'="C" S POP=1,FMDATE=DATEIDX Q
 I POP D ERRLOG^SDES2JSON(.ERRORS,521)
 Q
 ;
BLDCINREC(SDCINREC,CLINICIEN,INACTIVEDATE,ERRORS) ;Inactivate Clinic
 ; If the inactivation was filed in FILEMAN, no errors recorded, otherwise populate ERRORS
 N SDERR,SDFDA,SDCLNNAME,FMDATE
 S SDCLNNAME=""
 S FMDATE=$$ISOTFM^SDAMUTDT(INACTIVEDATE)
 S SDCLNNAME=$$GET1^DIQ(44,CLINICIEN,.01)
 S SDFDA(44,CLINICIEN_",",2505)=FMDATE
 D UPDATE^DIE("","SDFDA","","SDERR")
 I $G(SDERR) D ERRLOG^SDES2JSON(.ERRORS,81) Q
 S SDCINREC("ClinicInactivate",1)="Clinic is successfully inactivated."
 Q
 ;
UPDATECLNRES(SDCLINICIEN,INACTIVATIONDATE,SDDUZ,ERRORS) ;Update INACTIVATED DATE/TIME and INACTIVATED BY USER in SDEC RESOURCE File #409.831
 N SDRESFDA,SDCLINRES,SDERR,FMDATE
 S SDCLINRES=$$GETRES^SDES2UTIL1(SDCLINICIEN,1)
 Q:SDCLINRES=""  ; no resource associated with clinic
 S FMDATE=$$ISOTFM^SDAMUTDT(INACTIVATIONDATE)
 S SDRESFDA(409.831,SDCLINRES_",",.021)=$P(FMDATE,".")
 S SDRESFDA(409.831,SDCLINRES_",",.022)=$S(SDDUZ'="":SDDUZ,1:DUZ)
 D FILE^DIE("","SDRESFDA","SDERR")
 I $D(SDERR) D ERRLOG^SDES2JSON(.ERRORS,81,"File 409.831 not updated with the inactivation date for Resource IEN="_SDCLINRES)
 Q
