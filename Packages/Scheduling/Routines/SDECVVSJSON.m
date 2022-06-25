SDECVVSJSON ;ALB/ANU,LAB - Get Patient, Provider and System Info to make VVS call ;SEP 09, 2021@14:39
 ;;5.3;Scheduling;**797,801**;Aug 13, 1993;Build 13
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ;Reference to $$GETS^DIQ,$$GETS1^DIQ in ICR #2056 
 Q
 ;
GETVVSMAKEINFO(SDVVSJSON,PATIENTIEN,CLINICIEN) ;GET INFO TO MAKE A VIDEO VISIT WEB SERVICE (VVS) CALL
 ;INPUT - PATIENTIEN (Patient IEN)
 ;INPUT - CLINICIEN (Clinic IEN)
 ;RETURN PARMETER:
 ; Field List:
 ; (1) Patient Info
 ; (2) Default Provider Info
 ; (3) System Info
 ;
 N SDVVSREC,ERRPOP,ERR,ERRMSG,SDESI,VVSPATIENT,VVSPROVIDER,PROVIDERINFO,VVSSYSTEMINFO
 D INIT
 D VALIDATE
 I ERRPOP D BLDJSON Q
 D BLDVVSREC
 D BLDJSON
 ;
 K PATINFO,PROVIDERIEN,PROVIDERINFO,VVSSYSTEMINFO
 Q
 ;
INIT ; initialize values needed
 S SDESI=0
 S SDESI=$G(SDESI,0),ERR=""
 S (VVSPATIENT,VVSPROVIDER,PROVIDERINFO,VVSSYSTEMINFO)=""
 S ERRPOP=0,SDESI=0,ERRMSG=""
 Q
 ; 
VALIDATE ; validate incoming parameters
 I PATIENTIEN="" D
 . ;create error message - Patient IEN cannot be blank
 . D ERRLOG^SDESJSON(.SDVVSREC,66)
 . S ERRPOP=1
 I CLINICIEN="" D
 . ;create error message - Clinic IEN cannot be blank
 . D ERRLOG^SDESJSON(.SDVVSREC,67)
 . S ERRPOP=1
 Q
 ;
BLDJSON ;
 D ENCODE^SDESJSON(.SDVVSREC,.SDVVSJSON,.ERR)
 K SDVVSREC
 Q
 ;
BLDVVSREC ;Build VVS info
 ;
 S VVSPATIENT=""
 D GETVVSPATIENT^SDECVVS(.VVSPATIENT,PATIENTIEN)
 I VVSPATIENT'="" D
 .S SDESI=1
 .S SDVVSREC("VVSMakeInfo","Patient","IEN")=$P(VVSPATIENT,"^",1)
 .S SDVVSREC("VVSMakeInfo","Patient","DateOfBirth")=$P(VVSPATIENT,"^",2)
 .S SDVVSREC("VVSMakeInfo","Patient","FirstName")=$P(VVSPATIENT,"^",3)
 .S SDVVSREC("VVSMakeInfo","Patient","LastName")=$P(VVSPATIENT,"^",4)
 .S SDVVSREC("VVSMakeInfo","Patient","SSN")=$P(VVSPATIENT,"^",5)
 .S SDVVSREC("VVSMakeInfo","Patient","Email")=$P(VVSPATIENT,"^",6)
 .S SDVVSREC("VVSMakeInfo","Patient","HomePhone")=$P(VVSPATIENT,"^",7)
 .S SDVVSREC("VVSMakeInfo","Patient","CellPhone")=$P(VVSPATIENT,"^",8)
 .S SDVVSREC("VVSMakeInfo","Patient","ICN")=$P(VVSPATIENT,"^",9)
 .S SDVVSREC("VVSMakeInfo","Patient","ZipCode")=$P(VVSPATIENT,"^",10)
 D GETDPROIEN^SDECVVS(.PROVIDERIEN,CLINICIEN)
 D GETPROINFO^SDECVVS(.PROVIDERINFO,PROVIDERIEN)
 I PROVIDERINFO'="" D
 .S SDESI=1
 .S SDVVSREC("VVSMakeInfo","Provider","IEN")=$P(PROVIDERINFO,"^",1)
 .S SDVVSREC("VVSMakeInfo","Provider","Name")=$P(PROVIDERINFO,"^",2)
 .S SDVVSREC("VVSMakeInfo","Provider","Email")=$P(PROVIDERINFO,"^",3)
 .S SDVVSREC("VVSMakeInfo","Provider","Cell")=$P(PROVIDERINFO,"^",4)
 D GETSYSTEMINFO^SDECVVS(.VVSSYSTEMINFO)
 I VVSSYSTEMINFO'="" D
 .S SDESI=1
 .S SDVVSREC("VVSMakeInfo","SystemInfo","FacilityCode")=$P(VVSSYSTEMINFO,"^",1)
 .S SDVVSREC("VVSMakeInfo","SystemInfo","FacilityName")=$P(VVSSYSTEMINFO,"^",2)
 .S SDVVSREC("VVSMakeInfo","SystemInfo","TimeZone")=$P(VVSSYSTEMINFO,"^",3)
 I '$D(SDVVSREC("VVSMakeInfo")) S SDVVSREC("VVSMakeInfo")=""
 ;
 I SDESI=0 D
 . ;create error message - No VVS info found
 . D ERRLOG^SDESJSON(.SDVVSREC,68)
 . S ERRPOP=1
 Q
 ;
